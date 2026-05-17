<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nueva venta</title>
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
            .table-glass {
                background: #0a0a1a;
                border-radius: 20px;
                overflow-x: auto;
                border: 1px solid var(--glass-border);
            }
            .table {
                color: white;
                margin-bottom: 0;
                width: 100%;
                border-collapse: collapse;
                background: #0a0a1a;
            }
            .table thead th {
                background: #1a1a2e;
                color: white;
                padding: 15px;
                font-weight: 600;
                border-bottom: 1px solid var(--glass-border);
            }
            .table tbody tr {
                background: #0a0a1a;
            }
            .table tbody td {
                padding: 12px 15px;
                vertical-align: middle;
                border-bottom: 1px solid rgba(255,255,255,0.08);
                color: white;
                background: #0a0a1a;
            }
            .table tbody tr:hover td {
                background: #1a1a2e;
            }
            .form-control, .form-select {
                background: rgba(0,0,0,0.5);
                border: 1px solid var(--glass-border);
                color: white;
                border-radius: 12px;
            }
            .form-control:focus, .form-select:focus {
                background: rgba(0,0,0,0.7);
                color: white;
                border-color: var(--accent-color);
                box-shadow: 0 0 0 0.2rem rgba(162,155,254,0.25);
            }
            .form-select option {
                color: black;
            }
            .btn-custom {
                background: var(--accent-color);
                border: none;
                color: white;
                padding: 10px 20px;
                border-radius: 12px;
            }
            .btn-custom:hover {
                background: #8c84f7;
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
            .btn-outline-danger {
                color: #dc3545;
                border-color: #dc3545;
            }
            .btn-outline-danger:hover {
                background: #dc3545;
                color: white;
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
                <a href="${pageContext.request.contextPath}/ventas" class="nav-link active">
                    <i class="bi bi-cart-check"></i> Ventas / Fiados
                </a>
                <c:if test="${sessionScope.usuario.rol eq 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/usuarios" class="nav-link">
                        <i class="bi bi-person-badge"></i> Usuarios
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/reportes" class="nav-link"> 
                    <i class="bi bi-box-arrow-right"></i>
                    Reportes
                </a>
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
                            <h2 class="fw-bold mb-0">Nueva venta / fiado</h2>
                            <p class="text-muted-custom">Registra una nueva venta en el sistema</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/ventas" class="btn btn-outline-light">
                            <i class="bi bi-arrow-left"></i> Volver
                        </a>
                    </div>
                    <c:if test="${not empty error}">
                        <div class="alert-custom-danger mb-4">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                        </div>
                    </c:if>
                    <form method="post" action="${pageContext.request.contextPath}/ventas" id="formVenta">
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label class="form-label text-white-50">Cliente</label>
                                <select name="idCliente" class="form-select" required>
                                    <option value="">-- Selecciona --</option>
                                    <c:forEach var="c" items="${clientes}">
                                        <option value="${c.idCliente}">${c.nombre} ${c.apellido}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-4">
                                <label class="form-label text-white-50">Observación</label>
                                <input type="text" name="observacion" class="form-control" placeholder="Opcional">
                            </div>
                        </div>
                        <div class="glass-card mt-4">
                            <h4 class="fw-bold mb-4">Productos</h4>
                            <div class="row align-items-end">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label text-white-50">Producto</label>
                                    <select id="selectProducto" class="form-select">
                                        <option value="">-- Elige producto --</option>
                                        <c:forEach var="p" items="${productos}">
                                            <option value="${p.idProducto}" data-precio="${p.precio}" data-nombre="${p.nombre}" data-stock="${p.stockActual}">
                                                ${p.nombre} — S/ ${p.precio} (stock: ${p.stockActual})
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2 mb-3">
                                    <label class="form-label text-white-50">Cantidad</label>
                                    <input type="number" id="inputCantidad" class="form-control" value="1" min="1">
                                </div>
                                <div class="col-md-4 mb-3">
                                    <button type="button" onclick="agregarProducto()" class="btn btn-custom w-100">
                                        <i class="bi bi-plus-circle me-1"></i> Agregar producto
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="table-glass mt-4">
                            <table class="table align-middle">
                                <thead>
                                    <tr>
                                        <th>Producto</th>
                                        <th>Cantidad</th>
                                        <th>Precio unit.</th>
                                        <th>Subtotal</th>
                                        <th>Quitar</th>
                                    </tr>
                                </thead>
                                <tbody id="cuerpoDetalle">
                                    <tr id="filaVacia">
                                        <td colspan="5" class="text-center text-white-50 py-4">Agrega productos arriba.</td>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="3"><b>Total</b></td>
                                        <td><b>S/ <span id="totalLabel">0.00</span></b></td>
                                        <td></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        <div id="inputsOcultos"></div>
                        <div class="d-flex gap-3 mt-4">
                            <button type="submit" class="btn btn-custom">
                                <i class="bi bi-check-circle me-1"></i> Registrar venta
                            </button>
                            <a href="${pageContext.request.contextPath}/ventas" class="btn btn-outline-light">Cancelar</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>
            var detalle = [];

            function agregarProducto() {
                var sel = document.getElementById('selectProducto');
                var opt = sel.options[sel.selectedIndex];
                var cantidad = parseInt(document.getElementById('inputCantidad').value);
                if (!opt.value) {
                    alert('Selecciona un producto.');
                    return;
                }
                if (cantidad < 1) {
                    alert('La cantidad debe ser mayor a 0.');
                    return;
                }
                var stock = parseInt(opt.getAttribute('data-stock'));
                if (cantidad > stock) {
                    alert('Stock insuficiente. Disponible: ' + stock);
                    return;
                }
                var idProducto = opt.value;
                var nombre = opt.getAttribute('data-nombre');
                var precio = parseFloat(opt.getAttribute('data-precio'));
                var subtotal = (cantidad * precio).toFixed(2);
                var existente = detalle.find(function (d) {
                    return d.idProducto === idProducto;
                });
                if (existente) {
                    existente.cantidad += cantidad;
                    existente.subtotal = (existente.cantidad * precio).toFixed(2);
                } else {
                    detalle.push({
                        idProducto: idProducto,
                        nombre: nombre,
                        cantidad: cantidad,
                        precio: precio,
                        subtotal: subtotal
                    });
                }
                renderTabla();
            }

            function quitarProducto(idx) {
                detalle.splice(idx, 1);
                renderTabla();
            }

            function renderTabla() {
                var tbody = document.getElementById('cuerpoDetalle');
                var ocultos = document.getElementById('inputsOcultos');
                tbody.innerHTML = '';
                ocultos.innerHTML = '';
                if (detalle.length === 0) {
                    tbody.innerHTML = '<tr id="filaVacia"><td colspan="5" class="text-center text-white-50 py-4">Agrega productos arriba.</td></tr>';
                    document.getElementById('totalLabel').textContent = '0.00';
                    return;
                }
                var total = 0;
                detalle.forEach(function (d, i) {
                    total += parseFloat(d.subtotal);
                    tbody.innerHTML += '<tr>' +
                            '<td><strong>' + d.nombre + '</strong></td>' +
                            '<td>' + d.cantidad + '</td>' +
                            '<td>S/ ' + parseFloat(d.precio).toFixed(2) + '</td>' +
                            '<td>S/ ' + d.subtotal + '</td>' +
                            '<td><button type="button" class="btn btn-sm btn-outline-danger" onclick="quitarProducto(' + i + ')"><i class="bi bi-trash"></i></button></td>' +
                            '</tr>';
                    ocultos.innerHTML += '<input type="hidden" name="idProducto[]" value="' + d.idProducto + '">' +
                            '<input type="hidden" name="cantidad[]" value="' + d.cantidad + '">' +
                            '<input type="hidden" name="precioUnitario[]" value="' + d.precio + '">';
                });
                document.getElementById('totalLabel').textContent = total.toFixed(2);
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>