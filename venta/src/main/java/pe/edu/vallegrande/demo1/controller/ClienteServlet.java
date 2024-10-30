package pe.edu.vallegrande.demo1.controller;

import pe.edu.vallegrande.demo1.dto.ClienteDTO;
import pe.edu.vallegrande.demo1.service.ClienteSERVICE;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet("/cliente")
public class ClienteServlet extends HttpServlet {

    private ClienteSERVICE clienteSERVICE = new ClienteSERVICE();
    private static final String LISTAR = "jsp/cliente.jsp";


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "listar":
                request.getRequestDispatcher(LISTAR).forward(request, response);
                break;

            case "editar":
                String accesoEditar = editarPorId(request);
                request.getRequestDispatcher(accesoEditar).forward(request, response);
                break;

            case "eliminar":
                String eliminar = eliminarClienteID(request);
                request.getRequestDispatcher(eliminar).forward(request, response);

                break;

            case "restaurar":
                String restaurar = restaurarClienteID(request);
                request.getRequestDispatcher(restaurar).forward(request, response);
                return;

            default:
                request.getRequestDispatcher(LISTAR).forward(request, response);
                break;
        }
    }



    private String editarPorId(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        ClienteDTO cliente = clienteSERVICE.editarPorId(id);
        if (cliente != null) {
            request.setAttribute("pepito123", cliente);
            return "jsp/cliente.jsp?page=editar";
        } else {
            request.setAttribute("error", "Cliente no encontrado");
            return LISTAR;
        }
    }

    private String eliminarClienteID(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        clienteSERVICE.eliminarClienteID(id);
        return "jsp/cliente.jsp?page=cliente";
    }

    private String restaurarClienteID(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        clienteSERVICE.restaurarClienteID(id); // Llama al servicio para restaurar (activar) el cliente
        return "jsp/cliente.jsp?page=cliente";
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("agregarCliente".equals(action)) {
            agregarCliente(request);
            response.sendRedirect("cliente?action=listar&page=cliente"); // Redirige a la misma página después de agregar

        } else if ("modificarCliente".equals(action)) {
            modificarCliente(request);
            response.sendRedirect("cliente?action=listar&page=cliente");

        }


    }

    private String agregarCliente(HttpServletRequest request) {
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String tipoDocumento = request.getParameter("tipoDocumento");
        String numeroDocumento = request.getParameter("numeroDocumento");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String celular = request.getParameter("celular");
        String email = request.getParameter("email");
        String direccion = request.getParameter("direccion");
        String estatus = request.getParameter("estatus");

        // Obtener y formatear la fecha actual
        String fechaRegistro = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

        ClienteDTO nuevoCliente = new ClienteDTO(0, nombre, apellido, tipoDocumento, numeroDocumento, fechaNacimiento, celular, email, direccion, fechaRegistro, estatus);
        clienteSERVICE.agregarCliente(nuevoCliente);
        return LISTAR;
    }

    private String modificarCliente(HttpServletRequest request) {
        ClienteDTO cliente = new ClienteDTO();
        try {
            cliente.setClienteID(Integer.parseInt(request.getParameter("idcliente")));
            cliente.setNombre(request.getParameter("nombre"));
            cliente.setApellido(request.getParameter("apellido"));
            cliente.setTipoDocumento(request.getParameter("tipoDocumento"));
            cliente.setNumeroDocumento(request.getParameter("numeroDocumento"));
            cliente.setFechaNacimiento(request.getParameter("fechaNacimiento"));
            cliente.setCelular(request.getParameter("celular"));
            cliente.setEmail(request.getParameter("email"));
            cliente.setDireccion(request.getParameter("direccion"));

            clienteSERVICE.actualizarCliente(cliente);

            System.out.println("Cliente actualizado exitosamente.");
        } catch (Exception e) {
            e.printStackTrace();
        }return "jsp/cliente.jsp";
    }




}
