package com.company.pharmago.modelo;

public class DetallePedido {

    private Producto producto;
    private int cantidad;
    private double importe;

    public double Importe() {
        return producto.PrecioCnDescuento() * cantidad;
    }

    public void AumentarCantidad(int cantidad) {
        this.cantidad += cantidad;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getImporte() {
        return importe;
    }

    public void setImporte(double importe) {
        this.importe = importe;
    }

    
}
