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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    </head>
    <body>
        <c:set var="activeNav" value="ventas" scope="request"/>
        <jsp:include page="/views/_sidebar.jsp"/>
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