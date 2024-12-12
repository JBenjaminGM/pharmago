package com.company.pharmago.app;

import com.company.pharmago.modelo.dao.CategoriaDAO;
import com.company.pharmago.modelo.dao.FarmaciaDAO;
import com.company.pharmago.modelo.dao.ProductoDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebFilter("/*")
public class AppFilter implements Filter {
    private ProductoDAO productoDao = new ProductoDAO();
    private CategoriaDAO categoriaDao = new CategoriaDAO();
    private FarmaciaDAO farmaciaDao = new FarmaciaDAO();
    
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        cargarDatos(((HttpServletRequest) request).getSession().getServletContext());
        chain.doFilter(request, response);
    }
    
    public void destroy() {
        
    }
    
    private void cargarDatos(ServletContext servletContext) {
        servletContext.setAttribute("app_categorias", categoriaDao.ListarTodos());
          servletContext.setAttribute("app_farmacias", farmaciaDao.ListarTodos());
        servletContext.setAttribute("app_productos_cn_descuento", productoDao.listarProductosConDescuento());
    }
}