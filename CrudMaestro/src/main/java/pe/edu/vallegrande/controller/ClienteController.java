package pe.edu.vallegrande.controller;

import pe.edu.vallegrande.Dto.ClienteDto;
import pe.edu.vallegrande.service.ClienteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@WebServlet({"/clientes", "/clientesjuridicos", "/clientesinactivos", "/clientesjuridicosinactivos", "/agregarCliente",
        "/editarCliente", "/editarClienteJuridico", "/actualizarCliente", "/actualizarClienteJuridico","/eliminarCliente", "/reactivarCliente"})
public class ClienteController extends HttpServlet {

    private final ClienteService clienteService = new ClienteService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/clientes":
                listarPersonasNaturalesActivas(request, response);
                break;
            case "/clientesjuridicos":
                listarPersonasJuridicasActivas(request, response);
                break;
            case "/clientesinactivos":
                listarPersonasNaturalesInactivos(request, response);
                break;
            case "/clientesjuridicosinactivos":
                listarClientesJuridicosInactivos(request, response);
                break;
            case "/agregarCliente":
                mostrarFormularioAgregar(request, response);
                break;
            case "/editarCliente":
                mostrarFormularioEditarNatural(request, response);
                break;
            case "/editarClienteJuridico":
                mostrarFormularioEditarJuridico(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/agregarCliente":
                agregarCliente(request, response);
                break;
            case "/actualizarCliente":
                actualizarClienteNatural(request, response);
                break;
            case "/actualizarClienteJuridico":
                actualizarClienteJuridico(request, response);
                break;
            case "/eliminarCliente":
                eliminarCliente(request, response);
                break;
            case "/reactivarCliente":
                reactivarCliente(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void listarPersonasNaturalesActivas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ClienteDto> personasNaturales = clienteService.listarPersonasNaturalesActivas();
        request.setAttribute("personasNaturales", personasNaturales);
        request.getRequestDispatcher("personasNaturales.jsp").forward(request, response);
    }

    private void listarPersonasJuridicasActivas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ClienteDto> personasJuridicas = clienteService.listarPersonasJuridicasActivas();
        request.setAttribute("personasJuridicas", personasJuridicas);
        request.getRequestDispatcher("personasJuridicas.jsp").forward(request, response);
    }

    private void listarPersonasNaturalesInactivos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ClienteDto> clientesInactivos = clienteService.listarPersonasNaturalesInactivas();
        request.setAttribute("clientesInactivos", clientesInactivos);
        request.getRequestDispatcher("clientesInactivos.jsp").forward(request, response);
    }

    private void listarClientesJuridicosInactivos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ClienteDto> clientesJuridicosInactivos = clienteService.listarPersonasJuridicasInactivas();
        request.setAttribute("clientesJuridicosInactivos", clientesJuridicosInactivos);
        request.getRequestDispatcher("clientesJuridicosInactivos.jsp").forward(request, response);
    }

    private void mostrarFormularioAgregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("agregarCliente.jsp").forward(request, response);
    }



    protected void agregarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipoCliente = request.getParameter("typePerson");
        ClienteDto nuevoCliente = new ClienteDto();
        boolean agregadoExitosamente = false;

        try {
            if ("NATURAL".equalsIgnoreCase(tipoCliente)) {
                // Asignar datos de persona natural
                nuevoCliente.setTypePerson("NATURAL");
                nuevoCliente.setName(request.getParameter("name"));
                nuevoCliente.setLastName(request.getParameter("lastName"));
                nuevoCliente.setEmail(request.getParameter("persona_email"));
                nuevoCliente.setDocumentType(request.getParameter("documentType"));
                nuevoCliente.setDocumentNumber(request.getParameter("documentNumber"));
                nuevoCliente.setBirthdate(LocalDate.parse(request.getParameter("birthdate")));
                nuevoCliente.setPhone(request.getParameter("persona_phone"));
                nuevoCliente.setAddress(request.getParameter("persona_address"));
                nuevoCliente.setStatus(request.getParameter("persona_status"));

                agregadoExitosamente = clienteService.agregarPersonaNatural(nuevoCliente);

            } else if ("JURIDICA".equalsIgnoreCase(tipoCliente)) {
                // Asignar datos de persona jurídica
                nuevoCliente.setTypePerson("JURIDICA");
                nuevoCliente.setCompanyName(request.getParameter("companyName"));
                nuevoCliente.setRuc(request.getParameter("ruc"));
                nuevoCliente.setEmail(request.getParameter("juridica_email"));
                nuevoCliente.setAddress(request.getParameter("juridica_address"));
                nuevoCliente.setPhone(request.getParameter("juridica_phone"));
                nuevoCliente.setStatus(request.getParameter("juridica_status"));

                agregadoExitosamente = clienteService.agregarPersonaJuridica(nuevoCliente);
            }

            if (agregadoExitosamente) {
                response.sendRedirect("clientes");
            } else {
                request.setAttribute("error", "Error al agregar cliente.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void mostrarFormularioEditarNatural(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Optional<ClienteDto> clienteOpt = clienteService.obtenerClientePorId(id);

            if (clienteOpt.isPresent()) {
                request.setAttribute("cliente", clienteOpt.get());
                request.getRequestDispatcher("editarClienteNatural.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Cliente no encontrado");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de cliente inválido");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void mostrarFormularioEditarJuridico(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("clienteId"));
            Optional<ClienteDto> clienteOpt = clienteService.obtenerClientePorId(id);

            if (clienteOpt.isPresent()) {
                request.setAttribute("cliente", clienteOpt.get());
                request.getRequestDispatcher("editarClienteJuridico.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Cliente no encontrado");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de cliente inválido");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void actualizarClienteNatural(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ClienteDto cliente = new ClienteDto();
        try {
            cliente.setId(Integer.parseInt(request.getParameter("id")));
            cliente.setTypePerson("Natural");
            cliente.setName(request.getParameter("name"));
            cliente.setLastName(request.getParameter("lastName"));
            cliente.setEmail(request.getParameter("email"));
            cliente.setDocumentType(request.getParameter("documentType"));
            cliente.setDocumentNumber(request.getParameter("documentNumber"));
            cliente.setBirthdate(LocalDate.parse(request.getParameter("birthdate")));
            cliente.setPhone(request.getParameter("phone"));
            cliente.setAddress(request.getParameter("address"));
            cliente.setStatus(request.getParameter("status"));

            if (clienteService.editarPersonaNatural(cliente)) {
                response.sendRedirect("clientes");
            } else {
                request.setAttribute("error", "Error al actualizar el cliente");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void actualizarClienteJuridico(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ClienteDto cliente = new ClienteDto();
        try {
            cliente.setId(Integer.parseInt(request.getParameter("id")));
            cliente.setTypePerson("Juridica");
            cliente.setCompanyName(request.getParameter("companyName"));
            cliente.setRuc(request.getParameter("ruc"));
            cliente.setEmail(request.getParameter("email"));
            cliente.setAddress(request.getParameter("address"));
            cliente.setPhone(request.getParameter("phone"));
            cliente.setStatus(request.getParameter("status"));

            if (clienteService.editarPersonaJuridica(cliente)) {
                response.sendRedirect("clientesjuridicos");
            } else {
                request.setAttribute("error", "Error al actualizar el cliente");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void eliminarCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String tipoCliente = request.getParameter("tipo");

            boolean eliminado = clienteService.eliminarLogicoCliente(id);

            if (eliminado) {
                // Redirigir a la página correspondiente según el tipo de cliente
                if ("juridico".equals(tipoCliente)) {
                    System.out.println("Redirigiendo a clientesjuridicos");
                    response.sendRedirect("clientesjuridicos");
                } else {
                    System.out.println("Redirigiendo a clientes");
                    response.sendRedirect("clientes");
                }
            } else {
                System.out.println("Error al eliminar el cliente, redirigiendo a error.jsp");
                request.setAttribute("error", "Error al eliminar el cliente");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            System.out.println("ID de cliente inválido: " + e.getMessage());
            request.setAttribute("error", "ID de cliente inválido");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error en el proceso de eliminación: " + e.getMessage());
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void reactivarCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String tipo = request.getParameter("tipo");

            boolean reactivado = clienteService.reactivarCliente(id);

            if (reactivado) {
                // Redirigir a la página correspondiente según el tipo de cliente
                if ("juridico".equals(tipo)) {
                    response.sendRedirect("clientesjuridicosinactivos");
                } else {
                    response.sendRedirect("clientesinactivos");
                }
            } else {
                request.setAttribute("error", "Error al reactivar el cliente");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de cliente inválido");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
