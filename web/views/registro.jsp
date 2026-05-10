<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro</title>
</head>
<body>
    <h2>Crear cuenta</h2>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/registro">
        <label>Nombre completo:<br>
            <input type="text" name="nombreCompleto" required>
        </label><br><br>
        <label>Usuario:<br>
            <input type="text" name="username" required>
        </label><br><br>
        <label>Contraseña:<br>
            <input type="password" name="clave" required minlength="6">
        </label><br><br>
        <label>Confirmar contraseña:<br>
            <input type="password" name="confirmar" required>
        </label><br><br>
        <label>Rol:<br>
            <select name="rol">
                <option value="ADMIN">Admin (grupo7)</option>
                <option value="VENDEDOR">Vendedor</option>
            </select>
        </label><br><br>
        <button type="submit">Registrarse</button>
    </form>

    <p><a href="/Grupo7DWI/views/login.jsp">Ya tengo cuenta</a></p>
</body>
</html>