package Controller;

import DAO.impl.UsuarioDAOImpl;
import DAO.interfaces.IUsuarioDAO;
import DTO.UsuarioDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    private IUsuarioDAO usuarioDAO;

    @Override
    public void init() {
        usuarioDAO = new UsuarioDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Grupo7DWI/views/registro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String clave = request.getParameter("clave");
        String confirmar = request.getParameter("confirmar");
        String nombre = request.getParameter("nombreCompleto");
        String rol = request.getParameter("rol");

        // Validaciones
        if (username == null || username.trim().isEmpty()
                || clave == null || clave.trim().isEmpty()
                || nombre == null || nombre.trim().isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
            return;
        }

        if (!clave.equals(confirmar)) {
            request.setAttribute("error", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
            return;
        }

        if (clave.length() < 6) {
            request.setAttribute("error", "La contraseña debe tener al menos 6 caracteres.");
            request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
            return;
        }

        // Validar que rol sea válido
        if (!"ADMIN".equals(rol) && !"VENDEDOR".equals(rol)) {
            rol = "VENDEDOR";
        }

        try {
            if (usuarioDAO.existeUsername(username.trim())) {
                request.setAttribute("error", "El nombre de usuario ya está en uso.");
                request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
                return;
            }

            UsuarioDTO nuevo = new UsuarioDTO();
            nuevo.setUserName(username.trim());
            nuevo.setClave(clave);
            nuevo.setNombreCompleto(nombre.trim());
            nuevo.setRol(rol);

            usuarioDAO.registrar(nuevo);

            response.sendRedirect(request.getContextPath() + "/login?msg=registro_ok");

        } catch (Exception e) {
            request.setAttribute("error", "Error al registrar. Intenta de nuevo.");
            request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
        }
    }
}
