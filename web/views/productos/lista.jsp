<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Productos</title>
</head>
<body>

<h2>Inventario de Productos</h2>
<a href="${pageContext.request.contextPath}/productos?accion=nuevo">+ Nuevo producto</a>

<c:if test="${param.msg eq 'registrado'}"><p style="color:green">Producto registrado.</p></c:if>
<c:if test="${param.msg eq 'actualizado'}"><p style="color:green">Producto actualizado.</p></c:if>
<c:if test="${param.msg eq 'eliminado'}"><p style="color:green">Producto eliminado.</p></c:if>
<c:if test="${not empty error}"><p style="color:red">${error}</p></c:if>

<table border="1" cellpadding="6">
    <thead>
        <tr>
            <th>#</th>
            <th>Nombre</th>
            <th>Categoría</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>Mín.</th>
            <th>Estado stock</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="p" items="${productos}">
            <tr>
                <td>${p.idProducto}</td>
                <td>${p.nombre}</td>
                <td>${p.categoria}</td>
                <td>S/ <fmt:formatNumber value="${p.precio}" pattern="#,##0.00"/></td>
                <td>${p.stockActual}</td>
                <td>${p.stockMinimo}</td>
                <td>
                    <c:choose>
                        <c:when test="${p.stockActual <= p.stockMinimo}">
                            <span style="color:red">⚠ Bajo stock</span>
                        </c:when>
                        <c:otherwise>
                            <span style="color:green">OK</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/productos?accion=editar&id=${p.idProducto}">Editar</a>
                    |
                    <a href="${pageContext.request.contextPath}/productos?accion=eliminar&id=${p.idProducto}"
                       onclick="return confirm('¿Eliminar ${p.nombre}?')">Eliminar</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty productos}">
            <tr><td colspan="8">No hay productos registrados.</td></tr>
        </c:if>
    </tbody>
</table>

<br><a href="${pageContext.request.contextPath}/views/dashboard.jsp">← Volver al dashboard</a>
</body>
</html>