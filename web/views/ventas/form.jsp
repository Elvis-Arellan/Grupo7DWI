<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Nueva venta</title>
    </head>
    <body>

        <h2>Nueva venta / fiado</h2>
        <c:if test="${not empty error}"><p style="color:red">${error}</p></c:if>

            <form method="post" action="${pageContext.request.contextPath}/ventas" id="formVenta">

            <label>Cliente:<br>
                <select name="idCliente" required>
                    <option value="">-- Selecciona --</option>
                    <c:forEach var="c" items="${clientes}">
                        <option value="${c.idCliente}">${c.nombre} ${c.apellido}</option>
                    </c:forEach>
                </select>
            </label><br><br>

            <label>Observación:<br>
                <input type="text" name="observacion" placeholder="Opcional">
            </label><br><br>

            <hr>
            <h3>Productos</h3>

            <label>Producto:
                <select id="selectProducto">
                    <option value="">-- Elige producto --</option>
                    <c:forEach var="p" items="${productos}">
                        <option value="${p.idProducto}"
                                data-precio="${p.precio}"
                                data-nombre="${p.nombre}"
                                data-stock="${p.stockActual}">
                            ${p.nombre} — S/ ${p.precio} (stock: ${p.stockActual})
                        </option>
                    </c:forEach>
                </select>
            </label>
            <label>Cantidad: <input type="number" id="inputCantidad" value="1" min="1" style="width:60px"></label>
            <button type="button" onclick="agregarProducto()">Agregar</button>

            <br><br>

            <table border="1" cellpadding="6" id="tablaDetalle">
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
                    <tr id="filaVacia"><td colspan="5">Agrega productos arriba.</td></tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="3"><b>Total</b></td>
                        <td><b>S/ <span id="totalLabel">0.00</span></b></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>

            <div id="inputsOcultos"></div>

            <br>
            <button type="submit">Registrar venta</button>
            <a href="${pageContext.request.contextPath}/ventas">Cancelar</a>
        </form>

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
                    detalle.push({idProducto: idProducto, nombre: nombre,
                        cantidad: cantidad, precio: precio, subtotal: subtotal});
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
                    tbody.innerHTML = '<tr id="filaVacia"><td colspan="5">Agrega productos arriba.</td></tr>';
                    document.getElementById('totalLabel').textContent = '0.00';
                    return;
                }

                var total = 0;
                detalle.forEach(function (d, i) {
                    total += parseFloat(d.subtotal);
                    tbody.innerHTML +=
                            '<tr>' +
                            '<td>' + d.nombre + '</td>' +
                            '<td>' + d.cantidad + '</td>' +
                            '<td>S/ ' + parseFloat(d.precio).toFixed(2) + '</td>' +
                            '<td>S/ ' + d.subtotal + '</td>' +
                            '<td><button type="button" onclick="quitarProducto(' + i + ')">X</button></td>' +
                            '</tr>';


                    ocultos.innerHTML +=
                            '<input type="hidden" name="idProducto[]" value="' + d.idProducto + '">' +
                            '<input type="hidden" name="cantidad[]" value="' + d.cantidad + '">' +
                            '<input type="hidden" name="precioUnitario[]" value="' + d.precio + '">';
                });

                document.getElementById('totalLabel').textContent = total.toFixed(2);
            }
        </script>

    </body>
</html>