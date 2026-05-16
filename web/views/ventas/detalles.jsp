<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@taglib uri="jakarta.tags.fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head><meta charset="UTF-8"><title>Detalle venta</title></head>
    <body>

        <h2>Detalle de venta #${venta.idVenta}</h2>

        <p><b>Cliente:</b> ${venta.nombreCliente}</p>
        <p><b>Fecha:</b>   ${venta.fecha}</p>
        <p><b>Estado:</b>  ${venta.estado}</p>
        <c:if test="${not empty venta.observacion}">
            <p><b>Observación:</b> ${venta.observacion}</p>
        </c:if>

        <table border="1" cellpadding="6">
            <thead>
                <tr>
                    <th>Producto</th><th>Cantidad</th>
                    <th>Precio unit.</th><th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="d" items="${venta.detalle}">
                    <tr>
                        <td>${d.nombreProducto}</td>
                        <td>${d.cantidad}</td>
                        <td>S/ <fmt:formatNumber value="${d.precioUnitario}" pattern="#,##0.00"/></td>
                        <td>S/ <fmt:formatNumber value="${d.subtotal}"       pattern="#,##0.00"/></td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3"><b>Total</b></td>
                    <td><b>S/ <fmt:formatNumber value="${venta.total}" pattern="#,##0.00"/></b></td>
                </tr>
            </tfoot>
        </table>

        <br>
        <c:if test="${venta.estado eq 'PENDIENTE'}">
            <a href="${pageContext.request.contextPath}/ventas?accion=pagar&id=${venta.idVenta}"
               onclick="return confirm('¿Marcar como pagado?')">
                ✔ Marcar como pagado
            </a> |
        </c:if>
        <a href="${pageContext.request.contextPath}/ventas">← Volver a ventas</a>

    </body>
</html>