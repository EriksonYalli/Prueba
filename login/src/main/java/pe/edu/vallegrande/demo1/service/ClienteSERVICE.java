package pe.edu.vallegrande.demo1.service;

import pe.edu.vallegrande.demo1.db.Conexion;
import pe.edu.vallegrande.demo1.dto.ClienteDTO;
import pe.edu.vallegrande.demo1.dto.ProductoDTO;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class ClienteSERVICE {

    static Conexion db = new Conexion();

    // Método para listar todos los clientes
    public List<ClienteDTO> listarClientes() {
        List<ClienteDTO> clientes = new ArrayList<>();
        String sql = "SELECT * FROM Clientes WHERE Estatus= 'A'";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ClienteDTO cliente = new ClienteDTO();
                cliente.setClienteID(rs.getInt("ClienteID"));
                cliente.setNombre(rs.getString("Nombre"));
                cliente.setApellido(rs.getString("Apellido"));
                cliente.setTipoDocumento(rs.getString("TipoDocumento"));
                cliente.setNumeroDocumento(rs.getString("NumeroDocumento"));
                cliente.setFechaNacimiento(rs.getString("FechaNacimiento"));
                cliente.setCelular(rs.getString("Celular"));
                cliente.setEmail(rs.getString("Email"));
                cliente.setDireccion(rs.getString("Direccion"));
                cliente.setFechaRegistro(rs.getString("FechaRegistro"));
                cliente.setEstatus(rs.getString("Estatus"));
                clientes.add(cliente);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return clientes;
    }


    // Método para listar todos los clientes
    public List<ClienteDTO> listarClientesInactivos() {
        List<ClienteDTO> clientes = new ArrayList<>();
        String sql = "SELECT * FROM Clientes WHERE Estatus = 'I'";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ClienteDTO cliente = new ClienteDTO();
                cliente.setClienteID(rs.getInt("ClienteID"));
                cliente.setNombre(rs.getString("Nombre"));
                cliente.setApellido(rs.getString("Apellido"));
                cliente.setTipoDocumento(rs.getString("TipoDocumento"));
                cliente.setNumeroDocumento(rs.getString("NumeroDocumento"));
                cliente.setFechaNacimiento(rs.getString("FechaNacimiento"));
                cliente.setCelular(rs.getString("Celular"));
                cliente.setEmail(rs.getString("Email"));
                cliente.setDireccion(rs.getString("Direccion"));
                cliente.setFechaRegistro(rs.getString("FechaRegistro"));
                cliente.setEstatus(rs.getString("Estatus"));
                clientes.add(cliente);
            }
            System.out.println("Listado de Inactivos");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return clientes;
    }




    // Método para agregar un cliente nuevo
    public void agregarCliente(ClienteDTO cliente) {
        String sql = "INSERT INTO Clientes (Nombre, Apellido, TipoDocumento, NumeroDocumento, FechaNacimiento, Celular, Email, Direccion, FechaRegistro, Estatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getApellido());
            ps.setString(3, cliente.getTipoDocumento());
            ps.setString(4, cliente.getNumeroDocumento());
            ps.setDate(5, java.sql.Date.valueOf(cliente.getFechaNacimiento()));
            ps.setString(6, cliente.getCelular());
            ps.setString(7, cliente.getEmail());
            ps.setString(8, cliente.getDireccion());

            // Convierte la fecha en Timestamp
            ps.setTimestamp(9, java.sql.Timestamp.valueOf(cliente.getFechaRegistro()));

            ps.setString(10, cliente.getEstatus());

            ps.executeUpdate();
            System.out.println("Cliente agregado exitosamente.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // Método para contar clientes activos
    public int contarClientesActivos() {
        int totalClientesActivos = 0;
        String sql = "SELECT COUNT(*) FROM Clientes WHERE Estatus = 'A'";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalClientesActivos = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalClientesActivos;
    }

    // Método para obtener un cliente por su ID
    public ClienteDTO editarPorId(int clienteID) {
        String sql = "SELECT * FROM Clientes WHERE ClienteID = ?";
        ClienteDTO clienteDTO = null;
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, clienteID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                clienteDTO = new ClienteDTO();
                clienteDTO.setClienteID(rs.getInt("ClienteID"));
                clienteDTO.setNombre(rs.getString("Nombre"));
                clienteDTO.setApellido(rs.getString("Apellido"));
                clienteDTO.setTipoDocumento(rs.getString("TipoDocumento"));
                clienteDTO.setNumeroDocumento(rs.getString("NumeroDocumento"));
                Date fechaNacimiento = rs.getDate("FechaNacimiento");
                if (fechaNacimiento != null) {
                    clienteDTO.setFechaNacimiento(new SimpleDateFormat("yyyy-MM-dd").format(fechaNacimiento));
                }
                clienteDTO.setCelular(rs.getString("Celular"));
                clienteDTO.setEmail(rs.getString("Email"));
                clienteDTO.setDireccion(rs.getString("Direccion"));
                Timestamp fechaRegistro = rs.getTimestamp("FechaRegistro");
                if (fechaRegistro != null) {
                    clienteDTO.setFechaRegistro(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").format(fechaRegistro));
                }
                clienteDTO.setEstatus(rs.getString("Estatus"));
            }
            System.out.println("Cliente encontrado.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return clienteDTO;
    }

    // Método para actualizar un cliente
    public void actualizarCliente(ClienteDTO cliente) {
        String sql = "UPDATE Clientes SET Nombre = ?, Apellido = ?, TipoDocumento = ?, NumeroDocumento = ?, FechaNacimiento = ?, Celular = ?, Email = ?, Direccion = ? WHERE ClienteID = ?";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getApellido());
            ps.setString(3, cliente.getTipoDocumento());
            ps.setString(4, cliente.getNumeroDocumento());
            ps.setDate(5, java.sql.Date.valueOf(cliente.getFechaNacimiento()));
            ps.setString(6, cliente.getCelular());
            ps.setString(7, cliente.getEmail());
            ps.setString(8, cliente.getDireccion());
            ps.setInt(9, cliente.getClienteID());

            ps.executeUpdate();
            System.out.println("Cliente actualizado exitosamente.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Método para desactivar (eliminar lógicamente) un cliente por su ID
    public boolean eliminarClienteID(int id) {
        String sql = "UPDATE Clientes SET Estatus = 'I' WHERE ClienteID = ?";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            int filasActualizadas = ps.executeUpdate();
            System.out.println("Cliente eliminado exitosamente.");
            return filasActualizadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Método para restaurar un cliente (activar) por su ID
    public boolean restaurarClienteID(int id) {
        String sql = "UPDATE Clientes SET Estatus = 'A' WHERE ClienteID = ?";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            int filasActualizadas = ps.executeUpdate();
            System.out.println("Cliente restaurado exitosamente.");
            return filasActualizadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    // Método para obtener un cliente por su DNI
    public static ClienteDTO buscarCliente(String dni) {
        String sql = "SELECT * FROM Clientes WHERE NumeroDocumento = ?";
        ClienteDTO clienteDTO = null;
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, dni);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                clienteDTO = new ClienteDTO();
                clienteDTO.setNombre(rs.getString("Nombre"));
                clienteDTO.setApellido(rs.getString("Apellido"));
                clienteDTO.setNumeroDocumento(rs.getString("NumeroDocumento"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return clienteDTO;
    }

}
