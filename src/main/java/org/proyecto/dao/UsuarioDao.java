package org.proyecto.dao;

import org.proyecto.entities.Usuario;
import org.proyecto.interfaces.AdministradorConexiones;
import org.proyecto.interfaces.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDao implements AdministradorConexiones, Dao<Usuario, Integer> {
    // Implementación de métodos para interactuar con la base de datos

    private final String SQL_GETALL = "SELECT * FROM usuarios";
    private final String SQL_GETBY_ID = "SELECT * FROM usuarios WHERE idUsuario=?";
    private final String SQL_DELETE_BY_ID = "DELETE FROM usuarios WHERE idUsuario=?";

    private final String SQL_INSERT = "INSERT INTO usuarios (nombre, clave)" + " VALUES (?,      ?)";

    private final String SQL_UPDATE = "UPDATE usuarios SET nombre=?, clave=? WHERE idUsuario=?";

    // consulta para el login: busca por nombre y clave
    private final String SQL_LOGIN = "SELECT * FROM usuarios WHERE nombre=? AND clave=?";

    public Usuario getByNombreYClave(String nombre, String clave) {
        Usuario usuario = null;
        try {
            //1. conectar
            Connection conn = this.obtenerConexion();
            //2. creo preparedStatement con el string de la consulta
            PreparedStatement pst = conn.prepareStatement(SQL_LOGIN);
            //3. reemplazar los ? con los valores
            pst.setString(1, nombre);
            pst.setString(2, clave);
            //4. ejecutar
            ResultSet rs = pst.executeQuery();
            // si encontro el usuario el resulset tiene una fila
            if (rs.next()) {
                usuario = new Usuario();
                //usuario.setId(rs.getInt("idUsuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setClave(rs.getString("clave"));
            }
            // cierro
            rs.close();
            pst.close();
            conn.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    @Override
    public List<Usuario> getAll() {
        List<Usuario> lista = new ArrayList<>();
        try {
            Connection conn = this.obtenerConexion();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(SQL_GETALL);
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setClave(rs.getString("clave"));
                lista.add(usuario);
            }
            // cierro
            rs.close();
            st.close();
            conn.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return lista;
    }

    @Override
    public Usuario getById(Integer id) {
        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_GETBY_ID);
            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();
            Usuario usuario = new Usuario();
            if (rs.next()) {
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setClave(rs.getString("clave"));
            }

            //  cierro
            rs.close();
            pst.close();
            conn.close();
            return usuario;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public void insert(Usuario objeto) {
        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS);
            pst.setString(1, objeto.getNombre());
            pst.setString(2, objeto.getClave());

            pst.execute();

            ResultSet rs = pst.getGeneratedKeys();
            if (rs.next()) {
                //objeto.setId(rs.getInt(1)); // le asigno al objeto el id que le puso la bd
            }

            // cierro
            pst.close();
            conn.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public void update(Usuario objeto) {
        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_UPDATE);
            pst.setString(1, objeto.getNombre());
            pst.setString(2, objeto.getClave());
            // pst.setInt(3, objeto.getId());
            // ejecuto
            pst.executeUpdate();
            // cierro
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

        return elimino;
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
            //  cierro
            rs.close();
            pst.close();
            conn.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return existe;

    }
}
