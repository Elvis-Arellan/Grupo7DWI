<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Clientes</title>
    </head>
    <body>

        <h2>Clientes</h2>
        <a href="${pageContext.request.contextPath}/clientes?accion=nuevo">+ Nuevo cliente</a>

        <c:if test="${param.msg eq 'registrado'}">
            <p style="color:green">Cliente registrado correctamente.</p>
        </c:if>
        <c:if test="${param.msg eq 'actualizado'}">
            <p style="color:green">Cliente actualizado correctamente.</p>
        </c:if>
        <c:if test="${param.msg eq 'eliminado'}">
            <p style="color:green">Cliente eliminado correctamente.</p>
        </c:if>
        <c:if test="${not empty error}">
            <p style="color:red">${error}</p>
        </c:if>

        <table border="1" cellpadding="6">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Teléfono</th>
                    <th>Fecha registro</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${clientes}">
                    <tr>
                        <td>${c.idCliente}</td>
                        <td>${c.nombre}</td>
                        <td>${c.apellido}</td>
                        <td>${not empty c.telefono ? c.telefono : '-'}</td>
                        <td>${c.fechaRegistro}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/clientes?accion=editar&id=${c.idCliente}">
                                Editar
                            </a>
                            |
                            <a href="${pageContext.request.contextPath}/clientes?accion=eliminar&id=${c.idCliente}"
                               onclick="return confirm('¿Eliminar a ${c.nombre} ${c.apellido}?')">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty clientes}">
                    <tr>
                        <td colspan="6">No hay clientes registrados.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <br>
        <a href="${pageContext.request.contextPath}/views/dashboard.jsp">← Volver al dashboard</a>

    </body>
</html>