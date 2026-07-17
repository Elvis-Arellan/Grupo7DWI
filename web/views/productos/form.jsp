<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${empty producto ? 'Nuevo producto' : 'Editar producto'}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    </head>
    <body>
        <c:set var="activeNav" value="productos" scope="request"/>
        <jsp:include page="/views/_sidebar.jsp"/>
        <div class="main-content">
            <div class="glass-card">
                <div class="mb-4">
                    <h2 class="fw-bold">${empty producto ? 'Nuevo producto' : 'Editar producto'}</h2>
                    <p class="text-white-50">Completa la información del producto</p>
                </div>
                <c:if test="${not empty error}">
                    <div class="alert border-0 mb-4" style="background: rgba(220,53,69,0.2); color:#ff9ca7;">
                        ${error}
                    </div>
                </c:if>
                <form method="post" action="${pageContext.request.contextPath}/productos">
                    <c:if test="${not empty producto}">
                        <input type="hidden" name="idProducto" value="${producto.idProducto}">
                    </c:if>
                    <div class="mb-3">
                        <label class="form-label">Nombre</label>
                        <input type="text" name="nombre" value="${producto.nombre}" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Categoría</label>
                        <input type="text" name="categoria" value="${producto.categoria}" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Precio (S/)</label>
                        <input type="number" name="precio" value="${producto.precio}" step="0.01" min="0" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Stock actual</label>
                        <input type="number" name="stockActual" value="${producto.stockActual}" min="0" class="form-control" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Stock mínimo</label>
                        <input type="number" name="stockMinimo" value="${producto.stockMinimo}" min="0" class="form-control" required>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-custom">
                            <i class="bi bi-check-circle me-1"></i>
                            ${empty producto ? 'Registrar' : 'Actualizar'}
                        </button>
                        <a href="${pageContext.request.contextPath}/productos" class="btn btn-outline-light">
                            Cancelar
                        </a>
                    </div>
                </form>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>