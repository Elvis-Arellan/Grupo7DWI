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
                                <label class="form-label" style="visibility:hidden;">-</label>
                                <div>
                                    <button type="submit" name="accion" value="pdfVentas" class="btn-custom">
                                        <i class="bi bi-file-pdf me-1"></i> Descargar PDF
                                    </button>
                                </div>
                            </div>
                            <div>
                                <label class="form-label" style="visibility:hidden;">-</label>
                                <div>
                                    <button type="submit" name="accion" value="csvVentas" class="btn-outline-custom">
                                        <i class="bi bi-file-spreadsheet me-1"></i> Descargar CSV
                                    </button>
                                </div>
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