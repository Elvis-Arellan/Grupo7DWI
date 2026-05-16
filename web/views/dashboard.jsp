<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Dashboard</title>
    </head>
    <body>
        <h1>Dashboard</h1>
        <p>Bienvenido, <strong>${sessionScope.usuario.nombreCompleto}</strong></p>
        <p>Rol: ${sessionScope.usuario.rol}</p>

        <a href="${pageContext.request.contextPath}/views/login.jsp?salir=ok">Cerrar sesión</a>
        <span>|</span>
        <a href="${pageContext.request.contextPath}/productos">ver productos</a>
        <span>|</span>
        <a href="${pageContext.request.contextPath}/clientes">ver clientes</a>
        <span>|</span>
        <a href="${pageContext.request.contextPath}/ventas">Vender</a>
    </body>
</html>