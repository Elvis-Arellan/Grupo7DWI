<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reportes</title>
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
            .report-box {
                background: rgba(0, 0, 0, 0.3);
                border: 1px solid var(--glass-border);
                border-radius: 16px;
                padding: 20px;
                margin-bottom: 25px;
            }
            .report-box h3 {
                font-size: 1.3rem;
                margin-bottom: 15px;
                color: var(--accent-color);
            }
            .form-control {
                background: rgba(0,0,0,0.5);
                border: 1px solid var(--glass-border);
                color: white;
                border-radius: 12px;
                display: inline-block;
                width: auto;
            }
            .form-control:focus {
                background: rgba(0,0,0,0.7);
                color: white;
                border-color: var(--accent-color);
                box-shadow: none;
            }
            .form-label {
                color: rgba(255,255,255,0.8);
                margin-right: 10px;
            }
            .btn-custom {
                background: var(--accent-color);
                border: none;
                color: white;
                padding: 8px 20px;
                border-radius: 12px;
                transition: 0.3s;
            }
            .btn-custom:hover {
                background: #8c84f7;
                color: white;
            }
            .btn-outline-custom {
                background: transparent;
                border: 1px solid var(--accent-color);
                color: var(--accent-color);
                padding: 8px 20px;
                border-radius: 12px;
                transition: 0.3s;
                text-decoration: none;
                display: inline-block;
            }
            .btn-outline-custom:hover {
                background: var(--accent-color);
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
            .text-muted-custom {
                color: rgba(255,255,255,0.6);
            }
            .alert-custom-danger {
                background: rgba(220,53,69,0.15);
                border: 1px solid rgba(220,53,69,0.4);
                color: #ff9ca7;
                border-radius: 12px;
                padding: 12px 20px;
            }
            hr {
                border-color: var(--glass-border);
                margin: 20px 0;
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
                <a href="${pageContext.request.contextPath}/ventas" class="nav-link">
                    <i class="bi bi-cart-check"></i> Ventas / Fiados
                </a>
                <c:if test="${sessionScope.usuario.rol eq 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/usuarios" class="nav-link">
                        <i class="bi bi-person-badge"></i> Usuarios
                    </a>
                    <a href="${pageContext.request.contextPath}/reportes" class="nav-link active">
                        <i class="bi bi-file-text"></i> Reportes
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
                            <h2 class="fw-bold mb-0">Reportes</h2>
                            <p class="text-muted-custom">Genera reportes del sistema en PDF o CSV</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/views/dashboard.jsp" class="btn btn-outline-light">
                            <i class="bi bi-arrow-left"></i> Volver
                        </a>
                    </div>
                    <c:if test="${not empty error}">
                        <div class="alert-custom-danger mb-4">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                        </div>
                    </c:if>
                    <div class="report-box">
                        <h3><i class="bi bi-graph-up me-2"></i> Reporte de Ventas</h3>
                        <form method="get" action="${pageContext.request.contextPath}/reportes" class="d-flex flex-wrap align-items-center gap-3">
                            <div>
                                <label class="form-label">Desde:</label>
                                <input type="date" name="desde" class="form-control">
                            </div>
                            <div>
                                <label class="form-label">Hasta:</label>
                                <input type="date" name="hasta" class="form-control">
                            </div>
                            <div>
                                <button type="submit" name="accion" value="pdfVentas" class="btn-custom">
                                    <i class="bi bi-file-pdf me-1"></i> Descargar PDF
                                </button>
                            </div>
                            <div>
                                <button type="submit" name="accion" value="csvVentas" class="btn-outline-custom">
                                    <i class="bi bi-file-spreadsheet me-1"></i> Descargar CSV
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="report-box">
                        <h3><i class="bi bi-people me-2"></i> Reporte de deudas pendientes</h3>
                        <div class="d-flex gap-3">
                            <a href="${pageContext.request.contextPath}/reportes?accion=pdfDeudas" class="btn-custom">
                                <i class="bi bi-file-pdf me-1"></i> Descargar PDF
                            </a>
                            <a href="${pageContext.request.contextPath}/reportes?accion=csvDeudas" class="btn-outline-custom">
                                <i class="bi bi-file-spreadsheet me-1"></i> Descargar CSV
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>