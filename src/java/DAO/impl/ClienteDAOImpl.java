package DAO.impl;

import BBDD.Conexion;
import DAO.interfaces.IClienteDAO;
import DTO.ClienteDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAOImpl implements IClienteDAO {
     @Override
    public List<ClienteDTO> listar(int idUsuario) throws Exception {
        List<ClienteDTO> lista = new ArrayList<>();
        String sql = "SELECT * FROM clientes " +
                     "WHERE id_usuario = ? AND estado = 'ACTIVO' " +
                     "ORDER BY nombre, apellido";

        try (Connection con = Conexion.conectandoDWI();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapear(rs));
            }
        }
        return lista;
    }

    @Override
    public ClienteDTO buscarPorId(int idCliente) throws Exception {
        String sql = "SELECT * FROM clientes WHERE id_cliente = ?";

        try (Connection con = Conexion.conectandoDWI();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idCliente);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapear(rs) : null;
            }
        }
    }

    @Override
    public void registrar(ClienteDTO c) throws Exception {
        String sql = "INSERT INTO clientes (id_usuario, nombre, apellido, telefono) " +
                     "VALUES (?, ?, ?, ?)";

        try (Connection con = Conexion.conectandoDWI();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, c.getIdUsuario());
            ps.setString(2, c.getNombre());
            ps.setString(3, c.getApellido());
            ps.setString(4, c.getTelefono());
            ps.executeUpdate();
        }
    }

    @Override
    public void actualizar(ClienteDTO c) throws Exception {
        String sql = "UPDATE clientes SET nombre=?, apellido=?, telefono=? " +
                     "WHERE id_cliente=? AND id_usuario=?";

        try (Connection con = Conexion.conectandoDWI();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getNombre());
            ps.setString(2, c.getApellido());
            ps.setString(3, c.getTelefono());
            ps.setInt(4, c.getIdCliente());
            ps.setInt(5, c.getIdUsuario());
            ps.executeUpdate();
        }
    }

    @Override
    public void eliminar(int idCliente) throws Exception {
        String sql = "UPDATE clientes SET estado='INACTIVO' WHERE id_cliente=?";

        try (Connection con = Conexion.conectandoDWI();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idCliente);
            ps.executeUpdate();
        }
    }

    private ClienteDTO mapear(ResultSet rs) throws SQLException {
        ClienteDTO c = new ClienteDTO();
        c.setIdCliente(rs.getInt("id_cliente"));
        c.setIdUsuario(rs.getInt("id_usuario"));
        c.setNombre(rs.getString("nombre"));
        c.setApellido(rs.getString("apellido"));
        c.setTelefono(rs.getString("telefono"));
        c.setEstado(rs.getString("estado"));
        c.setFechaRegistro(rs.getString("fecha_registro"));
        return c;
    }
}
