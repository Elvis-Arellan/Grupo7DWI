package DAO.interfaces;

import DTO.ProductoDTO;
import java.util.List;

public interface IProductoDAO {

    List<ProductoDTO> listar(int idUsuario) throws Exception;

    ProductoDTO buscarPorId(int idProducto) throws Exception;

    void registrar(ProductoDTO producto) throws Exception;

    void actualizar(ProductoDTO producto) throws Exception;

    void eliminar(int idProducto) throws Exception;
}
