package DAO.interfaces;

import DTO.ClienteDTO;
import java.util.List;

public interface  IClienteDAO {

    List<ClienteDTO> listar(int idUsuario) throws Exception;

    ClienteDTO buscarPorId(int idCliente) throws Exception;

    void registrar(ClienteDTO cliente) throws Exception;

    void actualizar(ClienteDTO cliente) throws Exception;

    void eliminar(int idCliente) throws Exception;
}
