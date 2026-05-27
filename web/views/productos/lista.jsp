<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Productos</title>
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
                <a href="${pageContext.request.contextPath}/productos" class="nav-link active">
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
                <c:if test="${sessionScope.usuario.rol eq 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/usuarios" class="nav-link">
                        <i class="bi bi-person-badge"></i>
                        Usuarios
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/reportes" class="nav-link"> 
                    <i class="bi bi-box-arrow-right"></i>
                    Reportes
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
                            <h2 class="fw-bold mb-0">Inventario de Productos</h2>
                            <p class="text-muted-custom">Gestión de productos del minimarket</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/productos?accion=nuevo" class="btn btn-custom">
                            <i class="bi bi-plus-circle me-1"></i>
                            Nuevo producto
                        </a>
                    </div>
                    <c:if test="${param.msg eq 'registrado'}">
                        <div class="alert-custom-success mb-4">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            Producto registrado.
                        </div>
                    </c:if>
                    <c:if test="${param.msg eq 'actualizado'}">
                        <div class="alert-custom-success mb-4">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            Producto actualizado.
                        </div>
                    </c:if>
                    <c:if test="${param.msg eq 'eliminado'}">
                        <div class="alert-custom-danger mb-4">
                            <i class="bi bi-trash-fill me-2"></i>
                            Producto eliminado.
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
                                    <th>Categoría</th>
                                    <th>Precio</th>
                                    <th>Stock</th>
                                    <th>Mín.</th>
                                    <th>Estado stock</th>
                                    <th class="text-center">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${productos}">
                                    <tr>
                                        <td>${p.idProducto}</td>
                                        <td><strong>${p.nombre}</strong></td>
                                        <td>${p.categoria}</td>
                                        <td>S/ <fmt:formatNumber value="${p.precio}" pattern="#,##0.00"/></td>
                                        <td>${p.stockActual}</td>
                                        <td>${p.stockMinimo}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.stockActual <= p.stockMinimo}">
                                                    <span class="badge-danger">
                                                        <i class="bi bi-exclamation-triangle-fill me-1"></i>
                                                        Bajo stock
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge-success">
                                                        <i class="bi bi-check-circle-fill me-1"></i>
                                                        OK
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex gap-2 justify-content-center">
                                                <a href="${pageContext.request.contextPath}/productos?accion=editar&id=${p.idProducto}" class="btn btn-sm btn-outline-warning">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/productos?accion=eliminar&id=${p.idProducto}" class="btn btn-sm btn-outline-danger" onclick="return confirm('¿Eliminar ${p.nombre}?')">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty productos}">
                                    <tr>
                                        <td colspan="8" class="text-center text-white-50 py-4">
                                            No hay productos registrados.
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