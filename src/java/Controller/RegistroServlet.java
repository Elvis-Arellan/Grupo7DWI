package Controller;

import DAO.impl.UsuarioDAOImpl;
import DAO.impl.ProductoDAOImpl;
import DAO.interfaces.IUsuarioDAO;
import DAO.interfaces.IProductoDAO;
import DTO.ProductoDTO;
import DTO.UsuarioDTO;
import util.SeederProductos;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    private IUsuarioDAO usuarioDAO;
    private IProductoDAO productoDAO;

    @Override
    public void init() {
        usuarioDAO = new UsuarioDAOImpl();
        productoDAO = new ProductoDAOImpl();
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

            int idUsuarioCreado = usuarioDAO.registrar(nuevo);
            System.out.println("Do post registro servlet manda al login.jsp registro ok");

            try {
                List<ProductoDTO> plantilla = SeederProductos.leerPlantilla(getServletContext());
                productoDAO.registrarLote(idUsuarioCreado, plantilla);
                System.out.println("Productos de plantilla clonados para el usuario " + idUsuarioCreado);
            } catch (Exception eSeed) {
                System.out.println("Aviso: no se pudo clonar productos de plantilla: " + eSeed.getMessage());
            }

            res.sendRedirect(req.getContextPath() + "/login?msg=registro_ok");

        } catch (Exception e) {
            req.setAttribute("error", "Error al registrar. Intenta de nuevo.");
            req.getRequestDispatcher("/views/registro.jsp").forward(req, res);
        }
    }
}
