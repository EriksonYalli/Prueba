<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Añadir FontAwesome para el icono de check -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!-- Modal de Bootstrap para agregar producto -->
<div class="modal fade" id="modalAgregarProducto" tabindex="-1" aria-labelledby="modalAgregarProductoLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title" id="modalAgregarProductoLabel">Agregar Producto</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Formulario para agregar un producto -->
                <form id="formAgregarProducto" action="producto?action=agregar" method="POST">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El nombre debe tener entre 3 y 50 caracteres y solo debe contener letras.</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="descripcion" class="form-label">Descripción</label>
                                <textarea class="form-control" id="descripcion" name="descripcion" required></textarea>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">La descripción debe tener entre 10 y 200 caracteres y no debe contener etiquetas HTML.</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="categoria" class="form-label">Categoría</label>
                                <div>
                                    <input type="radio" id="tortas" name="categoria" value="Tortas y Pasteles" required>
                                    <label for="tortas">Tortas y Pasteles</label>
                                </div>
                                <div>
                                    <input type="radio" id="galletas" name="categoria" value="Galletas" required>
                                    <label for="galletas">Galletas</label>
                                </div>
                                <div>
                                    <input type="radio" id="cupcakes" name="categoria" value="Cupcakes y Muffins" required>
                                    <label for="cupcakes">Cupcakes y Muffins</label>
                                </div>
                                <div>
                                    <input type="radio" id="brownies" name="categoria" value="Brownies y Barras" required>
                                    <label for="brownies">Brownies y Barras</label>
                                </div>
                                <div>
                                    <input type="radio" id="macarons" name="categoria" value="Macarons y Delicias Francesas" required>
                                    <label for="macarons">Macarons y Delicias Francesas</label>
                                </div>
                                <div>
                                    <input type="radio" id="postres" name="categoria" value="Postres y Dulces" required>
                                    <label for="postres">Postres y Dulces</label>
                                </div>
                                <div>
                                    <input type="radio" id="panaderia" name="categoria" value="Panadería Dulce" required>
                                    <label for="panaderia">Panadería Dulce</label>
                                </div>
                                <div>
                                    <input type="radio" id="tartas" name="categoria" value="Tartas y Pies" required>
                                    <label for="tartas">Tartas y Pies</label>
                                </div>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">Debe seleccionar una categoría.</div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="marca" class="form-label">Marca</label>
                                <select class="form-select" id="marca" name="marca" required>
                                    <option value="" selected disabled>Selecciona una marca</option>
                                </select>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">Debe seleccionar una marca.</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="precioVenta" class="form-label">Precio Venta</label>
                                <input type="number" step="0.01" class="form-control" id="precioVenta" name="precioVenta" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El precio de venta debe ser mayor a 0.</div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="descuento" class="form-label">Descuento</label>
                                <input type="number" step="0.01" class="form-control" id="descuento" name="descuento" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El descuento debe estar entre 0 y 100.</div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="stock" class="form-label">Stock</label>
                                <input type="number" class="form-control" id="stock" name="stock" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El stock debe ser un número entero positivo.</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="estatus" class="form-label">Estatus</label>
                                <input type="text" class="form-control" id="estatus" name="estatus" value="A" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fechaIngreso" class="form-label">Fecha Ingreso</label>
                                <input type="date" class="form-control" id="fechaIngreso" name="fechaIngreso" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">La fecha de ingreso no puede ser futura.</div>
                            </div>
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Guardar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal flotante para "Agregando producto..." -->
<div class="modal fade" id="modalAgregandoProducto" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center p-5 shadow-lg rounded-3 border-0">
            <div class="modal-body">
                <div class="spinner-border text-primary mb-3" role="status" style="width: 4rem; height: 4rem;">
                    <span class="visually-hidden">Cargando...</span>
                </div>
                <h5 class="fw-bold text-secondary">Agregando producto...</h5>
                <p class="text-muted">Estamos procesando su solicitud, por favor espere un momento.</p>
            </div>
        </div>
    </div>
</div>

<!-- Modal flotante para "Producto agregado" -->
<div class="modal fade" id="modalProductoAgregado" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center p-5 shadow-lg rounded-3 border-0">
            <div class="modal-body">
                <i class="fas fa-check-circle text-success mb-3" style="font-size: 4rem;"></i>
                <h5 class="fw-bold text-success">¡Producto agregado exitosamente!</h5>
                <p class="text-muted">El producto se ha registrado en el sistema.</p>
                <button type="button" class="btn btn-outline-primary mt-3" data-bs-dismiss="modal">Aceptar</button>
            </div>
        </div>
    </div>
</div>

<style>
    /* Mejora del diseño de los modales */
    .modal-content {
        background-color: #f9f9f9;
        border-radius: 15px;
    }

    .spinner-border {
        animation: spin 1.2s linear infinite;
    }

    @keyframes spin {
        0% {
            transform: rotate(0deg);
        }
        100% {
            transform: rotate(360deg);
        }
    }

    .modal-body {
        font-family: 'Arial', sans-serif;
    }
</style>

<!-- JavaScript para validaciones de los campos -->
<script>
    // Función para mostrar visualmente la validez del campo
    function setValidationState(element, isValid) {
        if (isValid) {
            element.classList.remove('is-invalid');
            element.classList.add('is-valid');

        } else {
            element.classList.remove('is-valid');
            element.classList.add('is-invalid');
            element.nextElementSibling.classList.remove('text-success');
            element.nextElementSibling.innerHTML = '';
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        // Validación para el campo "nombre"
        const nombreInput = document.getElementById('nombre');
        nombreInput.addEventListener('input', function () {
            const regexNombre = /^[a-zA-ZÀ-ÿÑñ\s]{3,50}$/; // Solo letras, incluyendo tildes y la letra Ñ, con una longitud de 3-50
            const isValid = regexNombre.test(nombreInput.value);
            setValidationState(nombreInput, isValid);
        });

        // Validación para el campo "descripcion"
        const descripcionInput = document.getElementById('descripcion');
        descripcionInput.addEventListener('input', function () {
            const regexDescripcion = /^[^<>]{10,200}$/; // No permite etiquetas HTML, longitud de 10-200 caracteres
            const isValid = regexDescripcion.test(descripcionInput.value);
            setValidationState(descripcionInput, isValid);
        });

        // Validación para el campo "precioVenta"
        const precioVentaInput = document.getElementById('precioVenta');
        precioVentaInput.addEventListener('input', function () {
            const isValid = precioVentaInput.value > 0;
            setValidationState(precioVentaInput, isValid);
        });

        // Validación para el campo "descuento"
        const descuentoInput = document.getElementById('descuento');
        descuentoInput.addEventListener('input', function () {
            const isValid = descuentoInput.value >= 0 && descuentoInput.value <= 100;
            setValidationState(descuentoInput, isValid);
        });

        // Validación para el campo "stock"
        const stockInput = document.getElementById('stock');
        stockInput.addEventListener('input', function () {
            const isValid = stockInput.value >= 0 && Number.isInteger(parseFloat(stockInput.value));
            setValidationState(stockInput, isValid);
        });

        // Validación para el campo "fechaIngreso"
        const fechaIngresoInput = document.getElementById('fechaIngreso');
        fechaIngresoInput.addEventListener('input', function () {
            const fechaActual = new Date().toISOString().split('T')[0];
            const isValid = fechaIngresoInput.value <= fechaActual;
            setValidationState(fechaIngresoInput, isValid);
        });

        // Validación para el campo "categoria"
        const categoriaInputs = document.querySelectorAll('input[name="categoria"]');
        categoriaInputs.forEach(input => {
            input.addEventListener('change', function () {
                const isValid = Array.from(categoriaInputs).some(input => input.checked);
                const categoriaContainer = input.closest('.mb-3');
                setValidationState(categoriaContainer, isValid);
            });
        });

        // Validación para el campo "marca"
        const marcaSelect = document.getElementById('marca');
        marcaSelect.addEventListener('change', function () {
            const isValid = marcaSelect.value !== "";
            setValidationState(marcaSelect, isValid);
        });

        // Mostrar modal "Agregando producto..." cuando se envíe el formulario
        const formAgregarProducto = document.getElementById('formAgregarProducto');
        formAgregarProducto.addEventListener('submit', function (event) {
            event.preventDefault(); // Evitar el envío inmediato
            const modalAgregandoProducto = new bootstrap.Modal(document.getElementById('modalAgregandoProducto'));
            modalAgregandoProducto.show();

            // Simular el proceso de agregado del producto
            setTimeout(function () {
                modalAgregandoProducto.hide();
                const modalProductoAgregado = new bootstrap.Modal(document.getElementById('modalProductoAgregado'));
                modalProductoAgregado.show();
                // Enviar el formulario real después de mostrar la confirmación
                setTimeout(function () {
                    modalProductoAgregado.hide();
                    formAgregarProducto.submit();
                }, 2000);
            }, 2000);
        });
    });
</script>

<style>
    .is-valid {
        border-color: #28a745 !important; /* Color verde para indicar que el campo es válido */
    }

    .is-invalid {
        border-color: #dc3545 !important; /* Color rojo para indicar que el campo es inválido */
    }

    .text-success {
        color: #28a745 !important; /* Color verde para el icono de check */
    }

    .modal-backdrop {
        background-color: rgba(0, 0, 0, 0.5); /* Fondo oscuro cuando se muestra el modal */
    }
</style>

<!-- JavaScript para filtrar marcas según la categoría seleccionada -->
<script>
    // Asociar las marcas con las categorías
    const marcasPorCategoria = {
        "Tortas y Pasteles": ["Delicia Dulce", "Dulce de Leche Granulado", "Cake Boss"],
        "Galletas": ["Oreo", "Pepperidge Farm", "Chips Ahoy!"],
        "Cupcakes y Muffins": ["Hostess", "Magnolia Bakery", "Betty Crocker"],
        "Brownies y Barras": ["Ghirardelli", "Little Debbie", "Fudge Kitchen"],
        "Macarons y Delicias Francesas": ["Ladurée", "Pierre Hermé", "La Maison du Chocolat"],
        "Postres y Dulces": ["Ferrero Rocher", "Hershey's", "Godiva"],
        "Panadería Dulce": ["Cinnabon", "Krispy Kreme", "Panera Bread"],
        "Tartas y Pies": ["Marie Callender's", "Sara Lee", "Edwards"]
    };

    // Detectar el cambio en la categoría
    document.querySelectorAll('input[name="categoria"]').forEach((element) => {
        element.addEventListener('change', function() {
            const categoriaSeleccionada = this.value;
            const selectMarcas = document.getElementById('marca');

            // Limpiar el menú de marcas
            selectMarcas.innerHTML = '<option value="" selected disabled>Selecciona una marca</option>';

            // Llenar el menú de marcas según la categoría seleccionada
            marcasPorCategoria[categoriaSeleccionada].forEach(function(marca) {
                const option = document.createElement('option');
                option.value = marca;
                option.text = marca;
                selectMarcas.appendChild(option);
            });
        });
    });
</script>
