<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>DWI Grupo 7</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    </head>
    <body>
        <div class="container d-flex justify-content-center align-items-center vh-100">
            <div class="glass-card p-5" style="width: 100%; max-width: 400px;">
                <div class="text-center mb-4">
                    <h2 class="fw-bold">Bienvenido</h2>
                    <p class="text-white-50">Ingresa tus credenciales</p>
                </div>

                <c:if test="${param.error eq '1'}">
                    <div class="alert alert-danger border-0 bg-danger bg-opacity-25 text-white py-2 text-center">
                        Datos incorrectos
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <p class="alert alert-danger border-0 bg-danger  text-white py-2 text-center" ">${error}</p>
                </c:if>
                <c:if test="${param.msg eq 'registro_ok'}">
                    <p class="alert alert-success border-0 bg-success  text-white py-2 text-center" ">Registro exitoso. Inicia sesión.</p>
                </c:if>
                <c:if test="${param.salir eq 'ok'}">
                    <p class="alert alert-success border-0 bg-success  text-white py-2 text-center" ">Sesión cerrada. Inicia sesión.</p>
                </c:if>


                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label class="form-label small text-white-50">Usuario</label>
                        <input type="text" name="username" class="form-control" placeholder="user123" required autofocus>
                    </div>
                    <div class="mb-4">
                        <label class="form-label small text-white-50">Contraseña</label>
                        <input type="password" name="clave" class="form-control" placeholder="******" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 py-2 mb-3">Entrar al Sistema</button>
                </form>

                <div class="text-center">
                    <a href="/Grupo7DWI/views/registro.jsp" class="text-white-50 small text-decoration-none">¿No tienes cuenta? <span style="color: var(--accent-color);">Regístrate</span></a>
                </div>
            </div>
        </div>
    </body>
</html>