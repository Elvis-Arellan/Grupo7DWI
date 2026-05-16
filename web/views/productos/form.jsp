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
                background: var(--sidebar-bg);
                backdrop-filter: blur(10px);
                border-right: 1px solid var(--glass-border);
                padding: 20px;
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
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 40px;
            }
            .glass-card {
                background: rgba(255,255,255,0.05);
                backdrop-filter: blur(15px);
                border: 1px solid var(--glass-border);
                border-radius: 20px;
                padding: 35px;
                max-width: 700px;
                width: 100%;
            }
            .form-control {
                background: rgba(255,255,255,0.08);
                border: 1px solid rgba(255,255,255,0.1);
                color: white;
            }
            .form-control:focus {
                background: rgba(255,255,255,0.12);
                color: white;
                border-color: var(--accent-color);
                box-shadow: none;
            }
            .form-label {
                color: rgba(255,255,255,0.8);
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
                <a href="${pageContext.request.contextPath}/logout" class="nav-link">
                    <i class="bi bi-box-arrow-right"></i>
                    Cerrar sesión
                </a>
            </div>
        </nav>
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