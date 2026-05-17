package DAO.impl;

import BBDD.Conexion;
import DAO.interfaces.IReporteDAO;
import DTO.ClienteDTO;
import DTO.VentaDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReporteDAOImpl implements IReporteDAO {

    @Override
    public List<VentaDTO> ventasPorFecha(int idUsuario, String desde, String hasta)
            throws Exception {

        List<VentaDTO> lista = new ArrayList<>();
        String sql = "SELECT v.id_venta, v.fecha, v.total, v.estado, "
                + "CONCAT(c.nombre,' ',c.apellido) AS nombre_cliente "
                + "FROM ventas v "
                + "JOIN clientes c ON v.id_cliente = c.id_cliente "
                + "WHERE v.id_usuario = ? "
                + "AND DATE(v.fecha) BETWEEN ? AND ? "
                + "ORDER BY v.fecha DESC";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            ps.setString(2, desde);
            ps.setString(3, hasta);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    VentaDTO v = new VentaDTO();
                    v.setIdVenta(rs.getInt("id_venta"));
                    v.setFecha(rs.getString("fecha"));
                    v.setTotal(rs.getDouble("total"));
                    v.setEstado(rs.getString("estado"));
                    v.setNombreCliente(rs.getString("nombre_cliente"));
                    lista.add(v);
                }
            }
        }
        return lista;
    }

    @Override
    public List<ClienteDTO> clientesConDeuda(int idUsuario) throws Exception {
        List<ClienteDTO> lista = new ArrayList<>();
        String sql = "SELECT c.id_cliente, c.nombre, c.apellido, c.telefono, "
                + "SUM(v.total) AS deuda_total "
                + "FROM clientes c "
                + "JOIN ventas v ON c.id_cliente = v.id_cliente "
                + "WHERE c.id_usuario = ? AND v.estado = 'PENDIENTE' "
                + "GROUP BY c.id_cliente, c.nombre, c.apellido, c.telefono "
                + "ORDER BY deuda_total DESC";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ClienteDTO c = new ClienteDTO();
                    c.setIdCliente(rs.getInt("id_cliente"));
                    c.setNombre(rs.getString("nombre"));
                    c.setApellido(rs.getString("apellido"));
                    c.setTelefono(rs.getString("telefono"));
                    c.setDeudaTotal(rs.getDouble("deuda_total"));
                    lista.add(c);
                }
            }
        }
        return lista;
    }
}
