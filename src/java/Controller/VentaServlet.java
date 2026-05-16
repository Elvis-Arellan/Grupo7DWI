package Controller;

import DAO.impl.ClienteDAOImpl;
import DAO.impl.ProductoDAOImpl;
import DAO.impl.VentaDAOImpl;
import DAO.interfaces.IClienteDAO;
import DAO.interfaces.IProductoDAO;
import DAO.interfaces.IVentaDAO;
import DTO.DetalleVentaDTO;
import DTO.UsuarioDTO;
import DTO.VentaDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ventas")
public class VentaServlet extends HttpServlet {

    private IVentaDAO ventaDAO;
    private IClienteDAO clienteDAO;
    private IProductoDAO productoDAO;
    
      @Override
    public void init() {
        ventaDAO    = new VentaDAOImpl();
        clienteDAO  = new ClienteDAOImpl();
        productoDAO = new ProductoDAOImpl();
    }
    
     @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String accion = req.getParameter("accion");
        if (accion == null) accion = "listar";

         UsuarioDTO sesion = (UsuarioDTO) req.getSession().getAttribute("usuario");

        try {
            switch (accion) {
                case "nueva":
                    // Necesita lista de clientes y productos para los selects
                    req.setAttribute("clientes",  clienteDAO.listar(sesion.getIdUsuario()));
                    req.setAttribute("productos", productoDAO.listar(sesion.getIdUsuario()));
                    req.getRequestDispatcher("/views/ventas/form.jsp").forward(req, res);
                    break;

                case "ver":
                    int idVer = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("venta", ventaDAO.buscarPorId(idVer));
                    req.getRequestDispatcher("/views/ventas/detalle.jsp").forward(req, res);
                    break;

                case "pagar":
                    int idPagar = Integer.parseInt(req.getParameter("id"));
                    ventaDAO.marcarPagado(idPagar);
                    res.sendRedirect(req.getContextPath() + "/ventas?msg=pagado");
                    break;

                case "eliminar":
                    int idEliminar = Integer.parseInt(req.getParameter("id"));
                    ventaDAO.eliminar(idEliminar);
                    res.sendRedirect(req.getContextPath() + "/ventas?msg=eliminado");
                    break;

                default:
                    List<VentaDTO> lista = ventaDAO.listar(sesion.getIdUsuario());
                    req.setAttribute("ventas", lista);
                    req.getRequestDispatcher("/views/ventas/lista.jsp").forward(req, res);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            req.getRequestDispatcher("/views/ventas/lista.jsp").forward(req, res);
        }
    }
    
      @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        UsuarioDTO sesion = (UsuarioDTO) req.getSession().getAttribute("usuario");

        try {
            // Leer arrays de productos enviados desde el formulario
            String[] idsProducto    = req.getParameterValues("idProducto[]");
            String[] cantidades     = req.getParameterValues("cantidad[]");
            String[] precios        = req.getParameterValues("precioUnitario[]");

            if (idsProducto == null || idsProducto.length == 0) {
                req.setAttribute("error", "Debes agregar al menos un producto.");
                req.setAttribute("clientes",  clienteDAO.listar(sesion.getIdUsuario()));
                req.setAttribute("productos", productoDAO.listar(sesion.getIdUsuario()));
                req.getRequestDispatcher("/views/ventas/form.jsp").forward(req, res);
                return;
            }

            // Armar detalle
            List<DetalleVentaDTO> detalle = new ArrayList<>();
            double total = 0;

            for (int i = 0; i < idsProducto.length; i++) {
                DetalleVentaDTO d = new DetalleVentaDTO();
                d.setIdProducto(Integer.parseInt(idsProducto[i]));
                d.setCantidad(Integer.parseInt(cantidades[i]));
                d.setPrecioUnitario(Double.parseDouble(precios[i]));
                d.setSubtotal(d.getCantidad() * d.getPrecioUnitario());
                total += d.getSubtotal();
                detalle.add(d);
            }

            // Armar cabecera
            VentaDTO venta = new VentaDTO();
            venta.setIdUsuario(sesion.getIdUsuario());
            venta.setIdCliente(Integer.parseInt(req.getParameter("idCliente")));
            venta.setObservacion(req.getParameter("observacion"));
            venta.setTotal(total);
            venta.setDetalle(detalle);

            ventaDAO.registrar(venta);
            res.sendRedirect(req.getContextPath() + "/ventas?msg=registrado");

        } catch (Exception e) {
            req.setAttribute("error", "Error al registrar venta: " + e.getMessage());
            try {
                req.setAttribute("clientes",  clienteDAO.listar(sesion.getIdUsuario()));
                req.setAttribute("productos", productoDAO.listar(sesion.getIdUsuario()));
            } catch (Exception ex) { /* ignorar */ }
            req.getRequestDispatcher("/views/ventas/form.jsp").forward(req, res);
        }
    }
}
