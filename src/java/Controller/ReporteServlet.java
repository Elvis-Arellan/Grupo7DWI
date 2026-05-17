package Controller;

import jakarta.servlet.http.HttpServlet;
import DAO.impl.ReporteDAOImpl;
import DAO.interfaces.IReporteDAO;
import DTO.ClienteDTO;
import DTO.UsuarioDTO;
import DTO.VentaDTO;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.List;

@WebServlet("/reportes")
public class ReporteServlet extends HttpServlet {

    private IReporteDAO reporteDAO;

    @Override
    public void init() {
        reporteDAO = new ReporteDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String accion = req.getParameter("accion");
        if (accion == null) {
            accion = "vista";
        }

        UsuarioDTO sesion = (UsuarioDTO) req.getSession().getAttribute("usuario");

        try {
            switch (accion) {
                case "pdfVentas":
                    generarPdfVentas(req, res, sesion);
                    break;
                case "pdfDeudas":
                    generarPdfDeudas(req, res, sesion);
                    break;
                case "csvVentas":
                    generarCsvVentas(req, res, sesion);
                    break;
                case "csvDeudas":
                    generarCsvDeudas(req, res, sesion);
                    break;
                default:
                    req.getRequestDispatcher("/views/reportes/index.jsp")
                            .forward(req, res);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error al generar reporte: " + e.getMessage());
            req.getRequestDispatcher("/views/reportes/index.jsp").forward(req, res);
        }
    }

    private void generarPdfVentas(HttpServletRequest req, HttpServletResponse res,
            UsuarioDTO sesion) throws Exception {

        String desde = req.getParameter("desde");
        String hasta = req.getParameter("hasta");
        if (desde == null || desde.isEmpty()) {
            desde = "2000-01-01";
        }
        if (hasta == null || hasta.isEmpty()) {
            hasta = "2099-12-31";
        }

        List<VentaDTO> ventas = reporteDAO.ventasPorFecha(
                sesion.getIdUsuario(), desde, hasta);

        res.setContentType("application/pdf");
        res.setHeader("Content-Disposition", "attachment; filename=reporte_ventas.pdf");

        Document doc = new Document(PageSize.A4, 40, 40, 50, 50);
        PdfWriter.getInstance(doc, res.getOutputStream());
        doc.open();

        Font fTitulo = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
        Font fSubtit = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.GRAY);
        Font fHeader = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.WHITE);
        Font fCelda = new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL);
        Font fTotal = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD);

        doc.add(new Paragraph("Reporte de Ventas", fTitulo));
        doc.add(new Paragraph("Del " + desde + " al " + hasta
                + "  |  Usuario: " + sesion.getNombreCompleto(), fSubtit));
        doc.add(Chunk.NEWLINE);

        PdfPTable tabla = new PdfPTable(5);
        tabla.setWidthPercentage(100);
        tabla.setWidths(new float[]{1f, 3f, 2.5f, 2f, 2f});

        agregarCeldaHeader(tabla, "#", fHeader);
        agregarCeldaHeader(tabla, "Cliente", fHeader);
        agregarCeldaHeader(tabla, "Fecha", fHeader);
        agregarCeldaHeader(tabla, "Total", fHeader);
        agregarCeldaHeader(tabla, "Estado", fHeader);

        double totalGeneral = 0;
        for (VentaDTO v : ventas) {
            tabla.addCell(new PdfPCell(new Phrase(String.valueOf(v.getIdVenta()), fCelda)));
            tabla.addCell(new PdfPCell(new Phrase(v.getNombreCliente(), fCelda)));
            tabla.addCell(new PdfPCell(new Phrase(v.getFecha(), fCelda)));
            tabla.addCell(new PdfPCell(new Phrase(
                    String.format("S/ %.2f", v.getTotal()), fCelda)));

            PdfPCell cEstado = new PdfPCell(new Phrase(v.getEstado(), fCelda));
            cEstado.setBackgroundColor("PENDIENTE".equals(v.getEstado())
                    ? new BaseColor(255, 243, 205)
                    : new BaseColor(212, 237, 218));
            tabla.addCell(cEstado);

            totalGeneral += v.getTotal();
        }

        PdfPCell cTotalLabel = new PdfPCell(new Phrase("TOTAL GENERAL", fTotal));
        cTotalLabel.setColspan(4);
        cTotalLabel.setHorizontalAlignment(Element.ALIGN_RIGHT);
        tabla.addCell(cTotalLabel);
        tabla.addCell(new PdfPCell(new Phrase(
                String.format("S/ %.2f", totalGeneral), fTotal)));

        doc.add(tabla);

        doc.add(Chunk.NEWLINE);
        doc.add(new Paragraph("Total registros: " + ventas.size(), fSubtit));
        doc.close();
    }

    private void generarPdfDeudas(HttpServletRequest req, HttpServletResponse res,
            UsuarioDTO sesion) throws Exception {

        List<ClienteDTO> clientes = reporteDAO.clientesConDeuda(sesion.getIdUsuario());

        res.setContentType("application/pdf");
        res.setHeader("Content-Disposition", "attachment; filename=reporte_deudas.pdf");

        Document doc = new Document(PageSize.A4, 40, 40, 50, 50);
        PdfWriter.getInstance(doc, res.getOutputStream());
        doc.open();

        Font fTitulo = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
        Font fSubtit = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.GRAY);
        Font fHeader = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.WHITE);
        Font fCelda = new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL);
        Font fTotal = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD);

        doc.add(new Paragraph("Clientes con Deuda Pendiente", fTitulo));
        doc.add(new Paragraph("Usuario: " + sesion.getNombreCompleto(), fSubtit));
        doc.add(Chunk.NEWLINE);

        PdfPTable tabla = new PdfPTable(4);
        tabla.setWidthPercentage(100);
        tabla.setWidths(new float[]{3f, 3f, 2f, 2f});

        agregarCeldaHeader(tabla, "Nombre", fHeader);
        agregarCeldaHeader(tabla, "Apellido", fHeader);
        agregarCeldaHeader(tabla, "Teléfono", fHeader);
        agregarCeldaHeader(tabla, "Deuda", fHeader);

        double totalDeuda = 0;
        for (ClienteDTO c : clientes) {
            tabla.addCell(new PdfPCell(new Phrase(c.getNombre(), fCelda)));
            tabla.addCell(new PdfPCell(new Phrase(c.getApellido(), fCelda)));
            tabla.addCell(new PdfPCell(new Phrase(
                    c.getTelefono() != null ? c.getTelefono() : "-", fCelda)));

            PdfPCell cDeuda = new PdfPCell(new Phrase(
                    String.format("S/ %.2f", c.getDeudaTotal()), fCelda));
            cDeuda.setBackgroundColor(new BaseColor(255, 243, 205));
            tabla.addCell(cDeuda);

            totalDeuda += c.getDeudaTotal();
        }

        PdfPCell cLabel = new PdfPCell(new Phrase("TOTAL DEUDA", fTotal));
        cLabel.setColspan(3);
        cLabel.setHorizontalAlignment(Element.ALIGN_RIGHT);
        tabla.addCell(cLabel);
        tabla.addCell(new PdfPCell(new Phrase(
                String.format("S/ %.2f", totalDeuda), fTotal)));

        doc.add(tabla);
        doc.add(Chunk.NEWLINE);
        doc.add(new Paragraph("Total clientes con deuda: " + clientes.size(), fSubtit));
        doc.close();
    }

    private void generarCsvVentas(HttpServletRequest req, HttpServletResponse res,
            UsuarioDTO sesion) throws Exception {

        String desde = req.getParameter("desde");
        String hasta = req.getParameter("hasta");
        if (desde == null || desde.isEmpty()) {
            desde = "2000-01-01";
        }
        if (hasta == null || hasta.isEmpty()) {
            hasta = "2099-12-31";
        }

        List<VentaDTO> ventas = reporteDAO.ventasPorFecha(
                sesion.getIdUsuario(), desde, hasta);

        res.setContentType("text/csv; charset=UTF-8");
        res.setHeader("Content-Disposition", "attachment; filename=ventas.csv");

        PrintWriter pw = res.getWriter();
        pw.println("ID,Cliente,Fecha,Total,Estado");

        for (VentaDTO v : ventas) {
            pw.println(v.getIdVenta() + ","
                    + escaparCsv(v.getNombreCliente()) + ","
                    + v.getFecha() + ","
                    + String.format("%.2f", v.getTotal()) + ","
                    + v.getEstado());
        }
        pw.flush();
    }

    private void generarCsvDeudas(HttpServletRequest req, HttpServletResponse res,
            UsuarioDTO sesion) throws Exception {

        List<ClienteDTO> clientes = reporteDAO.clientesConDeuda(sesion.getIdUsuario());

        res.setContentType("text/csv; charset=UTF-8");
        res.setHeader("Content-Disposition", "attachment; filename=deudas.csv");

        PrintWriter pw = res.getWriter();
        pw.println("Nombre,Apellido,Telefono,Deuda Total");

        for (ClienteDTO c : clientes) {
            pw.println(escaparCsv(c.getNombre()) + ","
                    + escaparCsv(c.getApellido()) + ","
                    + (c.getTelefono() != null ? c.getTelefono() : "") + ","
                    + String.format("%.2f", c.getDeudaTotal()));
        }
        pw.flush();
    }

    private void agregarCeldaHeader(PdfPTable tabla, String texto, Font fuente) {
        PdfPCell celda = new PdfPCell(new Phrase(texto, fuente));
        celda.setBackgroundColor(new BaseColor(52, 58, 64));
        celda.setPadding(6);
        celda.setHorizontalAlignment(Element.ALIGN_CENTER);
        tabla.addCell(celda);
    }

    private String escaparCsv(String valor) {
        if (valor == null) {
            return "";
        }
        if (valor.contains(",") || valor.contains("\"") || valor.contains("\n")) {
            return "\"" + valor.replace("\"", "\"\"") + "\"";
        }
        return valor;
    }
}
