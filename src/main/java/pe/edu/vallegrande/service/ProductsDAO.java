package pe.edu.vallegrande.service;

import pe.edu.vallegrande.db.AccesoDB;
import pe.edu.vallegrande.dto.Products;


import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class ProductsDAO {
    private final AccesoDB db = new AccesoDB();

    public List<Products> listar() {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT " +
                "p.products_id, " +
                "p.comercial_name, " +
                "p.generic_name, " +
                "p.formulation, " +
                "p.brand, " +
                "p.description, " +
                "c.category_name, " + // Traemos el nombre de la categoría
                "p.sale_price, " +
                "p.unit, " +
                "s.name AS supplier_name, " + // Traemos el nombre del proveedor
                "p.status, " +
                "p.concentration, " +
                "p.concentration_unit, " +
                "p.action_mode, " +
                "cr.name, " +
                "p.pests_diseases, " +
                "p.recomended_dose, " +
                "p.precautions, " +
                "i.quantity " +
                "FROM Products p " +
                "LEFT JOIN Category c ON p.fk_category_id = c.category_id " + // Relacionamos correctamente
                "LEFT JOIN Inventory i ON p.fk_inventory_id = i.inventory_id " +
                "LEFT JOIN Suppliers s ON p.fk_suppliers_id = s.suppliers_id " +
                "LEFT JOIN Crops cr ON p.fk_crops_id = cr.crops_id " +
                "WHERE p.status = 'A'"; // Filtramos solo productos activos

        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Products pro = new Products();
                pro.setProducts_id(rs.getInt("products_id"));
                pro.setComercial_name(rs.getString("comercial_name"));
                pro.setGeneric_name(rs.getString("generic_name"));
                pro.setFormulation(rs.getString("formulation"));
                pro.setBrand(rs.getString("brand"));
                pro.setDescription(rs.getString("description"));
                pro.setCategory(rs.getString("category_name"));
                pro.setSales_price(rs.getBigDecimal("sale_price"));
                pro.setUnit(rs.getString("unit"));
                pro.setNameSuppliers(rs.getString("supplier_name")); // Cambiado a nombre del proveedor
                pro.setStatus(rs.getString("status"));
                pro.setConcentration(BigDecimal.valueOf(rs.getInt("concentration")));
                pro.setConcentration_unit(rs.getString("concentration_unit"));
                pro.setAction_mode(rs.getString("action_mode"));
                pro.setCrops(rs.getString("name"));
                pro.setPests_Diseases(rs.getString("pests_Diseases"));
                pro.setRecomended_dose(rs.getString("recomended_dose"));
                pro.setPrecautions(rs.getString("precautions"));
                pro.setQuantity(rs.getInt("quantity"));
                list.add(pro);

            }
            System.out.println("Listado exitoso");
        } catch (Exception e) {
            e.printStackTrace(); // Consider using a logging framework
        }
        return list;
    }

    public List<Products> inactivos() {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT " +
                "p.products_id, " +
                "p.comercial_name, " +
                "p.generic_name, " +
                "p.formulation, " +
                "p.brand, " +
                "p.description, " +
                "c.category_name, " + // Traemos el nombre de la categoría
                "p.sale_price, " +
                "p.unit, " +
                "s.name AS supplier_name, " + // Traemos el nombre del proveedor
                "p.status, " +
                "p.concentration, " +
                "p.concentration_unit, " +
                "p.action_mode, " +
                "cr.name, " +
                "p.pests_diseases, " +
                "p.recomended_dose, " +
                "p.precautions, " +
                "i.quantity " +
                "FROM Products p " +
                "LEFT JOIN Category c ON p.fk_category_id = c.category_id " + // Relacionamos correctamente
                "LEFT JOIN Inventory i ON p.fk_inventory_id = i.inventory_id " +
                "LEFT JOIN Suppliers s ON p.fk_suppliers_id = s.suppliers_id " +
                "LEFT JOIN Crops cr ON p.fk_crops_id = cr.crops_id " +
                "WHERE p.status = 'I'"; // Filtramos solo productos activos

        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Products pro = new Products();
                pro.setProducts_id(rs.getInt("products_id"));
                pro.setComercial_name(rs.getString("comercial_name"));
                pro.setGeneric_name(rs.getString("generic_name"));
                pro.setFormulation(rs.getString("formulation"));
                pro.setBrand(rs.getString("brand"));
                pro.setDescription(rs.getString("description"));
                pro.setCategory(rs.getString("category_name"));
                pro.setSales_price(rs.getBigDecimal("sale_price"));
                pro.setUnit(rs.getString("unit"));
                pro.setNameSuppliers(rs.getString("supplier_name")); // Cambiado a nombre del proveedor
                pro.setStatus(rs.getString("status"));
                pro.setConcentration(BigDecimal.valueOf(rs.getInt("concentration")));
                pro.setConcentration_unit(rs.getString("concentration_unit"));
                pro.setAction_mode(rs.getString("action_mode"));
                pro.setCrops(rs.getString("name"));
                pro.setPests_Diseases(rs.getString("pests_Diseases"));
                pro.setRecomended_dose(rs.getString("recomended_dose"));
                pro.setPrecautions(rs.getString("precautions"));
                pro.setQuantity(rs.getInt("quantity"));
                list.add(pro);

            }
            System.out.println("Listado Inactivos");
        } catch (Exception e) {
            e.printStackTrace(); // Consider using a logging framework
        }
        return list;
    }


    public Products listEdit(int id) {
        String sql = "SELECT * FROM products WHERE products_id = ?";
        Products p = null;

        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p = new Products();
                p.setProducts_id(rs.getInt("products_id"));
                p.setComercial_name(rs.getString("comercial_name")); // Cambiado a comercial_name
                p.setGeneric_name(rs.getString("generic_name")); // Nuevo campo
                p.setFormulation(rs.getString("formulation")); // Nuevo campo
                p.setBrand(rs.getString("brand")); // Nuevo campo
                p.setDescription(rs.getString("description"));
                p.setSales_price(rs.getBigDecimal("sale_price")); // Cambiado a sales_price
                p.setUnit(rs.getString("unit"));
                p.setNameSuppliers(rs.getString("fk_suppliers_id"));
                p.setCategory(rs.getString("fk_category_id"));// Cambiado a suppliers_id
                p.setStatus(rs.getString("status")); // Cambiado a minúscula
                p.setConcentration(BigDecimal.valueOf(rs.getInt("concentration"))); // Nuevo campo
                p.setConcentration_unit(rs.getString("concentration_unit"));
                p.setAction_mode(rs.getString("action_mode")); // Nuevo campo
                p.setCrops(rs.getString("fk_crops_id")); // Nuevo campo
                p.setPests_Diseases(rs.getString("pests_Diseases")); // Nuevo campo
                p.setRecomended_dose(rs.getString("recomended_dose")); // Nuevo campo
                p.setPrecautions(rs.getString("precautions")); // Nuevo campo

            }
        } catch (Exception e) {
            e.printStackTrace(); // Consider using a logging framework
        }

        return p;
    }


    public boolean add(Products p) {
        String sqlProduct = "INSERT INTO Products (" +
                "comercial_name, " +
                "generic_name, " +
                "formulation, " +
                "brand, " +
                "description, " +
                "fk_category_id, " +
                "sale_price, " +
                "unit, " +
                "fk_suppliers_id, " +
                "concentration, " +
                "concentration_unit, " +
                "action_mode, " +
                "fk_crops_id, " +
                "pests_Diseases, " +
                "recomended_dose, " +
                "precautions, " +
                "fk_inventory_id" + // Agregar FK de inventario
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String sqlInventory = "INSERT INTO Inventory (quantity) VALUES (?)";

        try (Connection con = db.getCon();
             PreparedStatement psInventory = con.prepareStatement(sqlInventory, Statement.RETURN_GENERATED_KEYS);
             PreparedStatement psProduct = con.prepareStatement(sqlProduct)) {

            // Inserción en Inventory
            psInventory.setInt(1, 0); // Inicializar con 0
            psInventory.executeUpdate();

            // Obtener el ID del inventario recién insertado
            ResultSet rs = psInventory.getGeneratedKeys();
            int inventoryId = 0;
            if (rs.next()) {
                inventoryId = rs.getInt(1);
            }

            // Inserción en Products con el ID del inventario
            psProduct.setString(1, p.getComercial_name());
            psProduct.setString(2, p.getGeneric_name());
            psProduct.setString(3, p.getFormulation());
            psProduct.setString(4, p.getBrand());
            psProduct.setString(5, p.getDescription());
            psProduct.setString(6, p.getCategory());
            psProduct.setBigDecimal(7, p.getSales_price());
            psProduct.setString(8, p.getUnit());
            psProduct.setString(9, p.getNameSuppliers());
            psProduct.setBigDecimal(10, p.getConcentration());
            psProduct.setString(11, p.getConcentration_unit());
            psProduct.setString(12, p.getAction_mode());
            psProduct.setString(13, p.getCrops());
            psProduct.setString(14, p.getPests_Diseases());
            psProduct.setString(15, p.getRecomended_dose());
            psProduct.setString(16, p.getPrecautions());
            psProduct.setInt(17, inventoryId); // Asignar el ID del inventario

            psProduct.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace(); // Consider using a logging framework
        }

        return false;
    }


    public boolean edit(Products p) {
        String sql = "UPDATE Products SET " +
                "comercial_name = ?, " + // Cambiado a comercial_name
                "generic_name = ?, " + // Nuevo campo
                "formulation = ?, " + // Nuevo campo
                "brand = ?, " + // Nuevo campo
                "description = ?, " +
                "fk_category_id = ?," +
                "sale_price = ?, " + // Cambiado a sales_price
                "unit = ?, " +// Cambiado a suppliers_id
                "concentration = ?," +
                "concentration_unit =?," + // Nuevo campo
                "action_mode = ?, " + // Nuevo campo
                "fk_crops_id = ?, " + // Nuevo campo
                "pests_Diseases = ?, " + // Nuevo campo
                "recomended_dose = ?, " + // Nuevo campo
                "precautions = ? " + // Nuevo campo
                "WHERE products_id = ?";


        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getComercial_name()); // Cambiado a comercial_name
            ps.setString(2, p.getGeneric_name()); // Nuevo campo
            ps.setString(3, p.getFormulation()); // Nuevo campo
            ps.setString(4, p.getBrand()); // Nuevo campo
            ps.setString(5, p.getDescription());
            ps.setString(6, p.getCategory());
            ps.setBigDecimal(7, p.getSales_price()); // Cambiado a sales_price
            ps.setString(8, p.getUnit());
            ps.setBigDecimal(9, p.getConcentration());
            ps.setString(10, p.getConcentration_unit());// Nuevo campo
            ps.setString(11, p.getAction_mode()); // Nuevo campo
            ps.setString(12, p.getCrops()); // Nuevo campo
            ps.setString(13, p.getPests_Diseases()); // Nuevo campo
            ps.setString(14, p.getRecomended_dose()); // Nuevo campo
            ps.setString(15, p.getPrecautions()); // Nuevo campo
            ps.setInt(16, p.getProducts_id());
            ps.executeUpdate();

            System.out.println("Datos actualizados");
            return true;

        } catch (Exception e) {
            e.printStackTrace(); // Consider using a logging framework
        }

        return false;
    }


    public boolean eliminar(int id) {
        String sql = "UPDATE Products SET Status = ? WHERE products_id = ?";

        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Establece el estado para indicar que el producto está "eliminado" (por ejemplo, 0 o "eliminado")
            ps.setString(1, "I"); // o usa un valor específico según tu lógica
            ps.setInt(2, id);


            int filasActualizadas = ps.executeUpdate();
            System.out.println("Eliminado correcto");
            return filasActualizadas > 0; // Devuelve verdadero si se actualizó al menos una fila

        } catch (Exception e) {
            e.printStackTrace(); // Considera usar un marco de logging
        }

        return false;
    }


    public boolean Restore(int id) {
        String sql = "UPDATE Products SET Status = ? WHERE products_id = ?";

        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Establece el estado para indicar que el producto está "eliminado" (por ejemplo, 0 o "eliminado")
            ps.setString(1, "A"); // o usa un valor específico según tu lógica
            ps.setInt(2, id);

            int filasActualizadas = ps.executeUpdate();
            return filasActualizadas > 0; // Devuelve verdadero si se actualizó al menos una fila

        } catch (Exception e) {
            e.printStackTrace(); // Considera usar un marco de logging
        }


        return false;
    }


    public List<Products> listarPorFiltro(String search) {
        String searchValue = "%" + search + "%";
        List<Products> productos = new ArrayList<>();

        String sql = "SELECT " +
                "p.products_id, " +
                "p.comercial_name, " +
                "p.generic_name, " +
                "p.formulation, " +
                "p.brand, " +
                "p.description, " +
                "c.category_name, " +
                "p.sale_price, " +
                "p.unit, " +
                "s.name AS supplier_name, " +
                "p.status, " +
                "p.concentration, " +
                "p.concentration_unit, " +
                "p.action_mode, " +
                "cr.name AS crop_name, " +
                "p.pests_diseases, " +
                "p.recomended_dose, " +
                "p.precautions, " +
                "i.quantity " +
                "FROM Products p " +
                "LEFT JOIN Category c ON p.fk_category_id = c.category_id " +
                "LEFT JOIN Inventory i ON p.fk_inventory_id = i.inventory_id " +
                "LEFT JOIN Suppliers s ON p.fk_suppliers_id = s.suppliers_id " +
                "LEFT JOIN Crops cr ON p.fk_crops_id = cr.crops_id " +
                "WHERE p.status = 'A' " +
                "AND (p.products_id LIKE ? OR " +
                "p.brand LIKE ? OR " +
                "p.comercial_name LIKE ?)";

        try (Connection con = db.getCon();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, searchValue); // Para products_id
            stmt.setString(2, searchValue); // Para brand
            stmt.setString(3, searchValue); // Para comercial_name

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Procesa los resultados
                Products producto = new Products();
                producto.setProducts_id(rs.getInt("products_id"));
                producto.setComercial_name(rs.getString("comercial_name"));
                producto.setGeneric_name(rs.getString("generic_name"));
                producto.setFormulation(rs.getString("formulation"));
                producto.setBrand(rs.getString("brand"));
                producto.setDescription(rs.getString("description"));
                producto.setCategory(rs.getString("category_name"));
                producto.setSales_price(rs.getBigDecimal("sale_price"));
                producto.setUnit(rs.getString("unit"));
                producto.setStatus(rs.getString("status"));
                producto.setConcentration(rs.getBigDecimal("concentration"));
                producto.setConcentration_unit(rs.getString("concentration_unit"));
                producto.setAction_mode(rs.getString("action_mode"));
                producto.setCrops(rs.getString("crop_name"));
                producto.setPests_Diseases(rs.getString("pests_diseases"));
                producto.setRecomended_dose(rs.getString("recomended_dose"));
                producto.setPrecautions(rs.getString("precautions"));
                producto.setQuantity(rs.getInt("quantity"));

                productos.add(producto);
                System.out.println(producto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }
}