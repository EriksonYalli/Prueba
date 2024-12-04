package pe.edu.vallegrande.demo1.service;

import pe.edu.vallegrande.demo1.db.Conexion;
import pe.edu.vallegrande.demo1.dto.VentaDTO;
import pe.edu.vallegrande.demo1.dto.DetalleVentaDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class VentaSERVICE {

    private Conexion db = new Conexion();

    // Método para listar todas las ventas
    public List<VentaDTO> listarVentas() {
        List<VentaDTO> ventas = new ArrayList<>();
        String sql = "SELECT * FROM Ventas";

        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                VentaDTO venta = new VentaDTO();
                venta.setVentaID(rs.getInt("VentaID"));
                venta.setClienteID(rs.getInt("FK_ClienteID"));
                venta.setFechaVenta(rs.getDate("FechaVenta"));
                venta.setTotalProductosVendidos(rs.getInt("TotalProductoVendidos"));
                venta.setPrecioTotal(rs.getBigDecimal("PrecioTotal"));
                ventas.add(venta);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ventas;
    }

    // Método para obtener una venta con sus detalles
    public VentaDTO obtenerVentaConDetalles(int ventaID) {
        VentaDTO venta = null;
        String ventaSql = "SELECT * FROM Ventas WHERE VentaID = ?";
        String detalleSql = "SELECT * FROM DetalleVentas WHERE FK_VentasID = ?";

        try (Connection con = db.getCon();
             PreparedStatement psVenta = con.prepareStatement(ventaSql);
             PreparedStatement psDetalle = con.prepareStatement(detalleSql)) {

            psVenta.setInt(1, ventaID);
            ResultSet rsVenta = psVenta.executeQuery();

            if (rsVenta.next()) {
                venta = new VentaDTO();
                venta.setVentaID(rsVenta.getInt("VentaID"));
                venta.setClienteID(rsVenta.getInt("FK_ClienteID"));
                venta.setFechaVenta(rsVenta.getDate("FechaVenta"));
                venta.setTotalProductosVendidos(rsVenta.getInt("TotalProductoVendidos"));
                venta.setPrecioTotal(rsVenta.getBigDecimal("PrecioTotal"));

                // Obtener los detalles de la venta
                psDetalle.setInt(1, ventaID);
                ResultSet rsDetalle = psDetalle.executeQuery();
                List<DetalleVentaDTO> detalles = new ArrayList<>();

                while (rsDetalle.next()) {
                    DetalleVentaDTO detalle = new DetalleVentaDTO();
                    detalle.setDetalleVentaID(rsDetalle.getInt("DetalleVentaID"));
                    detalle.setVentaID(rsDetalle.getInt("FK_VentasID"));
                    detalle.setProductoID(rsDetalle.getInt("FK_productoID"));
                    detalle.setCantidad(rsDetalle.getInt("CantidadProducto"));
                    detalle.setPrecioUnitario(rsDetalle.getBigDecimal("PrecioUnitario"));
                    detalle.setTotalDetalle(rsDetalle.getBigDecimal("TotalDetalle"));
                    detalles.add(detalle);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return venta;
    }


    public int insertSale(VentaDTO  venta) throws Exception {
        System.out.println("kakaroto");
        int VentaID = -1;
        String insertSaleSql = "INSERT INTO Ventas (FK_ClienteID, PrecioTotal, TotalProductoVendidos) VALUES (?, ?, ?)";

        try (Connection con = Conexion.getCon();
             PreparedStatement ps = con.prepareStatement(insertSaleSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            // Configuramos los parámetros del PreparedStatement
            ps.setInt(1, venta.getClienteID());
            ps.setBigDecimal(2, venta.getPrecioTotal());
            ps.setInt(3, venta.getTotalProductosVendidos());
            // Ejecutamos la consulta
            ps.executeUpdate();

            // Obtener el ID generado
            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                VentaID = generatedKeys.getInt(1);
            }
            System.out.println("Venta ingresada con éxito");
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error al insertar la venta", e);
        }

        return VentaID;
    }

    public void insertSaleDetails(int VentaID, List<DetalleVentaDTO> details) throws Exception {
        String insertDetailSql = "INSERT INTO DetalleVentas (FK_VentaID, FK_ProductoID, CantidadProducto, PrecioUnitario, TotalDetalle) VALUES (?, ?, ?, ?, ?)";
        Conexion conn = new Conexion();
        try (Connection con = conn.getCon();
             PreparedStatement detailPs = con.prepareStatement(insertDetailSql)) {

            // Recorrer los detalles y configurar el batch
            for (DetalleVentaDTO detail : details) {
                detailPs.setInt(1, VentaID); // ID de la venta
                detailPs.setInt(2, detail.getProductoID()); // ID del producto
                detailPs.setInt(3, detail.getCantidad()); // Cantidad vendida
                detailPs.setBigDecimal(4, detail.getPrecioUnitario()); // Precio de venta
                detailPs.setBigDecimal(5, detail.getTotalDetalle()); // Total del detalle
                detailPs.addBatch(); // Agregar al batch para optimizar inserciones
            }

            // Ejecutar todas las inserciones en Sale_details
            detailPs.executeBatch();

            System.out.println("Detalles de la venta ingresados correctamente");
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error al insertar los detalles de la venta",e);
        }
    }


}

