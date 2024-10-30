package pe.edu.vallegrande.service;

import pe.edu.vallegrande.db.ConexionDB;
import pe.edu.vallegrande.dto.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {

    // Método para listar productos
    public List<Product> listar() {
        List<Product> productos = new ArrayList<>();
        String sql = "SELECT * FROM product";
        try (Connection connection = ConexionDB.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                Product producto = new Product(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("description"),
                        resultSet.getString("trade_mark"),
                        resultSet.getInt("stock"),
                        resultSet.getBigDecimal("price"),
                        resultSet.getDate("expiration_date"),
                        resultSet.getInt("supplier_id")
                );
                productos.add(producto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }

    // Método para agregar un nuevo producto
    public int agregar(Product producto) {
        String sql = "INSERT INTO product (name, description, trade_mark, stock, price, expiration_date, supplier_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        int filasAfectadas = 0;
        try (Connection connection = ConexionDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, producto.getName());
            preparedStatement.setString(2, producto.getDescription());
            preparedStatement.setString(3, producto.getTradeMark()); // Cambia trade_mark a tradeMark
            preparedStatement.setInt(4, producto.getStock());
            preparedStatement.setBigDecimal(5, producto.getPrice());
            preparedStatement.setDate(6, producto.getExpirationDate()); // No es necesario hacer conversión
            preparedStatement.setInt(7, producto.getSupplierId()); // Cambia supplier_id a supplierId

            filasAfectadas = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al agregar producto: " + e.getMessage());
            e.printStackTrace();
        }
        return filasAfectadas;
    }


    // Método para editar un producto
    public int editar(Product producto) {
        String sql = "UPDATE product SET name = ?, description = ?, trade_mark = ?, stock = ?, price = ?, expiration_date = ? WHERE id = ?";
        int filasAfectadas = 0;
        try (Connection connection = ConexionDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, producto.getName());
            preparedStatement.setString(2, producto.getDescription());
            preparedStatement.setString(3, producto.getTradeMark());
            preparedStatement.setInt(4, producto.getStock());
            preparedStatement.setBigDecimal(5, producto.getPrice());
            preparedStatement.setDate(6, producto.getExpirationDate());
            preparedStatement.setInt(7, producto.getId());

            filasAfectadas = preparedStatement.executeUpdate();

            if (filasAfectadas > 0) {
                System.out.println("Producto actualizado exitosamente.");
            } else {
                System.out.println("No se encontró ningún producto con el ID: " + producto.getId());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return filasAfectadas;
    }

    // Método para eliminar un producto por su ID
    public int eliminar(int id) {
        String sql = "DELETE FROM product WHERE id = ?";
        int filasAfectadas = 0;
        try (Connection connection = ConexionDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, id);
            filasAfectadas = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return filasAfectadas;
    }

    // Método para buscar un producto por su ID
    public Product buscarPorId(int id) {
        Product producto = null;
        String sql = "SELECT * FROM product WHERE id = ?";
        try (Connection connection = ConexionDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                producto = new Product(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("description"),
                        resultSet.getString("trade_mark"),
                        resultSet.getInt("stock"),
                        resultSet.getBigDecimal("price"),
                        resultSet.getDate("expiration_date"),
                        resultSet.getInt("supplier_id")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return producto;
    }
}
