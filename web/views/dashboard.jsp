<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Dashboard</title>
    </head>
    <body>

        <h2>Bienvenido, ${sessionScope.usuario.nombreCompleto}</h2>
        <p>Rol: <b>${sessionScope.usuario.rol}</b></p>

        <c:if test="${ventasPendientes > 0}">
            <p style="color:orange">
                 Tienes <b>${ventasPendientes}</b> venta(s) pendiente(s) de cobro.
            </p>
        </c:if>

        <hr>
        <nav>
            <a href="${pageContext.request.contextPath}/productos"> Productos</a>
            <span>|</span>
            <a href="${pageContext.request.contextPath}/clientes"> Clientes</a>
            <span>|</span>
            <a href="${pageContext.request.contextPath}/ventas"> Ventas</a>
            <span>|</span>
            <a href="${pageContext.request.contextPath}/logout"> Cerrar sesión</a>
        </nav>

    </body>
</html>