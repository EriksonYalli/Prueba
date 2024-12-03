package pe.edu.vallegrande.service;

import pe.edu.vallegrande.Dto.PurcharseDto;
import pe.edu.vallegrande.Dto.PurcharseDetailDto;
import pe.edu.vallegrande.db.AccesoDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PurcharseDetailService {

    public boolean registrarCompra(PurcharseDto purchaseDto, List<PurcharseDetailDto> details) {
        try (Connection con = AccesoDB.getConnection()) {
            con.setAutoCommit(false);
            System.out.println("Conexión establecida. Iniciando transacción...");

            int purchaseId = insertPurchaseHeader(con, purchaseDto);
            System.out.println("Cabecera insertada con ID: " + purchaseId);

            insertPurchaseDetails(con, purchaseId, details);
            System.out.println("Detalles insertados.");

            updateSparePartsStock(con, details);
            System.out.println("Stock de repuestos actualizado.");

            con.commit();
            System.out.println("Transacción completada.");
            return true;
        } catch (SQLException e) {
            System.err.println("Error al registrar compra: " + e.getMessage());
            return false;
        }
    }

    private int insertPurchaseHeader(Connection con, PurcharseDto purchaseDto) throws SQLException {
        String sql = "INSERT INTO Purchase(date, total_amount, payment_method, status, supplier_id) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setDate(1, purchaseDto.getDate());
            ps.setBigDecimal(2, purchaseDto.getTotalAmount());
            ps.setString(3, purchaseDto.getPaymentMethod());
            ps.setString(4, purchaseDto.getStatus());
            ps.setInt(5, purchaseDto.getSupplierId());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Devuelve el ID generado
                }
                throw new SQLException("No se pudo obtener el ID de la compra");
            }
        }
    }

    private void insertPurchaseDetails(Connection con, int purchaseId, List<PurcharseDetailDto> details) throws SQLException {
        String sql = "INSERT INTO Purchase_detail(quantity, subtotal, price_unit, spare_parts_id, purchase_id) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            for (PurcharseDetailDto detail : details) {
                ps.setInt(1, detail.getQuantity());
                ps.setBigDecimal(2, detail.getSubtotal());
                ps.setBigDecimal(3, detail.getPriceUnit());
                ps.setInt(4, detail.getSparePartsId());
                ps.setInt(5, purchaseId);
                ps.addBatch();
            }
            ps.executeBatch(); // Ejecuta el batch
        }
    }

    private void updateSparePartsStock(Connection con, List<PurcharseDetailDto> details) throws SQLException {
        String sql = "UPDATE spare_parts SET stock = stock + ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            for (PurcharseDetailDto detail : details) {
                ps.setInt(1, detail.getQuantity());
                ps.setInt(2, detail.getSparePartsId());
                ps.addBatch();
            }
            ps.executeBatch(); // Ejecuta el batch
        }
    }

    public List<PurcharseDetailDto> getPurchaseDetailsByPurchaseId(int purchaseId) {
        String sql = "SELECT pd.id, pd.quantity, pd.subtotal, pd.price_unit, sp.id AS spare_parts_id, " +
                "sp.name AS spare_part_name, pd.purchase_id " +
                "FROM purchase_detail pd " +
                "JOIN spare_parts sp ON pd.spare_parts_id = sp.id " +
                "WHERE pd.purchase_id = ?";
        List<PurcharseDetailDto> details = new ArrayList<>();

        try (Connection con = AccesoDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, purchaseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PurcharseDetailDto detail = new PurcharseDetailDto();
                    detail.setId(rs.getInt("id"));
                    detail.setQuantity(rs.getInt("quantity"));
                    detail.setSubtotal(rs.getBigDecimal("subtotal"));
                    detail.setPriceUnit(rs.getBigDecimal("price_unit"));
                    detail.setSparePartsId(rs.getInt("spare_parts_id"));
                    detail.setPurchaseId(rs.getInt("purchase_id"));
                    detail.setSparePartName(rs.getString("spare_part_name")); // Asignar nombre del repuesto
                    details.add(detail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }
}
