package pe.edu.vallegrande.servicioautomotriz.prueba;

import java.sql.Connection;
import java.sql.SQLException;
import pe.edu.vallegrande.servicioautomotriz.db.AccesoDB;

public class Conexion {
    public static void main(String[] args) {
        Connection cn = null;
        try {
            // Crear objeto de conexión
            cn = AccesoDB.getConnection();
            if (cn != null) {
                System.out.println("Conexión exitosa.");
            } else {
                System.out.println("Conexión fallida.");
            }
        } catch (SQLException e) {
            System.err.println("Error de SQL: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
    }
}
