package DAO.interfaces;

import DTO.ClienteDTO;
import DTO.VentaDTO;
import java.util.List;

public interface IReporteDAO {

    List<VentaDTO> ventasPorFecha(int idUsuario, String desde, String hasta) throws Exception;

    List<ClienteDTO> clientesConDeuda(int idUsuario) throws Exception;
}
