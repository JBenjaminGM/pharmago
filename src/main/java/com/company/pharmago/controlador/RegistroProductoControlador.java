package com.company.pharmago.controlador;

import com.company.pharmago.modelo.Categoria;
import com.company.pharmago.modelo.Farmacia;
import com.company.pharmago.modelo.Producto;
import com.company.pharmago.modelo.dao.ProductoDAO;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "RegistroProductoControlador", urlPatterns = {"/registroProducto"})
@MultipartConfig
public class RegistroProductoControlador extends HttpServlet {

    private ProductoDAO productoDao = new ProductoDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        RegistrarProducto(request, response);
    }

    public void RegistrarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        Map<String, Object> resultado = new HashMap<>();

        try {
            String nombreProd = request.getParameter("nombreProd");
            int stock = Integer.parseInt(request.getParameter("stock"));
            double precio = Double.parseDouble(request.getParameter("precio"));
            String descripcion = request.getParameter("descripcion");
            double porcDesc = Double.parseDouble(request.getParameter("porcDesc"));
            int idCateg = Integer.parseInt(request.getParameter("idCateg"));
            int idFarmacia = Integer.parseInt(request.getParameter("idFarmacia"));
            String imagen = request.getParameter("imagen");

            Producto producto = new Producto();
            producto.setNombreProd(nombreProd);
            producto.setStock(stock);
            producto.setPrecio(precio);
            producto.setDescripcion(descripcion);
            producto.setPorcDesc(porcDesc);
            producto.setCategoria(new Categoria(idCateg));
            producto.setFarmacia(new Farmacia(idFarmacia));
            producto.setImagen(imagen);

            String msg = productoDao.Guardar(producto);
            resultado.put("msg", msg);

        } catch (Exception ex) {
            resultado.put("msg", ex.getMessage());
        }

        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(resultado));
        out.flush();
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
