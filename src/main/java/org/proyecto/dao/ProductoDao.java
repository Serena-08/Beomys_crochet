package org.proyecto.dao;

import org.proyecto.entities.Producto;
import org.proyecto.interfaces.AdministradorConexiones;
import org.proyecto.interfaces.Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class    ProductoDao implements AdministradorConexiones, Dao<Producto, Integer> {

    private final String SQL_GETALL = "SELECT * FROM productos";

    private final String SQL_GETBY_ID = "SELECT * FROM productos WHERE idProducto=?";
    private final String SQL_DELETE_BY_ID = "DELETE FROM productos WHERE idProducto=?";
    private final String SQL_INSERT = "INSERT INTO productos (nombre, precio, descripcion, urlImagen, urlML) VALUES (?, ?, ?, ?, ?)";
    private final String SQL_UPDATE = "UPDATE productos SET nombre=?, precio=?, descripcion=?, urlImagen=?, urlML=? WHERE idProducto=?";


    @Override
    public List<Producto> getAll() {
        List<Producto> lista = new ArrayList<>();

        try {
            Connection conn = this.obtenerConexion();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(SQL_GETALL);

            while (rs.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("idProducto"));
                producto.setNombre(rs.getString("nombre"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setUrlImagen(rs.getString("urlImagen"));
                producto.setUrlML(rs.getString("urlML"));

                lista.add(producto);
            }
            //Cierro
            rs.close();
            st.close();
            conn.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }


        return lista;
    }

    @Override
    public Producto getById(Integer id) {
        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_GETBY_ID);
            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();
            Producto producto = new Producto();

            if (rs.next()) {
                producto.setIdProducto(rs.getInt("idProducto"));
                producto.setNombre(rs.getString("nombre"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setUrlImagen(rs.getString("urlImagen"));
                producto.setUrlML(rs.getString("urlML"));
            }

            //Cierro
            rs.close();
            pst.close();
            conn.close();
            return producto;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void insert(Producto objeto) {

        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_INSERT);
            pst.setString(1, objeto.getNombre());
            pst.setDouble(2, objeto.getPrecio());
            pst.setString(3, objeto.getDescripcion());
            pst.setString(4, objeto.getUrlImagen());
            pst.setString(5, objeto.getUrlML());

            pst.executeUpdate();

            //Cierro
            pst.close();
            conn.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void update(Producto objeto) {

        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_UPDATE);
            pst.setString(1, objeto.getNombre());
            pst.setDouble(2, objeto.getPrecio());
            pst.setString(3, objeto.getDescripcion());
            pst.setString(4, objeto.getUrlImagen());
            pst.setString(5, objeto.getUrlML());
            pst.setInt(6, objeto.getIdProducto());

            pst.executeUpdate();

            //Cierro
            pst.close();
            conn.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean delete(Integer id) {
        boolean elimino = false;
        if (!this.exists(id)) {
            return elimino;
        } else {
            try {
                Connection conn = this.obtenerConexion();
                PreparedStatement pst = conn.prepareStatement(SQL_DELETE_BY_ID);
                pst.setInt(1, id);
                pst.execute();
                // cierro
                pst.close();
                conn.close();
                elimino = true;

            } catch (Exception e) {
                elimino = false;
                throw new RuntimeException(e);
            }
        }
        return false;
    }

    @Override
    public boolean exists(Integer id) {
        boolean existe = false;
        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_GETBY_ID);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                existe = true;
            }

            //cierro
            rs.close();
            pst.close();
            conn.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return existe;
    }
}
