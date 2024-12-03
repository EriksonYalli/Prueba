package pe.edu.vallegrande.service;

import pe.edu.vallegrande.db.AccesoDB;
import pe.edu.vallegrande.Dto.WorkerDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginService {

    // Método para autenticar al usuario
    public WorkerDto authenticate(String email, String password) {
        String query = "SELECT id, name, last_name, email, post, specialty, phone, password FROM worker WHERE email = ?";
        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);  // Usamos el email como identificador
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Obtenemos la contraseña almacenada
                String storedPassword = rs.getString("password");

                // Validamos la contraseña
                if (storedPassword.equals(password)) {
                    // Creamos y retornamos el DTO con los datos del trabajador
                    return new WorkerDto(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("last_name"),
                            rs.getString("email"),
                            rs.getString("post"),
                            rs.getString("specialty"),
                            rs.getString("phone"),
                            rs.getString("password")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Retorna null si las credenciales no son válidas o ocurre un error
    }
}
