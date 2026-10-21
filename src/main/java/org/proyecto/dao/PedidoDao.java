package org.proyecto.dao;

import org.proyecto.entities.Pedido;
import org.proyecto.entities.Usuario;
import org.proyecto.interfaces.AdministradorConexiones;
import org.proyecto.interfaces.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PedidoDao implements AdministradorConexiones, Dao<Pedido, Integer> {

    private final String SQL_GETALL = "SELECT * FROM pedidos";
    private final String SQL_GETBY_ID = "SELECT * FROM pedidos WHERE idPedido=?";
    private final String SQL_DELETE_BY_ID = "DELETE FROM pedidos WHERE idPedido=?";
    private final String SQL_INSERT = "INSERT INTO pedidos (idUsuario, fecha, estado) VALUES (?, ?, ?)";
    private final String SQL_UPDATE = "UPDATE pedidos SET idUsuario=?, fecha=?, estado=? WHERE idPedido=?";


    @Override
    public List<Pedido> getAll() {
        List<Pedido> lista = new ArrayList<>();

        try {
            Connection conn = this.obtenerConexion();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(SQL_GETALL);

            while (rs.next()) {
                Pedido pedido = new Pedido();
                pedido.setIdPedido(rs.getInt("idPedido"));

                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                pedido.setUsuario(usuario);

                pedido.setEstado(rs.getString("estado"));
                pedido.setFecha(rs.getString("fecha"));

                lista.add(pedido);
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

    @Override
    public Pedido getById(Integer id) {

        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_GETBY_ID);
            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();
            Pedido pedido = new Pedido();

            if (rs.next()) {
                pedido.setIdPedido(rs.getInt("idPedido"));

                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                pedido.setUsuario(usuario);

                pedido.setEstado(rs.getString("estado"));
                pedido.setFecha(rs.getString("fecha"));
            }

            //cierro
            rs.close();
            pst.close();
            conn.close();

            return pedido;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void insert(Pedido objeto) {
        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_INSERT);
            pst.setInt(1, objeto.getUsuario().getIdUsuario());
            pst.setString(2, objeto.getFecha());
            pst.setString(3, objeto.getEstado());

            pst.executeUpdate();

            //cierro
            pst.close();
            conn.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void update(Pedido objeto) {
        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_UPDATE);
            pst.setInt(1, objeto.getUsuario().getIdUsuario());
            pst.setString(2, objeto.getFecha());
            pst.setString(3, objeto.getEstado());
            pst.setInt(4, objeto.getIdPedido());

            pst.executeUpdate();

            //cierro
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
        }

        try {
            Connection conn = this.obtenerConexion();
            PreparedStatement pst = conn.prepareStatement(SQL_DELETE_BY_ID);
            pst.setInt(1, id);
            pst.execute();

            //cierro
            pst.close();
            conn.close();

            elimino = true;
        } catch (Exception e) {
            throw new RuntimeException(e);
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