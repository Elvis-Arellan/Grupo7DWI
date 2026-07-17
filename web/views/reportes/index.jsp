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
        <c:set var="activeNav" value="reportes" scope="request"/>
        <jsp:include page="/views/_sidebar.jsp"/>
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