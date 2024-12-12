package com.company.pharmago.controlador;

import com.company.pharmago.modelo.DetallePedido;
import com.company.pharmago.modelo.Producto;
import com.company.pharmago.modelo.dao.ProductoDAO;
import com.company.pharmago.utils.CarritoUtil;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

@WebServlet(name = "CarritoControlador", urlPatterns = {"/carrito"})
public class CarritoControlador extends HttpServlet {

    private ProductoDAO prodDao = new ProductoDAO();
    private CarritoUtil objCarrito = new CarritoUtil();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");

        switch (accion) {
            case "listar":
                Listar(request, response);
                break;
            case "agregar":
                Agregar(request, response);
                break;
            case "eliminar":
                Eliminar(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
        }
    }

    protected void Eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int indice = Integer.parseInt(request.getParameter("indice"));

            objCarrito.RemoverItemCarrito(request, indice);

            request.getSession().setAttribute("success", "Item quitado del carrito.");
        } catch (Exception ex) {
            request.getSession().setAttribute("error", "No se pudo quitar item del carrito.");
        }

        response.sendRedirect("carrito?accion=listar");
    }

    protected void Agregar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idProd = Integer.parseInt(request.getParameter("id"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));

            DetallePedido objDet = new DetallePedido();
            Producto objProd = prodDao.BuscarPorId(idProd);
            objDet.setCantidad(cantidad);
            objDet.setProducto(objProd);

            objCarrito.AgregarCarrito(request, objDet);
        } catch (Exception ex) {
             request.getSession().setAttribute("error", "No se pudo agregar item al carrito.");
        }

        response.sendRedirect("carrito?accion=listar");
    }

    protected void Listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<DetallePedido> lista = objCarrito.ObtenerSesion(request);

        request.setAttribute("carrito", lista);
        request.setAttribute("total", objCarrito.ImporteTotal(lista));

        request.getRequestDispatcher("pagCarrito.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
