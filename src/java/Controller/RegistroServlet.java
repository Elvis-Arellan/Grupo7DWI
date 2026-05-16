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
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/Grupo7DWI/views/registro.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String clave = req.getParameter("clave");
        String confirmar = req.getParameter("confirmar");
        String nombre = req.getParameter("nombreCompleto");
        String rol = req.getParameter("rol");

        if (username == null || username.trim().isEmpty()
                || clave == null || clave.trim().isEmpty()
                || nombre == null || nombre.trim().isEmpty()) {
            req.setAttribute("error", "Todos los campos son obligatorios.");
            req.getRequestDispatcher("/views/registro.jsp").forward(req, res);
            return;
        }

        if (!clave.equals(confirmar)) {
            req.setAttribute("error", "Las contraseñas no coinciden.");
            req.getRequestDispatcher("/views/registro.jsp").forward(req, res);
            return;
        }

        if (clave.length() < 6) {
            req.setAttribute("error", "La contraseña debe tener al menos 6 caracteres.");
            req.getRequestDispatcher("/views/registro.jsp").forward(req, res);
            return;
        }

        if (!"ADMIN".equals(rol) && !"VENDEDOR".equals(rol)) {
            rol = "VENDEDOR";
        }

        try {
            if (usuarioDAO.existeUsername(username.trim())) {
                req.setAttribute("error", "El nombre de usuario ya está en uso.");
                req.getRequestDispatcher("/views/registro.jsp").forward(req, res);
                return;
            }

            UsuarioDTO nuevo = new UsuarioDTO();
            nuevo.setUserName(username.trim());
            nuevo.setClave(clave);
            nuevo.setNombreCompleto(nombre.trim());
            nuevo.setRol(rol);

            usuarioDAO.registrar(nuevo);
            System.out.println("Do post registro servlet manda al login.jsp registro ok");
            res.sendRedirect(req.getContextPath() + "/login?msg=registro_ok");

        } catch (Exception e) {
            req.setAttribute("error", "Error al registrar. Intenta de nuevo.");
            req.getRequestDispatcher("/views/registro.jsp").forward(req, res);
        }
    }
}
