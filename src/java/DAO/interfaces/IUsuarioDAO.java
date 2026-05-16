package DAO.interfaces;

import DTO.UsuarioDTO;
import java.util.List;

public interface IUsuarioDAO {

    UsuarioDTO buscarPorUsername(String username) throws Exception;

    void registrar(UsuarioDTO usuario) throws Exception;

    boolean existeUsername(String username) throws Exception;

    List<UsuarioDTO> listarTodos() throws Exception;

    void cambiarEstado(int idUsuario, String estado) throws Exception;

    void eliminar(int idUsuario) throws Exception;
}
