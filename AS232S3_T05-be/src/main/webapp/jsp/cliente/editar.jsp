<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid" id="container">
    <h1 class="text-center">Editar Cliente</h1>
    <!-- Formulario para editar un Cliente -->
    <form action="cliente" method="post">
        <!-- Campo oculto para el ID del cliente -->
        <input type="hidden" name="idcliente" value="${pepito123.clienteID}">

        <!-- Nombre y Apellido -->
        <div class="row">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" name="nombre" value="${pepito123.nombre}" required>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="apellido" class="form-label">Apellido</label>
                    <input type="text" class="form-control" name="apellido" value="${pepito123.apellido}" required>
                </div>
            </div>
        </div>

        <!-- Tipo de Documento y Número de Documento -->
        <div class="row">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="tipoDocumento" class="form-label">Tipo de Documento</label>
                    <select class="form-select" name="tipoDocumento" required>
                        <option value="">Seleccione</option>
                        <option value="DNI" ${pepito123.tipoDocumento == 'DNI' ? 'selected' : ''}>DNI</option>
                        <option value="Carnet de Extranjería" ${pepito123.tipoDocumento == 'Carnet de Extranjería' ? 'selected' : ''}>Carnet de Extranjería</option>
                        <option value="Pasaporte" ${pepito123.tipoDocumento == 'Pasaporte' ? 'selected' : ''}>Pasaporte</option>
                        <option value="Permiso Temporal de Permanencia" ${pepito123.tipoDocumento == 'Permiso Temporal de Permanencia' ? 'selected' : ''}>Permiso Temporal de Permanencia</option>
                        <option value="Carné de Identidad Diplomático" ${pepito123.tipoDocumento == 'Carné de Identidad Diplomático' ? 'selected' : ''}>Carné de Identidad Diplomático</option>
                    </select>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="numeroDocumento" class="form-label">Número de Documento</label>
                    <input type="text" class="form-control" name="numeroDocumento" value="${pepito123.numeroDocumento}" required>
                </div>
            </div>
        </div>

        <!-- Fecha de Nacimiento y Celular -->
        <div class="row">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="fechaNacimiento" class="form-label">Fecha de Nacimiento</label>
                    <input type="date" class="form-control" name="fechaNacimiento" value="${pepito123.fechaNacimiento}">
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="celular" class="form-label">Celular</label>
                    <input type="text" class="form-control" name="celular" value="${pepito123.celular}">
                </div>
            </div>
        </div>

        <!-- Email y Dirección -->
        <div class="row">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" name="email" value="${pepito123.email}">
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="direccion" class="form-label">Dirección</label>
                    <input type="text" class="form-control" name="direccion" value="${pepito123.direccion}">
                </div>
            </div>
        </div>

        <!-- Botón para actualizar el cliente -->
        <div class="text-center">
            <button type="submit" name="action" value="modificarCliente" class="btn" style="background-color: #385c42; color: #f9f9f9">Actualizar Cliente</button>
        </div>
    </form>
</div>
