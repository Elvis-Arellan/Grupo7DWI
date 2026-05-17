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
        <style>
            :root {
                --primary-bg: #0f0c29;
                --sidebar-bg: rgba(255,255,255,0.05);
                --accent-color: #a29bfe;
                --glass-border: rgba(255,255,255,0.1);
            }
            *{
                margin:0;
                padding:0;
                box-sizing:border-box;
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
                padding: 40px;
            }
            .glass-card {
                max-width: 800px;
                margin: 0 auto;
                background: rgba(255,255,255,0.05);
                backdrop-filter: blur(15px);
                border: 1px solid var(--glass-border);
                border-radius: 25px;
                padding: 35px;
            }
            .form-control {
                background: rgba(255,255,255,0.05);
                border: 1px solid var(--glass-border);
                color: white;
                border-radius: 12px;
                padding: 12px 15px;
            }
            .form-control:focus {
                background: rgba(255,255,255,0.08);
                color: white;
                border-color: var(--accent-color);
                box-shadow: 0 0 0 0.2rem rgba(162,155,254,0.25);
            }
            .form-control::placeholder {
                color: rgba(255,255,255,0.5);
            }
            .btn-custom {
                background: var(--accent-color);
                border: none;
                color: white;
                padding: 12px 22px;
                border-radius: 12px;
                font-weight: 600;
            }
            .btn-custom:hover {
                background: #8c84f7;
                color: white;
            }
            .alert-custom {
                background: rgba(220,53,69,0.15);
                border: 1px solid rgba(220,53,69,0.4);
                color: #ffb3bd;
                border-radius: 12px;
                padding: 15px;
            }
            .form-label {
                color: rgba(255,255,255,0.8);
                margin-bottom: 8px;
                font-weight: 500;
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