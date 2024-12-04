<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Añadir FontAwesome para el icono de check -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">



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
                                <label for="codeBarra" class="form-label">
                                    <i class="fas fa-barcode"></i> Código de Barra
                                </label>
                                <input type="text" class="form-control" id="codeBarra" name="codeBarra" maxlength="20" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El código de barra debe ser único y no superar los 20 caracteres.</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="nombre" class="form-label">
                                    <i class="fas fa-tag"></i> Nombre
                                </label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El nombre debe tener entre 3 y 50 caracteres y solo debe contener letras.</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="descripcion" class="form-label">
                                    <i class="fas fa-align-left"></i> Descripción
                                </label>
                                <textarea class="form-control" id="descripcion" name="descripcion" required></textarea>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">La descripción debe tener entre 10 y 200 caracteres y no debe contener etiquetas HTML.</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="categoria" class="form-label">
                                    <i class="fas fa-list-alt"></i> Categoría
                                </label>
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
                                <label for="marca" class="form-label">
                                    <i class="fas fa-industry"></i> Marca
                                </label>
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
                                <label for="precioVenta" class="form-label">
                                    <i class="fas fa-dollar-sign"></i> Precio Venta
                                </label>
                                <input type="number" step="0.01" class="form-control" id="precioVenta" name="precioVenta" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El precio de venta debe ser mayor a 0.</div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="descuento" class="form-label">
                                    <i class="fas fa-percentage"></i> Descuento
                                </label>
                                <input type="number" step="0.01" class="form-control" id="descuento" name="descuento" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El descuento debe estar entre 0 y 100.</div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="stock" class="form-label">
                                    <i class="fas fa-boxes"></i> Stock
                                </label>
                                <input type="number" class="form-control" id="stock" name="stock" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El stock debe ser un número entero positivo.</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="estatus" class="form-label">
                                    <i class="fas fa-toggle-on"></i> Estatus
                                </label>
                                <input type="text" class="form-control" id="estatus" name="estatus" value="A" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fechaIngreso" class="form-label">
                                    <i class="fas fa-calendar-alt"></i> Fecha Ingreso
                                </label>
                                <input type="date" class="form-control" id="fechaIngreso" name="fechaIngreso" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">La fecha de ingreso no puede ser futura.</div>
                            </div>
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Guardar
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal de Error -->
<div class="modal fade" id="modalErrorProducto" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center p-5 shadow-lg rounded-3 border-0">
            <div class="modal-body">
                <i class="fas fa-exclamation-circle text-danger mb-3" style="font-size: 4rem;"></i>
                <h5 class="fw-bold text-danger">¡Error al agregar producto!</h5>
                <p class="text-muted">Por favor, revisa los campos y corrige los errores antes de continuar.</p>
                <button type="button" class="btn btn-outline-primary mt-3" data-bs-dismiss="modal">Aceptar</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal "Agregando Producto" -->
<div class="modal fade" id="modalAgregandoProducto" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center p-4 shadow-lg border-0">
            <div class="modal-body">
                <i class="fas fa-spinner fa-spin text-primary mb-3" style="font-size: 4rem;"></i>
                <h5 class="fw-bold text-primary">Agregando Producto...</h5>
                <p class="text-muted">Por favor espera unos segundos.</p>
            </div>
        </div>
    </div>
</div>

<!-- Modal "Producto Agregado" -->
<div class="modal fade" id="modalProductoAgregado" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center p-4 shadow-lg border-0">
            <div class="modal-body">
                <i class="fas fa-check-circle text-success mb-3" style="font-size: 4rem;"></i>
                <h5 class="fw-bold text-success">¡Producto Agregado!</h5>
                <p class="text-muted">El producto se agregó correctamente.</p>
                <button type="button" class="btn btn-outline-primary mt-3" data-bs-dismiss="modal">Aceptar</button>
            </div>
        </div>
    </div>
</div>



<!-- JavaScript para validaciones de los campos -->

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const formAgregarProducto = document.getElementById("formAgregarProducto");

        // Validaciones individuales de campos
        const validaciones = {
            nombre: /^[a-zA-ZÀ-ÿÑñ\s]{3,50}$/,
            descripcion: /^[^<>]{10,200}$/,
            precioVenta: (valor) => valor > 0,
            descuento: (valor) => valor >= 0 && valor <= 100,
            stock: (valor) => valor >= 0 && Number.isInteger(Number(valor)),
            fechaIngreso: (fecha) => {
                const fechaActual = new Date().toISOString().split("T")[0];
                return fecha <= fechaActual;
            },
            categoria: (inputs) => Array.from(inputs).some((input) => input.checked),
            marca: (valor) => valor !== ""
        };

        // Validar un campo individualmente
        function validarCampo(campo, valor, inputs = null) {
            if (campo === "categoria") {
                return validaciones.categoria(inputs);
            }
            if (typeof validaciones[campo] === "function") {
                return validaciones[campo](valor);
            }
            return validaciones[campo]?.test(valor) || false;
        }

        // Manejar el estado visual de validación
        function setValidationState(element, isValid) {
            if (isValid) {
                element.classList.remove("is-invalid");
                element.classList.add("is-valid");
            } else {
                element.classList.remove("is-valid");
                element.classList.add("is-invalid");
            }
        }

        // Asignar validación en tiempo real a cada campo
        const nombreInput = document.getElementById("nombre");
        nombreInput.addEventListener("input", function () {
            setValidationState(nombreInput, validarCampo("nombre", nombreInput.value));
        });

        const descripcionInput = document.getElementById("descripcion");
        descripcionInput.addEventListener("input", function () {
            setValidationState(descripcionInput, validarCampo("descripcion", descripcionInput.value));
        });

        const precioVentaInput = document.getElementById("precioVenta");
        precioVentaInput.addEventListener("input", function () {
            setValidationState(precioVentaInput, validarCampo("precioVenta", precioVentaInput.value));
        });

        const descuentoInput = document.getElementById("descuento");
        descuentoInput.addEventListener("input", function () {
            setValidationState(descuentoInput, validarCampo("descuento", descuentoInput.value));
        });

        const stockInput = document.getElementById("stock");
        stockInput.addEventListener("input", function () {
            setValidationState(stockInput, validarCampo("stock", stockInput.value));
        });

        const fechaIngresoInput = document.getElementById("fechaIngreso");
        fechaIngresoInput.addEventListener("input", function () {
            setValidationState(fechaIngresoInput, validarCampo("fechaIngreso", fechaIngresoInput.value));
        });

        const categoriaInputs = document.querySelectorAll('input[name="categoria"]');
        categoriaInputs.forEach((input) =>
            input.addEventListener("change", function () {
                const isValid = validarCampo("categoria", null, categoriaInputs);
                categoriaInputs.forEach((radio) => setValidationState(radio.closest(".mb-3"), isValid));
            })
        );

        const marcaSelect = document.getElementById("marca");
        marcaSelect.addEventListener("change", function () {
            setValidationState(marcaSelect, validarCampo("marca", marcaSelect.value));
        });

        // Validación completa al enviar el formulario
        formAgregarProducto.addEventListener("submit", function (event) {
            event.preventDefault();
            let formularioValido = true;

            // Validar todos los campos
            const campos = [
                { id: "nombre", tipo: null },
                { id: "descripcion", tipo: null },
                { id: "precioVenta", tipo: null },
                { id: "descuento", tipo: null },
                { id: "stock", tipo: null },
                { id: "fechaIngreso", tipo: null },
                { id: "categoria", tipo: "categoria", inputs: categoriaInputs },
                { id: "marca", tipo: null }
            ];

            campos.forEach((campo) => {
                if (campo.tipo === "categoria") {
                    const isValid = validarCampo(campo.tipo, null, campo.inputs);
                    categoriaInputs.forEach((radio) => setValidationState(radio.closest(".mb-3"), isValid));
                    if (!isValid) formularioValido = false;
                } else {
                    const input = document.getElementById(campo.id);
                    const isValid = validarCampo(campo.id, input.value);
                    setValidationState(input, isValid);
                    if (!isValid) formularioValido = false;
                }
            });

            // Si todo es válido
            if (formularioValido) {
                const modalAgregando = new bootstrap.Modal(document.getElementById("modalAgregandoProducto"));
                const modalAgregado = new bootstrap.Modal(document.getElementById("modalProductoAgregado"));

                // Mostrar el modal "Agregando Producto"
                modalAgregando.show();

                // Simular proceso de guardado y mostrar el modal "Producto Agregado"
                setTimeout(function () {
                    modalAgregando.hide();
                    modalAgregado.show();

                    // Enviar el formulario real después de la confirmación
                    setTimeout(function () {
                        modalAgregado.hide();
                        formAgregarProducto.submit();
                    }, 2000); // 2 segundos para mostrar "Producto Agregado"
                }, 2000); // 2 segundos para "Agregando Producto"
            } else {
                // Mostrar modal de error si hay campos inválidos
                const modalError = new bootstrap.Modal(document.getElementById("modalErrorProducto"));
                modalError.show();
            }
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
        element.addEventListener('change', function () {
            const categoriaSeleccionada = this.value;
            const selectMarcas = document.getElementById('marca');

            // Limpiar el menú de marcas
            selectMarcas.innerHTML = '<option value="" selected disabled>Selecciona una marca</option>';

            // Llenar el menú de marcas según la categoría seleccionada
            marcasPorCategoria[categoriaSeleccionada].forEach(function (marca) {
                const option = document.createElement('option');
                option.value = marca;
                option.text = marca;
                selectMarcas.appendChild(option);
            });
        });
    });
</script>
