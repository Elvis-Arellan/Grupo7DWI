package DAO.impl;

import BBDD.Conexion;
import DAO.interfaces.IVentaDAO;
import DTO.DetalleVentaDTO;
import DTO.VentaDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VentaDAOImpl implements IVentaDAO {

    @Override
    public List<VentaDTO> listar(int idUsuario) throws Exception {
        List<VentaDTO> lista = new ArrayList<>();
        String sql = "SELECT v.id_venta, v.fecha, v.total, v.estado, v.observacion, "
                + "CONCAT(c.nombre,' ',c.apellido) AS nombre_cliente "
                + "FROM ventas v "
                + "JOIN clientes c ON v.id_cliente = c.id_cliente "
                + "WHERE v.id_usuario = ? "
                + "ORDER BY v.fecha DESC";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    VentaDTO v = new VentaDTO();
                    v.setIdVenta(rs.getInt("id_venta"));
                    v.setFecha(rs.getString("fecha"));
                    v.setTotal(rs.getDouble("total"));
                    v.setEstado(rs.getString("estado"));
                    v.setObservacion(rs.getString("observacion"));
                    v.setNombreCliente(rs.getString("nombre_cliente"));
                    lista.add(v);
                }
            }
        }
        return lista;
    }

    @Override
    public VentaDTO buscarPorId(int idVenta) throws Exception {
        String sql = "SELECT v.*, CONCAT(c.nombre,' ',c.apellido) AS nombre_cliente "
                + "FROM ventas v "
                + "JOIN clientes c ON v.id_cliente = c.id_cliente "
                + "WHERE v.id_venta = ?";

        VentaDTO venta = null;
        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idVenta);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    venta = new VentaDTO();
                    venta.setIdVenta(rs.getInt("id_venta"));
                    venta.setIdCliente(rs.getInt("id_cliente"));
                    venta.setFecha(rs.getString("fecha"));
                    venta.setTotal(rs.getDouble("total"));
                    venta.setEstado(rs.getString("estado"));
                    venta.setObservacion(rs.getString("observacion"));
                    venta.setNombreCliente(rs.getString("nombre_cliente"));
                }
            }
        }

        // Cargar detalle
        if (venta != null) {
            venta.setDetalle(listarDetalle(idVenta));
        }
        return venta;
    }

    // Transacción: inserta venta + detalle + descuenta stock
    @Override
    public void registrar(VentaDTO venta) throws Exception {
        String sqlVenta = "INSERT INTO ventas (id_usuario, id_cliente, total, observacion) "
                + "VALUES (?, ?, ?, ?)";
        String sqlDetalle = "INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, "
                + "precio_unitario, subtotal) VALUES (?, ?, ?, ?, ?)";
        String sqlStock = "UPDATE productos SET stock_actual = stock_actual - ? "
                + "WHERE id_producto = ?";

        Connection con = null;
        try {
            con = Conexion.conectandoDWI();
            con.setAutoCommit(false);   // inicio transacción

            // 1. Insertar cabecera de venta
            int idVenta;
            try (PreparedStatement ps = con.prepareStatement(sqlVenta,
                    Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, venta.getIdUsuario());
                ps.setInt(2, venta.getIdCliente());
                ps.setDouble(3, venta.getTotal());
                ps.setString(4, venta.getObservacion());
                ps.executeUpdate();

                try (ResultSet keys = ps.getGeneratedKeys()) {
                    keys.next();
                    idVenta = keys.getInt(1);
                }
            }

            // 2. Insertar detalle y descontar stock
            for (DetalleVentaDTO d : venta.getDetalle()) {
                try (PreparedStatement ps = con.prepareStatement(sqlDetalle)) {
                    ps.setInt(1, idVenta);
                    ps.setInt(2, d.getIdProducto());
                    ps.setInt(3, d.getCantidad());
                    ps.setDouble(4, d.getPrecioUnitario());
                    ps.setDouble(5, d.getSubtotal());
                    ps.executeUpdate();
                }
                try (PreparedStatement ps = con.prepareStatement(sqlStock)) {
                    ps.setInt(1, d.getCantidad());
                    ps.setInt(2, d.getIdProducto());
                    ps.executeUpdate();
                }
            }

            con.commit();   // confirmar todo

        } catch (Exception e) {
            if (con != null) {
                con.rollback();    // revertir si algo falla
            }
            throw e;
        } finally {
            if (con != null) {
                con.setAutoCommit(true);
            }
            if (con != null) {
                con.close();
            }
        }
    }

    @Override
    public void marcarPagado(int idVenta) throws Exception {
        String sql = "UPDATE ventas SET estado='PAGADO' WHERE id_venta=?";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idVenta);
            ps.executeUpdate();
        }
    }

    @Override
    public void eliminar(int idVenta) throws Exception {
        // CASCADE en BD elimina el detalle automáticamente
        String sql = "DELETE FROM ventas WHERE id_venta=?";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idVenta);
            ps.executeUpdate();
        }
    }

    private List<DetalleVentaDTO> listarDetalle(int idVenta) throws Exception {
        List<DetalleVentaDTO> lista = new ArrayList<>();
        String sql = "SELECT dv.*, p.nombre AS nombre_producto "
                + "FROM detalle_ventas dv "
                + "JOIN productos p ON dv.id_producto = p.id_producto "
                + "WHERE dv.id_venta = ?";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idVenta);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DetalleVentaDTO d = new DetalleVentaDTO();
                    d.setIdDetalle(rs.getInt("id_detalle"));
                    d.setIdVenta(idVenta);
                    d.setIdProducto(rs.getInt("id_producto"));
                    d.setNombreProducto(rs.getString("nombre_producto"));
                    d.setCantidad(rs.getInt("cantidad"));
                    d.setPrecioUnitario(rs.getDouble("precio_unitario"));
                    d.setSubtotal(rs.getDouble("subtotal"));
                    lista.add(d);
                }
            }
        }
        return lista;
    }
}
