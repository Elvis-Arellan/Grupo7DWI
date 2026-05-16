package DAO.impl;

import BBDD.Conexion;
import DAO.interfaces.IProductoDAO;
import DTO.ProductoDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAOImpl implements IProductoDAO {

    @Override
    public List<ProductoDTO> listar(int idUsuario) throws Exception {
        List<ProductoDTO> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos WHERE id_usuario = ? AND estado = 'ACTIVO' ORDER BY nombre";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapear(rs));
                }
            }
        }
        return lista;
    }

    @Override
    public ProductoDTO buscarPorId(int idProducto) throws Exception {
        String sql = "SELECT * FROM productos WHERE id_producto = ?";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idProducto);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapear(rs) : null;
            }
        }
    }

    @Override
    public void registrar(ProductoDTO p) throws Exception {
        String sql = "INSERT INTO productos (id_usuario, nombre, categoria, precio, stock_actual, stock_minimo) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, p.getIdUsuario());
            ps.setString(2, p.getNombre());
            ps.setString(3, p.getCategoria());
            ps.setDouble(4, p.getPrecio());
            ps.setInt(5, p.getStockActual());
            ps.setInt(6, p.getStockMinimo());
            ps.executeUpdate();
        }
    }

    @Override
    public void actualizar(ProductoDTO p) throws Exception {
        String sql = "UPDATE productos SET nombre=?, categoria=?, precio=?, "
                + "stock_actual=?, stock_minimo=? WHERE id_producto=? AND id_usuario=?";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getCategoria());
            ps.setDouble(3, p.getPrecio());
            ps.setInt(4, p.getStockActual());
            ps.setInt(5, p.getStockMinimo());
            ps.setInt(6, p.getIdProducto());
            ps.setInt(7, p.getIdUsuario());
            ps.executeUpdate();
        }
    }

    @Override
    public void eliminar(int idProducto) throws Exception {
        // Eliminación lógica
        String sql = "UPDATE productos SET estado = 'INACTIVO' WHERE id_producto = ?";

        try (Connection con = Conexion.conectandoDWI(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idProducto);
            ps.executeUpdate();
        }
    }

    private ProductoDTO mapear(ResultSet rs) throws SQLException {
        ProductoDTO p = new ProductoDTO();
        p.setIdProducto(rs.getInt("id_producto"));
        p.setIdUsuario(rs.getInt("id_usuario"));
        p.setNombre(rs.getString("nombre"));
        p.setCategoria(rs.getString("categoria"));
        p.setPrecio(rs.getDouble("precio"));
        p.setStockActual(rs.getInt("stock_actual"));
        p.setStockMinimo(rs.getInt("stock_minimo"));
        p.setEstado(rs.getString("estado"));
        return p;
    }
}
