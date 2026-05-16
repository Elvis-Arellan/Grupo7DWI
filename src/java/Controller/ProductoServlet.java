package Controller;

import DAO.impl.ProductoDAOImpl;
import DAO.interfaces.IProductoDAO;
import DTO.ProductoDTO;
import DTO.UsuarioDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/productos")
public class ProductoServlet extends HttpServlet {

    private IProductoDAO productoDAO;

    @Override
    public void init() {
        productoDAO = new ProductoDAOImpl();
    }
    //pa la api rest
    // GET /productos          → lista
    // GET /productos?accion=nuevo      → form vacío
    // GET /productos?accion=editar&id= → form con datos

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String accion = req.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        try {
            switch (accion) {
                case "nuevo":
                    req.getRequestDispatcher("/views/productos/form.jsp").forward(req, res);
                    break;

                case "editar":
                    int id = Integer.parseInt(req.getParameter("id"));
                    ProductoDTO producto = productoDAO.buscarPorId(id);
                    req.setAttribute("producto", producto);
                    req.getRequestDispatcher("/views/productos/form.jsp").forward(req, res);
                    break;

                case "eliminar":
                    int idEliminar = Integer.parseInt(req.getParameter("id"));
                    productoDAO.eliminar(idEliminar);
                    res.sendRedirect(req.getContextPath() + "/productos?msg=eliminado");
                    break;

                default:
                    listar(req, res);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            req.getRequestDispatcher("/views/productos/lista.jsp").forward(req, res);
        }
    }

    // POST /productos → registrar o actualizar
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        UsuarioDTO usuarioSesion = (UsuarioDTO) req.getSession().getAttribute("usuario");

        String idStr = req.getParameter("idProducto");
        boolean esEdicion = idStr != null && !idStr.isEmpty();

        try {
            ProductoDTO p = new ProductoDTO();
            p.setIdUsuario(usuarioSesion.getIdUsuario());
            p.setNombre(req.getParameter("nombre"));
            p.setCategoria(req.getParameter("categoria"));
            p.setPrecio(Double.parseDouble(req.getParameter("precio")));
            p.setStockActual(Integer.parseInt(req.getParameter("stockActual")));
            p.setStockMinimo(Integer.parseInt(req.getParameter("stockMinimo")));

            if (esEdicion) {
                p.setIdProducto(Integer.parseInt(idStr));
                productoDAO.actualizar(p);
                res.sendRedirect(req.getContextPath() + "/productos?msg=actualizado");
            } else {
                productoDAO.registrar(p);
                res.sendRedirect(req.getContextPath() + "/productos?msg=registrado");
            }

        } catch (Exception e) {
            req.setAttribute("error", "Error al guardar: " + e.getMessage());
            req.getRequestDispatcher("/views/productos/form.jsp").forward(req, res);
        }
    }

    private void listar(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        UsuarioDTO usuarioSesion = (UsuarioDTO) req.getSession().getAttribute("usuario");
        List<ProductoDTO> lista = productoDAO.listar(usuarioSesion.getIdUsuario());
        req.setAttribute("productos", lista);
        req.getRequestDispatcher("/views/productos/lista.jsp").forward(req, res);
    }

}
