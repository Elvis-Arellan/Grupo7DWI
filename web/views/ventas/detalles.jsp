<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Detalle venta</title>
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
            .info-box {
                background: rgba(0,0,0,0.4);
                border: 1px solid var(--glass-border);
                border-radius: 15px;
                padding: 20px;
                height: 100%;
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
            .btn-success {
                background: #28a745;
                border: none;
            }
            .btn-success:hover {
                background: #218838;
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
                <a href="${pageContext.request.contextPath}/reportes" class="nav-link"> 
                    <i class="bi bi-box-arrow-right"></i>
                    Reportes
                </a>
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
                            <h2 class="fw-bold mb-0">Detalle de venta #${venta.idVenta}</h2>
                            <p class="text-muted-custom">Información completa de la venta registrada</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/ventas" class="btn btn-outline-light">
                            <i class="bi bi-arrow-left"></i> Volver
                        </a>
                    </div>
                    <div class="row g-4 mb-4">
                        <div class="col-md-4">
                            <div class="info-box">
                                <p class="text-muted-custom mb-1">Cliente</p>
                                <h5 class="fw-bold mb-0">${venta.nombreCliente}</h5>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="info-box">
                                <p class="text-muted-custom mb-1">Fecha</p>
                                <h5 class="fw-bold mb-0">${venta.fecha}</h5>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="info-box">
                                <p class="text-muted-custom mb-1">Estado</p>
                                <h5 class="fw-bold mb-0">
                                    <c:choose>
                                        <c:when test="${venta.estado eq 'PENDIENTE'}">
                                            <span class="badge-pendiente">PENDIENTE</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-pagado">PAGADO</span>
                                        </c:otherwise>
                                    </c:choose>
                                </h5>
                            </div>
                        </div>
                    </div>
                    <c:if test="${not empty venta.observacion}">
                        <div class="glass-card mb-4">
                            <p class="text-muted-custom mb-2">Observación</p>
                            <p class="mb-0">${venta.observacion}</p>
                        </div>
                    </c:if>
                    <div class="table-glass">
                        <table class="table align-middle">
                            <thead>
                                <tr>
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio unit.</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="d" items="${venta.detalle}">
                                    <tr>
                                        <td><strong>${d.nombreProducto}</strong></td>
                                        <td>${d.cantidad}</td>
                                        <td>S/ <fmt:formatNumber value="${d.precioUnitario}" pattern="#,##0.00"/></td>
                                        <td>S/ <fmt:formatNumber value="${d.subtotal}" pattern="#,##0.00"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="3"><b>Total</b></td>
                                    <td><b>S/ <fmt:formatNumber value="${venta.total}" pattern="#,##0.00"/></b></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <div class="d-flex gap-3 mt-4">
                        <c:if test="${venta.estado eq 'PENDIENTE'}">
                            <a href="${pageContext.request.contextPath}/ventas?accion=pagar&id=${venta.idVenta}" class="btn btn-success" onclick="return confirm('¿Marcar como pagado?')">
                                <i class="bi bi-cash-coin me-1"></i> Marcar como pagado
                            </a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/ventas" class="btn btn-outline-light">
                            <i class="bi bi-arrow-left me-1"></i> Volver a ventas
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>