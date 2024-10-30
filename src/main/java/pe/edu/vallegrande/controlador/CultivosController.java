package pe.edu.vallegrande.controlador;


import pe.edu.vallegrande.dto.Cultivos;
import pe.edu.vallegrande.service.CultivosDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/cultivos")
class CultivosController extends HttpServlet {

    Cultivos cultivos = new Cultivos();
    CultivosDAO cultivosDAO = new CultivosDAO();
    String listarCultivos = "vistas/page.jsp";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("accion");

        try {
            switch (action) {
                case "listarCultivos":
                    List<Cultivos> cultivos = CultivosDAO.listar();
                    request.setAttribute("cultivos", cultivos);
                    request.getRequestDispatcher("page.jsp").forward(request, response);
                    break;
                // ... otros casos
                default:
                    // Manejar acciones inválidas
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            // Manejar excepciones
            e.printStackTrace();
            request.setAttribute("error", "Ocurrió un error al procesar la solicitud.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
