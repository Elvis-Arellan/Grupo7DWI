<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Iniciar sesión</title>
</head>
<body>
    <h2>Iniciar sesión</h2>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
    <c:if test="${param.msg eq 'registro_ok'}">
        <p style="color:green;">Registro exitoso. Inicia sesión.</p>
    </c:if>
    <c:if test="${param.salir eq 'ok'}">
        <p style="color:green;">Sesión cerrada. Inicia sesión.</p>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/login">
        <label>Usuario:<br>
            <input type="text" name="username" required autofocus>
        </label><br><br>
        <label>Contraseña:<br>
            <input type="password" name="clave" required>
        </label><br><br>
        <button type="submit">Entrar</button>
    </form>

    <p><a href="/Grupo7DWI/views/registro.jsp">Crear cuenta</a></p>
</body>
</html>