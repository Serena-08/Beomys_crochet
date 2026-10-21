package org.proyecto.interfaces;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public interface AdministradorConexiones {

    public default Connection obtenerConexion(){
        String dbDriver="com.mysql.cj.jdbc.Driver";
        String dbCadenaConexion="jdbc:mysql://localhost:3306/crochet";
        String dbUsuario="root";
        String dbPassword="root";

        Connection conn =null;
        try {
            Class.forName(dbDriver);
            conn= DriverManager.getConnection(dbCadenaConexion,dbUsuario,dbPassword);
            System.out.println("Bien!!!!! conecto la BD");

        } catch (ClassNotFoundException e) {
            System.out.println("No se encontro el Driver");
        } catch (SQLException e) {
            System.out.println("No se pudo establecer la conexion");
        }

        return conn;
    }
}
