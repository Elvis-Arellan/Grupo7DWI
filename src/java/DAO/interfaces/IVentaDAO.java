package DAO.interfaces;

import DTO.VentaDTO;
import java.util.List;

public interface IVentaDAO {

    List<VentaDTO> listar(int idUsuario) throws Exception;

    VentaDTO buscarPorId(int idVenta) throws Exception;

    void registrar(VentaDTO venta) throws Exception;

    void marcarPagado(int idVenta) throws Exception;

    void eliminar(int idVenta) throws Exception;
}
