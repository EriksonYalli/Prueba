package pe.edu.vallegrande.service;

import pe.edu.vallegrande.Dto.BrandDto;
import pe.edu.vallegrande.Dto.CategoryDto;
import pe.edu.vallegrande.Dto.SparePartDto;
import pe.edu.vallegrande.db.AccesoDB;

import java.sql.*;
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
            String sql = "SELECT sp.id, sp.name, sp.description, sp.compatibility_type, sp.stock, sp.entry_date, sp.state, " +
                    "sp.category_id, sp.brand_id, " +
                    "c.name AS category_name, b.name AS brand_name " +
                    "FROM spare_parts sp " +
                    "JOIN Category c ON sp.category_id = c.id " +
                    "JOIN brand b ON sp.brand_id = b.id " +
                    "WHERE sp.state = 'A' " +
                    "ORDER BY sp.name ASC;"; // Aquí agregamos el orden ascendente
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                SparePartDto sparePart = new SparePartDto();
                sparePart.setId(rs.getInt("id"));
                sparePart.setName(rs.getString("name"));
                sparePart.setDescription(rs.getString("description"));
                sparePart.setCompatibilityType(rs.getString("compatibility_type"));
                sparePart.setStock(rs.getInt("stock"));
                sparePart.setEntryDate(rs.getDate("entry_date"));
                sparePart.setState(rs.getString("state"));
                sparePart.setCategoryId(rs.getInt("category_id"));
                sparePart.setBrandId(rs.getInt("brand_id"));
                sparePart.setCategoryName(rs.getString("category_name"));
                sparePart.setBrandName(rs.getString("brand_name"));
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
            String sql = "INSERT INTO spare_parts(name, description, compatibility_type, entry_date, category_id, brand_id) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
            ps = cn.prepareStatement(sql);

            ps.setString(1, sparePart.getName());
            ps.setString(2, sparePart.getDescription());
            ps.setString(3, sparePart.getCompatibilityType());
            ps.setDate(4, sparePart.getEntryDate());
            ps.setInt(5, sparePart.getCategoryId());
            ps.setInt(6, sparePart.getBrandId());

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
            String sql = "UPDATE spare_parts SET name = ?, description = ?, compatibility_type = ?, entry_date = ?, " +
                    "category_id = ?, brand_id = ? WHERE id = ?";
            ps = cn.prepareStatement(sql);
            ps.setString(1, sparePart.getName());
            ps.setString(2, sparePart.getDescription());
            ps.setString(3, sparePart.getCompatibilityType());
            ps.setDate(4, sparePart.getEntryDate());
            ps.setInt(5, sparePart.getCategoryId());
            ps.setInt(6, sparePart.getBrandId());
            ps.setInt(7, sparePart.getId());
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
            String sql = "SELECT sp.id, sp.name, sp.description, sp.compatibility_type, sp.stock, sp.entry_date, sp.state, " +
                    "sp.category_id, sp.brand_id, " +
                    "c.name AS category_name, b.name AS brand_name " +
                    "FROM spare_parts sp " +
                    "JOIN Category c ON sp.category_id = c.id " +
                    "JOIN brand b ON sp.brand_id = b.id " +
                    "WHERE sp.state = 'I' " +
                    "ORDER BY sp.name ASC;";
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                SparePartDto sparePart = new SparePartDto();
                sparePart.setId(rs.getInt("id"));
                sparePart.setName(rs.getString("name"));
                sparePart.setDescription(rs.getString("description"));
                sparePart.setCompatibilityType(rs.getString("compatibility_type"));
                sparePart.setStock(rs.getInt("stock"));
                sparePart.setEntryDate(rs.getDate("entry_date"));
                sparePart.setState(rs.getString("state"));
                sparePart.setCategoryId(rs.getInt("category_id"));
                sparePart.setBrandId(rs.getInt("brand_id"));
                sparePart.setCategoryName(rs.getString("category_name"));
                sparePart.setBrandName(rs.getString("brand_name"));
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

    public List<SparePartDto> buscarRepuestos(String nombre, Integer brandId) {
        List<SparePartDto> spareParts = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            cn = AccesoDB.getConnection();

            // Construir la consulta dinámica según los filtros
            StringBuilder sql = new StringBuilder("SELECT sp.id, sp.name, sp.description, sp.compatibility_type, sp.stock, sp.entry_date, sp.state, " +
                    "sp.category_id, sp.brand_id, " +
                    "c.name AS category_name, b.name AS brand_name " +
                    "FROM spare_parts sp " +
                    "JOIN Category c ON sp.category_id = c.id " +
                    "JOIN brand b ON sp.brand_id = b.id " +
                    "WHERE sp.state = 'A' AND sp.name LIKE ?");
            if (brandId != null) {
                sql.append(" AND sp.brand_id = ?");
            }

            ps = cn.prepareStatement(sql.toString());

            // Establecer los parámetros
            ps.setString(1, "%" + nombre + "%");
            if (brandId != null) {
                ps.setInt(2, brandId);
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                SparePartDto sparePart = new SparePartDto();
                sparePart.setId(rs.getInt("id"));
                sparePart.setName(rs.getString("name"));
                sparePart.setDescription(rs.getString("description"));
                sparePart.setCompatibilityType(rs.getString("compatibility_type"));
                sparePart.setStock(rs.getInt("stock"));
                sparePart.setEntryDate(rs.getDate("entry_date"));
                sparePart.setState(rs.getString("state"));
                sparePart.setCategoryId(rs.getInt("category_id"));
                sparePart.setBrandId(rs.getInt("brand_id"));
                sparePart.setCategoryName(rs.getString("category_name")); // Agregar el nombre de la categoría
                sparePart.setBrandName(rs.getString("brand_name"));       // Agregar el nombre de la marca
                spareParts.add(sparePart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return spareParts;
    }

    public List<SparePartDto> buscarRepuestosInactivo(String nombre, Integer brandId) {
        List<SparePartDto> spareParts = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            cn = AccesoDB.getConnection();

            // Construir la consulta dinámica según los filtros
            StringBuilder sql = new StringBuilder("SELECT sp.id, sp.name, sp.description, sp.compatibility_type, sp.stock, sp.entry_date, sp.state, " +
                    "sp.category_id, sp.brand_id, " +
                    "c.name AS category_name, b.name AS brand_name " +
                    "FROM spare_parts sp " +
                    "JOIN Category c ON sp.category_id = c.id " +
                    "JOIN brand b ON sp.brand_id = b.id " +
                    "WHERE sp.state = 'I' AND sp.name LIKE ?");
            if (brandId != null) {
                sql.append(" AND sp.brand_id = ?");
            }

            ps = cn.prepareStatement(sql.toString());

            // Establecer los parámetros
            ps.setString(1, "%" + nombre + "%");
            if (brandId != null) {
                ps.setInt(2, brandId);
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                SparePartDto sparePart = new SparePartDto();
                sparePart.setId(rs.getInt("id"));
                sparePart.setName(rs.getString("name"));
                sparePart.setDescription(rs.getString("description"));
                sparePart.setCompatibilityType(rs.getString("compatibility_type"));
                sparePart.setStock(rs.getInt("stock"));
                sparePart.setEntryDate(rs.getDate("entry_date"));
                sparePart.setState(rs.getString("state"));
                sparePart.setCategoryId(rs.getInt("category_id"));
                sparePart.setBrandId(rs.getInt("brand_id"));
                sparePart.setCategoryName(rs.getString("category_name"));
                sparePart.setBrandName(rs.getString("brand_name"));
                spareParts.add(sparePart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return spareParts;
    }

    public List<BrandDto> getBrands() {
        List<BrandDto> brands = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            cn = AccesoDB.getConnection();
            String sql = "SELECT * FROM brand";
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                BrandDto brand = new BrandDto();
                brand.setId(rs.getInt("id"));
                brand.setName(rs.getString("name"));
                brands.add(brand);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }

    public List<CategoryDto> getCategories() {
        List<CategoryDto> categories = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            cn = AccesoDB.getConnection();
            String sql = "SELECT * FROM Category"; // Asegúrate de que el nombre de la tabla sea correcto
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                CategoryDto category = new CategoryDto();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }
}
