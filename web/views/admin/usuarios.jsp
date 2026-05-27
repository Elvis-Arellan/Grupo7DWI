<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de usuarios</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    </head>
    <body>
        <nav class="sidebar">
            <div class="text-center mb-4">
                <i class="bi bi-shop text-primary" style="font-size:2rem;"></i>
                <h5 class="text-white mt-2">Minimarket Mario</h5>
            </div>
            <hr class="text-secondary">
            <div class="nav flex-column">
                <a href="${pageContext.request.contextPath}/views/dashboard.jsp" class="nav-link">
                    <i class="bi bi-speedometer2"></i>
                    Inicio
                </a>
                <a href="${pageContext.request.contextPath}/productos" class="nav-link">
                    <i class="bi bi-box-seam"></i>
                    Productos
                </a>
                <a href="${pageContext.request.contextPath}/clientes" class="nav-link">
                    <i class="bi bi-people"></i>
                    Clientes
                </a>
                <a href="${pageContext.request.contextPath}/ventas" class="nav-link">
                    <i class="bi bi-cart-check"></i>
                    Ventas / Fiados
                </a>
                <a href="${pageContext.request.contextPath}/admin/usuarios" class="nav-link active">
                    <i class="bi bi-person-badge"></i>
                    Usuarios
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="nav-link">
                    <i class="bi bi-box-arrow-right"></i>
                    Cerrar sesión
                </a>
            </div>
        </nav>
        <div class="main-content">
            <div class="container-fluid">
                <div class="glass-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="fw-bold mb-0">Gestión de usuarios</h2>
                            <p class="text-muted-custom">Administra los usuarios del sistema</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/views/dashboard.jsp" class="btn btn-outline-light">
                            <i class="bi bi-arrow-left"></i>
                            Volver
                        </a>
                    </div>
                    <c:if test="${param.msg eq 'desactivado'}">
                        <div class="alert-custom-warning mb-4">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            Usuario desactivado. Ya no puede ingresar.
                        </div>
                    </c:if>
                    <c:if test="${param.msg eq 'activado'}">
                        <div class="alert-custom-success mb-4">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            Usuario activado correctamente.
                        </div>
                    </c:if>
                    <c:if test="${param.msg eq 'eliminado'}">
                        <div class="alert-custom-danger mb-4">
                            <i class="bi bi-trash-fill me-2"></i>
                            Usuario eliminado del sistema.
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
                                    <th>Username</th>
                                    <th>Nombre</th>
                                    <th>Rol</th>
                                    <th>Estado</th>
                                    <th>Fecha registro</th>
                                    <th class="text-center">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="u" items="${usuarios}">
                                    <tr>
                                        <td>${u.idUsuario}</td>
                                        <td><strong>${u.userName}</strong></td>
                                        <td>${u.nombreCompleto}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.rol eq 'ADMIN'}">
                                                    <span class="badge bg-primary">ADMIN</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">USUARIO</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.estado eq 'ACTIVO'}">
                                                    <span class="badge-active">ACTIVO</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge-inactive">INACTIVO</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${u.fechaRegistro}</td>
                                        <td class="text-center">
                                            <div class="d-flex gap-2 justify-content-center">
                                                <c:choose>
                                                    <c:when test="${u.estado eq 'ACTIVO'}">
                                                        <a href="${pageContext.request.contextPath}/admin/usuarios?accion=desactivar&id=${u.idUsuario}"
                                                           class="btn btn-sm btn-outline-warning"
                                                           onclick="return confirm('¿Denegar acceso a ${u.userName}?')">
                                                            <i class="bi bi-person-x"></i>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/admin/usuarios?accion=activar&id=${u.idUsuario}"
                                                           class="btn btn-sm btn-outline-success">
                                                            <i class="bi bi-person-check"></i>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <a href="${pageContext.request.contextPath}/admin/usuarios?accion=eliminar&id=${u.idUsuario}"
                                                   class="btn btn-sm btn-outline-danger"
                                                   onclick="return confirm('¿ELIMINAR permanentemente a ${u.userName}?')">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty usuarios}">
                                    <tr>
                                        <td colspan="7" class="text-center text-white-50 py-4">
                                            No hay usuarios registrados.
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