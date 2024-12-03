package pe.edu.vallegrande.service;

import pe.edu.vallegrande.Dto.PurcharseDetailDto;
import pe.edu.vallegrande.Dto.PurcharseDto;
import pe.edu.vallegrande.db.AccesoDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PurchaseService {

    public List<PurcharseDto> listarCompras() {
        List<PurcharseDto> purchases = new ArrayList<>();
        String sql = "SELECT p.id, p.date, p.total_amount, p.payment_method, p.status, s.Empresa AS supplier_name " +
                "FROM purchase p " +
                "JOIN supplier s ON p.supplier_id = s.id";

        try (
                Connection cn = AccesoDB.getConnection();
                PreparedStatement ps = cn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                PurcharseDto purchase = new PurcharseDto();
                purchase.setId(rs.getInt("id"));
                purchase.setDate(rs.getDate("date"));
                purchase.setTotalAmount(rs.getBigDecimal("total_amount"));
                purchase.setPaymentMethod(rs.getString("payment_method"));
                purchase.setStatus(rs.getString("status"));
                purchase.setSupplierName(rs.getString("supplier_name")); // Asignar el nombre del proveedor
                purchases.add(purchase);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar las compras: " + e.getMessage());
            e.printStackTrace();
        }

        return purchases;
    }

    public PurcharseDto getPurchaseById(int purchaseId) {
        String sql = "SELECT p.id, p.date, p.total_amount, p.payment_method, p.status, " +
                "p.supplier_id, s.Empresa AS supplier_name " +
                "FROM purchase p " +
                "LEFT JOIN supplier s ON p.supplier_id = s.id " +
                "WHERE p.id = ?";
        PurcharseDto purchase = null;

        try (Connection con = AccesoDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Establecer parámetro
            ps.setInt(1, purchaseId);
            System.out.println("Ejecutando consulta con ID: " + purchaseId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Crear instancia de PurcharseDto
                    purchase = new PurcharseDto();
                    purchase.setId(rs.getInt("id"));
                    purchase.setDate(rs.getDate("date"));
                    purchase.setTotalAmount(rs.getBigDecimal("total_amount"));
                    purchase.setPaymentMethod(rs.getString("payment_method"));
                    purchase.setStatus(rs.getString("status"));
                    purchase.setSupplierId(rs.getInt("supplier_id"));

                    // Manejar valores NULL para supplier_name
                    String supplierName = rs.getString("supplier_name");
                    purchase.setSupplierName(supplierName != null ? supplierName : "Proveedor desconocido");

                    System.out.println("Proveedor obtenido: " + purchase.getSupplierName());
                } else {
                    System.out.println("No se encontraron resultados para ID: " + purchaseId);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en la consulta SQL: " + e.getMessage());
            e.printStackTrace();
        }
        return purchase;
    }

    // Método para listar compras filtradas por proveedor
    public List<PurcharseDto> listarComprasBySupplier(int supplierId) {
        List<PurcharseDto> purchases = new ArrayList<>();
        String sql = "SELECT p.id, p.date, p.total_amount, p.payment_method, p.status, s.Empresa AS supplier_name " +
                "FROM purchase p " +
                "JOIN supplier s ON p.supplier_id = s.id " +
                "WHERE p.supplier_id = ?"; // Filtro por proveedor

        try (Connection cn = AccesoDB.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, supplierId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PurcharseDto purchase = new PurcharseDto();
                purchase.setId(rs.getInt("id"));
                purchase.setDate(rs.getDate("date"));
                purchase.setTotalAmount(rs.getBigDecimal("total_amount"));
                purchase.setPaymentMethod(rs.getString("payment_method"));
                purchase.setStatus(rs.getString("status"));
                purchase.setSupplierName(rs.getString("supplier_name"));
                purchases.add(purchase);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return purchases;
    }

}
