package pe.edu.vallegrande.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class AccesoDB {

    public static Connection getConnection() throws SQLException {
        Connection cn = null;
        String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        String urlDB = "jdbc:sqlserver://localhost:1433;databaseName=TallerMecanica;encrypt=True;TrustServerCertificate=True;characterEncoding=UTF-8;useUnicode=true;";
        String user = "sa";
        String pass = "oscar123";
        try {
            // Paso 1: Cargar el driver a memoria
            Class.forName(driver).getDeclaredConstructor().newInstance();
            // Paso 2: Obtener el objeto Connection
            cn = DriverManager.getConnection(urlDB, user, pass);
        } catch (SQLException e) {
            throw e; // Propagar la excepción
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encontró el driver de la base de datos.");
        } catch (Exception e) {
            throw new SQLException("No se puede establecer la conexión con la BD.");
        }
        return cn;
    }

}
