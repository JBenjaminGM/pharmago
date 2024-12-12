package com.company.pharmago.controlador;

import com.company.pharmago.modelo.Cliente;
import com.company.pharmago.modelo.DetallePedido;
import com.company.pharmago.modelo.Pedido;
import com.company.pharmago.modelo.dao.ClienteDAO;
import com.company.pharmago.service.PaymentService;
import com.company.pharmago.utils.CarritoUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Transaction;
import java.util.ArrayList;

@WebServlet(name = "TransacionControlador", urlPatterns = {"/transacion"})
public class TransacionControlador extends HttpServlet {

    private ClienteDAO cliDao = new ClienteDAO();
    private CarritoUtil objCarrito = new CarritoUtil();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion") == null ? "" : request.getParameter("accion");

        switch (accion.toLowerCase()) {
            case "autorizar":
                PagoAutorizar(request, response);
                break;
            case "procesar":
                PagoProcesar(request, response);
                break;
        }
    }

    protected void PagoProcesar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");

        try {
            PaymentService paymentServices = new PaymentService();
            Payment payment = paymentServices.executePayment(paymentId, payerId);

            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().get(0);

            request.getSession().setAttribute("id_transacion", payment.getId());

            request.setAttribute("payer", payerInfo);
            request.setAttribute("transaction", transaction);

            response.sendRedirect("pedido?accion=procesar");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", ex.getMessage());
            request.getRequestDispatcher("Error.jsp").forward(request, response);
        }
    }

    protected void PagoAutorizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            Cliente objCli = (Cliente) request.getSession().getAttribute("usuario");
            ArrayList<DetallePedido> listaDetalles = objCarrito.ObtenerSesion(request);

            if (objCli != null) {
                Pedido objVenta = new Pedido();
                objVenta.setCliente(objCli);
                objVenta.setTotal(objCarrito.ImporteTotal(listaDetalles));
                
                request.getSession().setAttribute("direccionEnvio", request.getParameter("direccionEnvio"));
                request.getSession().setAttribute("referenciaEnvio", request.getParameter("referenciaEnvio"));
                request.getSession().setAttribute("detalleAdicional", request.getParameter("detalleAdicional"));

                PaymentService paymentServices = new PaymentService();
                String approvalLink = paymentServices.authorizePayment(objVenta, listaDetalles, request);

                response.sendRedirect(approvalLink);
            } else {
                request.getSession().setAttribute("error", "Debe iniciar sesión primero para poder generar pedido.");

                response.sendRedirect("pagLogin.jsp");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", ex.getMessage());
            request.getRequestDispatcher("pagError.jsp").forward(request, response);
        }
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
