package pe.edu.vallegrande.service;

import pe.edu.vallegrande.Dto.SupplierDto;
import pe.edu.vallegrande.db.AccesoDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SupplierService {
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    // Método para buscar un proveedor por ID
    public SupplierDto buscar(int id) {
        SupplierDto supplier = null;
        String sql = "SELECT * FROM Supplier WHERE id = ?";
        try {
            con = AccesoDB.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                supplier = new SupplierDto();
                supplier.setId(rs.getInt("id"));
                supplier.setRuc(rs.getString("RUC"));
                supplier.setCompany(rs.getString("company"));
                supplier.setContact(rs.getString("contact"));
                supplier.setTelefono(rs.getString("telefono"));
                supplier.setStatus(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return supplier;
    }

    // Método para listar todos los proveedores activos
    public List<SupplierDto> getSuppliers() {
        List<SupplierDto> suppliers = new ArrayList<>();
        String sql = "SELECT id, RUC, Empresa, status, Contacto FROM Supplier WHERE status = 'A'";
        try {
            con = AccesoDB.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                SupplierDto supplier = new SupplierDto();
                supplier.setId(rs.getInt("id"));
                supplier.setRuc(rs.getString("RUC"));
                supplier.setCompany(rs.getString("Empresa")); // Ajustado
                supplier.setContact(rs.getString("Contacto")); // Ajustado
                supplier.setStatus(rs.getString("status"));
                suppliers.add(supplier);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return suppliers;
    }
}
