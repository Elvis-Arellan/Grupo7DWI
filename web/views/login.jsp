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

        <style>
            :root {
                --primary-bg: #0f0c29;
                --sidebar-bg: rgba(255, 255, 255, 0.05);
                --accent-color: #a29bfe;
                --glass-border: rgba(255, 255, 255, 0.1);
            }

            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%);
                background-attachment: fixed;
                color: white;
                overflow-x: hidden;
            }

            /* Sidebar Estilo */
            .sidebar {
                width: 260px;
                height: 100vh;
                position: fixed;
                background: var(--sidebar-bg);
                backdrop-filter: blur(10px);
                border-right: 1px solid var(--glass-border);
                padding: 20px;
                transition: all 0.3s;
            }

            .nav-link {
                color: rgba(255, 255, 255, 0.7);
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
                font-size: 1.2rem;
            }

            .nav-link:hover, .nav-link.active {
                background: rgba(162, 155, 254, 0.2);
                color: var(--accent-color);
                transform: translateX(5px);
            }

            /* Contenido Principal */
            .main-content {
                margin-left: 260px;
                padding: 30px;
                width: calc(100% - 260px);
            }

            .glass-card {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(15px);
                border: 1px solid var(--glass-border);
                border-radius: 20px;
                padding: 25px;
            }

            .stat-card {
                border-left: 4px solid var(--accent-color);
            }

            .user-badge {
                background: rgba(162, 155, 254, 0.1);
                padding: 5px 15px;
                border-radius: 20px;
                border: 1px solid var(--accent-color);
                font-size: 0.9rem;
            }
        </style>
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
                        <input type="password" name="clave" class="form-control" placeholder="••••••••" required>
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