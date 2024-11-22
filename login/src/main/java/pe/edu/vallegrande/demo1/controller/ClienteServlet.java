package pe.edu.vallegrande.demo1.controller;

import org.json.JSONObject;
import pe.edu.vallegrande.demo1.dto.ClienteDTO;
import pe.edu.vallegrande.demo1.dto.ProductoDTO;
import pe.edu.vallegrande.demo1.service.ClienteSERVICE;
import pe.edu.vallegrande.demo1.service.ProductoSERVICE;

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
    private static final String LISTAR = "index.jsp?page=listarCliente";


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

            case "listarCliente":
                response.sendRedirect("index.jsp?page=listarCliente");
                break;

            case "Inactivos":
                response.sendRedirect("index.jsp?page=listarInactivos");
                break;

            case "buscarCliente":
                System.out.println("buscandoCliente");
                String dni = request.getParameter("dni");

                // Busca al cliente utilizando el servicio
                ClienteDTO cliente = ClienteSERVICE.buscarCliente(dni);

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                // Crea la respuesta en JSON
                JSONObject jsonResponse = new JSONObject();

                if (cliente != null) {
                    jsonResponse.put("nombre", cliente.getNombre());
                    jsonResponse.put("apellido", cliente.getApellido());
                    response.getWriter().write(jsonResponse.toString());
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    jsonResponse.put("message", "Cliente no encontrado");
                    response.getWriter().write(jsonResponse.toString());
                }
                break;

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
            return "index.jsp?page=editarCliente";
        } else {
            request.setAttribute("error", "Cliente no encontrado");
            return LISTAR;
        }
    }

    private String eliminarClienteID(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        clienteSERVICE.eliminarClienteID(id);
        return LISTAR;
    }

    private String restaurarClienteID(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        clienteSERVICE.restaurarClienteID(id); // Llama al servicio para restaurar (activar) el cliente
        return "index.jsp?page=listarInactivos";
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("agregarCliente".equals(action)) {
            agregarCliente(request);
            response.sendRedirect(LISTAR); // Redirige a la misma página después de agregar

        } else if ("modificarCliente".equals(action)) {
            modificarCliente(request);
            response.sendRedirect(LISTAR);

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
        return "index.jsp?page=ListarCliente";
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
        }return "";
    }




}
