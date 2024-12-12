package com.company.pharmago.config;

import com.company.pharmago.modelo.dao.CategoriaDAO;
import com.company.pharmago.modelo.dao.ProductoDAO;

public class Test {

    public static void main(String[] args) {
       ConexionDB.getInstance();
        ProductoDAO productoDao = new ProductoDAO();
        CategoriaDAO categDao = new CategoriaDAO();
        System.out.println(productoDao.listarProductosConDescuento());
    }
    
}
