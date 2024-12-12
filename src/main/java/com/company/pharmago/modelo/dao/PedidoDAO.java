package com.company.pharmago.modelo.dao;

import com.company.pharmago.config.ConexionDB;
import com.company.pharmago.modelo.Categoria;
import com.company.pharmago.modelo.DetallePedido;
import com.company.pharmago.modelo.Farmacia;
import com.company.pharmago.modelo.Pedido;
import com.company.pharmago.modelo.PedidoFarmacia;
import com.company.pharmago.modelo.Producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class PedidoDAO {

    private Connection connection = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public PedidoDAO() {
        this.connection = ConexionDB.getInstance().getConnection();
    }

    public int GenerarPedido(Pedido obj) {
        System.out.println("Cliente: " + obj.getCliente().getIdCliente());
        System.out.println("Total: " + obj.getTotal());

        for (PedidoFarmacia far : obj.getPedidosFarmacias()) {
            System.out.println("Farmacia: " + far.getFarmacia().getIdFarmacia() + " - " + far.getFarmacia().getNombre());
            System.out.println("Total farmacia:" + far.getTotal());
            System.out.println("PRODUCTO\tCANTIDAD\tPRECIO");
            for (DetallePedido itemDet : far.getDetallesPedido()) {
                System.out.println(itemDet.getProducto().getIdProd() + "\t" + itemDet.getCantidad() + "\t" + itemDet.getProducto().PrecioCnDescuento());
            }
            System.out.println("====================");
        }

        int result = 0;
        int idPedido = 0;
        int idPedidoFarmacia = 0;
        PreparedStatement psPedido = null;
        PreparedStatement psPedidoFarmacia = null;
        PreparedStatement psDetallePedido = null;
        ResultSet rsPedido = null;
        ResultSet rsPedidoFarmacia = null;

        try {
            connection.setAutoCommit(false);

            String sqlPedido = "INSERT INTO pedido(id_cliente,fecha_pedido,monto_total,direccion_envio,referencia_envio,detalle_adicional) VALUES(?,NOW(),?,?,?,?)";
            psPedido = connection.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS);
            psPedido.setInt(1, obj.getCliente().getIdCliente());
            psPedido.setDouble(2, obj.getTotal());
            psPedido.setString(3, obj.getDireccionEnvio());
            psPedido.setString(4, obj.getReferenciaEnvio());
            psPedido.setString(5, obj.getDetalleAdicional());
            result = psPedido.executeUpdate();

            if (result > 0) {
                rsPedido = psPedido.getGeneratedKeys();
                if (rsPedido.next()) {
                    idPedido = rsPedido.getInt(1);

                    String sqlPedidoFarmacia = "INSERT INTO pedido_farmacia(id_pedido,id_farmacia,total,fecha_despacho1_aceptado,codigo_transacion) VALUES(?,?,?, NOW(),?)";
                    for (PedidoFarmacia far : obj.getPedidosFarmacias()) {
                        psPedidoFarmacia = connection.prepareStatement(sqlPedidoFarmacia, Statement.RETURN_GENERATED_KEYS);
                        psPedidoFarmacia.setInt(1, idPedido);
                        psPedidoFarmacia.setInt(2, far.getFarmacia().getIdFarmacia());
                        psPedidoFarmacia.setDouble(3, far.getTotal());
                        psPedidoFarmacia.setString(4, far.getCodigoTransacion());
                        result = psPedidoFarmacia.executeUpdate();

                        if (result > 0) {
                            rsPedidoFarmacia = psPedidoFarmacia.getGeneratedKeys();
                            if (rsPedidoFarmacia.next()) {
                                idPedidoFarmacia = rsPedidoFarmacia.getInt(1);

                                String sqlDetallePedido = "{CALL sp_insertar_detalle_pedido(?,?,?,?)}";
                                for (DetallePedido itemDet : far.getDetallesPedido()) {
                                    psDetallePedido = connection.prepareStatement(sqlDetallePedido);
                                    psDetallePedido.setInt(1, idPedidoFarmacia);
                                    psDetallePedido.setInt(2, itemDet.getProducto().getIdProd());
                                    psDetallePedido.setDouble(3, itemDet.getCantidad());
                                    psDetallePedido.setDouble(4, itemDet.getProducto().PrecioCnDescuento());
                                    psDetallePedido.executeUpdate();
                                }
                            }
                        }
                    }
                }
            }

            connection.commit();
        } catch (Exception ex) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
                System.out.println("Aplicando [ROLLBACK]: " + ex.getMessage());
            } catch (SQLException e) {
                e.printStackTrace();
            }
            ex.printStackTrace();
        } finally {
            try {
                if (rsPedido != null) {
                    rsPedido.close();
                }
                if (rsPedidoFarmacia != null) {
                    rsPedidoFarmacia.close();
                }
                if (psPedido != null) {
                    psPedido.close();
                }
                if (psPedidoFarmacia != null) {
                    psPedidoFarmacia.close();
                }
                if (psDetallePedido != null) {
                    psDetallePedido.close();
                }
                if (connection != null) {
                    connection.setAutoCommit(true);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public ArrayList<PedidoFarmacia> BuscarPedidosPorCliente(int id) {
        ArrayList<PedidoFarmacia> lista = new ArrayList<>();

        try {
            String sql = "select * from pedido_farmacia pf inner join farmacia f on f.id_farmacia = pf.id_farmacia"
                    + " where id_pedido IN (select id_pedido from pedido where id_cliente = ?)";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            while (rs.next()) {
                Farmacia objFarm = new Farmacia();
                PedidoFarmacia objPedFar = new PedidoFarmacia();
                objFarm.setNombre(rs.getString("nombre_farmacia"));
                objPedFar.setFarmacia(objFarm);
                objPedFar.setFechaDespacho1Aceptado(rs.getString("fecha_despacho1_aceptado"));
                objPedFar.setIdPedFarmacia(rs.getInt("id_pedido_farmacia"));
                objPedFar.setTotal(rs.getDouble("total"));
                objPedFar.setCodigoTransacion(rs.getString("codigo_transacion"));
                lista.add(objPedFar);
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

    public PedidoFarmacia BuscarPedidosPorIdPedFarmacia(int id) {
        PedidoFarmacia objPedFar = null;

        try {
            String sql = "select * from pedido_farmacia pf inner join farmacia f on f.id_farmacia = pf.id_farmacia"
                    + " where id_pedido_farmacia = ?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                Farmacia objFarm = new Farmacia();
                objPedFar = new PedidoFarmacia();
                objFarm.setNombre(rs.getString("nombre_farmacia"));
                objPedFar.setFarmacia(objFarm);
                objPedFar.setFechaDespacho1Aceptado(rs.getString("fecha_despacho1_aceptado"));
                objPedFar.setFechaDespacho2EnCurso(rs.getString("fecha_despacho2_en_curso"));
                objPedFar.setFechaDespacho3Entregado(rs.getString("fecha_despacho3_entregado"));
                objPedFar.setIdPedFarmacia(rs.getInt("id_pedido_farmacia"));
                objPedFar.setTotal(rs.getDouble("total"));
                objPedFar.setCodigoTransacion(rs.getString("codigo_transacion"));
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

        return objPedFar;
    }

    public ArrayList<DetallePedido> obtenerDetallePedidoPorIdPedidoFarmacia(int idPedidoFarmacia) {
        ArrayList<DetallePedido> listaDetalles = new ArrayList<>();

        try {
            String sql = "SELECT c.nombre_categ, p.nombre_prod, p.imagen, pd.cantidad, pd.precio_unitario, pd.importe "
                    + "FROM detalle_pedido pd "
                    + "INNER JOIN producto p ON p.id_prod = pd.id_prod "
                    + "INNER JOIN categoria c ON c.id_categ = p.id_categ "
                    + "WHERE pd.id_pedido_farmacia = ?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, idPedidoFarmacia);
            rs = ps.executeQuery();

            while (rs.next()) {
                DetallePedido detalle = new DetallePedido();

                Producto producto = new Producto();
                producto.setNombreProd(rs.getString("nombre_prod"));
                producto.setImagen(rs.getString("imagen"));

                Categoria categoria = new Categoria();
                categoria.setNombreCateg(rs.getString("nombre_categ"));
                producto.setCategoria(categoria);

                detalle.setProducto(producto);
                detalle.setCantidad(rs.getInt("cantidad"));
                detalle.getProducto().setPrecio(rs.getDouble("precio_unitario"));
                detalle.setImporte(rs.getDouble("importe"));
                listaDetalles.add(detalle);
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

        return listaDetalles;
    }
}
