package com.company.pharmago.modelo;


public class Categoria {
    private int idCateg;
    private String nombreCateg;

    public Categoria() {
    }

    public Categoria(int idCateg) {
        this.idCateg = idCateg;
    }

    public int getIdCateg() {
        return idCateg;
    }

    public void setIdCateg(int idCateg) {
        this.idCateg = idCateg;
    }

    public String getNombreCateg() {
        return nombreCateg;
    }

    public void setNombreCateg(String nombreCateg) {
        this.nombreCateg = nombreCateg;
    }

    @Override
    public String toString() {
        return "Categoria{" + "idCateg=" + idCateg + ", nombreCateg=" + nombreCateg + '}';
    }
    
    
}
