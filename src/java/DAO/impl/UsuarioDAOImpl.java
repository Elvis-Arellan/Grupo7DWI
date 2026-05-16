package DAO.impl;

import DAO.interfaces.IUsuarioDAO;
import BBDD.Conexion;
import DTO.UsuarioDTO;
import util.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAOImpl implements IUsuarioDAO {

    @Override
    public UsuarioDTO buscarPorUsername(String username) throws Exception {
        String sql = "SELECT id_usuario, username, clave, nombre_completo, rol "
                + "FROM usuarios WHERE username = ? AND estado = 'ACTIVO'";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UsuarioDTO u = new UsuarioDTO();
                    u.setIdUsuario(rs.getInt("id_usuario"));
                    u.setUserName(rs.getString("username"));
                    u.setClave(rs.getString("clave"));
                    u.setNombreCompleto(rs.getString("nombre_completo"));
                    u.setRol(rs.getString("rol"));
                    return u;
                }
            }
        }
        return null;
    }

    @Override
    public void registrar(UsuarioDTO usuario) throws Exception {
        String sql = "INSERT INTO usuarios (username, clave, nombre_completo, rol) "
                + "VALUES (?, ?, ?, ?)";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, usuario.getUserName());
            ps.setString(2, PasswordUtil.hashear(usuario.getClave()));
            ps.setString(3, usuario.getNombreCompleto());
            ps.setString(4, usuario.getRol());
            ps.executeUpdate();
        }
    }

    @Override
    public boolean existeUsername(String username) throws Exception {
        String sql = "SELECT COUNT(*) FROM usuarios WHERE username = ?";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    @Override
    public List<UsuarioDTO> listarTodos() throws Exception {
        List<UsuarioDTO> lista = new ArrayList<>();
        String sql = "SELECT id_usuario, username, nombre_completo, rol, "
                + "estado, fecha_registro FROM usuarios ORDER BY fecha_registro DESC";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                UsuarioDTO u = new UsuarioDTO();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setUserName(rs.getString("username"));
                u.setNombreCompleto(rs.getString("nombre_completo"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getString("estado"));
                u.setFechaRegistro(rs.getString("fecha_registro"));
                lista.add(u);
            }
        }
        return lista;
    }

    @Override
    public void cambiarEstado(int idUsuario, String estado) throws Exception {
        String sql = "UPDATE usuarios SET estado=? WHERE id_usuario=?";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, estado);
            ps.setInt(2, idUsuario);
            ps.executeUpdate();
        }
    }

    @Override
    public void eliminar(int idUsuario) throws Exception {
        String sql = "DELETE FROM usuarios WHERE id_usuario=?";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.executeUpdate();
        }
    }
}
