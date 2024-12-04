package pe.edu.vallegrande.demo1.service;

import pe.edu.vallegrande.demo1.db.Conexion;
import pe.edu.vallegrande.demo1.dto.DetalleVentaDTO;
import pe.edu.vallegrande.demo1.dto.VentaDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class HistorialSERVICE {

    private Conexion db = new Conexion();

    // Método para listar todas las ventas
    public List<VentaDTO> ListarVenta() {
        List<VentaDTO> detalles = new ArrayList<>();
        String sql = "SELECT v.VentaID, v.FK_ClienteID, v.FechaVenta, v.TotalProductoVendidos, v.PrecioTotal, c.Nombre "
                + "FROM Ventas v "
                + "JOIN Clientes c ON v.FK_ClienteID = c.ClienteID";

        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                VentaDTO venta = new VentaDTO();
                venta.setVentaID(rs.getInt("VentaID"));
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

}
