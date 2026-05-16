<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@taglib uri="jakarta.tags.fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head><meta charset="UTF-8"><title>Ventas / Fiados</title></head>
    <body>

        <h2>Ventas / Fiados</h2>
        <a href="${pageContext.request.contextPath}/ventas?accion=nueva">+ Nueva venta</a>

        <c:if test="${param.msg eq 'registrado'}"><p style="color:green">Venta registrada.</p></c:if>
        <c:if test="${param.msg eq 'pagado'}">    <p style="color:green">Venta marcada como pagada.</p></c:if>
        <c:if test="${param.msg eq 'eliminado'}"> <p style="color:green">Venta eliminada.</p></c:if>
        <c:if test="${not empty error}">          <p style="color:red">${error}</p></c:if>

            <table border="1" cellpadding="6">
                <thead>
                    <tr>
                        <th>#</th><th>Cliente</th><th>Fecha</th>
                        <th>Total</th><th>Estado</th><th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="v" items="${ventas}">
                    <tr>
                        <td>${v.idVenta}</td>
                        <td>${v.nombreCliente}</td>
                        <td>${v.fecha}</td>
                        <td>S/ <fmt:formatNumber value="${v.total}" pattern="#,##0.00"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${v.estado eq 'PENDIENTE'}">
                                    <span style="color:orange"><b>PENDIENTE</b></span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:green"><b>PAGADO</b></span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/ventas?accion=ver&id=${v.idVenta}">
                                Ver
                            </a>
                            <c:if test="${v.estado eq 'PENDIENTE'}">
                                |
                                <a href="${pageContext.request.contextPath}/ventas?accion=pagar&id=${v.idVenta}"
                                   onclick="return confirm('¿Marcar como pagado?')">
                                    Pagar
                                </a>
                            </c:if>
                            |
                            <a href="${pageContext.request.contextPath}/ventas?accion=eliminar&id=${v.idVenta}"
                               onclick="return confirm('¿Eliminar esta venta?')">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty ventas}">
                    <tr><td colspan="6">No hay ventas registradas.</td></tr>
                </c:if>
            </tbody>
        </table>

        <br><a href="${pageContext.request.contextPath}/views/dashboard.jsp">← Volver</a>
    </body>
</html>