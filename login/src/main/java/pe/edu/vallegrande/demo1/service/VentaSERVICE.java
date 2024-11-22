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
                    detalle.setDescuento(rsDetalle.getBigDecimal("Descuento"));
                    detalle.setTotalDetalle(rsDetalle.getBigDecimal("TotalDetalle"));
                    detalles.add(detalle);
                }
                venta.setDetalles(detalles);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return venta;
    }

    // Método para agregar una nueva venta con sus detalles
    public boolean agregarVenta(VentaDTO venta) {
        String ventaSql = "INSERT INTO Ventas (FK_ClienteID, FechaVenta, TotalProductoVendidos, PrecioTotal) VALUES (?, ?, ?, ?)";
        String detalleSql = "INSERT INTO DetalleVentas (FK_VentasID, FK_productoID, CantidadProducto, PrecioUnitario, Descuento, TotalDetalle) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = db.getCon();
             PreparedStatement psVenta = con.prepareStatement(ventaSql, Statement.RETURN_GENERATED_KEYS);
             PreparedStatement psDetalle = con.prepareStatement(detalleSql)) {

            // Agregar la venta
            psVenta.setInt(1, venta.getClienteID());
            psVenta.setDate(2, new java.sql.Date(venta.getFechaVenta().getTime()));
            psVenta.setInt(3, venta.getTotalProductosVendidos());
            psVenta.setBigDecimal(4, venta.getPrecioTotal());
            psVenta.executeUpdate();

            // Obtener el ID generado de la venta
            ResultSet generatedKeys = psVenta.getGeneratedKeys();
            int ventaID = 0;
            if (generatedKeys.next()) {
                ventaID = generatedKeys.getInt(1);
            }

            // Agregar cada detalle de venta
            for (DetalleVentaDTO detalle : venta.getDetalles()) {
                psDetalle.setInt(1, ventaID);
                psDetalle.setInt(2, detalle.getProductoID());
                psDetalle.setInt(3, detalle.getCantidad());
                psDetalle.setBigDecimal(4, detalle.getPrecioUnitario());
                psDetalle.setBigDecimal(5, detalle.getDescuento());
                psDetalle.setBigDecimal(6, detalle.getTotalDetalle());
                psDetalle.addBatch();
            }
            psDetalle.executeBatch();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
