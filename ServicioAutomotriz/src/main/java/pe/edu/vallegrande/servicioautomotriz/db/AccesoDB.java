package pe.edu.vallegrande.servicioautomotriz.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class AccesoDB {

    public AccesoDB() {
    }

    public static Connection getConnection() throws SQLException {
        Connection cn = null;
        String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        String database = "TallerMecanica";
        String url = "jdbc:sqlserver://localhost:1433;databaseName=" + database + ";encrypt=true;trustServerCertificate=true;loginTimeout=30;";

        String user = "sa";
        String password = "oscar123";

        try {
            Class.forName(driver).getDeclaredConstructor().newInstance();
            cn = DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encontró el driver de la base de datos.");
        } catch (Exception e) {
            throw new SQLException("No se puede establecer la conexión con la BD.");
        }
        return cn;
    }
}
