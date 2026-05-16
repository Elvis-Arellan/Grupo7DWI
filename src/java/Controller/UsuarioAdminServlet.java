package Controller;

import DAO.impl.UsuarioDAOImpl;
import DAO.interfaces.IUsuarioDAO;
import DTO.UsuarioDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/usuarios")
public class UsuarioAdminServlet extends HttpServlet {

    private IUsuarioDAO usuarioDAO;

    @Override
    public void init() {
        usuarioDAO = new UsuarioDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        UsuarioDTO sesion = (UsuarioDTO) req.getSession().getAttribute("usuario");
        if (!"ADMIN".equals(sesion.getRol())) {
            res.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        String accion = req.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        try {
            switch (accion) {
                case "desactivar":
                    int idDes = Integer.parseInt(req.getParameter("id"));
                    usuarioDAO.cambiarEstado(idDes, "INACTIVO");
                    res.sendRedirect(req.getContextPath() + "/admin/usuarios?msg=desactivado");
                    break;

                case "activar":
                    int idAct = Integer.parseInt(req.getParameter("id"));
                    usuarioDAO.cambiarEstado(idAct, "ACTIVO");
                    res.sendRedirect(req.getContextPath() + "/admin/usuarios?msg=activado");
                    break;

                case "eliminar":
                    int idEl = Integer.parseInt(req.getParameter("id"));
                    usuarioDAO.eliminar(idEl);
                    res.sendRedirect(req.getContextPath() + "/admin/usuarios?msg=eliminado");
                    break;

                default:
                    List<UsuarioDTO> lista = usuarioDAO.listarTodos();
                    req.setAttribute("usuarios", lista);
                    req.getRequestDispatcher("/views/admin/usuarios.jsp")
                            .forward(req, res);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/usuarios.jsp").forward(req, res);
        }
    }
}
