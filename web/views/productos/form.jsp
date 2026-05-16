<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty producto ? 'Nuevo producto' : 'Editar producto'}</title>
</head>
<body>

<h2>${empty producto ? 'Nuevo producto' : 'Editar producto'}</h2>

<c:if test="${not empty error}"><p style="color:red">${error}</p></c:if>

<form method="post" action="${pageContext.request.contextPath}/productos">

    <%-- Campo oculto: si existe producto es edición --%>
    <c:if test="${not empty producto}">
        <input type="hidden" name="idProducto" value="${producto.idProducto}">
    </c:if>

    <label>Nombre:<br>
        <input type="text" name="nombre" value="${producto.nombre}" required>
    </label><br><br>

    <label>Categoría:<br>
        <input type="text" name="categoria" value="${producto.categoria}">
    </label><br><br>

    <label>Precio (S/):<br>
        <input type="number" name="precio" value="${producto.precio}"
               step="0.01" min="0" required>
    </label><br><br>

    <label>Stock actual:<br>
        <input type="number" name="stockActual" value="${producto.stockActual}"
               min="0" required>
    </label><br><br>

    <label>Stock mínimo:<br>
        <input type="number" name="stockMinimo" value="${producto.stockMinimo}"
               min="0" required>
    </label><br><br>

    <button type="submit">${empty producto ? 'Registrar' : 'Actualizar'}</button>
    <a href="${pageContext.request.contextPath}/productos">Cancelar</a>
</form>

</body>
</html>