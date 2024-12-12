package com.company.pharmago.modelo;

public class Producto {

    private int idProd;
    private Categoria categoria;
    private Farmacia farmacia;
    private String nombreProd;
    private int stock;
    private double precio;
    private String descripcion;
    private double porcDesc;
    private String imagen;

    public double PrecioCnDescuento() {
        if (porcDesc > 0) {
            return precio - (precio * (porcDesc / 100.0));
        }
        return precio;
    }

    public int getIdProd() {
        return idProd;
    }

    public void setIdProd(int idProd) {
        this.idProd = idProd;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public Farmacia getFarmacia() {
        return farmacia;
    }

    public void setFarmacia(Farmacia farmacia) {
        this.farmacia = farmacia;
    }

    public String getNombreProd() {
        return nombreProd;
    }

    public void setNombreProd(String nombreProd) {
        this.nombreProd = nombreProd;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPorcDesc() {
        return porcDesc;
    }

    public void setPorcDesc(double porcDesc) {
        this.porcDesc = porcDesc;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    @Override
    public String toString() {
        return "Producto{" + "idProd=" + idProd + ", categoria=" + categoria + ", farmacia=" + farmacia + ", nombreProd=" + nombreProd + ", stock=" + stock + ", precio=" + precio + ", descripcion=" + descripcion + ", porcDesc=" + porcDesc + '}';
    }
}
