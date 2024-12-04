<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="pe.edu.vallegrande.demo1.dto.ProductoDTO" %>
<%@ page import="pe.edu.vallegrande.demo1.service.ProductoSERVICE" %>
<%@ page import="java.util.List" %>


<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.0/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.0/dist/sweetalert2.all.min.js"></script>

<style>
    .total-pagar-container {
        display: flex;
        justify-content: space-between; /* Espaciado entre los elementos */
        align-items: center;
        margin-top: 15px;
        gap: 20px; /* Espacio adicional entre los elementos */
    }

    .total-pagar-input {
        border: none; /* Elimina el borde */
        font-size: 2.5rem; /* Aumenta el tamaño del número */
        font-weight: bold; /* Hace el número más grueso */
        padding-left: 15px; /* Agrega espacio a la izquierda */
        background: transparent; /* El fondo transparente */
        color: #921f2e; /* Color rojo */
        text-align: left; /* Alinea el texto hacia la izquierda */
        margin-left: 10px; /* Añade un margen extra a la izquierda para ajustarlo */
    }

    .total-pagar-container h4 {
        font-size: 1.5rem; /* Ajusta el tamaño del texto en el h4 */
        margin-bottom: 0; /* Elimina el margen inferior del h4 */
    }

    /* Elimina los bordes de los inputs dentro de la tabla */
    #tablaVenta input {
        border: none; /* Sin bordes */
        outline: none; /* Sin resaltado al enfocar */
        background-color: transparent; /* Fondo transparente */
        text-align: center; /* Centra el texto */
    }

    /* Cambia el fondo cuando el usuario enfoca */
    #tablaVenta input:focus {
        border: 1px solid #ced4da; /* Borde suave solo al enfocar */
        background-color: #f8f9fa; /* Fondo claro */
        outline: none;
    }

    .table-wrapper {
        max-height: 300px; /* Altura máxima para mostrar el scroll */
        overflow-y: auto; /* Mostrar scroll cuando el contenido exceda la altura */
    }

    thead tr {
        position: sticky;
        top: 0; /* Fija el encabezado en la parte superior */
        background-color: #343a40; /* Asegúrate de que tenga un fondo sólido para no perder visibilidad */
        z-index: 1; /* Asegura que el encabezado quede sobre el contenido */
    }
    /* Estilo del Modal */
    .modal-content {
        background: #1e1e2f;  /* Fondo oscuro para un look más moderno */
        border-radius: 15px;   /* Bordes redondeados suaves */
        border: none;
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);  /* Sombra intensa */
        transform: scale(0.8);
        opacity: 0;
        transition: transform 0.7s ease-out, opacity 0.7s ease-out;
    }

    /* Animación de entrada del modal */
    @keyframes slideIn {
        0% {
            transform: scale(0.5) translateY(30px);
            opacity: 0;
        }
        100% {
            transform: scale(1) translateY(0);
            opacity: 1;
        }
    }

    .animate-modal {
        animation: slideIn 0.7s ease-out forwards;
    }

    /* Animación de la X (icono de error) */
    .error-icon {
        font-size: 2.5rem;
        color: #dc3545;  /* Color vibrante para la X */
        transition: transform 0.4s ease, color 0.4s ease;
        animation: iconBounce 1.2s ease-in-out infinite;
    }

    .error-icon:hover {
        color: #dc3545;  /* Cambio de color al pasar el mouse */
        transform: rotate(180deg);  /* Efecto de rotación */
    }

    /* Animación de rebote de la X */
    @keyframes iconBounce {
        0%, 100% {
            transform: translateY(0);
        }
        50% {
            transform: translateY(-10px);  /* Efecto de rebote */
        }
    }

    /* Estilo del título */
    .modal-header {
        background: #1e1e2f;  /* Mismo fondo oscuro */
        border-bottom: 1px solid #444;
        padding: 25px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .modal-title {
        font-family: 'Roboto', sans-serif;
        font-weight: 600;
        font-size: 1.4rem;
        color: #fff;
    }

    /* Estilo del cuerpo del modal */
    .modal-body {
        padding: 25px;
        font-family: 'Roboto', sans-serif;
        font-size: 1.1rem;
        color: #ddd;
        line-height: 1.6;
        text-align: center;
    }

    .modal-body i {
        font-size: 2rem;
        color: #dc3545;  /* Color similar al de la X */
        margin-right: 10px;
    }

    /* Estilo de los botones */
    .modal-footer {
        background: #1e1e2f;
        border-top: 1px solid #444;
        padding: 20px;
        text-align: center;
    }

    .btn-danger {
        background: #dc3545;
        color: #fff;
        border: none;
        padding: 12px 25px;
        border-radius: 8px;
        transition: background 0.3s ease;
    }

    .btn-danger:hover {
        background: #dc3545;  /* Cambio de color en hover */
    }

    /* Animación de salida del modal (cuando se cierra) */
    .modal.fade .modal-dialog {
        transform: translateY(0);
        opacity: 0;
        transition: transform 0.3s ease-out, opacity 0.3s ease-out;
    }

    .modal.fade.show .modal-dialog {
        transform: translateY(0);
        opacity: 1;
    }
</style>

<!-- Contenido Principal -->
<div class="container mt-5" id="container">
    <form id="ventaForm" action="${pageContext.request.contextPath}/venta" method="post">
        <h1 class="text-center mb-4">Gestión de Ventas</h1>

        <!-- Fila para Datos del Cliente y Datos del Producto -->
        <div class="row g-4">
            <!-- Datos del Cliente -->
            <div class="col-6">
                <div class="card shadow-sm h-100" style="min-height: 300px;">
                    <div class="card-body">
                        <h2 class="h5 mb-3">Datos del Cliente</h2>
                        <div class="mb-3">
                            <label for="dniCliente" class="form-label">N° Identificación</label>
                            <div class="input-group">
                                <input type="text" id="dniCliente" name="dniCliente" class="form-control" placeholder="Ingrese N° de Identificación" required>
                                <button type="button" class="btn btn-primary" onclick="buscarCliente()">
                                    <i class="bi bi-search"></i>
                                </button>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="nombreCliente" class="form-label">Nombre del Cliente</label>
                            <input type="text" id="nombreCliente" name="nombreCliente" class="form-control" placeholder="Nombre del Cliente" readonly>
                            <input name="clienteID" type="hidden" id="clienteID" class="form-control" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="apellidoCliente" class="form-label">Apellido del Cliente</label>
                            <input type="text" id="apellidoCliente" name="apellidoCliente" class="form-control" placeholder="Apellido del Cliente" readonly>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Datos del Producto -->
            <div class="col-6">
                <div class="card shadow-sm h-100" style="min-height: 300px;">
                    <div class="card-body">
                        <h2 class="h5 mb-3">Datos del Producto</h2>
                        <div class="mb-3">
                            <label for="codeProducto" class="form-label">Código de Producto</label>
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
                            <input type="hidden" id="productoID" class="form-control" readonly>
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
        </div>

        <!-- Tabla de Productos -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h3 class="h5 mb-3">Lista de Productos en la Venta</h3>
                        <div class="table-wrapper">
                            <table id="tablaProductos" class="table table-bordered table-striped text-center">
                                <thead class="table-dark">
                                <tr style="font-size: 14px">
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
                        <div class="d-flex justify-content-between items-center mt-3 total-pagar-container">
                            <h4>Total a Pagar: S/. <input id="totalVenta" name="totalVenta" type="text" readonly class="total-pagar-input"></h4>
                            <input name="totalProductos" id="totalProductos" type="hidden">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Botones de acción -->
        <div class="d-flex justify-content-end mt-4">
            <input type="hidden" name="action" value="generarVenta">
            <input type="hidden" name="productos" id="productos">
            <button type="submit" class="btn btn-success me-2"  id="botonGenerarVenta" style="font-size: 15px;">Generar Venta</button>
            <button type="button" class="btn btn-danger" style="font-size: 15px;" onclick="cancelarVenta()">Cancelar</button>
        </div>
    </form>
</div>

<!-- Modal de Error con Animaciones Futuristas -->
<div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content animate-modal">
            <div class="modal-header">
                <span class="modal-title text-white" id="errorModalLabel">
                    <i class="bi bi-x-circle error-icon"></i> Error de Validación
                </span>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p id="errorMessage">
                    <i class="bi bi-exclamation-circle"></i> Por favor, seleccione un cliente antes de generar la venta.
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">


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
                if (cliente.id && cliente.nombre && cliente.apellido) {
                    document.getElementById("clienteID").value = cliente.id;
                    document.getElementById("nombreCliente").value = cliente.nombre;
                    document.getElementById("apellidoCliente").value = cliente.apellido;
                    console.log("Cliente encontrado. ClienteID:", cliente.id, "Nombre:", cliente.nombre, "Apellido:", cliente.apellido);
                } else {
                    alert("Datos incompletos del cliente");
                    console.log("Datos incompletos del cliente"); // Log cuando los datos están incompletos
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
                    document.getElementById("productoID").value = producto.id;
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
        const productoID = document.getElementById("productoID").value;
        const productoNombre = document.getElementById("productoNombre").value;
        const productoPrecio = parseFloat(document.getElementById("productoPrecio").value);
        const productoCantidad = parseInt(document.getElementById("productoCantidad").value);
        const productoSubtotal = productoPrecio * productoCantidad;

        // Primero, validamos que el producto se haya encontrado correctamente
        if (!productoID || !productoNombre || !productoPrecio || productoPrecio <= 0) {
            alert("Por favor, busque un producto válido antes de agregarlo.");
            return; // Si no se encuentra un producto válido, no se agrega
        }

        // Crear una nueva fila para el producto agregado
        const filaProducto = document.createElement("tr");

        // Crear celdas con inputs
        const idcelda = document.createElement("td");
        const idInput = document.createElement("input");
        idInput.type = "hidden";
        idInput.name = "productoID[]";
        idInput.value = productoID;
        idInput.readOnly = true; // Opcional: evitar edición
        idcelda.appendChild(idInput);

        const nombreCelda = document.createElement("td");
        const nombreInput = document.createElement("input");
        nombreInput.type = "text";
        nombreInput.name = "productoNombre[]";
        nombreInput.value = productoNombre;
        nombreInput.readOnly = true; // Opcional: evitar edición
        nombreCelda.appendChild(nombreInput);

        const precioCelda = document.createElement("td");
        const precioInput = document.createElement("input");
        precioInput.type = "number";
        precioInput.name = "productoPrecio[]";
        precioInput.value = productoPrecio.toFixed(2);
        precioInput.readOnly = true; // Opcional
        precioCelda.appendChild(precioInput);

        const cantidadCelda = document.createElement("td");
        const cantidadInput = document.createElement("input");
        cantidadInput.type = "number";
        cantidadInput.name = "productoCantidad[]";
        cantidadInput.value = productoCantidad;
        cantidadInput.readOnly = true; // Opcional
        cantidadCelda.appendChild(cantidadInput);


        const subtotalCelda = document.createElement("td");
        const subtotalInput = document.createElement("input");
        subtotalInput.type = "number";
        subtotalInput.name = "productoSubtotal[]";
        subtotalInput.value = productoSubtotal.toFixed(2);
        subtotalInput.readOnly = true; // Opcional
        subtotalCelda.appendChild(subtotalInput);

        // Botón de eliminar
        const accionCelda = document.createElement("td");
        const eliminarBoton = document.createElement("button");
        eliminarBoton.textContent = "Eliminar";
        eliminarBoton.className = "btn btn-danger btn-sm";
        eliminarBoton.onclick = function () {
            eliminarProducto(eliminarBoton, productoSubtotal);
        };
        accionCelda.appendChild(eliminarBoton);

        // Agregar celdas a la fila
        filaProducto.appendChild(idcelda);
        idcelda.style.display = "none";
        filaProducto.appendChild(nombreCelda);
        filaProducto.appendChild(precioCelda);
        filaProducto.appendChild(cantidadCelda);
        filaProducto.appendChild(subtotalCelda);
        filaProducto.appendChild(accionCelda);

        // Agregar la fila a la tabla de venta
        document.getElementById("tablaVenta").appendChild(filaProducto);

        // Actualizar el total de la venta
        totalVenta += productoSubtotal;
        document.getElementById("totalVenta").value = totalVenta.toFixed(2); // Asignar al input


        // Limpiar los campos de entrada después de agregar el producto
        document.getElementById("productoID").value = "";
        document.getElementById("codeProducto").value = "";
        document.getElementById("productoNombre").value = "";
        document.getElementById("productoPrecio").value = "";
        document.getElementById("productoCantidad").value = "";
    }


    function eliminarProducto(button, subtotal) {
        const fila = button.parentElement.parentElement;
        tablaVenta.removeChild(fila);
        totalVenta -= subtotal;
        document.getElementById("totalVenta").innerText = totalVenta.toFixed(2);
    }

    document.getElementById('botonGenerarVenta').addEventListener('click', function(event) {
        const dniCliente = document.getElementById('dniCliente').value;
        const clienteID = document.getElementById('clienteID').value;

        if (!dniCliente || !clienteID) {
            event.preventDefault(); // Previene que se envíe el formulario
            showErrorModal("Debe seleccionar un cliente para generar la venta.");
        }
    });

    function showErrorModal(message) {
        const errorMessage = document.getElementById('errorMessage');
        errorMessage.textContent = message;
        const errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
        errorModal.show();
    }
</script>




