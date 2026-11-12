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

import org.proyecto.util.Seguridad;

public class UsuarioDao implements AdministradorConexiones, Dao<Usuario, Integer> {
    private final String SQL_GETALL = "SELECT * FROM usuarios";
    private final String SQL_GETBY_ID = "SELECT * FROM usuarios WHERE idUsuario=?";
    private final String SQL_DELETE_BY_ID = "DELETE FROM usuarios WHERE idUsuario=?";
    private final String SQL_INSERT = "INSERT INTO usuarios (nombre, apellido, correo, clave, idRol) VALUES (?, ?, ?, ?, ?)";
    private final String SQL_UPDATE = "UPDATE usuarios SET nombre=?, apellido=?, correo=?, clave=?, idRol=? WHERE idUsuario=?";
    // consulta para el login: busca por nombre y clave
    private final String SQL_LOGIN = "SELECT u.*, r.nombre AS rol FROM usuarios u JOIN roles r ON r.idRol = u.idRol WHERE u.nombre=?";
    private final String SQL_EXISTE_NOMBRE_O_CORREO = "SELECT idUsuario FROM usuarios WHERE nombre=? OR correo=?";
    private final String SQL_GETALL_CON_ROL = "SELECT u.*, r.nombre AS rol FROM usuarios u JOIN roles r ON r.idRol = u.idRol ORDER BY u.idUsuario";
    private final String SQL_TIENE_PEDIDOS = "SELECT idPedido FROM pedidos WHERE idUsuario=? LIMIT 1";
    private final String SQL_EXISTE_DE_OTRO = "SELECT idUsuario FROM usuarios WHERE (nombre=? OR correo=?) AND idUsuario<>?";

    public Usuario getByNombreYClave(String nombre, String clave) {
        Usuario usuario = null;
        try {
            Connection conn = this.obtenerConexion();
            //2. creo preparedStatement con el string de la consulta
            PreparedStatement pst = conn.prepareStatement(SQL_LOGIN);
            //3. reemplazar el ? con el nombre (la clave se compara después, con BCrypt)
            pst.setString(1, nombre);
            ResultSet rs = pst.executeQuery();
            // si encontro el usuario el resulset tiene una fila
            if (rs.next()) {
                String hashGuardado = rs.getString("clave");
                // comparo la clave escrita con el hash guardado
                if (Seguridad.coincide(clave, hashGuardado)) {
                    usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("idUsuario"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setRol(rs.getString("rol"));
                    // la clave no se copia al objeto, así no queda guardada en la sesión
                }
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

    public boolean existeNombreOCorreo(String nombre, String correo) {
        boolean existe = false;
        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_EXISTE_NOMBRE_O_CORREO);
            pst.setString(1, nombre);
            pst.setString(2, correo);

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
                usuario.setApellido(rs.getString("apellido"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setIdRol(rs.getInt("idRol"));
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
            pst.setString(2, objeto.getApellido());
            pst.setString(3, objeto.getCorreo());
            pst.setString(4, Seguridad.asegurarHash(objeto.getClave()));
            pst.setInt(5, objeto.getIdRol() > 0 ? objeto.getIdRol() : 2); // si no se indica rol, queda 2 = CLIENTE

            pst.execute();

            ResultSet rs = pst.getGeneratedKeys();
            if (rs.next()) {
                objeto.setIdUsuario(rs.getInt(1)); // le asigno al objeto el id que le puso la bd
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
            pst.setString(2, objeto.getApellido());
            pst.setString(3, objeto.getCorreo());
            pst.setString(4, Seguridad.asegurarHash(objeto.getClave())); // si ya es un hash lo deja igual
            pst.setInt(5, objeto.getIdRol());
            pst.setInt(6, objeto.getIdUsuario());
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

    // Lista de usuarios con el nombre de su rol (para la pantalla del admin)
    public List<Usuario> getAllConRol() {
        List<Usuario> lista = new ArrayList<>();
        try {
            Connection conn = this.obtenerConexion();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(SQL_GETALL_CON_ROL);

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setIdRol(rs.getInt("idRol"));
                usuario.setRol(rs.getString("rol"));
                // la clave no se copia: la lista no la necesita
                lista.add(usuario);
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

    // true si el usuario tiene pedidos (en ese caso no se puede borrar)
    public boolean tienePedidos(int idUsuario) {
        boolean tiene = false;
        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_TIENE_PEDIDOS);
            pst.setInt(1, idUsuario);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                tiene = true;
            }
            //cierro
            rs.close();
            pst.close();
            conn.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return tiene;
    }

    // true si OTRO usuario distinto al indicado ya usa ese nombre o ese correo.
// Para un usuario nuevo se pasa id 0.
    public boolean existeNombreOCorreoDeOtro(String nombre, String correo, int idUsuario) {
        boolean existe = false;
        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_EXISTE_DE_OTRO);
            pst.setString(1, nombre);
            pst.setString(2, correo);
            pst.setInt(3, idUsuario);
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
