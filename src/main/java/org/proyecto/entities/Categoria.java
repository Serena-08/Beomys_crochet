package org.proyecto.entities;

public class Categoria {
    private int idCateogria;
    private String categoria;

    public Categoria(){}

    public Categoria(int idCateogria, String categoria) {
        this.idCateogria = idCateogria;
        this.categoria = categoria;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public int getIdCateogria() {
        return idCateogria;
    }

    public void setIdCateogria(int idCateogria) {
        this.idCateogria = idCateogria;
    }

    @Override
    public String toString() {
        return "Categoria{" +
                "idCateogria=" + idCateogria +
                ", categoria='" + categoria + '\'' +
                '}';
    }
}
