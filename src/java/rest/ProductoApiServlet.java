package rest;

import DAO.impl.ProductoDAOImpl;
import DAO.interfaces.IProductoDAO;
import DTO.ProductoDTO;
import DTO.UsuarioDTO;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;


@WebServlet("/api/productos/*")
public class ProductoApiServlet extends HttpServlet {

    private IProductoDAO productoDAO;
    private final Gson gson = new Gson();

    @Override
    public void init() {
        productoDAO = new ProductoDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("application/json;charset=UTF-8");
        UsuarioDTO sesion = obtenerSesion(req, res);
        if (sesion == null) return;

        String pathInfo = req.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                List<ProductoDTO> lista = productoDAO.listar(sesion.getIdUsuario());
                res.getWriter().write(gson.toJson(lista));
            } else {
                int id = Integer.parseInt(pathInfo.substring(1));
                ProductoDTO p = productoDAO.buscarPorId(id);

                if (p == null || p.getIdUsuario() != sesion.getIdUsuario()) {
                    res.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    res.getWriter().write("{\"error\":\"Producto no encontrado\"}");
                    return;
                }
                res.getWriter().write(gson.toJson(p));
            }
        } catch (NumberFormatException nfe) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            res.getWriter().write("{\"error\":\"El id del producto debe ser numerico\"}");
        } catch (Exception e) {
            res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            res.getWriter().write("{\"error\":\"" + escapar(e.getMessage()) + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("application/json;charset=UTF-8");
        UsuarioDTO sesion = obtenerSesion(req, res);
        if (sesion == null) return;

        try {
            ProductoDTO nuevo = gson.fromJson(leerBody(req), ProductoDTO.class);
            if (nuevo == null || nuevo.getNombre() == null || nuevo.getNombre().trim().isEmpty()) {
                res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                res.getWriter().write("{\"error\":\"El nombre del producto es obligatorio\"}");
                return;
            }

            nuevo.setIdUsuario(sesion.getIdUsuario()); 

            productoDAO.registrar(nuevo);

            res.setStatus(HttpServletResponse.SC_CREATED);
            res.getWriter().write("{\"mensaje\":\"Producto creado correctamente\"}");

        } catch (Exception e) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            res.getWriter().write("{\"error\":\"" + escapar(e.getMessage()) + "\"}");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("application/json;charset=UTF-8");
        UsuarioDTO sesion = obtenerSesion(req, res);
        if (sesion == null) return;

        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            res.getWriter().write("{\"error\":\"Falta el id del producto en la URL\"}");
            return;
        }

        try {
            int id = Integer.parseInt(pathInfo.substring(1));
            ProductoDTO existente = productoDAO.buscarPorId(id);

            if (existente == null || existente.getIdUsuario() != sesion.getIdUsuario()) {
                res.setStatus(HttpServletResponse.SC_FORBIDDEN);
                res.getWriter().write("{\"error\":\"No tienes permiso sobre este producto\"}");
                return;
            }

            ProductoDTO datos = gson.fromJson(leerBody(req), ProductoDTO.class);
            datos.setIdProducto(id);
            datos.setIdUsuario(sesion.getIdUsuario());

            productoDAO.actualizar(datos);
            res.getWriter().write("{\"mensaje\":\"Producto actualizado correctamente\"}");

        } catch (NumberFormatException nfe) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            res.getWriter().write("{\"error\":\"El id del producto debe ser numerico\"}");
        } catch (Exception e) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            res.getWriter().write("{\"error\":\"" + escapar(e.getMessage()) + "\"}");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("application/json;charset=UTF-8");
        UsuarioDTO sesion = obtenerSesion(req, res);
        if (sesion == null) return;

        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            res.getWriter().write("{\"error\":\"Falta el id del producto en la URL\"}");
            return;
        }

        try {
            int id = Integer.parseInt(pathInfo.substring(1));
            ProductoDTO existente = productoDAO.buscarPorId(id);

            if (existente == null || existente.getIdUsuario() != sesion.getIdUsuario()) {
                res.setStatus(HttpServletResponse.SC_FORBIDDEN);
                res.getWriter().write("{\"error\":\"No tienes permiso sobre este producto\"}");
                return;
            }

            productoDAO.eliminar(id);
            res.getWriter().write("{\"mensaje\":\"Producto eliminado correctamente\"}");

        } catch (NumberFormatException nfe) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            res.getWriter().write("{\"error\":\"El id del producto debe ser numerico\"}");
        } catch (Exception e) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            res.getWriter().write("{\"error\":\"" + escapar(e.getMessage()) + "\"}");
        }
    }

    private UsuarioDTO obtenerSesion(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession(false);
        UsuarioDTO usuario = session != null ? (UsuarioDTO) session.getAttribute("usuario") : null;

        if (usuario == null) {
            res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            res.getWriter().write("{\"error\":\"No hay sesion activa. Inicia sesion primero.\"}");
            return null;
        }
        return usuario;
    }

    private String leerBody(HttpServletRequest req) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = req.getReader()) {
            String linea;
            while ((linea = reader.readLine()) != null) sb.append(linea);
        }
        return sb.toString();
    }

    private String escapar(String valor) {
        return valor == null ? "" : valor.replace("\"", "'");
    }
}
