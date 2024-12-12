package com.company.pharmago.modelo;

public class Farmacia {

    private int idFarmacia;
    private String nombre;
    private String logo;

    public Farmacia() {
    }

    public Farmacia(int idFarmacia) {
        this.idFarmacia = idFarmacia;
    }

    public int getIdFarmacia() {
        return idFarmacia;
    }

    public void setIdFarmacia(int idFarmacia) {
        this.idFarmacia = idFarmacia;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    @Override
    public String toString() {
        return "Farmacia{" + "idFarmacia=" + idFarmacia + ", nombre=" + nombre + ", logo=" + logo + '}';
    }

}
