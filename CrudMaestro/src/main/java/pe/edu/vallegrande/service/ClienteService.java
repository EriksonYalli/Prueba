package pe.edu.vallegrande.service;

import pe.edu.vallegrande.Dto.ClienteDto;
import pe.edu.vallegrande.db.AccesoDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ClienteService {

    // SQL para listar personas naturales activas
    private static final String SQL_LISTAR_PERSONAS_NATURALES_ACTIVAS = "SELECT id, type_person, name, last_name, email, document_type, document_number, birthdate, phone, address, status FROM customer WHERE type_person = 'Natural' AND status = 'A'";

    // SQL para listar personas naturales inactivas
    private static final String SQL_LISTAR_PERSONAS_NATURALES_INACTIVAS = "SELECT id, type_person, name, last_name, email, document_type, document_number, birthdate, phone, address, status FROM customer WHERE type_person = 'Natural' AND status = 'I'";

    // SQL para listar personas jurídicas activas
    private static final String SQL_LISTAR_PERSONAS_JURIDICAS_ACTIVAS = "SELECT id, type_person, company_name, ruc, email, address, phone, status FROM customer WHERE type_person = 'Jurídica' AND status = 'A'";

    // SQL para listar personas jurídicas inactivas
    private static final String SQL_LISTAR_PERSONAS_JURIDICAS_INACTIVAS = "SELECT id, type_person, company_name, ruc, email, address, phone, status FROM customer WHERE type_person = 'Jurídica' AND status = 'I'";

    // SQL para agregar una persona natural
    private static final String SQL_AGREGAR_PERSONA_NATURAL = "INSERT INTO customer (type_person, name, last_name, email, document_type, document_number, birthdate, status, phone, address) VALUES ('Natural', ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    // SQL para agregar una persona jurídica
    private static final String SQL_AGREGAR_PERSONA_JURIDICA = "INSERT INTO customer (type_person, company_name, ruc, email, address, phone, status) VALUES ('Jurídica', ?, ?, ?, ?, ?, ?)";

    // SQL para editar una persona natural
    private static final String SQL_EDITAR_PERSONA_NATURAL = "UPDATE customer SET name = ?, last_name = ?, email = ?, document_type = ?, document_number = ?, birthdate = ?, phone = ?, address = ?, status = ? WHERE id = ? AND type_person = 'Natural'";

    // SQL para editar una persona jurídica
    private static final String SQL_EDITAR_PERSONA_JURIDICA = "UPDATE customer SET company_name = ?, ruc = ?, email = ?, address = ?, phone = ?, status = ? WHERE id = ? AND type_person = 'Jurídica'";

    // SQL para la eliminación lógica de un cliente
    private static final String SQL_ELIMINAR_LOGICO = "UPDATE customer SET status = 'I' WHERE id = ?";

    // SQL para reactivar un cliente
    private static final String SQL_REACTIVAR_CLIENTE = "UPDATE customer SET status = 'A' WHERE id = ?";

    // SQL para obtener un cliente por ID
    private static final String SQL_OBTENER_CLIENTE_POR_ID = "SELECT id, type_person, name, last_name, email, document_type, document_number, birthdate, phone, address, status, company_name, ruc FROM customer WHERE id = ?";


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // Método para listar personas naturales activas
    public List<ClienteDto> listarPersonasNaturalesActivas() {
        List<ClienteDto> clientesNaturales = new ArrayList<>();
        try (Connection cn = AccesoDB.getConnection();
             PreparedStatement pstmt = cn.prepareStatement(SQL_LISTAR_PERSONAS_NATURALES_ACTIVAS);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                ClienteDto cliente = new ClienteDto();
                cliente.setId(rs.getInt("id"));
                cliente.setTypePerson(rs.getString("type_person"));  // Tipo de persona
                cliente.setName(rs.getString("name"));               // Nombre
                cliente.setLastName(rs.getString("last_name"));       // Apellido
                cliente.setEmail(rs.getString("email"));              // Correo electrónico
                cliente.setDocumentType(rs.getString("document_type"));// Tipo de documento
                cliente.setDocumentNumber(rs.getString("document_number")); // Número de documento
                cliente.setBirthdate(rs.getDate("birthdate") != null ? rs.getDate("birthdate").toLocalDate() : null); // Fecha de nacimiento
                cliente.setPhone(rs.getString("phone"));              // Teléfono
                cliente.setAddress(rs.getString("address"));          // Dirección
                cliente.setStatus(rs.getString("status"));            // Estado
                clientesNaturales.add(cliente);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de errores
        }
        return clientesNaturales;
    }

    // Método para listar personas naturales inactivas
    public List<ClienteDto> listarPersonasNaturalesInactivas() {
        List<ClienteDto> clientesNaturales = new ArrayList<>();
        try (Connection cn = AccesoDB.getConnection();
             PreparedStatement pstmt = cn.prepareStatement(SQL_LISTAR_PERSONAS_NATURALES_INACTIVAS);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                ClienteDto cliente = new ClienteDto();
                cliente.setId(rs.getInt("id"));
                cliente.setTypePerson(rs.getString("type_person"));  // Tipo de persona
                cliente.setName(rs.getString("name"));               // Nombre
                cliente.setLastName(rs.getString("last_name"));       // Apellido
                cliente.setEmail(rs.getString("email"));              // Correo electrónico
                cliente.setDocumentType(rs.getString("document_type"));// Tipo de documento
                cliente.setDocumentNumber(rs.getString("document_number")); // Número de documento
                cliente.setBirthdate(rs.getDate("birthdate") != null ? rs.getDate("birthdate").toLocalDate() : null); // Fecha de nacimiento
                cliente.setPhone(rs.getString("phone"));              // Teléfono
                cliente.setAddress(rs.getString("address"));          // Dirección
                cliente.setStatus(rs.getString("status"));            // Estado
                clientesNaturales.add(cliente);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de errores
        }
        return clientesNaturales;
    }

    // Método para listar personas jurídicas activas
    public List<ClienteDto> listarPersonasJuridicasActivas() {
        List<ClienteDto> clientesJuridicos = new ArrayList<>();
        try (Connection cn = AccesoDB.getConnection();
             PreparedStatement pstmt = cn.prepareStatement(SQL_LISTAR_PERSONAS_JURIDICAS_ACTIVAS);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                ClienteDto cliente = new ClienteDto();
                cliente.setId(rs.getInt("id"));
                cliente.setTypePerson(rs.getString("type_person"));  // Tipo de persona
                cliente.setCompanyName(rs.getString("company_name")); // Nombre de la empresa
                cliente.setRuc(rs.getString("ruc"));                 // RUC
                cliente.setEmail(rs.getString("email"));              // Correo electrónico
                cliente.setAddress(rs.getString("address"));          // Dirección
                cliente.setPhone(rs.getString("phone"));              // Teléfono
                cliente.setStatus(rs.getString("status"));            // Estado
                clientesJuridicos.add(cliente);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de errores
        }
        return clientesJuridicos;
    }

    // Método para listar personas jurídicas inactivas
    public List<ClienteDto> listarPersonasJuridicasInactivas() {
        List<ClienteDto> clientesJuridicos = new ArrayList<>();
        try (Connection cn = AccesoDB.getConnection();
             PreparedStatement pstmt = cn.prepareStatement(SQL_LISTAR_PERSONAS_JURIDICAS_INACTIVAS);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                ClienteDto cliente = new ClienteDto();
                cliente.setId(rs.getInt("id"));
                cliente.setTypePerson(rs.getString("type_person"));  // Tipo de persona
                cliente.setCompanyName(rs.getString("company_name")); // Nombre de la empresa
                cliente.setRuc(rs.getString("ruc"));                 // RUC
                cliente.setEmail(rs.getString("email"));              // Correo electrónico
                cliente.setAddress(rs.getString("address"));          // Dirección
                cliente.setPhone(rs.getString("phone"));              // Teléfono
                cliente.setStatus(rs.getString("status"));            // Estado
                clientesJuridicos.add(cliente);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de errores
        }
        return clientesJuridicos;
    }


    public boolean agregarPersonaNatural(ClienteDto clienteDto) {
        try (Connection cn = AccesoDB.getConnection();
             PreparedStatement pstmt = cn.prepareStatement(SQL_AGREGAR_PERSONA_NATURAL)) {

            pstmt.setString(1, clienteDto.getName());
            pstmt.setString(2, clienteDto.getLastName());
            pstmt.setString(3, clienteDto.getEmail());
            pstmt.setString(4, clienteDto.getDocumentType());
            pstmt.setString(5, clienteDto.getDocumentNumber());
            pstmt.setDate(6, clienteDto.getBirthdate() != null ? Date.valueOf(clienteDto.getBirthdate()) : null);
            pstmt.setString(7, "A");
            pstmt.setString(8, clienteDto.getPhone());
            pstmt.setString(9, clienteDto.getAddress());
            pstmt.executeUpdate();
            return true; // Agregado exitosamente
        } catch (SQLException e) {
            System.err.println("Error al agregar persona natural: " + e.getMessage());
            e.printStackTrace();
            return false; // Fallo en la adición
        }
    }


    // Método para agregar una persona jurídica
    public boolean agregarPersonaJuridica(ClienteDto clienteDto) {
        try (Connection cn = AccesoDB.getConnection();
             PreparedStatement pstmt = cn.prepareStatement(SQL_AGREGAR_PERSONA_JURIDICA)) {

            pstmt.setString(1, clienteDto.getCompanyName());
            pstmt.setString(2, clienteDto.getRuc());
            pstmt.setString(3, clienteDto.getEmail());
            pstmt.setString(4, clienteDto.getAddress());
            pstmt.setString(5, clienteDto.getPhone());
            pstmt.setString(6, "A"); // Estado 'A' para activo
            pstmt.executeUpdate();
            return true; // Agregado exitosamente
        } catch (SQLException e) {
            System.out.println("Error al agregar persona juridica: " + e.getMessage());
            e.printStackTrace();
            return false; // Fallo en la adición
        }
    }



    // Método para editar una persona natural
    public boolean editarPersonaNatural(ClienteDto clienteDto) {
        try (Connection cn = AccesoDB.getConnection();
             PreparedStatement pstmt = cn.prepareStatement(SQL_EDITAR_PERSONA_NATURAL)) {

            pstmt.setString(1, clienteDto.getName());
            pstmt.setString(2, clienteDto.getLastName());
            pstmt.setString(3, clienteDto.getEmail());
            pstmt.setString(4, clienteDto.getDocumentType());
            pstmt.setString(5, clienteDto.getDocumentNumber());
            pstmt.setDate(6, clienteDto.getBirthdate() != null ? Date.valueOf(clienteDto.getBirthdate()) : null);
            pstmt.setString(7, clienteDto.getPhone());
            pstmt.setString(8, clienteDto.getAddress());
            pstmt.setString(9, clienteDto.getStatus());
            pstmt.setInt(10, clienteDto.getId()); // Asignar el ID del cliente

            pstmt.executeUpdate();
            return true; // Editado exitosamente
        } catch (SQLException e) {
            System.err.println("Error al editar persona natural: " + e.getMessage());
            e.printStackTrace();
            return false; // Fallo en la edición
        }
    }


    // Método para editar una persona jurídica
    public boolean editarPersonaJuridica(ClienteDto clienteDto) {
        try (Connection cn = AccesoDB.getConnection();
             PreparedStatement pstmt = cn.prepareStatement(SQL_EDITAR_PERSONA_JURIDICA)) {

            pstmt.setString(1, clienteDto.getCompanyName());
            pstmt.setString(2, clienteDto.getRuc());
            pstmt.setString(3, clienteDto.getEmail());
            pstmt.setString(4, clienteDto.getAddress());
            pstmt.setString(5, clienteDto.getPhone());
            pstmt.setString(6, clienteDto.getStatus());
            pstmt.setInt(7, clienteDto.getId());
            pstmt.executeUpdate();
            return true; // Editado exitosamente
        } catch (SQLException e) {
            System.err.println("Error al editar persona jurídica: " + e.getMessage());
            e.printStackTrace();
            return false; // Fallo en la edición
        }
    }


    // Método para eliminar lógicamente un cliente
    public boolean eliminarLogicoCliente(int id) {
        try (Connection cn = AccesoDB.getConnection();
             PreparedStatement pstmt = cn.prepareStatement(SQL_ELIMINAR_LOGICO)) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            return true; // Eliminado lógicamente con éxito
        } catch (SQLException e) {
            System.err.println("Error al eliminar lógicamente el cliente: " + e.getMessage());
            e.printStackTrace();
            return false; // Fallo en la eliminación lógica
        }
    }

    // Método para reactivar un cliente
    public boolean reactivarCliente(int id) {
        try (Connection cn = AccesoDB.getConnection();
             PreparedStatement pstmt = cn.prepareStatement(SQL_REACTIVAR_CLIENTE)) {

            pstmt.setInt(1, id); // Establece el ID del cliente a reactivar
            int filasAfectadas = pstmt.executeUpdate();

            // Verificar si se realizó la actualización
            return filasAfectadas > 0; // Retorna true si se reactivó correctamente
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Fallo en la reactivación
        }
    }

    // Método para obtener un cliente por ID
    public Optional<ClienteDto> obtenerClientePorId(int id) {
        Optional<ClienteDto> clienteOpt = Optional.empty();
        try (Connection cn = AccesoDB.getConnection();
             PreparedStatement pstmt = cn.prepareStatement(SQL_OBTENER_CLIENTE_POR_ID)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ClienteDto cliente = new ClienteDto();
                    cliente.setId(rs.getInt("id"));
                    cliente.setTypePerson(rs.getString("type_person"));
                    cliente.setName(rs.getString("name"));
                    cliente.setLastName(rs.getString("last_name"));
                    cliente.setEmail(rs.getString("email"));
                    cliente.setDocumentType(rs.getString("document_type"));
                    cliente.setDocumentNumber(rs.getString("document_number"));
                    cliente.setBirthdate(rs.getDate("birthdate") != null ? rs.getDate("birthdate").toLocalDate() : null);
                    cliente.setPhone(rs.getString("phone"));
                    cliente.setAddress(rs.getString("address"));
                    cliente.setStatus(rs.getString("status"));
                    cliente.setCompanyName(rs.getString("company_name"));
                    cliente.setRuc(rs.getString("ruc"));
                    clienteOpt = Optional.of(cliente);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener el cliente por ID: " + e.getMessage());
            e.printStackTrace();
        }
        return clienteOpt;
    }


}
