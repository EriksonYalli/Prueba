package pe.edu.vallegrande.demo1.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private String url = "jdbc:sqlserver://localhost:14033;databaseName=VentaReposteria;trustServerCertificate=true;";
    private String usuario = "sa";
    private String password = "MyPassword2024";

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