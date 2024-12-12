package com.company.pharmago.modelo.dao;

import com.company.pharmago.config.ConexionDB;
import com.company.pharmago.modelo.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    private Connection connection = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public ClienteDAO() {
        this.connection = ConexionDB.getInstance().getConnection();
    }

    public String Registrar(Cliente cliente) {
        String msg = "";

        try {
            String sql = "INSERT INTO cliente (nombres, apellidos, nro_documento, fecha_nac, telefono, correo, password) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            ps = connection.prepareStatement(sql);

            ps.setString(1, cliente.getNombres());
            ps.setString(2, cliente.getApellidos());
            ps.setString(3, cliente.getNroDocumento());
            ps.setString(4, cliente.getFechaNac());
            ps.setString(5, cliente.getTelefono());
            ps.setString(6, cliente.getCorreo());
            ps.setString(7, cliente.getPassword());

            msg = ps.executeUpdate() > 0 ? "OK" : "No se pudo registrar cuenta";

        } catch (SQLException ex) {
            msg = ex.getMessage();
            ex.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return msg;
    }

    public int ExisteCorreo(String correo) {
        int result = 0;

        try {

            String sql = "select count(1) from cliente where correo=?";
            ps = connection.prepareStatement(sql);
            ps.setString(1, correo);
            rs = ps.executeQuery();

            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (Exception ex) {
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

        return result;
    }

    public Cliente Login(String correo, String password) {
        Cliente obj = null;

        try {
            String sql = "SELECT * FROM cliente WHERE correo = ? AND password = ?";
            ps = connection.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                obj = new Cliente();
                obj.setIdCliente(rs.getInt("id_cliente"));
                obj.setNombres(rs.getString("nombres"));
                obj.setApellidos(rs.getString("apellidos"));
                obj.setNroDocumento(rs.getString("nro_documento"));
                obj.setFechaNac(rs.getString("fecha_nac"));
                obj.setTelefono(rs.getString("telefono"));
                obj.setCorreo(rs.getString("correo"));
                obj.setPassword(rs.getString("password"));
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

    public Cliente BuscarPorId(int id) {
        Cliente obj = null;

        try {
            String sql = "SELECT * FROM cliente WHERE id_cliente = ?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                obj = new Cliente();
                obj.setIdCliente(rs.getInt("id_cliente"));
                obj.setNombres(rs.getString("nombres"));
                obj.setApellidos(rs.getString("apellidos"));
                obj.setNroDocumento(rs.getString("nro_documento"));
                obj.setFechaNac(rs.getString("fecha_nac"));
                obj.setTelefono(rs.getString("telefono"));
                obj.setCorreo(rs.getString("correo"));
                obj.setPassword(rs.getString("password"));
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

    public String Actualizar(Cliente cliente) {
        String msg = "";

        try {
            String sql = "UPDATE cliente SET nombres = ?, apellidos = ?, nro_documento = ?, "
                    + " fecha_nac = ?, telefono = ?, password = ? WHERE id_cliente = ?";
            ps = connection.prepareStatement(sql);

            ps.setString(1, cliente.getNombres());
            ps.setString(2, cliente.getApellidos());
            ps.setString(3, cliente.getNroDocumento());
            ps.setString(4, cliente.getFechaNac());
            ps.setString(5, cliente.getTelefono());
            ps.setString(6, cliente.getPassword());
            ps.setInt(7, cliente.getIdCliente());

            msg = ps.executeUpdate() > 0 ? "OK" : "No se pudo actualizar datos del cliente";

        } catch (SQLException ex) {
            msg = ex.getMessage();
            ex.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return msg;
    }
}
