<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="pe.edu.vallegrande.demo1.dto.ProductoDTO" %>
<%@ page import="pe.edu.vallegrande.demo1.service.ProductoSERVICE" %>
<%@ page import="java.util.List" %>


<!-- Contenido Principal -->
<div class="container mt-5" id="container">
    <form id="ventaForm" action="${pageContext.request.contextPath}/venta" method="post">
    <h1 class="text-center mb-4">Gestión de Ventas</h1>
    <div class="row">
        <!-- Datos del Cliente, Datos del Producto, y Lista de Productos en la Venta en una sola fila -->
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm h-100">
                <div class="card-body">
                    <h2 class="h5 mb-3">Datos del Cliente</h2>
                    <div class="mb-3">
                        <label for="dniCliente" class="form-label">N° Identificacion</label>
                        <div class="input-group">
                            <input type="text" id="dniCliente" name="dniCliente" class="form-control" placeholder="Ingrese N° de Identificacion">
                            <button type="button" class="btn btn-primary" onclick="buscarCliente()">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="nombreCliente"  class="form-label">Nombre del Cliente</label>
                        <input type="text" id="nombreCliente" name="nombreCliente" class="form-control" placeholder="Nombre del Cliente" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="apellidoCliente" class="form-label">Apellido del Cliente</label>
                        <input type="text" id="apellidoCliente"  name="apellidoCliente" class="form-control" placeholder="Apellido del Cliente" readonly>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card shadow-sm h-100">
                <div class="card-body">
                    <h2 class="h5 mb-3">Datos del Producto</h2>
                    <div class="mb-3">
                        <label for="codeProducto" class="form-label">Codigo de Producto</label>
                        <div class="input-group">
                            <input type="text" id="codeProducto" class="form-control" placeholder="Ingrese ID del Producto">
                            <button type="button" class="btn btn-primary" onclick="buscarProducto()">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="productoNombre" class="form-label">Nombre del Producto</label>
                        <input type="text" id="productoNombre" class="form-control" placeholder="Nombre del Producto" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="productoPrecio" class="form-label">Precio Unitario</label>
                        <input type="text" id="productoPrecio" class="form-control" placeholder="Precio Unitario" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="productoCantidad" class="form-label">Cantidad</label>
                        <input type="number" id="productoCantidad" class="form-control" min="1" value="1">
                    </div>
                    <button type="button" class="btn btn-success w-100" onclick="agregarProducto()">
                        <i class="bi bi-cart-plus"></i> Agregar Producto
                    </button>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card shadow-sm h-100">
                <div class="card-body">
                    <h3 class="h5 mb-3">Lista de Productos en la Venta</h3>
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped text-center">
                            <thead class="table-dark">
                            <tr style="font-size: 12px">
                                <th>Producto</th>
                                <th>Precio Unitario</th>
                                <th>Cantidad</th>
                                <th>SubTotal</th>
                                <th>Acción</th>
                            </tr>
                            </thead>
                            <tbody id="tablaVenta">
                            <!-- Los productos se agregarán dinámicamente aquí -->
                            </tbody>
                        </table>
                    </div>


                    <div class="d-flex justify-content-between align-items-center mt-3">



                        <h4>Total a Pagar: S/. <span id="totalVenta">0.00</span></h4>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <input type="hidden" name="action" value="generarVenta">
        <input type="hidden" name="productos" id="productos">
        <button style="font-size: 15px" type="button" class="btn btn-success me-2" onclick="submitVentaForm()">Generar Venta</button>
        <button style="font-size: 15px" type="button" class="btn btn-danger" onclick="cancelarVenta()">Cancelar</button>
    </form>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    const tablaVenta = document.getElementById("tablaVenta");
    let totalVenta = 0;
    let nroProducto = 1;

    function buscarCliente() {
        const dni = document.getElementById("dniCliente").value;

        if (!dni) {
            alert("Por favor, ingrese un DNI válido");
            return;
        }

        $.ajax({
            url: '<c:out value="${pageContext.request.contextPath}/cliente"/>', // URL del servlet
            type: 'GET',
            data: { action: 'buscarCliente', dni: dni },
            dataType: 'json',
            success: function(cliente) {
                // Verifica si se devolvieron datos válidos
                if (cliente.nombre && cliente.apellido) {
                    document.getElementById("nombreCliente").value = cliente.nombre;
                    document.getElementById("apellidoCliente").value = cliente.apellido;
                } else {
                    // Si el JSON no tiene datos válidos
                    alert("Datos incompletos del cliente");
                }
            },
            error: function(xhr, status, error) {
                console.error("Error al buscar cliente:", error);

                if (xhr.status === 404) {
                    alert("Cliente no encontrado");
                } else {
                    alert("Ocurrió un error inesperado. Intente nuevamente.");
                }
            }
        });
    }


    function buscarProducto() {
        const code = document.getElementById("codeProducto").value;
        $.ajax({
            url: '<c:out value="${pageContext.request.contextPath}/producto"/>', // URL del ProductoServlet
            type: 'GET',
            data: { action: 'buscarProducto', code: code },
            dataType: 'json',
            success: function(producto) {
                if (producto) {
                    document.getElementById("productoNombre").value = producto.nombre; // Nombre en minúscula, igual que en el JSON
                    document.getElementById("productoPrecio").value = producto.precioVenta;
                    document.getElementById("productoCantidad").value = 1; // Reiniciar la cantidad a 1
                } else {
                    document.getElementById("productoNombre").value = "";
                    document.getElementById("productoPrecio").value = "";
                    alert("Producto no encontrado");
                }
            },
            error: function(error) {
                console.error("Error al buscar producto:", error);
                alert("Error al buscar producto");
            }
        });
    }


    function agregarProducto() {
        const productoNombre = document.getElementById("productoNombre").value;
        const productoPrecio = parseFloat(document.getElementById("productoPrecio").value);
        const productoCantidad = parseInt(document.getElementById("productoCantidad").value);
        const productoSubtotal = productoPrecio * productoCantidad;

        // Crear una nueva fila para el producto agregado
        const filaProducto = document.createElement("tr");
        const nombreCelda = document.createElement("td");
        nombreCelda.textContent = productoNombre;
        nombreCelda.setAttribute("name", "productoNombre[]");
        const precioCelda = document.createElement("td");
        precioCelda.textContent = productoPrecio.toFixed(2);
        precioCelda.setAttribute("name", "productoPrecio[]");
        const cantidadCelda = document.createElement("td");
        cantidadCelda.textContent = productoCantidad;
        cantidadCelda.setAttribute("name", "productoCantidad");
        const subTotal = document.createElement("td");
        subTotal.textContent = productoSubtotal.toFixed(2);
        subTotal.setAttribute("name", "productoSubtotal");
        const accionCelda = document.createElement("td");
        const eliminarBoton = document.createElement("button");
        eliminarBoton.textContent = "Eliminar";
        eliminarBoton.className = "btn btn-danger btn-sm";
        eliminarBoton.onclick = function() {
            eliminarProducto(eliminarBoton, productoSubtotal);
        };
        accionCelda.appendChild(eliminarBoton);

        filaProducto.appendChild(nombreCelda);
        filaProducto.appendChild(precioCelda);
        filaProducto.appendChild(cantidadCelda);
        filaProducto.appendChild(subTotal);
        filaProducto.appendChild(accionCelda);

        // Agregar la fila a la tabla de venta
        tablaVenta.appendChild(filaProducto);

        // Actualizar el total de la venta
        totalVenta += productoSubtotal;
        document.getElementById("totalVenta").innerText = totalVenta.toFixed(2);
    }

    function eliminarProducto(button, subtotal) {
        const fila = button.parentElement.parentElement;
        tablaVenta.removeChild(fila);
        totalVenta -= subtotal;
        document.getElementById("totalVenta").innerText = totalVenta.toFixed(2);
    }

    function submitVentaForm() {
        const dniCliente = document.getElementById("dniCliente").value;
        const nombreCliente = document.getElementById("nombreCliente").value;
        const apellidoCliente = document.getElementById("apellidoCliente").value;

        // Validar que los datos del cliente estén completos
        if (!dniCliente || !nombreCliente || !apellidoCliente) {
            alert("Por favor, complete los datos del cliente antes de generar la venta.");
            return;
        }

        // Capturar los productos desde la tabla
        const productos = [];
        const filas = document.getElementById("tablaVenta").getElementsByTagName("tr");

        for (let i = 0; i < filas.length; i++) {
            const columnas = filas[i].getElementsByTagName("td");
            const producto = {
                nombre: columnas[0].textContent.trim(),
                precio: parseFloat(columnas[1].textContent.trim().replace("S/.", "")),
                cantidad: parseInt(columnas[2].textContent.trim())
            };
            productos.push(producto);
        }

        // Validar que haya al menos un producto
        if (productos.length === 0) {
            alert("Debe agregar al menos un producto a la venta.");
            return;
        }

        // Crear el objeto combinado
        const ventaData = {
            cliente: {
                dni: dniCliente,
                nombre: nombreCliente,
                apellido: apellidoCliente
            },
            productos: productos
        };

        // Enviar el JSON al backend
        $.ajax({
            url: '<c:out value="${pageContext.request.contextPath}/venta"/>',
            type: 'POST',
            data: {
                action: 'generarVenta',
                ventaData: JSON.stringify(ventaData)
            },
            success: function (response) {
                alert(response.message);
                location.reload(); // Recargar la página después de generar la venta
            },
            error: function (xhr) {
                alert("Error al generar la venta: " + xhr.responseText);
            }
        });
    }
</script>

