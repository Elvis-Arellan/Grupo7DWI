<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${empty cliente ? 'Nuevo cliente' : 'Editar cliente'}</title>
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
                <a href="${pageContext.request.contextPath}/clientes" class="nav-link active">
                    <i class="bi bi-people"></i>
                    Clientes
                </a>
                <a href="${pageContext.request.contextPath}/ventas" class="nav-link">
                    <i class="bi bi-cart-check"></i>
                    Ventas / Fiados
                </a>
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
            <div class="glass-card">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="fw-bold mb-1">${empty cliente ? 'Nuevo cliente' : 'Editar cliente'}</h2>
                        <p class="text-white-50 mb-0">
                            ${empty cliente 
                              ? 'Registra un nuevo cliente en el sistema'
                              : 'Actualiza la información del cliente'}
                        </p>
                    </div>
                    <a href="${pageContext.request.contextPath}/clientes" class="btn btn-outline-light">
                        <i class="bi bi-arrow-left"></i>
                        Volver
                    </a>
                </div>
                <c:if test="${not empty error}">
                    <div class="alert-custom mb-4">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        ${error}
                    </div>
                </c:if>
                <form method="post" action="${pageContext.request.contextPath}/clientes">
                    <c:if test="${not empty cliente}">
                        <input type="hidden" name="idCliente" value="${cliente.idCliente}">
                    </c:if>
                    <div class="mb-4">
                        <label class="form-label">Nombre</label>
                        <input type="text" name="nombre" value="${cliente.nombre}" class="form-control" placeholder="Ingrese el nombre" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Apellido</label>
                        <input type="text" name="apellido" value="${cliente.apellido}" class="form-control" placeholder="Ingrese el apellido" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Teléfono</label>
                        <input type="text" name="telefono" value="${cliente.telefono}" class="form-control" placeholder="Ingrese teléfono" maxlength="15">
                    </div>
                    <div class="d-flex gap-3 mt-4">
                        <button type="submit" class="btn btn-custom">
                            <i class="bi bi-check-circle me-1"></i>
                            ${empty cliente ? 'Registrar' : 'Actualizar'}
                        </button>
                        <a href="${pageContext.request.contextPath}/clientes" class="btn btn-outline-light">
                            Cancelar
                        </a>
                    </div>
                </form>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>