package com.company.pharmago.modelo.dao;

import com.company.pharmago.config.ConexionDB;
import com.company.pharmago.modelo.Farmacia;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FarmaciaDAO {

    private Connection connection = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public FarmaciaDAO() {
        this.connection = ConexionDB.getInstance().getConnection();
    }

    public ArrayList<Farmacia> ListarTodos() {
        ArrayList<Farmacia> lista = new ArrayList<>();

        try {
            String sql = "SELECT * FROM farmacia order by nombre_farmacia asc";
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Farmacia obj = new Farmacia();
                obj.setIdFarmacia(rs.getInt("id_farmacia"));
                obj.setNombre(rs.getString("nombre_farmacia"));
                obj.setLogo(rs.getString("logo"));
                lista.add(obj);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return lista;
    }

    public Farmacia BuscarPorId(int id) {
        Farmacia obj = null;

        try {
            String sql = "SELECT * FROM farmacia where id_farmacia=? ";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                obj = new Farmacia();
                obj.setIdFarmacia(rs.getInt("id_farmacia"));
                obj.setNombre(rs.getString("nombre_farmacia"));
                obj.setLogo(rs.getString("logo"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return obj;
    }

}
