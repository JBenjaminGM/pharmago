package com.company.pharmago.utils;

import com.company.pharmago.modelo.DetallePedido;
import jakarta.servlet.http.HttpServletRequest;
import java.util.ArrayList;

public class CarritoUtil {

    public void AgregarCarrito(HttpServletRequest request, DetallePedido detalle) {
        ArrayList<DetallePedido> lista = ObtenerSesion(request);
        int posc = ExisteProducto(lista, detalle.getProducto().getIdProd());

        if (posc == -1) {
            lista.add(detalle);
        } else {
            DetallePedido objDet = lista.get(posc);
            objDet.AumentarCantidad(detalle.getCantidad());
        }

        GuardarSesion(request, lista);
    }

    public void RemoverItemCarrito(HttpServletRequest request, int indice) {
        ArrayList<DetallePedido> lista = ObtenerSesion(request);
        lista.remove(indice);
        GuardarSesion(request, lista);
    }

    public ArrayList<DetallePedido> ObtenerSesion(HttpServletRequest request) {
        ArrayList<DetallePedido> lista;

        if (request.getSession().getAttribute("carrito") == null) {
            lista = new ArrayList<>();
        } else {
            lista = (ArrayList<DetallePedido>) request.getSession().getAttribute("carrito");
        }
        return lista;
    }

    public int ExisteProducto(ArrayList<DetallePedido> lista, int idProd) {

        for (int i = 0; i < lista.size(); i++) {
            if (lista.get(i).getProducto().getIdProd() == idProd) {
                return i;
            }
        }
        return -1;
    }

    public double ImporteTotal(ArrayList<DetallePedido> lista) {
        double total = 0;
        for (DetallePedido item : lista) {
            total += item.Importe();
        }
        return total;
    }

    public void GuardarSesion(HttpServletRequest request, ArrayList<DetallePedido> lista) {
        request.getSession().setAttribute("carrito", lista);
    }
}
