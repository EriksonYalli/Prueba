<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.0/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.0/dist/sweetalert2.all.min.js"></script>
<style>
    .modal-content {
        border-radius: 15px;
        overflow: hidden;
    }

    .btn-danger {
        background: #ff4d4d;
        border: none;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .btn-danger:hover {
        background: #ff1a1a;
        transform: scale(1.05);
    }

    .animate-icon {
        animation: bounce 1s infinite;
    }

    @keyframes bounce {
        0%, 100% {
            transform: scale(1);
        }
        50% {
            transform: scale(1.2);
        }
    }
</style>


<!-- Modal de Bootstrap para agregar cliente -->

<div class="modal fade" id="modalAgregarCliente" tabindex="-1" aria-labelledby="modalAgregarClienteLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title" id="modalAgregarClienteLabel">Agregar Cliente</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="formAgregarCliente" action="cliente" method="POST" novalidate>
                    <input type="hidden" name="action" value="agregarCliente">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="nombre" class="form-label">
                                    <i class="fas fa-user me-2"></i>Nombre
                                </label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El nombre debe tener entre 3 y 50 caracteres y solo debe contener letras.</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="apellido" class="form-label">
                                    <i class="fas fa-user me-2"></i>Apellido
                                </label>
                                <input type="text" class="form-control" id="apellido" name="apellido" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El apellido debe tener entre 3 y 50 caracteres y solo debe contener letras.</div>
                            </div>
                        </div>
                    </div>

                    <!-- Tipo de Documento y Número de Documento -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="tipoDocumento" class="form-label">
                                    <i class="fas fa-id-card me-2"></i>Tipo de Documento
                                </label>

                                <select class="form-select" id="tipoDocumento" name="tipoDocumento" required>
                                    <option value="" selected disabled>Seleccione</option>
                                    <option value="DNI">DNI</option>
                                    <option value="Carnet de Extranjería">Carnet de Extranjería</option>
                                    <option value="Pasaporte">Pasaporte</option>
                                    <option value="Permiso Temporal de Permanencia">Permiso Temporal de Permanencia</option>
                                    <option value="Carné de Identidad Diplomático">Carné de Identidad Diplomático</option>
                                </select>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">Debe seleccionar un tipo de documento.</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="numeroDocumento" class="form-label">
                                    <i class="fas fa-key me-2"></i>Número de Documento
                                </label>
                                <input type="text" class="form-control" id="numeroDocumento" name="numeroDocumento" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El número de documento no es válido para el tipo seleccionado.</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fechaNacimiento" class="form-label">
                                    <i class="fas fa-calendar-alt me-2"></i>Fecha de Nacimiento
                                </label>
                                <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">Debe tener al menos 17 años de edad.</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="celular" class="form-label">
                                    <i class="fas fa-phone me-2"></i>Celular
                                </label>
                                <div class="input-group">
                                    <select class="form-select" id="codigoPais" name="codigoPais" required>
                                        <option value="+51" selected><span class="fi fi-pe"></span> 🇵🇪 +51</option>
                                        <option value="+52"><span class="fi fi-mx"></span> 🇲🇽 +52</option>
                                        <option value="+53"><span class="fi fi-cu"></span> 🇨🇺 +53</option>
                                    </select>
                                    <input type="text" class="form-control" id="celular" name="celular" required>
                                </div>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback" id="celularFeedback">El número de celular no es válido para el país seleccionado.</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope me-2"></i>Email
                                </label>
                                <input type="email" class="form-control" id="email" name="email">
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">Debe ingresar un correo electrónico válido.</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="direccion" class="form-label">
                                    <i class="fas fa-map-marker-alt me-2"></i>Dirección
                                </label>

                                <input type="text" class="form-control" id="direccion" name="direccion">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fechaRegistro" class="form-label">
                                    <i class="fas fa-clock me-2"></i>Fecha de Registro
                                </label>

                                <input type="datetime-local" class="form-control" id="fechaRegistro" name="fechaRegistro" value="<%= new java.sql.Timestamp(System.currentTimeMillis()).toString().substring(0, 16) %>" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="estatus" class="form-label">
                                    <i class="fas fa-info-circle me-2"></i>Estatus
                                </label>
                                <input type="text" class="form-control" id="estatus" name="estatus" value="A" readonly>
                            </div>
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Guardar
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<script>
    document.addEventListener('DOMContentLoaded', function () {
        const formAgregarCliente = document.getElementById('formAgregarCliente');

        // Validaciones individuales de campos
        const validaciones = {
            nombre: /^[a-zA-ZÀ-ÿ\s]{3,50}$/, // Solo letras, entre 3 y 50 caracteres
            apellido: /^[a-zA-ZÀ-ÿ\s]{3,50}$/, // Solo letras, entre 3 y 50 caracteres
            numeroDocumento: {
                DNI: /^\d{8}$/,
                "Carnet de Extranjería": /^\d{9}$/,
                Pasaporte: /^[a-zA-Z0-9]{6,12}$/,
                "Permiso Temporal de Permanencia": /^[a-zA-Z0-9]{6,15}$/,
                "Carné de Identidad Diplomático": /^[a-zA-Z0-9]{6,15}$/
            },
            celular: {
                "+51": /^\d{9}$/, // Perú
                "+52": /^\d{10}$/, // México
                "+53": /^\d{8}$/ // Cuba
            },
            email: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/, // Formato de correo
            fechaNacimiento: function (fecha) {
                const fechaNacimiento = new Date(fecha);
                const fechaLimite = new Date();
                fechaLimite.setFullYear(fechaLimite.getFullYear() - 17);
                return fechaNacimiento <= fechaLimite; // Mayor de 17 años
            }
        };

        // Función para validar un campo individual
        function validarCampo(campo, valor, tipo = null) {
            if (campo === "numeroDocumento" && tipo) {
                const regex = validaciones.numeroDocumento[tipo];
                return regex ? regex.test(valor) : false;
            }
            if (campo === "celular" && tipo) {
                const regex = validaciones.celular[tipo];
                return regex ? regex.test(valor) : false;
            }
            if (campo === "fechaNacimiento") {
                return validaciones.fechaNacimiento(valor);
            }
            const regex = validaciones[campo];
            return regex ? regex.test(valor) : false;
        }

        // Función para manejar el estado de validación visual
        function setValidationState(element, isValid) {
            if (isValid) {
                element.classList.remove("is-invalid");
                element.classList.add("is-valid");
            } else {
                element.classList.remove("is-valid");
                element.classList.add("is-invalid");
            }
        }

        // Validación en tiempo real de los campos
        const nombreInput = document.getElementById("nombre");
        nombreInput.addEventListener("input", function () {
            setValidationState(nombreInput, validarCampo("nombre", nombreInput.value));
        });

        const apellidoInput = document.getElementById("apellido");
        apellidoInput.addEventListener("input", function () {
            setValidationState(apellidoInput, validarCampo("apellido", apellidoInput.value));
        });

        const tipoDocumentoSelect = document.getElementById("tipoDocumento");
        const numeroDocumentoInput = document.getElementById("numeroDocumento");
        tipoDocumentoSelect.addEventListener("change", function () {
            numeroDocumentoInput.value = '';
            setValidationState(numeroDocumentoInput, false);
        });
        numeroDocumentoInput.addEventListener("input", function () {
            const tipoDocumento = tipoDocumentoSelect.value;
            setValidationState(
                numeroDocumentoInput,
                validarCampo("numeroDocumento", numeroDocumentoInput.value, tipoDocumento)
            );
        });

        const codigoPaisSelect = document.getElementById("codigoPais");
        const celularInput = document.getElementById("celular");
        codigoPaisSelect.addEventListener("change", function () {
            celularInput.value = '';
            setValidationState(celularInput, false);
        });
        celularInput.addEventListener("input", function () {
            const codigoPais = codigoPaisSelect.value;
            setValidationState(celularInput, validarCampo("celular", celularInput.value, codigoPais));
        });

        const emailInput = document.getElementById("email");
        emailInput.addEventListener("input", function () {
            setValidationState(emailInput, validarCampo("email", emailInput.value));
        });

        const fechaNacimientoInput = document.getElementById("fechaNacimiento");
        fechaNacimientoInput.addEventListener("input", function () {
            setValidationState(
                fechaNacimientoInput,
                validarCampo("fechaNacimiento", fechaNacimientoInput.value)
            );
        });

        // Validación completa del formulario antes de enviar
        formAgregarCliente.addEventListener("submit", function (event) {
            let formularioValido = true;

            // Validar cada campo antes de enviar
            const campos = [
                { id: "nombre", tipo: null },
                { id: "apellido", tipo: null },
                { id: "numeroDocumento", tipo: tipoDocumentoSelect.value },
                { id: "celular", tipo: codigoPaisSelect.value },
                { id: "email", tipo: null },
                { id: "fechaNacimiento", tipo: null }
            ];

            campos.forEach((campo) => {
                const input = document.getElementById(campo.id);
                const valido = validarCampo(campo.id, input.value, campo.tipo);
                setValidationState(input, valido);
                if (!valido) formularioValido = false;
            });

            // Si todos los campos son válidos, mostrar la alerta de éxito
            if (formularioValido) {
                event.preventDefault(); // Evitar que se envíe el formulario automáticamente

                // Alerta de SweetAlert2 para confirmar que el cliente fue agregado
                Swal.fire({
                    icon: 'success',
                    title: '¡Cliente agregado correctamente!',
                    text: 'El cliente ha sido registrado en el sistema.',
                    confirmButtonText: 'Aceptar'
                }).then(() => {
                    // Si el usuario hace clic en "Aceptar", se envía el formulario
                    formAgregarCliente.submit(); // Aquí se enviaría el formulario
                });
            } else {
                event.preventDefault();
                // Alerta para completar los campos si algo no es válido
                Swal.fire({
                    icon: 'warning',
                    title: '¡Complete todos los campos!',
                    text: 'Por favor, revisa los campos del formulario antes de enviarlo.',
                    confirmButtonText: 'Aceptar'
                });
            }
        });
    });
</script>





<style>
    .is-valid {
        border-color: #28a745 !important;
    }

    .is-invalid {
        border-color: #dc3545 !important;
    }

    .text-success {
        color: #28a745 !important;
    }

    .modal-backdrop {
        background-color: rgba(0, 0, 0, 0.5);
    }
</style>
