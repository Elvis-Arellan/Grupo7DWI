package Controller;

import DAO.impl.VentaDAOImpl;
import DAO.interfaces.IVentaDAO;
import DTO.UsuarioDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private IVentaDAO ventaDAO;

    @Override
    public void init() {
        ventaDAO = new VentaDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        UsuarioDTO sesion = (UsuarioDTO) req.getSession().getAttribute("usuario");

        try {
            req.setAttribute("ventasPendientes",
                    ventaDAO.listar(sesion.getIdUsuario())
                            .stream()
                            .filter(v -> "PENDIENTE".equals(v.getEstado()))
                            .count());
        } catch (Exception e) {
            req.setAttribute("ventasPendientes", 0);
        }

        req.getRequestDispatcher("/views/dashboard.jsp").forward(req, res);
    }
}
