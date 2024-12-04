package pe.edu.vallegrande.demo1.service;

import pe.edu.vallegrande.demo1.db.Conexion;
import pe.edu.vallegrande.demo1.dto.DetalleVentaDTO;
import pe.edu.vallegrande.demo1.dto.ProductoDTO;
import pe.edu.vallegrande.demo1.dto.VentaDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class HistorialSERVICE {

    private Conexion db = new Conexion();

    // Método para listar todas las ventas
    public List<VentaDTO> ListarVenta(int id) {
        List<VentaDTO> detalles = new ArrayList<>();
        String sql = "SELECT v.FK_ClienteID, v.FechaVenta, v.TotalProductoVendidos, v.PrecioTotal, c.Nombre "
                + "FROM Ventas v "
                + "JOIN Clientes c ON v.FK_ClienteID = c.ClienteID "
                + "WHERE v.VentaID = ?";



        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();


            while (rs.next()) {
                VentaDTO venta = new VentaDTO();
                venta.setClienteID(rs.getInt("FK_ClienteID"));
                venta.setNombre(rs.getString("Nombre")); // Asignamos el nombre del cliente
                System.out.println(venta.getNombre());
                venta.setFechaVenta(rs.getDate("FechaVenta"));
                venta.setTotalProductosVendidos(rs.getInt("TotalProductoVendidos"));
                venta.setPrecioTotal(rs.getBigDecimal("PrecioTotal"));
                detalles.add(venta);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detalles;
    }

    // Método para listar todas las ventas
    public List<DetalleVentaDTO> VerDetalleVenta(int id) {
        List<DetalleVentaDTO> detalles = new ArrayList<>();
        // Consulta SQL
        String sql = "SELECT DV.DetalleVentaID, " +
                "DV.FK_ProductoID, " +
                "P.Nombre AS ProductoNombre, " +
                "DV.CantidadProducto, " +
                "DV.PrecioUnitario, " +
                "DV.Descuento, " +
                "DV.TotalDetalle " +
                "FROM DetalleVentas DV " +
                "INNER JOIN Productos P ON DV.FK_ProductoID = P.ProductoID " +
                "WHERE DV.FK_VentaID = ?";  // Usando el parámetro de VentaID

        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
        ) {
            // Establecer el parámetro antes de ejecutar la consulta
            ps.setInt(1, id);

            // Ahora ejecutas la consulta
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DetalleVentaDTO detalle = new DetalleVentaDTO();
                detalle.setNombreProducto(rs.getString("ProductoNombre")); // Asegúrate de usar el alias correcto
                detalle.setCantidad(rs.getInt("CantidadProducto"));
                detalle.setPrecioUnitario(rs.getBigDecimal("PrecioUnitario"));
                detalle.setTotalDetalle(rs.getBigDecimal("TotalDetalle"));
                detalles.add(detalle);
            }
            System.out.println("detalle encontrados");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detalles;
    }

}
