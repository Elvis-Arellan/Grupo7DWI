<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>

<nav class="sidebar">
    <div class="text-center mb-4">
        <i class="bi bi-shop text-primary" style="font-size:2rem;"></i>
        <h5 class="text-white mt-2">Minimarket Mario</h5>
    </div>
    <hr class="text-secondary">
    <div class="nav flex-column">
        <a href="${pageContext.request.contextPath}/dashboard"
           class="nav-link ${activeNav eq 'inicio' ? 'active' : ''}">
            <i class="bi bi-speedometer2"></i>
            Inicio
        </a>
        <a href="${pageContext.request.contextPath}/productos"
           class="nav-link ${activeNav eq 'productos' ? 'active' : ''}">
            <i class="bi bi-box-seam"></i>
            Productos
        </a>

        <c:choose>
            <c:when test="${sessionScope.usuario.rol eq 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin/usuarios"
                   class="nav-link ${activeNav eq 'usuarios' ? 'active' : ''}">
                    <i class="bi bi-person-badge"></i>
                    Usuarios
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/clientes"
                   class="nav-link ${activeNav eq 'clientes' ? 'active' : ''}">
                    <i class="bi bi-people"></i>
                    Clientes
                </a>
                <a href="${pageContext.request.contextPath}/ventas"
                   class="nav-link ${activeNav eq 'ventas' ? 'active' : ''}">
                    <i class="bi bi-cart-check"></i>
                    Ventas / Fiados
                </a>
                <a href="${pageContext.request.contextPath}/reportes"
                   class="nav-link ${activeNav eq 'reportes' ? 'active' : ''}">
                    <i class="bi bi-file-earmark-bar-graph"></i>
                    Reportes
                </a>
            </c:otherwise>
        </c:choose>

        <a href="${pageContext.request.contextPath}/logout" class="nav-link">
            <i class="bi bi-box-arrow-right"></i>
            Cerrar sesión
        </a>
    </div>
</nav>
