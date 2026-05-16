<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty cliente ? 'Nuevo cliente' : 'Editar cliente'}</title>
</head>
<body>

<h2>${empty cliente ? 'Nuevo cliente' : 'Editar cliente'}</h2>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/clientes">

    <c:if test="${not empty cliente}">
        <input type="hidden" name="idCliente" value="${cliente.idCliente}">
    </c:if>

    <label>Nombre:<br>
        <input type="text" name="nombre" value="${cliente.nombre}" required>
    </label><br><br>

    <label>Apellido:<br>
        <input type="text" name="apellido" value="${cliente.apellido}" required>
    </label><br><br>

    <label>Teléfono:<br>
        <input type="text" name="telefono" value="${cliente.telefono}"
               maxlength="15">
    </label><br><br>

    <button type="submit">
        ${empty cliente ? 'Registrar' : 'Actualizar'}
    </button>
    <a href="${pageContext.request.contextPath}/clientes">Cancelar</a>

</form>

</body>
</html>