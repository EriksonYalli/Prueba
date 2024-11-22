<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El nombre debe tener entre 3 y 50 caracteres y solo debe contener letras.</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="apellido" class="form-label">Apellido</label>
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
                                <label for="tipoDocumento" class="form-label">Tipo de Documento</label>
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
                                <label for="numeroDocumento" class="form-label">Número de Documento</label>
                                <input type="text" class="form-control" id="numeroDocumento" name="numeroDocumento" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">El número de documento no es válido para el tipo seleccionado.</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fechaNacimiento" class="form-label">Fecha de Nacimiento</label>
                                <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" required>
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">Debe tener al menos 17 años de edad.</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="celular" class="form-label">Celular</label>
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
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email">
                                <div class="valid-feedback text-success"></div>
                                <div class="invalid-feedback">Debe ingresar un correo electrónico válido.</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="direccion" class="form-label">Dirección</label>
                                <input type="text" class="form-control" id="direccion" name="direccion">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fechaRegistro" class="form-label">Fecha de Registro</label>
                                <input type="datetime-local" class="form-control" id="fechaRegistro" name="fechaRegistro" value="<%= new java.sql.Timestamp(System.currentTimeMillis()).toString().substring(0, 16) %>" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="estatus" class="form-label">Estatus</label>
                                <input type="text" class="form-control" id="estatus" name="estatus" value="A" readonly>
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

<!-- Modal flotante para "Error al agregar cliente" -->
<div class="modal fade" id="modalErrorAgregarCliente" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center p-5 shadow-lg rounded-3 border-0">
            <div class="modal-body">
                <i class="fas fa-exclamation-circle text-danger mb-3" style="font-size: 4rem;"></i>
                <h5 class="fw-bold text-danger">Error al agregar cliente</h5>
                <p class="text-muted">Por favor, corrija los errores en el formulario antes de continuar.</p>
                <button type="button" class="btn btn-outline-primary mt-3" data-bs-dismiss="modal">Aceptar</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Validación para el campo "nombre"
        const nombreInput = document.getElementById('nombre');
        nombreInput.addEventListener('input', function () {
            const regexNombre = /^[a-zA-ZÀ-ÿ\s]{3,50}$/;
            const isValid = regexNombre.test(nombreInput.value);
            setValidationState(nombreInput, isValid);
        });

        // Validación para el campo "apellido"
        const apellidoInput = document.getElementById('apellido');
        apellidoInput.addEventListener('input', function () {
            const regexApellido = /^[a-zA-ZÀ-ÿ\s]{3,50}$/;
            const isValid = regexApellido.test(apellidoInput.value);
            setValidationState(apellidoInput, isValid);
        });

        // Validación para el campo "númeroDocumento" según "tipoDocumento"
        const tipoDocumentoSelect = document.getElementById('tipoDocumento');
        const numeroDocumentoInput = document.getElementById('numeroDocumento');
        tipoDocumentoSelect.addEventListener('change', function () {
            numeroDocumentoInput.value = '';
            setValidationState(numeroDocumentoInput, false);
        });
        numeroDocumentoInput.addEventListener('input', function () {
            let regexNumeroDocumento;
            switch (tipoDocumentoSelect.value) {
                case 'DNI':
                    regexNumeroDocumento = /^\d{8}$/;
                    break;
                case 'Carnet de Extranjería':
                    regexNumeroDocumento = /^\d{9}$/;
                    break;
                case 'Pasaporte':
                    regexNumeroDocumento = /^[a-zA-Z0-9]{6,12}$/;
                    break;
                case 'Permiso Temporal de Permanencia':
                case 'Carné de Identidad Diplomático':
                    regexNumeroDocumento = /^[a-zA-Z0-9]{6,15}$/;
                    break;
                default:
                    regexNumeroDocumento = /^$/;
            }
            const isValid = regexNumeroDocumento.test(numeroDocumentoInput.value);
            setValidationState(numeroDocumentoInput, isValid);
        });

        // Validación para el campo "fechaNacimiento" (mayor de 17 años)
        const fechaNacimientoInput = document.getElementById('fechaNacimiento');
        fechaNacimientoInput.addEventListener('input', function () {
            const fechaNacimiento = new Date(fechaNacimientoInput.value);
            const fechaLimite = new Date();
            fechaLimite.setFullYear(fechaLimite.getFullYear() - 17);
            const isValid = fechaNacimiento <= fechaLimite;
            setValidationState(fechaNacimientoInput, isValid);
        });

        // Validación para el campo "celular" según "código de país"
        const celularInput = document.getElementById('celular');
        const codigoPaisSelect = document.getElementById('codigoPais');
        const celularFeedback = document.getElementById('celularFeedback');
        codigoPaisSelect.addEventListener('change', function () {
            celularInput.value = '';
            setValidationState(celularInput, false);
            updateCelularFeedback();
        });
        celularInput.addEventListener('input', function () {
            let regexCelular;
            switch (codigoPaisSelect.value) {
                case '+51': // Perú
                    regexCelular = /^\d{9}$/;
                    celularFeedback.textContent = "El número de celular debe tener exactamente 9 dígitos para Perú.";
                    break;
                case '+52': // México
                    regexCelular = /^\d{10}$/;
                    celularFeedback.textContent = "El número de celular debe tener exactamente 10 dígitos para México.";
                    break;
                case '+53': // Cuba
                    regexCelular = /^\d{8}$/;
                    celularFeedback.textContent = "El número de celular debe tener exactamente 8 dígitos para Cuba.";
                    break;
                default:
                    regexCelular = /^$/;
                    celularFeedback.textContent = "";
            }
            const isValid = regexCelular.test(celularInput.value);
            setValidationState(celularInput, isValid);
        });

        // Validación para el campo "email"
        const emailInput = document.getElementById('email');
        emailInput.addEventListener('input', function () {
            const regexEmail = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            const isValid = regexEmail.test(emailInput.value);
            setValidationState(emailInput, isValid);
        });

        // Validación del formulario antes de enviar
        const formAgregarCliente = document.getElementById('formAgregarCliente');
        formAgregarCliente.addEventListener('submit', function (event) {
            if (!formAgregarCliente.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                const modalErrorAgregarCliente = new bootstrap.Modal(document.getElementById('modalErrorAgregarCliente'));
                modalErrorAgregarCliente.show();
            }
            formAgregarCliente.classList.add('was-validated');
        });

        // Funciones comunes para validaciones
        function setValidationState(element, isValid) {
            if (isValid) {
                element.classList.remove('is-invalid');
                element.classList.add('is-valid');
            } else {
                element.classList.remove('is-valid');
                element.classList.add('is-invalid');
            }
        }

        // Función para actualizar el mensaje de feedback del campo "celular"
        function updateCelularFeedback() {
            switch (codigoPaisSelect.value) {
                case '+51': // Perú
                    celularFeedback.textContent = "El número de celular debe tener exactamente 9 dígitos para Perú.";
                    break;
                case '+52': // México
                    celularFeedback.textContent = "El número de celular debe tener exactamente 10 dígitos para México.";
                    break;
                case '+53': // Cuba
                    celularFeedback.textContent = "El número de celular debe tener exactamente 8 dígitos para Cuba.";
                    break;
                default:
                    celularFeedback.textContent = "";
            }
        }
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
