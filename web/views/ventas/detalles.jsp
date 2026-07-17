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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    </head>
    <body>
        <c:set var="activeNav" value="ventas" scope="request"/>
        <jsp:include page="/views/_sidebar.jsp"/>
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