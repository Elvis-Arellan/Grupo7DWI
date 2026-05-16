<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Registro</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

        <style>
            :root {
                --primary-bg: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%);
                --glass-bg: rgba(255, 255, 255, 0.1);
                --glass-border: rgba(255, 255, 255, 0.2);
                --accent-color: #a29bfe;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background: var(--primary-bg);
                background-attachment: fixed;
                color: #ffffff;
                min-height: 100vh;
                margin: 0;
            }

            .glass-card {
                background: var(--glass-bg);
                backdrop-filter: blur(15px);
                -webkit-backdrop-filter: blur(15px);
                border: 1px solid var(--glass-border);
                border-radius: 20px;
                box-shadow: 0 8px 32px rgba(0,0,0,0.37);
            }

            .form-control,
            .form-select {
                background: rgba(255,255,255,0.05);
                border: 1px solid var(--glass-border);
                color: #fff;
                border-radius: 10px;
            }

            .form-control:focus,
            .form-select:focus {
                background: rgba(255,255,255,0.1);
                color: #fff;
                border-color: var(--accent-color);
                box-shadow: 0 0 0 0.25rem rgba(162,155,254,0.25);
            }

            .btn-primary {
                background: var(--accent-color);
                border: none;
                font-weight: 600;
                transition: 0.3s;
            }

            .btn-primary:hover {
                background: #8e86f7;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(162,155,254,0.4);
            }

            .text-link {
                color: rgba(255,255,255,0.7);
                text-decoration: none;
            }

            .text-link:hover {
                color: white;
            }
        </style>

    </head>

    <body>

        <div class="container d-flex justify-content-center align-items-center min-vh-100">

            <div class="glass-card p-5" style="width:100%; max-width:550px;">

                <div class="text-center mb-4">
                    <h2 class="fw-bold">Crear Cuenta</h2>
                    <p class="text-white-50">Regístrate para ingresar al sistema</p>
                </div>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/registro">

                    <div class="mb-3">
                        <label class="form-label text-white-50">Nombre completo</label>
                        <input type="text" name="nombreCompleto" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white-50"> Usuario</label>
                        <input type="text" name="username" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white-50">Contraseña</label>
                        <input type="password" name="clave" class="form-control" required minlength="6">
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white-50">Confirmar contraseña</label>
                        <input type="password" name="confirmar" class="form-control" required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label text-white-50">Rol</label>
                        <select name="rol"
                                class="form-select">
                            <option value="ADMIN">Admin (grupo7)</option>
                            <option value="VENDEDOR">Vendedor</option>
                        </select>
                    </div>

                    <button type="submit"
                            class="btn btn-primary w-100 py-2">Registrarse</button>
                </form>

                <div class="mt-4 text-center">
                    <a href="${pageContext.request.contextPath}/views/login.jsp" class="text-link small">Ya tengo cuenta</a>
                </div>

            </div>

        </div>

    </body>
</html>