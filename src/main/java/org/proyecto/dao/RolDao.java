package org.proyecto.dao;

import org.proyecto.entities.Rol;
import org.proyecto.interfaces.AdministradorConexiones;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class RolDao implements AdministradorConexiones {

    private final String SQL_GETALL = "SELECT * FROM roles ORDER BY idRol";

    public List<Rol> getAll() {
        List<Rol> lista = new ArrayList<>();

        try {
            Connection conn = this.obtenerConexion();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(SQL_GETALL);

            while (rs.next()) {
                Rol rol = new Rol();
                rol.setIdRol(rs.getInt("idRol"));
                rol.setNombre(rs.getString("nombre"));
                lista.add(rol);
            }
            //cierro
            rs.close();
            st.close();
            conn.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return lista;
    }
}