package pe.edu.vallegrande.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class AccesoDB {

    private String url = "jdbc:sqlserver://localhost:1433;databaseName=T06_AGROZAM;trustServerCertificate=true;?useUnicode=true&characterEncoding=UTF-8;";
    private String usuario = "SA";
    private String password = "<polula3128>";

    // Método para obtener una nueva conexión
    public Connection getCon() {
        Connection con = null;
        try {
            // Cargar el controlador de SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection(url, usuario, password);
            System.out.println("Conexión exitosa");
        } catch (ClassNotFoundException e) {
            System.out.println("Controlador no encontrado: " + e);
        } catch (SQLException e) {
            System.out.println("Error de conexión: " + e);
        }
        return con;
    }
}

