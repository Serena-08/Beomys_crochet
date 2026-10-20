package org.proyecto.dao;

import org.proyecto.entities.Categoria;
import org.proyecto.interfaces.AdministradorConexiones;
import org.proyecto.interfaces.Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDao implements AdministradorConexiones, Dao<Categoria, Integer> {

    private final String SQL_GETALL = "SELECT * FROM categorias";
    private final String SQL_GETBY_ID = "SELECT * FROM categorias WHERE idCategoria=?";
    private final String SQL_DELETE_BY_ID = "DELETE FROM categorias WHERE idCategoria=?";
    private final String SQL_INSERT = "INSERT INTO categorias (categoria) VALUES (?)";
    private final String SQL_UPDATE = "UPDATE categorias SET categoria=? WHERE idCategoria=?";

    @Override
    public List<Categoria> getAll() {
        List <Categoria> lista = new ArrayList<>();

        try{
            Connection conn = this.obtenerConexion();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(SQL_GETALL);

            while(rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCateogria(rs.getInt("idCategoria"));
                categoria.setCategoria(rs.getString("categoria"));

                lista.add(categoria);

                //cierro
                rs.close();
                st.close();
                conn.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }

    @Override
    public Categoria getById(Integer id) {
        try{
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_GETBY_ID);
            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();
            Categoria categoria = new Categoria();
            if(rs.next()) {
                categoria.setIdCateogria(rs.getInt("idCategoria"));
                categoria.setCategoria(rs.getString("categoria"));
            }
            //cierro
            rs.close();
            pst.close();
            conn.close();

            return categoria;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void insert(Categoria objeto) {
        try{
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_INSERT);
            pst.setString(1, objeto.getCategoria());

            pst.executeUpdate();

            //cierro
            pst.close();
            conn.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public void update(Categoria objeto) {

        try{
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_UPDATE);
            pst.setString(1, objeto.getCategoria());
            pst.setInt(2, objeto.getIdCateogria());

            pst.executeUpdate();

            //cierro
            pst.close();
            conn.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public boolean delete(Integer id) {
        boolean elemino = false;
        if(!this.exists(id)){
            return elemino;
        } else {
            try {
                Connection conn = this.obtenerConexion();
                PreparedStatement pst = conn.prepareStatement(SQL_DELETE_BY_ID);
                pst.setInt(1, id);
                pst.execute();

                //cierro
                pst.close();
                conn.close();
                elemino = true;
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return false;
    }

    @Override
    public boolean exists(Integer id) {
        boolean existe = false;
        try{
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_GETBY_ID);
            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();
            if(rs.next()) {
                existe = true;
            }

            //cierro
            rs.close();
            pst.close();
            conn.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return existe;
    }
}
