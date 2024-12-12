package com.company.pharmago.modelo.dao;

import com.company.pharmago.config.ConexionDB;
import com.company.pharmago.modelo.Categoria;
import com.company.pharmago.modelo.Farmacia;
import com.company.pharmago.modelo.Producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProductoDAO {

    private Connection connection = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public ProductoDAO() {
        this.connection = ConexionDB.getInstance().getConnection();
    }

    public ArrayList<Producto> listarProductosConDescuento() {
        ArrayList<Producto> lista = new ArrayList<>();

        try {
            String sql = "SELECT p.id_prod, p.nombre_prod, p.stock, p.precio, p.descripcion, p.porc_desc, "
                    + "c.id_categ, c.nombre_categ, f.id_farmacia, f.nombre_farmacia, f.logo , p.imagen "
                    + "FROM producto p "
                    + "INNER JOIN categoria c ON p.id_categ = c.id_categ "
                    + "INNER JOIN farmacia f ON p.id_farmacia = f.id_farmacia "
                    + "WHERE p.porc_desc > 0  and p.stock > 0";
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCateg(rs.getInt("id_categ"));
                categoria.setNombreCateg(rs.getString("nombre_categ"));

                Farmacia farmacia = new Farmacia();
                farmacia.setIdFarmacia(rs.getInt("id_farmacia"));
                farmacia.setNombre(rs.getString("nombre_farmacia"));
                farmacia.setLogo(rs.getString("logo"));

                Producto producto = new Producto();
                producto.setIdProd(rs.getInt("id_prod"));
                producto.setCategoria(categoria);
                producto.setFarmacia(farmacia);
                producto.setNombreProd(rs.getString("nombre_prod"));
                producto.setStock(rs.getInt("stock"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setPorcDesc(rs.getDouble("porc_desc"));
                producto.setImagen(rs.getString("imagen"));
                lista.add(producto);
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

    public ArrayList<Producto> BuscarPorTermino(String termino) {
        ArrayList<Producto> lista = new ArrayList<>();

        try {
            String sql = "SELECT p.id_prod, p.nombre_prod, p.stock, p.precio, p.descripcion, p.porc_desc, "
                    + "c.id_categ, c.nombre_categ, f.id_farmacia, f.nombre_farmacia, f.logo , p.imagen "
                    + "FROM producto p "
                    + "INNER JOIN categoria c ON p.id_categ = c.id_categ "
                    + "INNER JOIN farmacia f ON p.id_farmacia = f.id_farmacia "
                    + "WHERE p.nombre_prod like ?  and p.stock > 0";
            ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + termino + "%");
            rs = ps.executeQuery();

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCateg(rs.getInt("id_categ"));
                categoria.setNombreCateg(rs.getString("nombre_categ"));

                Farmacia farmacia = new Farmacia();
                farmacia.setIdFarmacia(rs.getInt("id_farmacia"));
                farmacia.setNombre(rs.getString("nombre_farmacia"));
                farmacia.setLogo(rs.getString("logo"));

                Producto producto = new Producto();
                producto.setIdProd(rs.getInt("id_prod"));
                producto.setCategoria(categoria);
                producto.setFarmacia(farmacia);
                producto.setNombreProd(rs.getString("nombre_prod"));
                producto.setStock(rs.getInt("stock"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setPorcDesc(rs.getDouble("porc_desc"));
                producto.setImagen(rs.getString("imagen"));
                lista.add(producto);
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

    public ArrayList<Producto> BuscarPorIdCateg(int id) {
        ArrayList<Producto> lista = new ArrayList<>();

        try {
            String sql = "SELECT p.id_prod, p.nombre_prod, p.stock, p.precio, p.descripcion, p.porc_desc, "
                    + "c.id_categ, c.nombre_categ, f.id_farmacia, f.nombre_farmacia, f.logo , p.imagen "
                    + "FROM producto p "
                    + "INNER JOIN categoria c ON p.id_categ = c.id_categ "
                    + "INNER JOIN farmacia f ON p.id_farmacia = f.id_farmacia "
                    + "WHERE p.id_categ=? and p.stock > 0";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCateg(rs.getInt("id_categ"));
                categoria.setNombreCateg(rs.getString("nombre_categ"));

                Farmacia farmacia = new Farmacia();
                farmacia.setIdFarmacia(rs.getInt("id_farmacia"));
                farmacia.setNombre(rs.getString("nombre_farmacia"));
                farmacia.setLogo(rs.getString("logo"));

                Producto producto = new Producto();
                producto.setIdProd(rs.getInt("id_prod"));
                producto.setCategoria(categoria);
                producto.setFarmacia(farmacia);
                producto.setNombreProd(rs.getString("nombre_prod"));
                producto.setStock(rs.getInt("stock"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setPorcDesc(rs.getDouble("porc_desc"));
                producto.setImagen(rs.getString("imagen"));
                lista.add(producto);
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
    public ArrayList<Producto> BuscarPorIdFarmacia(int id) {
        ArrayList<Producto> lista = new ArrayList<>();

        try {
            String sql = "SELECT p.id_prod, p.nombre_prod, p.stock, p.precio, p.descripcion, p.porc_desc, "
                    + "c.id_categ, c.nombre_categ, f.id_farmacia, f.nombre_farmacia, f.logo , p.imagen "
                    + "FROM producto p "
                    + "INNER JOIN categoria c ON p.id_categ = c.id_categ "
                    + "INNER JOIN farmacia f ON p.id_farmacia = f.id_farmacia "
                    + "WHERE p.id_farmacia=? and p.stock > 0";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCateg(rs.getInt("id_categ"));
                categoria.setNombreCateg(rs.getString("nombre_categ"));

                Farmacia farmacia = new Farmacia();
                farmacia.setIdFarmacia(rs.getInt("id_farmacia"));
                farmacia.setNombre(rs.getString("nombre_farmacia"));
                farmacia.setLogo(rs.getString("logo"));

                Producto producto = new Producto();
                producto.setIdProd(rs.getInt("id_prod"));
                producto.setCategoria(categoria);
                producto.setFarmacia(farmacia);
                producto.setNombreProd(rs.getString("nombre_prod"));
                producto.setStock(rs.getInt("stock"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setPorcDesc(rs.getDouble("porc_desc"));
                producto.setImagen(rs.getString("imagen"));
                lista.add(producto);
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
    public Producto BuscarPorId(int id) {
        Producto producto = null;

        try {
            String sql = "SELECT p.id_prod, p.nombre_prod, p.stock, p.precio, p.descripcion, p.porc_desc, "
                    + "c.id_categ, c.nombre_categ, f.id_farmacia, f.nombre_farmacia, f.logo , p.imagen "
                    + "FROM producto p "
                    + "INNER JOIN categoria c ON p.id_categ = c.id_categ "
                    + "INNER JOIN farmacia f ON p.id_farmacia = f.id_farmacia "
                    + "WHERE p.id_prod = ?  and p.stock > 0";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCateg(rs.getInt("id_categ"));
                categoria.setNombreCateg(rs.getString("nombre_categ"));

                Farmacia farmacia = new Farmacia();
                farmacia.setIdFarmacia(rs.getInt("id_farmacia"));
                farmacia.setNombre(rs.getString("nombre_farmacia"));
                farmacia.setLogo(rs.getString("logo"));

                producto = new Producto();
                producto.setIdProd(rs.getInt("id_prod"));
                producto.setCategoria(categoria);
                producto.setFarmacia(farmacia);
                producto.setNombreProd(rs.getString("nombre_prod"));
                producto.setStock(rs.getInt("stock"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setPorcDesc(rs.getDouble("porc_desc"));
                producto.setImagen(rs.getString("imagen"));
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

        return producto;
    }

    public String Guardar(Producto producto) {
        String msg = "";
        try {
            String sql = "INSERT INTO producto (nombre_prod, stock, precio, descripcion, porc_desc, id_categ, id_farmacia, imagen) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            ps = connection.prepareStatement(sql);
            ps.setString(1, producto.getNombreProd());
            ps.setInt(2, producto.getStock());
            ps.setDouble(3, producto.getPrecio());
            ps.setString(4, producto.getDescripcion());
            ps.setDouble(5, producto.getPorcDesc());
            ps.setInt(6, producto.getCategoria().getIdCateg());
            ps.setInt(7, producto.getFarmacia().getIdFarmacia());
            ps.setString(8, producto.getImagen());

            msg = ps.executeUpdate() > 0 ? "OK" : "No se pudo registrar producto";

        } catch (SQLException ex) {
            msg = ex.getMessage();
            ex.printStackTrace();
        }

        return msg;
    }
}
