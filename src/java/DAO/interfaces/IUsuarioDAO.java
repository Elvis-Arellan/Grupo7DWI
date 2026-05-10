package DAO.interfaces;

import DTO.UsuarioDTO;

public interface  IUsuarioDAO {

    UsuarioDTO buscarPorUsername(String username) throws Exception;

    void registrar(UsuarioDTO usuario) throws Exception;

    boolean existeUsername(String username) throws Exception;
}
