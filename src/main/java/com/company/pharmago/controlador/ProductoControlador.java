package com.company.pharmago.controlador;

import com.company.pharmago.modelo.Categoria;
import com.company.pharmago.modelo.Farmacia;
import com.company.pharmago.modelo.Producto;
import com.company.pharmago.modelo.dao.CategoriaDAO;
import com.company.pharmago.modelo.dao.FarmaciaDAO;
import com.company.pharmago.modelo.dao.ProductoDAO;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ProductoControlador", urlPatterns = {"/producto"})
public class ProductoControlador extends HttpServlet {

    private CategoriaDAO categoriaDao = new CategoriaDAO();
    private ProductoDAO productoDao = new ProductoDAO();
    private FarmaciaDAO farmaciaDao = new FarmaciaDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");

        switch (accion) {
            case "detalle":
                DetalleProducto(request, response);
                break;
            case "categoria":
                BuscarCateg(request, response);
                break;
            case "oferta":
                BuscarOferta(request, response);
                break;
            case "farmacia":
                BuscarFarmacias(request, response);
                break;
            case "search":
                BusquedaProductos(request, response);
                break;
            case "registro":
                RegistrarProducto(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
        }
    }

    protected void BuscarFarmacias(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Farmacia objFarmacia = farmaciaDao.BuscarPorId(id);

        if (objFarmacia != null) {
            ArrayList<Producto> lista = productoDao.BuscarPorIdFarmacia(id);

            if (lista.size() == 0) {
                request.setAttribute("msg_error", "No se encontró productos de la farmacia " + objFarmacia.getNombre());
            }

            request.setAttribute("productos", lista);
            request.setAttribute("titulo", "Farmacia " + objFarmacia.getNombre());
        } else {
            request.setAttribute("msg_error", "No se encontro la farmacia con id " + id);
            request.setAttribute("titulo", "Busqueda por farmacia");
        }

        request.getRequestDispatcher("pagBuscarProductos.jsp").forward(request, response);

    }

    protected void BusquedaProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String s = request.getParameter("s");
        ArrayList<Producto> lista = productoDao.BuscarPorTermino(s);

        if (lista.size() == 0) {
            request.setAttribute("msg_error", "No se encontraron ofertas.");
        }

        request.setAttribute("productos", lista);

        request.setAttribute("titulo", "Resultado de la búsqueda: " + s);
        request.setAttribute("s", s);
        request.getRequestDispatcher("pagBuscarProductos.jsp").forward(request, response);
    }

    protected void BuscarOferta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Producto> lista = productoDao.listarProductosConDescuento();

        if (lista.size() == 0) {
            request.setAttribute("msg_error", "No se encontraron ofertas.");
        }

        request.setAttribute("productos", lista);

        request.setAttribute("titulo", "Ofertas");
        request.getRequestDispatcher("pagBuscarProductos.jsp").forward(request, response);
    }

    protected void BuscarCateg(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Categoria objCateg = categoriaDao.BuscarPorId(id);

        if (objCateg != null) {
            ArrayList<Producto> lista = productoDao.BuscarPorIdCateg(id);

            if (lista.size() == 0) {
                request.setAttribute("msg_error", "No se encontró productos de la categoria " + objCateg.getNombreCateg());
            }

            request.setAttribute("productos", lista);
            request.setAttribute("titulo", "Categoria " + objCateg.getNombreCateg());
        } else {
            request.setAttribute("msg_error", "No se encontro la categoria con id " + id);
            request.setAttribute("titulo", "Busqueda por categoria");
        }

        request.getRequestDispatcher("pagBuscarProductos.jsp").forward(request, response);

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

            Producto nuevoProducto = new Producto();
            nuevoProducto.setNombreProd(nombreProd);
            nuevoProducto.setStock(stock);
            nuevoProducto.setPrecio(precio);
            nuevoProducto.setDescripcion(descripcion);
            nuevoProducto.setPorcDesc(porcDesc);
            nuevoProducto.setCategoria(new Categoria(idCateg));
            nuevoProducto.setFarmacia(new Farmacia(idFarmacia));
            nuevoProducto.setImagen(imagen);

            String msg = productoDao.Guardar(nuevoProducto);

            resultado.put("msg", msg);
        } catch (Exception ex) {
            resultado.put("msg", ex.getMessage());
        }

        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(resultado));
        out.flush();
    }

    protected void DetalleProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Producto obj = productoDao.BuscarPorId(id);

        request.setAttribute("producto", obj);
        request.getRequestDispatcher("pagDetalleProducto.jsp").forward(request, response);

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
