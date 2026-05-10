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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession(false);
        if (sesion != null && sesion.getAttribute("usuario") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String clave = request.getParameter("clave");
        
        // Validación básica de campos vacíos
        if (username == null || username.trim().isEmpty()
                || clave == null || clave.trim().isEmpty()) {
            request.setAttribute("error", "Completa todos los campos.");
            request.getRequestDispatcher("/Grupo7DWI/views/login.jsp").forward(request, response);
            return;
        }

        try {
            UsuarioDTO usuario = usuarioDAO.buscarPorUsername(username.trim());

            if (usuario != null && PasswordUtil.verificar(clave, usuario.getClave())) {
                // Crear sesión — NO guardar la clave en sesión
                HttpSession sesion = request.getSession(true);
                sesion.setAttribute("usuario", usuario);
                sesion.setAttribute("idUsuario", usuario.getIdUsuario());
                sesion.setAttribute("rolUsuario", usuario.getRol());
                sesion.setMaxInactiveInterval(30 * 60); // 30 minutos

                response.sendRedirect("/Grupo7DWI/views/dashboard.jsp");
            } else {
                request.setAttribute("error", "Usuario o contraseña incorrectos.");
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Error del servidor. Intenta de nuevo.");
            request.getRequestDispatcher("/Grupo7DWI/views/login.jsp").forward(request, response);
        }
    }
}
