<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head><meta charset="UTF-8"><title>Gestión de usuarios</title></head>
    <body>

        <h2>Usuarios del sistema</h2>

        <c:if test="${param.msg eq 'desactivado'}">
            <p style="color:orange">Usuario desactivado. Ya no puede ingresar.</p>
        </c:if>
        <c:if test="${param.msg eq 'activado'}">
            <p style="color:green">Usuario activado correctamente.</p>
        </c:if>
        <c:if test="${param.msg eq 'eliminado'}">
            <p style="color:green">Usuario eliminado del sistema.</p>
        </c:if>
        <c:if test="${not empty error}">
            <p style="color:red">${error}</p>
        </c:if>

        <table border="1" cellpadding="6">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Username</th>
                    <th>Nombre</th>
                    <th>Rol</th>
                    <th>Estado</th>
                    <th>Fecha registro</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${usuarios}">
                    <tr>
                        <td>${u.idUsuario}</td>
                        <td>${u.userName}</td>
                        <td>${u.nombreCompleto}</td>
                        <td>${u.rol}</td>
                        <td>
                            <c:choose>
                                <c:when test="${u.estado eq 'ACTIVO'}">
                                    <span style="color:green">ACTIVO</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:red">INACTIVO</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${u.fechaRegistro}</td>
                        <td>
                            <c:choose>
                                <c:when test="${u.estado eq 'ACTIVO'}">
                                    <a href="${pageContext.request.contextPath}/admin/usuarios?accion=desactivar&id=${u.idUsuario}"
                                       onclick="return confirm('¿Denegar acceso a ${u.userName}?')">
                                        Desactivar
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/usuarios?accion=activar&id=${u.idUsuario}">
                                        Activar
                                    </a>
                                </c:otherwise>
                            </c:choose>
                            |
                            <a href="${pageContext.request.contextPath}/admin/usuarios?accion=eliminar&id=${u.idUsuario}"
                               onclick="return confirm('¿ELIMINAR permanentemente a ${u.userName}?')">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty usuarios}">
                    <tr><td colspan="7">No hay usuarios registrados.</td></tr>
                </c:if>
            </tbody>
        </table>

        <br>
        <a href="${pageContext.request.contextPath}/dashboard">← Volver al dashboard</a>
    </body>
</html>