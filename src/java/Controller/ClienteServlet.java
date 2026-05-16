package Controller;

import DAO.impl.ClienteDAOImpl;
import DAO.interfaces.IClienteDAO;
import DTO.ClienteDTO;
import DTO.UsuarioDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/clientes")
public class ClienteServlet extends HttpServlet {

    private IClienteDAO clienteDAO;

    @Override
    public void init() {
        clienteDAO = new ClienteDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String accion = req.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        try {
            switch (accion) {
                case "nuevo":
                    req.getRequestDispatcher("/views/clientes/form.jsp")
                            .forward(req, res);
                    break;

                case "editar":
                    int id = Integer.parseInt(req.getParameter("id"));
                    ClienteDTO cliente = clienteDAO.buscarPorId(id);
                    req.setAttribute("cliente", cliente);
                    req.getRequestDispatcher("/views/clientes/form.jsp")
                            .forward(req, res);
                    break;

                case "eliminar":
                    int idEliminar = Integer.parseInt(req.getParameter("id"));
                    clienteDAO.eliminar(idEliminar);
                    res.sendRedirect(req.getContextPath() + "/clientes?msg=eliminado");
                    break;

                default:
                    listar(req, res);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            listar(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        UsuarioDTO sesion = (UsuarioDTO) req.getSession().getAttribute("usuario");

        String idStr = req.getParameter("idCliente");
        boolean esEdicion = idStr != null && !idStr.isEmpty();

        String nombre = req.getParameter("nombre");
        String apellido = req.getParameter("apellido");

        if (nombre == null || nombre.trim().isEmpty()
                || apellido == null || apellido.trim().isEmpty()) {
            req.setAttribute("error", "Nombre y apellido son obligatorios.");
            req.getRequestDispatcher("/views/clientes/form.jsp").forward(req, res);
            return;
        }

        try {
            ClienteDTO c = new ClienteDTO();
            c.setIdUsuario(sesion.getIdUsuario());
            c.setNombre(nombre.trim());
            c.setApellido(apellido.trim());
            c.setTelefono(req.getParameter("telefono"));

            if (esEdicion) {
                c.setIdCliente(Integer.parseInt(idStr));
                clienteDAO.actualizar(c);
                res.sendRedirect(req.getContextPath() + "/clientes?msg=actualizado");
            } else {
                clienteDAO.registrar(c);
                res.sendRedirect(req.getContextPath() + "/clientes?msg=registrado");
            }

        } catch (Exception e) {
            req.setAttribute("error", "Error al guardar: " + e.getMessage());
            req.getRequestDispatcher("/views/clientes/form.jsp").forward(req, res);
        }
    }

    private void listar(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            UsuarioDTO sesion = (UsuarioDTO) req.getSession().getAttribute("usuario");

            List<ClienteDTO> lista = clienteDAO.listar(sesion.getIdUsuario());

            req.setAttribute("clientes", lista);

            req.getRequestDispatcher("/views/clientes/lista.jsp").forward(req, res);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
