package com.company.pharmago.controlador;

import com.company.pharmago.modelo.Cliente;
import com.company.pharmago.modelo.dao.ClienteDAO;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AuthControlador", urlPatterns = {"/auth"})
public class AuthControlador extends HttpServlet {

    private ClienteDAO clienteDao = new ClienteDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");

        switch (accion) {
            case "login":
                Login(request, response);
                break;
            case "logout":
                Logout(request, response);
                break;
            case "new_account":
                NuevaCuenta(request, response);
                break;
            case "register":
                Register(request, response);
                break;
            case "actualizar":
                Actualizar(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
        }
    }

    protected void Actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        Map<String, Object> resultado = new HashMap<>();
        try {
            Cliente obj = new Cliente();
            obj.setNombres(request.getParameter("nombres"));
            obj.setApellidos(request.getParameter("apellidos"));
            obj.setNroDocumento(request.getParameter("nroDocumento"));
            obj.setFechaNac(request.getParameter("fechaNacimiento"));
            obj.setTelefono(request.getParameter("telefono"));
            obj.setPassword(request.getParameter("password"));
            obj.setIdCliente(Integer.parseInt(request.getParameter("id")));

            String result = clienteDao.Actualizar(obj);

            if (result.equals("OK")) {
                request.getSession().setAttribute("usuario", obj);
                resultado.put("msg", result);
            } else {
                resultado.put("msg", result);
            }
        } catch (Exception ex) {
            resultado.put("msg", ex.getMessage());
        }

        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(resultado));
        out.flush();
    }

    protected void Register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Cliente obj = new Cliente();
        obj.setNombres(request.getParameter("nombres"));
        obj.setApellidos(request.getParameter("apellidos"));
        obj.setNroDocumento(request.getParameter("nroDocumento"));
        obj.setFechaNac(request.getParameter("fechaNacimiento"));
        obj.setTelefono(request.getParameter("telefono"));
        obj.setCorreo(request.getParameter("correo"));
        obj.setPassword(request.getParameter("password"));

        if (clienteDao.ExisteCorreo(obj.getCorreo()) == 0) {
            String result = clienteDao.Registrar(obj);

            if (result.equals("OK")) {
                request.getSession().setAttribute("success", "Cuenta registrada!");
                response.sendRedirect("auth?accion=new_account");
                return;
            } else {
                request.getSession().setAttribute("error", "No se pudo registrar cuenta");
            }
        } else {
            request.getSession().setAttribute("error", "El correo " + obj.getCorreo() + " ya se encuentra registrado");
        }

        request.setAttribute("cliente", obj);
        request.getRequestDispatcher("pagNuevaCuenta.jsp").forward(request, response);
    }

    protected void NuevaCuenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.setAttribute("cliente", new Cliente());
        request.getRequestDispatcher("pagNuevaCuenta.jsp").forward(request, response);

    }

    protected void Login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        Cliente obj = clienteDao.Login(correo, password);

        if (obj != null) {
            request.getSession().setAttribute("usuario", obj);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("correo", correo);
            request.getSession().setAttribute("error", "Correo y/o contraseña incorrecto");
            request.getRequestDispatcher("pagLogin.jsp").forward(request, response);
        }
    }

    protected void Logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.getSession().setAttribute("usuario", null);
        response.sendRedirect("pagLogin.jsp");

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
