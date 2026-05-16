package Controller;

import DAO.impl.UsuarioDAOImpl;
import DAO.interfaces.IUsuarioDAO;
import DTO.UsuarioDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import util.PasswordUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private IUsuarioDAO usuarioDAO;

    @Override
    public void init() {
        usuarioDAO = new UsuarioDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession sesion = req.getSession(false);
        if (sesion != null && sesion.getAttribute("usuario") != null) {
            System.out.println("doget login servlet: Estoy dirigiendo al dashboard");
            res.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }
        req.getRequestDispatcher("/views/login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String clave = req.getParameter("clave");

        if (username == null || username.trim().isEmpty()
                || clave == null || clave.trim().isEmpty()) {
            req.setAttribute("error", "Completa todos los campos.");
            req.getRequestDispatcher("/Grupo7DWI/views/login.jsp").forward(req, res);
            return;
        }

        try {
            UsuarioDTO usuario = usuarioDAO.buscarPorUsername(username.trim());

            if (usuario != null && PasswordUtil.verificar(clave, usuario.getClave())) {
                HttpSession sesion = req.getSession(true);
                sesion.setAttribute("usuario", usuario);
                sesion.setAttribute("idUsuario", usuario.getIdUsuario());
                sesion.setAttribute("rolUsuario", usuario.getRol());
                sesion.setMaxInactiveInterval(30 * 60);
                System.out.println("DOPOST login servlet: correctamente al dashboard");
                res.sendRedirect("/Grupo7DWI/views/dashboard.jsp");
            } else {
                req.setAttribute("error", "Usuario o contraseña incorrectos.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, res);
            }

        } catch (Exception e) {
            req.setAttribute("error", "Error del servidor. Intenta de nuevo.");
            req.getRequestDispatcher("/Grupo7DWI/views/login.jsp").forward(req, res);
        }
    }
}
