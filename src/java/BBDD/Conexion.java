package BBDD;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    
    private static final String URL = "jdbc:mysql://localhost:3306/dwi2026";
    private static final String USER = "root";
    private static final String PASS = "root";

    public static Connection conectandoDWI() {
        Connection cn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("Conectado a la BASE DE DATOS dwi2026");
        } catch (ClassNotFoundException c) {
            System.err.println("No hay jdbc jar: " + c.getMessage());
        } catch (SQLException e) {
            System.err.println("No se puede conectar: " + e.getMessage());
        }

        return cn;
    }
    
    public static void main(String[] args) {
        Connection cd = conectandoDWI();//esto es para probar mi base de datos
    }
}
