package org.proyecto.entities;

public class Pedido {
    private int idPedido;
    private Usuario usuario;
    private String estado;
    private String fecha;


    public Pedido() {
        usuario = new Usuario();
    }

    public Pedido(int idPedido, Usuario usuario, String estado, String fecha) {
        this.idPedido = idPedido;
        this.usuario = usuario;
        this.estado = estado;
        this.fecha = fecha;
    }

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    @Override
    public String toString() {
        return "Pedido{" +
                "idPedido=" + idPedido +
                ", usuario=" + usuario +
                ", estado='" + estado + '\'' +
                ", fecha='" + fecha + '\'' +
                '}';
    }
}