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
        <style>
            :root {
                --primary-bg: #0f0c29;
                --sidebar-bg: rgba(255,255,255,0.05);
                --accent-color: #a29bfe;
                --glass-border: rgba(255,255,255,0.1);
            }
            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(
                    135deg,
                    #0f0c29 0%,
                    #302b63 50%,
                    #24243e 100%
                    );
                background-attachment: fixed;
                color: white;
                overflow-x: hidden;
            }
            .sidebar {
                width: 260px;
                height: 100vh;
                position: fixed;
                top: 0;
                left: 0;
                background: var(--sidebar-bg);
                backdrop-filter: blur(10px);
                border-right: 1px solid var(--glass-border);
                padding: 20px;
                overflow-y: auto;
                z-index: 1000;
            }
            .nav-link {
                color: rgba(255,255,255,0.7);
                padding: 12px 15px;
                border-radius: 10px;
                margin-bottom: 10px;
                display: flex;
                align-items: center;
                transition: 0.3s;
                text-decoration: none;
            }
            .nav-link i {
                margin-right: 15px;
                font-size: 1.1rem;
            }
            .nav-link:hover,
            .nav-link.active {
                background: rgba(162,155,254,0.2);
                color: var(--accent-color);
                transform: translateX(5px);
            }
            .main-content {
                margin-left: 260px;
                width: calc(100% - 260px);
                min-height: 100vh;
                padding: 35px;
                box-sizing: border-box;
            }
            .glass-card {
                background: rgba(255,255,255,0.05);
                backdrop-filter: blur(15px);
                border: 1px solid var(--glass-border);
                border-radius: 20px;
                padding: 30px;
            }
            .table-glass {
                background: #0a0a1a;
                border-radius: 20px;
                overflow-x: auto;
                border: 1px solid var(--glass-border);
            }
            .table {
                color: white;
                margin-bottom: 0;
                width: 100%;
                border-collapse: collapse;
                background: #0a0a1a;
            }
            .table thead th {
                background: #1a1a2e;
                color: white;
                padding: 15px;
                font-weight: 600;
                border-bottom: 1px solid var(--glass-border);
            }
            .table tbody tr {
                background: #0a0a1a;
            }
            .table tbody td {
                padding: 12px 15px;
                vertical-align: middle;
                border-bottom: 1px solid rgba(255,255,255,0.08);
                color: white;
                background: #0a0a1a;
            }
            .table tbody tr:hover td {
                background: #1a1a2e;
            }
            .btn-outline-warning {
                color: #ffc107;
                border-color: #ffc107;
            }
            .btn-outline-warning:hover {
                background: #ffc107;
                color: black;
            }
            .btn-outline-success {
                color: #28a745;
                border-color: #28a745;
            }
            .btn-outline-success:hover {
                background: #28a745;
                color: white;
            }
            .btn-outline-danger {
                color: #dc3545;
                border-color: #dc3545;
            }
            .btn-outline-danger:hover {
                background: #dc3545;
                color: white;
            }
            .btn-outline-light {
                color: white;
                border-color: rgba(255,255,255,0.3);
            }
            .btn-outline-light:hover {
                background: white;
                color: #0f0c29;
            }
            .badge-active {
                background: rgba(40,167,69,0.25);
                color: #8dffb1;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
            }
            .badge-inactive {
                background: rgba(220,53,69,0.25);
                color: #ff9ca7;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
            }
            .badge.bg-primary {
                background: var(--accent-color) !important;
            }
            .badge.bg-secondary {
                background: rgba(255,255,255,0.2) !important;
            }
            .text-muted-custom {
                color: rgba(255,255,255,0.6);
            }
            .alert-custom-success {
                background: rgba(40,167,69,0.15);
                border: 1px solid rgba(40,167,69,0.4);
                color: #8dffb1;
                border-radius: 12px;
                padding: 12px 20px;
            }
            .alert-custom-warning {
                background: rgba(255,193,7,0.15);
                border: 1px solid rgba(255,193,7,0.4);
                color: #ffd86b;
                border-radius: 12px;
                padding: 12px 20px;
            }
            .alert-custom-danger {
                background: rgba(220,53,69,0.15);
                border: 1px solid rgba(220,53,69,0.4);
                color: #ff9ca7;
                border-radius: 12px;
                padding: 12px 20px;
            }
        </style>
    </head>
    <body>
        <nav class="sidebar">
            <div class="text-center mb-4">
                <i class="bi bi-shop text-primary" style="font-size:2rem;"></i>
                <h5 class="text-white mt-2">Minimarket SaaS</h5>
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