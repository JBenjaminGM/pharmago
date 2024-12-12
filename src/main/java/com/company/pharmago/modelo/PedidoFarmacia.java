package com.company.pharmago.modelo;

import java.util.ArrayList;

public class PedidoFarmacia {
    private int idPedFarmacia;
    private Farmacia farmacia;
    private double total;
    private String fechaDespacho1Aceptado;
    private String fechaDespacho2EnCurso;
    private String fechaDespacho3Entregado;
    private String codigoTransacion;
    private ArrayList<DetallePedido> detallesPedido = new ArrayList<>();

    public Farmacia getFarmacia() {
        return farmacia;
    }

    public void setFarmacia(Farmacia farmacia) {
        this.farmacia = farmacia;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getFechaDespacho1Aceptado() {
        return fechaDespacho1Aceptado;
    }

    public void setFechaDespacho1Aceptado(String fechaDespacho1Aceptado) {
        this.fechaDespacho1Aceptado = fechaDespacho1Aceptado;
    }

    public String getFechaDespacho2EnCurso() {
        return fechaDespacho2EnCurso;
    }

    public void setFechaDespacho2EnCurso(String fechaDespacho2EnCurso) {
        this.fechaDespacho2EnCurso = fechaDespacho2EnCurso;
    }

    public String getFechaDespacho3Entregado() {
        return fechaDespacho3Entregado;
    }

    public void setFechaDespacho3Entregado(String fechaDespacho3Entregado) {
        this.fechaDespacho3Entregado = fechaDespacho3Entregado;
    }

    public ArrayList<DetallePedido> getDetallesPedido() {
        return detallesPedido;
    }

    public void setDetallesPedido(ArrayList<DetallePedido> detallesPedido) {
        this.detallesPedido = detallesPedido;
    }

    public int getIdPedFarmacia() {
        return idPedFarmacia;
    }

    public void setIdPedFarmacia(int idPedFarmacia) {
        this.idPedFarmacia = idPedFarmacia;
    }

    public String getCodigoTransacion() {
        return codigoTransacion;
    }

    public void setCodigoTransacion(String codigoTransacion) {
        this.codigoTransacion = codigoTransacion;
    }

    
}
