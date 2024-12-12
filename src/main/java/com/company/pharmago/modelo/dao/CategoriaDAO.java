package com.company.pharmago.modelo.dao;

import com.company.pharmago.config.ConexionDB;
import com.company.pharmago.modelo.Categoria;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {

    private Connection connection = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public CategoriaDAO() {
        this.connection = ConexionDB.getInstance().getConnection();
    }

    public List<Categoria> ListarTodos() {
        List<Categoria> lista = new ArrayList<>();

        String sql = "select * from categoria order by nombre_categ asc";

        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Categoria obj = new Categoria();
                obj.setIdCateg(rs.getInt("id_categ"));
                obj.setNombreCateg(rs.getString("nombre_categ"));
                lista.add(obj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public Categoria BuscarPorId(int id) {
        Categoria obj = null;

        String sql = "select * from categoria"
                + " where id_categ=? ";

        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                obj = new Categoria();
                obj.setIdCateg(rs.getInt("id_categ"));
                obj.setNombreCateg(rs.getString("nombre_categ"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return obj;
    }

}
