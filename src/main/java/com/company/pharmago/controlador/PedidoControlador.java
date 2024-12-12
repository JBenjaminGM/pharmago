package com.company.pharmago.controlador;

import com.company.pharmago.modelo.Cliente;
import com.company.pharmago.modelo.DetallePedido;
import com.company.pharmago.modelo.Farmacia;
import com.company.pharmago.modelo.Pedido;
import com.company.pharmago.modelo.PedidoFarmacia;
import com.company.pharmago.modelo.dao.ClienteDAO;
import com.company.pharmago.modelo.dao.PedidoDAO;
import com.company.pharmago.utils.CarritoUtil;
import com.mysql.cj.xdevapi.Client;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PedidoControlador extends HttpServlet {
    private ClienteDAO clienteDao = new ClienteDAO();
    private PedidoDAO pedidoDao = new PedidoDAO();
    private CarritoUtil objCarrito = new CarritoUtil();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");

        switch (accion) {
            case "procesar":
                Procesar(request, response);
                break;
            case "view_pedido":
                ViewPedido(request, response);
                break;
            case "cuenta":
                CuentaPedido(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
        }

    }

    protected void ViewPedido(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        PedidoFarmacia obj = pedidoDao.BuscarPedidosPorIdPedFarmacia(id);
        obj.setDetallesPedido(pedidoDao.obtenerDetallePedidoPorIdPedidoFarmacia(id));
        request.setAttribute("pedido", obj);
        request.getRequestDispatcher("pages/pagViewPedido.jsp").forward(request, response);
    }

    protected void CuentaPedido(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Cliente objCli = (Cliente) request.getSession().getAttribute("usuario");

        if (objCli == null) {
            request.getSession().setAttribute("error", "Debe iniciar sesión primero.");
            response.sendRedirect("pagLogin.jsp");
            return;
        }
        
        request.setAttribute("cliente",  clienteDao.BuscarPorId(objCli.getIdCliente()));
        request.setAttribute("pedidos", pedidoDao.BuscarPedidosPorCliente(objCli.getIdCliente()));
        request.getRequestDispatcher("pagMisPedidos.jsp").forward(request, response);
    }

    protected void Procesar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        if (request.getSession().getAttribute("usuario") != null) {
            Pedido objPed = new Pedido();
            Cliente objCli = (Cliente) request.getSession().getAttribute("usuario");
            ArrayList<DetallePedido> listaDetalles = objCarrito.ObtenerSesion(request);
            double totalPedido = objCarrito.ImporteTotal(listaDetalles);

            objPed.setCliente(objCli);
            objPed.setTotal(totalPedido);
            objPed.setDireccionEnvio(requestParam("direccionEnvio", request));
            objPed.setReferenciaEnvio(requestParam("referenciaEnvio", request));
            objPed.setDetalleAdicional(requestParam("detalleAdicional", request));

            Map<Integer, PedidoFarmacia> pedidosPorFarmacia = new HashMap<>();

            for (DetallePedido detalle : listaDetalles) {
                Farmacia farmacia = detalle.getProducto().getFarmacia();
                int idFarmacia = farmacia.getIdFarmacia();

                PedidoFarmacia pedidoFarmacia = pedidosPorFarmacia.computeIfAbsent(idFarmacia, k -> {
                    PedidoFarmacia nuevoPedidoFarmacia = new PedidoFarmacia();
                    nuevoPedidoFarmacia.setFarmacia(farmacia);
                    nuevoPedidoFarmacia.setDetallesPedido(new ArrayList<>());
                    nuevoPedidoFarmacia.setTotal(0.0);
                    return nuevoPedidoFarmacia;
                });

                pedidoFarmacia.getDetallesPedido().add(detalle);
                pedidoFarmacia.setCodigoTransacion((String) request.getSession().getAttribute("id_transacion"));
                double totalDetalle = detalle.Importe();
                pedidoFarmacia.setTotal(pedidoFarmacia.getTotal() + totalDetalle);
            }

            ArrayList<PedidoFarmacia> listaPedidosFarmacia = new ArrayList<>(pedidosPorFarmacia.values());

            objPed.setPedidosFarmacias(listaPedidosFarmacia);

            int result = pedidoDao.GenerarPedido(objPed);

            if (result > 0) {
                objCarrito.GuardarSesion(request, new ArrayList<>());
                request.getSession().setAttribute("success", "Pedido procesado de forma correcta!");
                response.sendRedirect("pedido?accion=cuenta");
            } else {
                request.getSession().setAttribute("error", "No se pudo procesar el pedido");
                request.getRequestDispatcher("pagCarrito.jsp").forward(request, response);
            }
        } else {
            request.getSession().setAttribute("error", "Debe autentificarse primero, antes de procesar su pedido.");
            request.getRequestDispatcher("pagLogin.jsp").forward(request, response);
        }
    }

    public String requestParam(String name , HttpServletRequest request){
        if(request.getSession().getAttribute(name) != null){
            return request.getSession().getAttribute(name).toString();
        }
        return "";
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
