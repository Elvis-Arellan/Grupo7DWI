<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ventas</title>
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
                background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%);
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
            .btn-custom {
                background: var(--accent-color);
                border: none;
                color: white;
            }
            .btn-custom:hover {
                background: #8c84f7;
                color: white;
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
            .badge-pendiente {
                background: rgba(255,193,7,0.25);
                color: #ffd86b;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
            }
            .badge-pagado {
                background: rgba(40,167,69,0.25);
                color: #8dffb1;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
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
                    <i class="bi bi-speedometer2"></i> Inicio
                </a>
                <a href="${pageContext.request.contextPath}/productos" class="nav-link">
                    <i class="bi bi-box-seam"></i> Productos
                </a>
                <a href="${pageContext.request.contextPath}/clientes" class="nav-link">
                    <i class="bi bi-people"></i> Clientes
                </a>
                <a href="${pageContext.request.contextPath}/ventas" class="nav-link active">
                    <i class="bi bi-cart-check"></i> Ventas / Fiados
                </a>
                <c:if test="${sessionScope.usuario.rol eq 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/usuarios" class="nav-link">
                        <i class="bi bi-person-badge"></i> Usuarios
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/logout" class="nav-link">
                    <i class="bi bi-box-arrow-right"></i> Cerrar sesión
                </a>
            </div>
        </nav>
        <div class="main-content">
            <div class="container-fluid">
                <div class="glass-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="fw-bold mb-0">Ventas / Fiados</h2>
                            <p class="text-muted-custom">Gestión de ventas registradas</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/ventas?accion=nueva" class="btn btn-custom">
                            <i class="bi bi-plus-circle me-1"></i> Nueva venta
                        </a>
                    </div>
                    <c:if test="${param.msg eq 'registrado'}">
                        <div class="alert-custom-success mb-4">
                            <i class="bi bi-check-circle-fill me-2"></i> Venta registrada.
                        </div>
                    </c:if>
                    <c:if test="${param.msg eq 'pagado'}">
                        <div class="alert-custom-success mb-4">
                            <i class="bi bi-check-circle-fill me-2"></i> Venta marcada como pagada.
                        </div>
                    </c:if>
                    <c:if test="${param.msg eq 'eliminado'}">
                        <div class="alert-custom-danger mb-4">
                            <i class="bi bi-trash-fill me-2"></i> Venta eliminada.
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert-custom-danger mb-4">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                        </div>
                    </c:if>
                    <div class="table-glass">
                        <table class="table align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Cliente</th>
                                    <th>Fecha</th>
                                    <th>Total</th>
                                    <th>Estado</th>
                                    <th class="text-center">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="v" items="${ventas}">
                                    <tr>
                                        <td>${v.idVenta}</td>
                                        <td><strong>${v.nombreCliente}</strong></td>
                                        <td>${v.fecha}</td>
                                        <td>S/ <fmt:formatNumber value="${v.total}" pattern="#,##0.00"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${v.estado eq 'PENDIENTE'}">
                                                    <span class="badge-pendiente">PENDIENTE</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge-pagado">PAGADO</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex gap-2 justify-content-center">
                                                <a href="${pageContext.request.contextPath}/ventas?accion=ver&id=${v.idVenta}" class="btn btn-sm btn-outline-light">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <c:if test="${v.estado eq 'PENDIENTE'}">
                                                    <a href="${pageContext.request.contextPath}/ventas?accion=pagar&id=${v.idVenta}" class="btn btn-sm btn-outline-success" onclick="return confirm('¿Marcar como pagado?')">
                                                        <i class="bi bi-cash"></i>
                                                    </a>
                                                </c:if>
                                                <a href="${pageContext.request.contextPath}/ventas?accion=eliminar&id=${v.idVenta}" class="btn btn-sm btn-outline-danger" onclick="return confirm('¿Eliminar esta venta?')">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty ventas}">
                                    <tr>
                                        <td colspan="6" class="text-center text-white-50 py-4">
                                            No hay ventas registradas.
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