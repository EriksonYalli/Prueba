package pe.edu.vallegrande.service;

import pe.edu.vallegrande.db.ConexionDB;
import pe.edu.vallegrande.dto.Supplier;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SupplierService {

    public List<Supplier> listar() {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Proveedores.Supplier WHERE status = 'A'";
        try (Connection connection = ConexionDB.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                Supplier supplier = new Supplier(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("direction"),
                        resultSet.getString("email"),
                        resultSet.getString("ruc"),
                        resultSet.getString("representative"),
                        resultSet.getString("email_representative"),
                        resultSet.getString("phone_representative"),
                        resultSet.getString("status").charAt(0)
                );
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    public int agregar(Supplier supplier) {
        String sql = "INSERT INTO Proveedores.Supplier (name, direction, email, ruc, representative, email_representative, phone_representative) VALUES (?, ?, ?, ?, ?, ?, ?)";
        int filasAfectadas = 0;
        try (Connection connection = ConexionDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, supplier.getName());
            preparedStatement.setString(2, supplier.getDirection());
            preparedStatement.setString(3, supplier.getEmail());
            preparedStatement.setString(4, supplier.getRuc());
            preparedStatement.setString(5, supplier.getRepresentative());
            preparedStatement.setString(6, supplier.getEmailRepresentative());
            preparedStatement.setString(7, supplier.getPhoneRepresentative());

            filasAfectadas = preparedStatement.executeUpdate();
            if (filasAfectadas > 0) {
                System.out.println("Proveedor agregado exitosamente.");
            } else {
                System.out.println("No se pudo agregar el proveedor.");
            }
        } catch (SQLException e) {
            System.err.println("Error al agregar proveedor: " + e.getMessage());
            e.printStackTrace();
        }
        return filasAfectadas;
    }


    public int editar(Supplier supplier) {
        String sql = "UPDATE Proveedores.Supplier SET name = ?, direction = ?, email = ?, ruc = ?, representative = ?, email_representative = ?, phone_representative = ? WHERE id = ?";
        int filasAfectadas = 0;
        try (Connection connection = ConexionDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, supplier.getName());
            preparedStatement.setString(2, supplier.getDirection());
            preparedStatement.setString(3, supplier.getEmail());
            preparedStatement.setString(4, supplier.getRuc());
            preparedStatement.setString(5, supplier.getRepresentative());
            preparedStatement.setString(6, supplier.getEmailRepresentative());
            preparedStatement.setString(7, supplier.getPhoneRepresentative());
            preparedStatement.setInt(8, supplier.getId());

            filasAfectadas = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return filasAfectadas;
    }


    public int eliminar(int id) {
        String sql = "UPDATE Proveedores.Supplier SET status = 'I' WHERE id = ?";
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


    public Supplier buscarPorId(int id) {
        Supplier supplier = null;
        String sql = "SELECT * FROM Proveedores.Supplier WHERE id = ?";
        try (Connection connection = ConexionDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                supplier = new Supplier(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("direction"),
                        resultSet.getString("email"),
                        resultSet.getString("ruc"),
                        resultSet.getString("representative"),
                        resultSet.getString("email_representative"),
                        resultSet.getString("phone_representative"),
                        resultSet.getString("status").charAt(0)
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return supplier;
    }
    public List<Supplier> listarInactivos() {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Proveedores.Supplier WHERE status = 'I'";
        try (Connection connection = ConexionDB.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                Supplier supplier = new Supplier(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("direction"),
                        resultSet.getString("email"),
                        resultSet.getString("ruc"),
                        resultSet.getString("representative"),
                        resultSet.getString("email_representative"),
                        resultSet.getString("phone_representative"),
                        resultSet.getString("status").charAt(0)
                );
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    public int restaurar(int id) {
        String sql = "UPDATE Proveedores.Supplier SET status = 'A' WHERE id = ?";
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
    public List<Supplier> buscarPorNombre(String name) {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Proveedores.Supplier WHERE status = 'A' AND name LIKE ?";

        try (Connection connection = ConexionDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, "%" + name + "%"); // Usar LIKE para buscar
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Supplier supplier = new Supplier(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("direction"),
                        resultSet.getString("email"),
                        resultSet.getString("ruc"),
                        resultSet.getString("representative"),
                        resultSet.getString("email_representative"),
                        resultSet.getString("phone_representative"),
                        resultSet.getString("status").charAt(0)
                );
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }
    public List<Supplier> buscarPorRuc(String ruc) {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Proveedores.Supplier WHERE status = 'A' AND ruc LIKE ?";

        try (Connection connection = ConexionDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, "%" + ruc + "%"); // Usar LIKE para buscar
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Supplier supplier = new Supplier(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("direction"),
                        resultSet.getString("email"),
                        resultSet.getString("ruc"),
                        resultSet.getString("representative"),
                        resultSet.getString("email_representative"),
                        resultSet.getString("phone_representative"),
                        resultSet.getString("status").charAt(0)
                );
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }
    public List<Supplier> buscarPorNombreInactivos(String name) {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Proveedores.Supplier WHERE status = 'I' AND name LIKE ?";

        try (Connection connection = ConexionDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, "%" + name + "%"); // Usar LIKE para buscar
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Supplier supplier = new Supplier(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("direction"),
                        resultSet.getString("email"),
                        resultSet.getString("ruc"),
                        resultSet.getString("representative"),
                        resultSet.getString("email_representative"),
                        resultSet.getString("phone_representative"),
                        resultSet.getString("status").charAt(0)
                );
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    public List<Supplier> buscarPorRucInactivos(String ruc) {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Proveedores.Supplier WHERE status = 'I' AND ruc LIKE ?";

        try (Connection connection = ConexionDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, "%" + ruc + "%"); // Usar LIKE para buscar
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Supplier supplier = new Supplier(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("direction"),
                        resultSet.getString("email"),
                        resultSet.getString("ruc"),
                        resultSet.getString("representative"),
                        resultSet.getString("email_representative"),
                        resultSet.getString("phone_representative"),
                        resultSet.getString("status").charAt(0)
                );
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }




}
