package pe.edu.vallegrande.service;

import pe.edu.vallegrande.db.AccesoDB;
import pe.edu.vallegrande.dto.Buys;
import pe.edu.vallegrande.dto.Buys_detail;
import pe.edu.vallegrande.dto.Products;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static pe.edu.vallegrande.service.CategoryDAO.accesoDB;
import static pe.edu.vallegrande.service.CultivosDAO.db;

public class BuysDAO {
    AccesoDB accesoDB = new AccesoDB();
    public List<Buys> listarCompras() {
        List<Buys> BUYS = new ArrayList<>();

        String sql = "SELECT b.buys_id, b.buys_date, b.buys_price, SUM(bd.quantity) AS total_quantity, p.name AS supplier_name " +
                "FROM Buys b " +
                "JOIN Suppliers p ON b.fk_suppliers_id = p.suppliers_id " +
                "LEFT JOIN Buys_detail bd ON b.buys_id = bd.fk_buys_Id " +
                "GROUP BY b.buys_id, b.buys_date, b.buys_price, p.name";

        try (Connection con = accesoDB.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Buys buys = new Buys();
                buys.setBuys_Id(rs.getInt("buys_id"));
                buys.setBuys_date(rs.getDate("buys_date"));
                buys.setBuys_price(rs.getBigDecimal("buys_price"));
                buys.setSupplierName(rs.getString("supplier_name"));
                buys.setTotalQuantity(rs.getInt("total_quantity"));
                BUYS.add(buys);
            }

        }catch (Exception e) {
            e.printStackTrace();
        }
        return BUYS;
    }

    public int insertPurchase(Buys buy) throws Exception {
        int buyId = -1;
        String insertBuySql = "INSERT INTO Buys (buys_date, buys_price, fk_suppliers_id) VALUES (?, ?, ?)";

        try (Connection con = accesoDB.getCon();
             PreparedStatement ps = con.prepareStatement(insertBuySql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setDate(1, java.sql.Date.valueOf(buy.getBuys_date().toString()));
            ps.setBigDecimal(2, buy.getBuys_price());
            ps.setInt(3, buy.getSupplierId());
            ps.executeUpdate();

            // Obtener el ID insertado
            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                buyId = generatedKeys.getInt(1);
            }
            System.out.println("Compra ingresada");
        }
        return buyId;
    }

    public Buys listEdit(int id) {
        String sql = "SELECT b.*, p.name AS supplier_name, p.ruc, p.email, p.phone FROM Buys b " +
                "JOIN Suppliers p ON b.fk_suppliers_id = p.suppliers_id " +
                "WHERE b.buys_id = ?";
        Buys B = null;

        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                B = new Buys();
                B.setBuys_Id(rs.getInt("buys_id"));
                B.setBuys_date(rs.getDate("buys_date"));
                B.setBuys_price(rs.getBigDecimal("buys_price"));
                B.setSupplierId(rs.getInt("fk_suppliers_id"));
                B.setSupplierName(rs.getString("supplier_name"));
                B.setRuc_supplier(rs.getString("ruc"));
                B.setPhone_supplier(rs.getString("phone"));
                B.setEmail_supplier(rs.getString("email"));

            }
            System.out.println("Listado de compra por ID exitoso");
        } catch (Exception e) {
            e.printStackTrace(); // Consider using a logging framework
        }

        return B;
    }

    public List<Buys> listarComprasPorProveedor(int supplierId) {
        List<Buys> BUYS = new ArrayList<>();

        String sql = "SELECT b.buys_id, b.buys_date, b.buys_price, SUM(bd.quantity) AS total_quantity, p.name AS supplier_name " +
                "FROM Buys b " +
                "JOIN Suppliers p ON b.fk_suppliers_id = p.suppliers_id " +
                "LEFT JOIN Buys_detail bd ON b.buys_id = bd.fk_buys_Id " +
                "WHERE b.fk_suppliers_id = ? " +
                "GROUP BY b.buys_id, b.buys_date, b.buys_price, p.name";

        try (Connection con = accesoDB.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, supplierId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Buys buys = new Buys();
                    buys.setBuys_Id(rs.getInt("buys_id"));
                    buys.setBuys_date(rs.getDate("buys_date"));
                    buys.setBuys_price(rs.getBigDecimal("buys_price"));
                    buys.setSupplierName(rs.getString("supplier_name"));
                    buys.setTotalQuantity(rs.getInt("total_quantity"));
                    BUYS.add(buys);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BUYS;
    }

    public List<Buys> listarComprasPorFecha(Date fecha) {
        List<Buys> BUYS = new ArrayList<>();

        String sql = "SELECT b.buys_id, b.buys_date, b.buys_price, SUM(bd.quantity) AS total_quantity, p.name AS supplier_name " +
                "FROM Buys b " +
                "JOIN Suppliers p ON b.fk_suppliers_id = p.suppliers_id " +
                "LEFT JOIN Buys_detail bd ON b.buys_id = bd.fk_buys_Id " +
                "WHERE b.buys_date = ? " +
                "GROUP BY b.buys_id, b.buys_date, b.buys_price, p.name";

        try (Connection con = accesoDB.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, fecha);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Buys buys = new Buys();
                    buys.setBuys_Id(rs.getInt("buys_id"));
                    buys.setBuys_date(rs.getDate("buys_date"));
                    buys.setBuys_price(rs.getBigDecimal("buys_price"));
                    buys.setSupplierName(rs.getString("supplier_name"));
                    buys.setTotalQuantity(rs.getInt("total_quantity"));
                    BUYS.add(buys);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BUYS;
    }
}
