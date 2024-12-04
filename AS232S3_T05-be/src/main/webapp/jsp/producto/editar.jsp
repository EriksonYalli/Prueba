<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.0/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.0/dist/sweetalert2.all.min.js"></script>

<div class="container-fluid" id="container">
    <!-- Título de la página -->
    <h1 class="text-center">Editar Producto</h1>

    <!-- Formulario para editar un producto -->
    <form id="formEditarProducto" action="producto" method="POST">
        <!-- ID del producto (campo oculto) -->
        <input type="hidden" name="id" value="${pepito123.productoID}">

        <div class="row">
            <!-- Campo de Nombre -->
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" value="${pepito123.nombre}" required>
                    <div class="valid-feedback text-success"></div>
                    <div class="invalid-feedback">El nombre debe tener entre 3 y 50 caracteres y solo debe contener letras.</div>
                </div>
            </div>

            <!-- Campo de Descripción -->
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="descripcion" class="form-label">Descripción</label>
                    <textarea class="form-control" id="descripcion" name="descripcion" required>${pepito123.descripcion}</textarea>
                    <div class="valid-feedback text-success"></div>
                    <div class="invalid-feedback">La descripción debe tener entre 10 y 200 caracteres y no debe contener etiquetas HTML.</div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Campo de Categoría (con radio buttons) -->
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="categoria" class="form-label">Categoría</label>
                    <div>
                        <input type="radio" id="tortas" name="categoria" value="Tortas y Pasteles"
                        ${pepito123.categoria == 'Tortas y Pasteles' ? 'checked' : ''} required>
                        <label for="tortas">Tortas y Pasteles</label>
                    </div>
                    <div>
                        <input type="radio" id="galletas" name="categoria" value="Galletas"
                        ${pepito123.categoria == 'Galletas' ? 'checked' : ''} required>
                        <label for="galletas">Galletas</label>
                    </div>
                    <div>
                        <input type="radio" id="cupcakes" name="categoria" value="Cupcakes y Muffins"
                        ${pepito123.categoria == 'Cupcakes y Muffins' ? 'checked' : ''} required>
                        <label for="cupcakes">Cupcakes y Muffins</label>
                    </div>
                    <div>
                        <input type="radio" id="brownies" name="categoria" value="Brownies y Barras"
                        ${pepito123.categoria == 'Brownies y Barras' ? 'checked' : ''} required>
                        <label for="brownies">Brownies y Barras</label>
                    </div>
                    <div>
                        <input type="radio" id="macarons" name="categoria" value="Macarons y Delicias Francesas"
                        ${pepito123.categoria == 'Macarons y Delicias Francesas' ? 'checked' : ''} required>
                        <label for="macarons">Macarons y Delicias Francesas</label>
                    </div>
                    <div>
                        <input type="radio" id="postres" name="categoria" value="Postres y Dulces"
                        ${pepito123.categoria == 'Postres y Dulces' ? 'checked' : ''} required>
                        <label for="postres">Postres y Dulces</label>
                    </div>
                    <div>
                        <input type="radio" id="panaderia" name="categoria" value="Panadería Dulce"
                        ${pepito123.categoria == 'Panadería Dulce' ? 'checked' : ''} required>
                        <label for="panaderia">Panadería Dulce</label>
                    </div>
                    <div>
                        <input type="radio" id="tartas" name="categoria" value="Tartas y Pies"
                        ${pepito123.categoria == 'Tartas y Pies' ? 'checked' : ''} required>
                        <label for="tartas">Tartas y Pies</label>
                    </div>
                    <div class="valid-feedback text-success"></div>
                    <div class="invalid-feedback">Debe seleccionar una categoría.</div>
                </div>
            </div>

            <!-- Campo de Marca (con select dropdown) -->
            <div class="col-md-6">
                <div class="mb-4">
                    <label for="marca" class="form-label">Marca</label>
                    <select class="form-select" id="marca" name="marca" required>
                        <option value="" disabled>Selecciona una marca</option>
                        <!-- Opciones de marca a cargar mediante JavaScript según la categoría seleccionada -->
                    </select>
                    <div class="valid-feedback text-success"></div>
                    <div class="invalid-feedback">Debe seleccionar una marca.</div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Campo de Precio Venta -->
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="precioVenta" class="form-label">Precio Venta</label>
                    <input type="number" step="0.01" class="form-control" id="precioVenta" name="precioVenta"
                           value="${pepito123.precioVenta}" required>
                    <div class="valid-feedback text-success"></div>
                    <div class="invalid-feedback">El precio de venta debe ser mayor a 0.</div>
                </div>
            </div>

            <!-- Campo de Descuento -->
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="descuento" class="form-label">Descuento</label>
                    <input type="number" step="0.01" class="form-control" id="descuento" name="descuento"
                           value="${pepito123.descuento}" required>
                    <div class="valid-feedback text-success"></div>
                    <div class="invalid-feedback">El descuento debe estar entre 0 y 100.</div>
                </div>
            </div>

            <!-- Campo de Stock -->
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="stock" class="form-label">Stock</label>
                    <input type="number" class="form-control" id="stock" name="stock" value="${pepito123.stock}" required>
                    <div class="valid-feedback text-success"></div>
                    <div class="invalid-feedback">El stock debe ser un número entero positivo.</div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Campo de Estatus (solo lectura) -->
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="estatus" class="form-label">Estatus</label>
                    <input type="text" class="form-control" id="estatus" name="estatus" value="${pepito123.estatus}" readonly>
                </div>
            </div>

            <!-- Campo de Fecha de Ingreso -->
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="fechaIngreso" class="form-label">Fecha Ingreso</label>
                    <input type="date" class="form-control" id="fechaIngreso" name="fechaIngreso"
                           value="${pepito123.fechaIngreso}" required>
                    <div class="valid-feedback text-success"></div>
                    <div class="invalid-feedback">La fecha de ingreso no puede ser futura.</div>
                </div>
            </div>
        </div>
        <input type="hidden" name="action" value="actualizar">
        <!-- Botón para actualizar el producto -->
        <button type="submit" id="btnActualizarProducto" name="action" value="actualizar" class="btn" style="background-color: #385c42; color: #f9f9f9">Actualizar Producto</button>
    </form>
</div>



<!-- JavaScript para validaciones de los campos y mostrar modales -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const formEditarProducto = document.getElementById("formEditarProducto");

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

                function validarCampo(campo, valor, inputs = null) {
                    if (campo === "categoria") {
                        return validaciones.categoria(inputs);
                    }
                    if (typeof validaciones[campo] === "function") {
                        return validaciones[campo](valor);
                    }
                    return validaciones[campo]?.test(valor) || false;
                }

                function setValidationState(element, isValid) {
                    if (isValid) {
                        element.classList.remove("is-invalid");
                        element.classList.add("is-valid");
                    } else {
                        element.classList.remove("is-valid");
                        element.classList.add("is-invalid");
                    }
                }

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

                formEditarProducto.addEventListener("submit", function (event) {
                    event.preventDefault();
                    let formularioValido = true;

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
                    if (formularioValido) {
                        // Mostrar la alerta de confirmación con 2 opciones
                        Swal.fire({
                            title: '¡Éxito!',
                            text: '¿Seguro que deseas actualizar el producto?',
                            icon: 'question',
                            showCancelButton: true,  // Mostrar el botón de Cancelar
                            confirmButtonText: 'Aceptar',
                            cancelButtonText: 'Cancelar',
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            timer: 15000,  // Más tiempo para mostrar la alerta (15 segundos)
                            reverseButtons: true  // Coloca el botón de cancelar a la izquierda
                        }).then((result) => {
                            // Si el usuario hace clic en "Aceptar"
                            if (result.isConfirmed) {
                                formEditarProducto.submit();  // Enviar el formulario
                                Swal.fire({
                                    title: '¡Producto actualizado!',
                                    text: 'El producto ha sido actualizado correctamente.',
                                    icon: 'success',
                                    confirmButtonText: 'Aceptar',
                                    timer: 5000  // Duración de la alerta de éxito
                                });
                            } else {
                                // Si el usuario hace clic en "Cancelar", no hacer nada
                                Swal.fire({
                                    title: 'Actualización cancelada',
                                    text: 'La actualización del producto ha sido cancelada.',
                                    icon: 'info',
                                    confirmButtonText: 'Aceptar'
                                });
                            }
                        });
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
</style>



<!-- JavaScript para filtrar marcas según la categoría seleccionada y preseleccionar la marca -->
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

    // Al cargar la página, establecer la categoría y marca preseleccionada
    document.addEventListener('DOMContentLoaded', function() {
        const categoriaSeleccionada = "${pepito123.categoria}";
        const marcaSeleccionada = "${pepito123.marca}";
        const selectMarcas = document.getElementById('marca');

        // Marcar la categoría seleccionada
        document.querySelectorAll('input[name="categoria"]').forEach((element) => {
            if (element.value === categoriaSeleccionada) {
                element.checked = true;

                // Llenar el menú de marcas según la categoría preseleccionada
                marcasPorCategoria[categoriaSeleccionada].forEach(function(marca) {
                    const option = document.createElement('option');
                    option.value = marca;
                    option.text = marca;

                    // Seleccionar la marca en el menú si coincide con la marca del producto
                    if (marca === marcaSeleccionada) {
                        option.selected = true;
                    }
                    selectMarcas.appendChild(option);
                });
            }
        });
    });

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