package pe.edu.vallegrande.servicioautomotriz.service;

import pe.edu.vallegrande.servicioautomotriz.db.AccesoDB;
import pe.edu.vallegrande.servicioautomotriz.dto.SparePartDto;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SparePartService {
    public List<SparePartDto> getSpareParts() {
        List<SparePartDto> spareParts = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            cn = AccesoDB.getConnection();
            String sql = "SELECT * FROM spare_parts WHERE state = 'A';";
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                SparePartDto sparePart = new SparePartDto();
                sparePart.setId(rs.getInt("id"));
                sparePart.setName(rs.getString("name"));
                sparePart.setDescription(rs.getString("description"));
                sparePart.setPriceUnit(rs.getBigDecimal("price_unit"));
                sparePart.setBrand(rs.getString("brand"));
                sparePart.setStock(rs.getInt("stock"));
                sparePart.setCompatibleModel(rs.getString("compatible_model"));
                sparePart.setEntryDate(rs.getDate("entry_date"));
                sparePart.setState(rs.getString("state"));
                spareParts.add(sparePart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return spareParts;
    }

    public void insertSparePart(SparePartDto sparePart) {
        Connection cn = null;
        PreparedStatement ps = null;
        try {
            cn = AccesoDB.getConnection();
            String sql = "INSERT INTO spare_parts(name, description, price_unit, brand, stock, compatible_model, entry_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
            ps = cn.prepareStatement(sql);
            ps.setString(1, sparePart.getName());
            ps.setString(2, sparePart.getDescription());
            ps.setBigDecimal(3, sparePart.getPriceUnit());
            ps.setString(4, sparePart.getBrand());
            ps.setInt(5, sparePart.getStock());
            ps.setString(6, sparePart.getCompatibleModel());
            ps.setDate(7, sparePart.getEntryDate());
            ps.executeUpdate();
            System.out.println("Repuesto insertado exitosamente.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Repuesto no insertado exitosamente.");
        }
    }

    public void updateSparePart(SparePartDto sparePart) {
        Connection cn = null;
        PreparedStatement ps = null;
        try {
            cn = AccesoDB.getConnection();
            String sql = "UPDATE spare_parts SET name = ?, description = ?, price_unit = ?, brand = ?, stock = ?, compatible_model = ?, entry_date = ? WHERE id = ?";
            ps = cn.prepareStatement(sql);
            ps.setString(1, sparePart.getName());
            ps.setString(2, sparePart.getDescription());
            ps.setBigDecimal(3, sparePart.getPriceUnit());
            ps.setString(4, sparePart.getBrand());
            ps.setInt(5, sparePart.getStock());
            ps.setString(6, sparePart.getCompatibleModel());
            ps.setDate(7, sparePart.getEntryDate());
            ps.setInt(8, sparePart.getId());
            ps.executeUpdate();
            System.out.println("Repuesto actualizado exitosamente.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error al actualizar el repuesto.");
        }
    }
    public void deleteSparePart(int id) {
        Connection cn = null;
        PreparedStatement ps = null;
        try {
            cn = AccesoDB.getConnection();
            String sql = "UPDATE spare_parts SET state = 'I' WHERE id = ?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Repuesto eliminado lógicamente.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error al eliminar el repuesto.");
        } finally {
            try {
                if (ps != null) ps.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<SparePartDto> inactivo() {
        List<SparePartDto> spareParts = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            cn = AccesoDB.getConnection();
            String sql = "SELECT * FROM spare_parts WHERE state = 'I'";
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                SparePartDto sparePart = new SparePartDto();
                sparePart.setId(rs.getInt("id"));
                sparePart.setName(rs.getString("name"));
                sparePart.setDescription(rs.getString("description"));
                sparePart.setPriceUnit(rs.getBigDecimal("price_unit"));
                sparePart.setBrand(rs.getString("brand"));
                sparePart.setStock(rs.getInt("stock"));
                sparePart.setCompatibleModel(rs.getString("compatible_model"));
                sparePart.setEntryDate(rs.getDate("entry_date"));
                sparePart.setState(rs.getString("state"));
                spareParts.add(sparePart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return spareParts;
    }

    public void Restaurar(int id) {
        Connection cn = null;
        PreparedStatement ps = null;
        try {
            cn = AccesoDB.getConnection();
            String sql = "UPDATE spare_parts SET state = 'A' WHERE id = ?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Repuesto Restaurado.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error al Restaurar el repuesto.");
        } finally {
            try {
                if (ps != null) ps.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<SparePartDto> buscarRepuestos(String nombre, String marca) {
        List<SparePartDto> spareParts = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            cn = AccesoDB.getConnection();
            String sql = "SELECT * FROM spare_parts WHERE state = 'A' AND name LIKE ? AND brand LIKE ?";
            ps = cn.prepareStatement(sql);
            ps.setString(1, "%" + nombre + "%");
            ps.setString(2, "%" + marca + "%");
            rs = ps.executeQuery();

            while (rs.next()) {
                SparePartDto sparePart = new SparePartDto();
                sparePart.setId(rs.getInt("id"));
                sparePart.setName(rs.getString("name"));
                sparePart.setDescription(rs.getString("description"));
                sparePart.setPriceUnit(rs.getBigDecimal("price_unit"));
                sparePart.setBrand(rs.getString("brand"));
                sparePart.setStock(rs.getInt("stock"));
                sparePart.setCompatibleModel(rs.getString("compatible_model"));
                sparePart.setEntryDate(rs.getDate("entry_date"));
                sparePart.setState(rs.getString("state"));
                spareParts.add(sparePart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return spareParts;
    }

    public List<SparePartDto> buscarRepuestosInactivo(String nombre, String marca) {
        List<SparePartDto> spareParts = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            cn = AccesoDB.getConnection();
            String sql = "SELECT * FROM spare_parts WHERE state = 'I' AND name LIKE ? AND brand LIKE ?";
            ps = cn.prepareStatement(sql);
            ps.setString(1, "%" + nombre + "%");
            ps.setString(2, "%" + marca + "%");
            rs = ps.executeQuery();

            while (rs.next()) {
                SparePartDto sparePart = new SparePartDto();
                sparePart.setId(rs.getInt("id"));
                sparePart.setName(rs.getString("name"));
                sparePart.setDescription(rs.getString("description"));
                sparePart.setPriceUnit(rs.getBigDecimal("price_unit"));
                sparePart.setBrand(rs.getString("brand"));
                sparePart.setStock(rs.getInt("stock"));
                sparePart.setCompatibleModel(rs.getString("compatible_model"));
                sparePart.setEntryDate(rs.getDate("entry_date"));
                sparePart.setState(rs.getString("state"));
                spareParts.add(sparePart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return spareParts;
    }

}
