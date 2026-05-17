<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap"
              rel="stylesheet">
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

            .nav-link:hover {
                background: rgba(162,155,254,0.2);
                color: var(--accent-color);
                transform: translateX(5px);
            }

            .main-content {
                margin-left: 260px;
                padding: 35px;
            }

            .glass-card {
                background: rgba(255,255,255,0.05);
                backdrop-filter: blur(15px);
                border: 1px solid var(--glass-border);
                border-radius: 20px;
                padding: 25px;
            }

            .stat-card {
                border-left: 4px solid var(--accent-color);
            }

            .user-badge {
                background: rgba(162,155,254,0.15);
                border: 1px solid rgba(162,155,254,0.4);
                border-radius: 30px;
                padding: 6px 14px;
                font-size: 0.9rem;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <nav class="sidebar">
                <div class="text-center mb-4">
                    <i class="bi bi-shop text-primary" style="font-size: 2rem;"></i>
                    <h5 class="text-white mt-2">Minimarket SaaS</h5>
                </div>
                <hr class="text-secondary">
                <div class="nav flex-column">
                    <a href="${pageContext.request.contextPath}/productos" class="nav-link">
                        <i class="bi bi-box-seam"></i>
                        Productos
                    </a>
                    <c:choose>
                        <c:when test="${sessionScope.usuario.rol eq 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/admin/usuarios" class="nav-link">
                                <i class="bi bi-people"></i>
                                Usuarios
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/clientes" class="nav-link">
                                <i class="bi bi-person-lines-fill"></i>
                                Clientes
                            </a>
                        </c:otherwise>
                    </c:choose>
                    <a href="${pageContext.request.contextPath}/ventas" class="nav-link">
                        <i class="bi bi-cart-check"></i>
                        Ventas
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
                <div class="d-flex justify-content-between align-items-center mb-5">
                    <div>
                        <h2 class="fw-bold">Bienvenido, ${sessionScope.usuario.nombreCompleto}</h2>
                        <p class="text-white-50 mb-0">Panel principal del sistema</p>
                    </div>
                    <div class="user-badge">
                        Rol: <b>${sessionScope.usuario.rol}</b>
                    </div>
                </div>
                <c:if test="${ventasPendientes > 0}">
                    <div class="alert border-0 mb-4" style="background: rgba(255, 193, 7, 0.15); color: #ffd86b; border-radius: 15px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        Tienes <b>${ventasPendientes}</b> venta(s) pendiente(s) de cobro.
                    </div>
                </c:if>
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="glass-card stat-card">
                            <p class="text-white-50 mb-1">Gestión</p>
                            <h4 class="fw-bold">Clientes</h4>
                            <p class="mb-0">Administra información de clientes.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="glass-card stat-card">
                            <p class="text-white-50 mb-1">Inventario</p>
                            <h4 class="fw-bold">Productos</h4>
                            <p class="mb-0">Control de stock y productos.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="glass-card stat-card">
                            <p class="text-white-50 mb-1">Operaciones</p>
                            <h4 class="fw-bold">Ventas</h4>
                            <p class="mb-0">Registro y control de ventas.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>