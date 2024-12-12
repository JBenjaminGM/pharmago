package com.company.pharmago.modelo;

import java.util.ArrayList;

public class Pedido {

    private Cliente cliente;
    private double total;
    private ArrayList<PedidoFarmacia> pedidosFarmacias = new ArrayList<>();
    private String direccionEnvio;
    private String referenciaEnvio;
    private String detalleAdicional;

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public ArrayList<PedidoFarmacia> getPedidosFarmacias() {
        return pedidosFarmacias;
    }

    public void setPedidosFarmacias(ArrayList<PedidoFarmacia> pedidosFarmacias) {
        this.pedidosFarmacias = pedidosFarmacias;
    }

    public String getDetalleAdicional() {
        return detalleAdicional;
    }

    public void setDetalleAdicional(String detalleAdicional) {
        this.detalleAdicional = detalleAdicional;
    }

    public String getDireccionEnvio() {
        return direccionEnvio;
    }

    public void setDireccionEnvio(String direccionEnvio) {
        this.direccionEnvio = direccionEnvio;
    }

    public String getReferenciaEnvio() {
        return referenciaEnvio;
    }

    public void setReferenciaEnvio(String referenciaEnvio) {
        this.referenciaEnvio = referenciaEnvio;
    }

}
