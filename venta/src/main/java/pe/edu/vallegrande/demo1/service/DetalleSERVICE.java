package pe.edu.vallegrande.demo1.service;

import pe.edu.vallegrande.demo1.db.Conexion;
import pe.edu.vallegrande.demo1.dto.DetalleDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DetalleSERVICE {

    Conexion db = new Conexion();


    public List<DetalleDTO> listarDetallesVenta() {
        List<DetalleDTO> detalles = new ArrayList<>();
        String sql = "SELECT * FROM DetalleVentas";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DetalleDTO detalle = new DetalleDTO();
                detalle.setDetalleVentaID(rs.getInt("DetalleVentaID"));
                detalle.setFkVentaID(rs.getInt("FK_VentaID"));
                detalle.setFkProductoID(rs.getInt("FK_ProductoID"));
                detalle.setNombreProducto(rs.getString("NombreProducto"));
                detalle.setCantidad(rs.getInt("Cantidad"));
                detalle.setPrecioVenta(rs.getBigDecimal("PrecioVenta"));
                detalle.setDescuento(rs.getBigDecimal("Descuento"));
                detalle.setSubtotal(rs.getBigDecimal("Subtotal"));
                detalle.setMontoRecibido(rs.getBigDecimal("MontoRecibido"));
                detalle.setVuelto(rs.getBigDecimal("Vuelto"));
                detalle.setFechaVenta(rs.getString("FechaVenta"));
                detalle.setEstadoDetalle(rs.getString("EstadoDetalle"));

                detalles.add(detalle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detalles;
    }

    // Método para agregar un nuevo detalle de venta
    public void agregarDetalleVenta(DetalleDTO detalle) {
        String sql = "INSERT INTO DetalleVentas (FK_VentaID, FK_ProductoID, NombreProducto, Cantidad, PrecioVenta, Descuento, Subtotal, MontoRecibido, EstadoDetalle) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, detalle.getFkVentaID());
            ps.setInt(2, detalle.getFkProductoID());
            ps.setString(3, detalle.getNombreProducto());
            ps.setInt(4, detalle.getCantidad());
            ps.setBigDecimal(5, detalle.getPrecioVenta());
            ps.setBigDecimal(6, detalle.getDescuento());
            ps.setBigDecimal(7, detalle.getSubtotal());
            ps.setBigDecimal(8, detalle.getMontoRecibido());
            ps.setString(9, detalle.getEstadoDetalle());

            ps.executeUpdate();
            System.out.println("Detalle de venta agregado exitosamente.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


