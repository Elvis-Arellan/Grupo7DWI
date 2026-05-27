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