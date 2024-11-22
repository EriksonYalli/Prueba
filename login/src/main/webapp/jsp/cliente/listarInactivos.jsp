<%@ page import="pe.edu.vallegrande.demo1.service.ClienteSERVICE" %>
<%@ page import="pe.edu.vallegrande.demo1.dto.ClienteDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid" id="container">
  <!-- Título de la página -->
  <h1 class="text-center my-4">Listado de Clientes Inactivos</h1>


  <!-- Botón para agregar un nuevo cliente -->
  <div class="d-flex justify-content-end mb-3">
    <a href="cliente?action=Activos" class="btn btn-success ms-2">
      Activos <i class="bi bi-person-check"></i>
    </a>
  </div>



  <!-- Tabla de clientes -->
  <div class="table-responsive">
    <table class="table table-bordered table-striped text-center">
      <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Apellido</th>
        <th>Tipo Documento</th>
        <th>Número Documento</th>
        <th>Fecha Nacimiento</th>
        <th>Celular</th>
        <th>Email</th>
        <th>Dirección</th>
        <th>Fecha Registro</th>
        <th>Estatus</th>
        <th>Acción</th>
      </tr>
      </thead>
      <tbody>
      <%-- Generación dinámica de la lista de clientes --%>
      <%
        ClienteSERVICE clienteService = new ClienteSERVICE();
        List<ClienteDTO> clientes = clienteService.listarClientesInactivos();
        for (ClienteDTO cliente : clientes) {
      %>
      <tr>
        <td><%= cliente.getClienteID() %></td>
        <td><%= cliente.getNombre() %></td>
        <td><%= cliente.getApellido() %></td>
        <td><%= cliente.getTipoDocumento() %></td>
        <td><%= cliente.getNumeroDocumento() %></td>
        <td><%= cliente.getFechaNacimiento() %></td>
        <td><%= cliente.getCelular() %></td>
        <td><%= cliente.getEmail() %></td>
        <td><%= cliente.getDireccion() %></td>
        <td><%= cliente.getFechaRegistro() %></td>
        <td><%= cliente.getEstatus() %></td>
        <td>


          <a href="cliente?action=restaurar&id=<%= cliente.getClienteID() %>" class="btn btn-info btn-sm" title="Restaurar">
            <i class="bi bi-arrow-clockwise"></i>
          </a>
        </td>
      </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </div>
</div>
