package pe.edu.vallegrande.service;

import pe.edu.vallegrande.db.AccesoDB;
import pe.edu.vallegrande.dto.Buys_detail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static pe.edu.vallegrande.service.CategoryDAO.accesoDB;

public class BuysDetail {
    AccesoDB accesoDB = new AccesoDB();

    public List<Buys_detail> listarDetalles() {
        List<Buys_detail> detail = new ArrayList<>();
        String sql = "select * from Buys_detail";
        try (Connection con = accesoDB.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Buys_detail buysDetail = new Buys_detail();
                buysDetail.setBuyDetailId(rs.getInt("buy_detail_id")); // Asegúrate de que el nombre de la columna sea correcto
                buysDetail.setQuantity(rs.getInt("quantity"));
                buysDetail.setUnitPrice(rs.getBigDecimal("unit_price"));
                buysDetail.setTotalDetail(rs.getBigDecimal("total_detail"));
                buysDetail.setBatch(rs.getString("batch"));
                buysDetail.setExpireDate(String.valueOf(rs.getDate("expire_date")));
                buysDetail.setPresentation(rs.getString("presentation"));
                buysDetail.setHealthRecord(rs.getString("health_record"));
                buysDetail.setFkBuysId(rs.getInt("fk_buys_Id"));
                buysDetail.setComercialName(rs.getString("comercial_name"));
                detail.add(buysDetail);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }


        return detail;
    }

    public List<Buys_detail> listarDetallesPorCompra(int idCompra) {

        List<Buys_detail> detalles = new ArrayList<>();
        String sql = "SELECT bd.buy_detail_id, bd.quantity, bd.unit_price, bd.total_detail, " +
                "bd.batch, bd.expire_date, bd.presentation, bd.health_record, " +
                "bd.fk_products_id, p.comercial_name, p.description " + // Incluyendo fk_products_id
                "FROM Buys_detail bd " +
                "JOIN Products p ON bd.fk_products_id = p.products_id " +
                "WHERE bd.fk_buys_Id = ?";

        try (Connection con = accesoDB.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCompra);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Buys_detail detalle = new Buys_detail();
                detalle.setBuyDetailId(rs.getInt("buy_detail_id"));
                detalle.setQuantity(rs.getInt("quantity"));
                detalle.setUnitPrice(rs.getBigDecimal("unit_price"));
                detalle.setTotalDetail(rs.getBigDecimal("total_detail"));
                detalle.setBatch(rs.getString("batch"));
                detalle.setExpireDate(String.valueOf(rs.getDate("expire_date")));
                detalle.setPresentation(rs.getString("presentation"));
                detalle.setHealthRecord(rs.getString("health_record"));
                detalle.setComercialName(rs.getString("comercial_name"));
                detalle.setFkproduct_id(rs.getInt("fk_products_id"));
                detalle.setDescriptionProduct(rs.getString("description"));


                // Si necesitas otros datos, añádelos aquí
                // Por ejemplo: detalle.setProductName(rs.getString("comercial_name"));

                detalles.add(detalle);
            }

            System.out.println("listado detalles exitoso");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return detalles;
    }

    public void insertPurchaseDetails(int buyId, List<Buys_detail> details) throws Exception {
        String insertDetailSql = "INSERT INTO Buys_detail (fk_buys_id, fk_products_id, quantity, unit_price, total_detail, batch, expire_date, presentation, health_record) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String updateInventorySql = "UPDATE Inventory SET quantity = quantity + ? WHERE inventory_id = (SELECT fk_inventory_id FROM Products WHERE products_id = ?)";

        try (Connection con = accesoDB.getCon();
             PreparedStatement detailPs = con.prepareStatement(insertDetailSql);
             PreparedStatement updateInventoryPs = con.prepareStatement(updateInventorySql)) {

            // Mapa para acumular las cantidades por producto
            Map<Integer, Integer> productQuantities = new HashMap<>();

            for (Buys_detail detail : details) {
                detailPs.setInt(1, buyId);
                detailPs.setInt(2, detail.getFkproduct_id());
                detailPs.setInt(3, detail.getQuantity());
                detailPs.setBigDecimal(4, detail.getUnitPrice());
                detailPs.setBigDecimal(5, detail.getTotalDetail());
                detailPs.setString(6, detail.getBatch());
                detailPs.setDate(7, java.sql.Date.valueOf(detail.getExpireDate()));
                detailPs.setString(8, detail.getPresentation());
                detailPs.setString(9, detail.getHealthRecord());
                detailPs.addBatch(); // Agregar al batch para optimizar inserciones

                // Acumular cantidad por producto
                productQuantities.merge(detail.getFkproduct_id(), detail.getQuantity(), Integer::sum);
            }
            detailPs.executeBatch(); // Ejecutar todas las inserciones en Buys_detail

            // Actualizar el inventario
            for (Map.Entry<Integer, Integer> entry : productQuantities.entrySet()) {
                int productId = entry.getKey();
                int totalQuantity = entry.getValue();

                updateInventoryPs.setInt(1, totalQuantity);
                updateInventoryPs.setInt(2, productId);
                updateInventoryPs.executeUpdate(); // Actualizar inventario por cada producto
            }

            System.out.println("Detalles ingresados y inventario actualizado");
        }
    }

    public void actualizarCompra(int buyId, List<Buys_detail> newDetails) throws Exception {
        String selectDetailsSql = "SELECT fk_products_id, quantity FROM Buys_detail WHERE fk_buys_Id = ?";
        String deleteDetailsSql = "DELETE FROM Buys_detail WHERE fk_buys_Id = ?";
        String insertDetailSql = "INSERT INTO Buys_detail (fk_buys_Id, fk_products_id, quantity, unit_price, total_detail, batch, expire_date, presentation, health_record) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String selectInventorySql = "SELECT quantity FROM Inventory WHERE inventory_id = (SELECT fk_inventory_id FROM Products WHERE products_id = ?)";
        String updateInventorySql = "UPDATE Inventory SET quantity = quantity + ? WHERE inventory_id = (SELECT fk_inventory_id FROM Products WHERE products_id = ?)";

        Map<Integer, Integer> currentQuantities = new HashMap<>();

        try (Connection con = accesoDB.getCon()) {
            con.setAutoCommit(false); // Iniciar transacción

            // Obtener los detalles actuales
            try (PreparedStatement psSelect = con.prepareStatement(selectDetailsSql)) {
                psSelect.setInt(1, buyId);
                ResultSet rs = psSelect.executeQuery();
                while (rs.next()) {
                    currentQuantities.put(rs.getInt("fk_products_id"), rs.getInt("quantity"));
                }
            }

            // Eliminar los detalles antiguos
            try (PreparedStatement psDelete = con.prepareStatement(deleteDetailsSql)) {
                psDelete.setInt(1, buyId);
                psDelete.executeUpdate();
            }

            // Insertar los nuevos detalles y actualizar el inventario
            try (PreparedStatement psInsert = con.prepareStatement(insertDetailSql);
                 PreparedStatement psSelectInventory = con.prepareStatement(selectInventorySql);
                 PreparedStatement psUpdateInventory = con.prepareStatement(updateInventorySql)) {

                for (Buys_detail detail : newDetails) {
                    // Insertar el nuevo detalle
                    psInsert.setInt(1, buyId);
                    psInsert.setInt(2, detail.getFkproduct_id());
                    psInsert.setInt(3, detail.getQuantity());
                    psInsert.setBigDecimal(4, detail.getUnitPrice());
                    psInsert.setBigDecimal(5, detail.getTotalDetail());
                    psInsert.setString(6, detail.getBatch());
                    psInsert.setDate(7, java.sql.Date.valueOf(detail.getExpireDate()));
                    psInsert.setString(8, detail.getPresentation());
                    psInsert.setString(9, detail.getHealthRecord());
                    psInsert.executeUpdate();

                    // Obtener la cantidad actual del inventario
                    psSelectInventory.setInt(1, detail.getFkproduct_id());
                    ResultSet inventoryRs = psSelectInventory.executeQuery();
                    int currentInventoryQuantity = 0;

                    if (inventoryRs.next()) {
                        currentInventoryQuantity = inventoryRs.getInt("quantity");
                    }

                    // Calcular el cambio de cantidad y actualizar el inventario
                    int previousQuantity = currentQuantities.getOrDefault(detail.getFkproduct_id(), 0); // Cantidad anterior
                    int quantityChange = detail.getQuantity() - previousQuantity; // Diferencia a aplicar

                    // Actualizar el inventario
                    if (quantityChange != 0) {
                        psUpdateInventory.setInt(1, quantityChange); // Puede ser positivo o negativo
                        psUpdateInventory.setInt(2, detail.getFkproduct_id());
                        psUpdateInventory.executeUpdate();
                    }
                }
            }

            con.commit(); // Confirmar transacción
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // Relanzar excepción
        }
    }
}








