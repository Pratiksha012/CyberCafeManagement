package cybercafe;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String DB_URL = "jdbc:postgresql://localhost:5433/cyber_cafe_management"; // Change as needed
    private static final String USER = "postgres";
    private static final String PASS = "Dragoon8870!";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("org.postgresql.Driver"); // Explicitly load the JDBC driver
        return DriverManager.getConnection(DB_URL, USER, PASS); // Return the connection
    }
}
