<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Clientes</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    </head>
    <body>
        <c:set var="activeNav" value="clientes" scope="request"/>
        <jsp:include page="/views/_sidebar.jsp"/>
        <div class="main-content">
            <div class="container-fluid">
                <div class="glass-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="fw-bold mb-0">Clientes</h2>
                            <p class="text-muted-custom">Gestión de clientes registrados</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/clientes?accion=nuevo" class="btn btn-custom">
                            <i class="bi bi-plus-circle me-1"></i>
                            Nuevo cliente
                        </a>
                    </div>
                    <c:if test="${param.msg eq 'registrado'}">
                        <div class="alert-custom-success mb-4">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            Cliente registrado correctamente.
                        </div>
                    </c:if>
                    <c:if test="${param.msg eq 'actualizado'}">
                        <div class="alert-custom-success mb-4">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            Cliente actualizado correctamente.
                        </div>
                    </c:if>
                    <c:if test="${param.msg eq 'eliminado'}">
                        <div class="alert-custom-danger mb-4">
                            <i class="bi bi-trash-fill me-2"></i>
                            Cliente eliminado correctamente.
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert-custom-danger mb-4">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            ${error}
                        </div>
                    </c:if>
                    <div class="table-glass">
                        <table class="table align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Nombre</th>
                                    <th>Apellido</th>
                                    <th>Teléfono</th>
                                    <th>Fecha registro</th>
                                    <th class="text-center">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${clientes}">
                                    <tr>
                                        <td>${c.idCliente}</td>
                                        <td><strong>${c.nombre}</strong></td>
                                        <td>${c.apellido}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty c.telefono}">
                                                    ${c.telefono}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted-custom">-</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${c.fechaRegistro}</td>
                                        <td class="text-center">
                                            <div class="d-flex gap-2 justify-content-center">
                                                <a href="${pageContext.request.contextPath}/clientes?accion=editar&id=${c.idCliente}" class="btn btn-sm btn-outline-warning">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/clientes?accion=eliminar&id=${c.idCliente}" class="btn btn-sm btn-outline-danger" onclick="return confirm('¿Eliminar a ${c.nombre} ${c.apellido}?')">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty clientes}">
                                    <tr>
                                        <td colspan="6" class="text-center text-white-50 py-4">
                                            No hay clientes registrados.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>