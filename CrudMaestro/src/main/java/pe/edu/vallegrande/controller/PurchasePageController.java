package pe.edu.vallegrande.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import pe.edu.vallegrande.Dto.PurcharseDetailDto;
import pe.edu.vallegrande.Dto.PurcharseDto;
import pe.edu.vallegrande.Dto.SupplierDto;
import pe.edu.vallegrande.service.PurcharseDetailService;
import pe.edu.vallegrande.service.PurchaseService;
import pe.edu.vallegrande.service.SupplierService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet({"/Compras", "/ComprasAlmacen", "/ComprasDetalles"})
public class PurchasePageController extends HttpServlet {

    private PurchaseService purchaseService = new PurchaseService();
    private SupplierService supplierService = new SupplierService();
    private PurcharseDetailService purcharseDetailService = new PurcharseDetailService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/Compras":
                ComprasAdmin(request, response);
                break;
            case "/ComprasAlmacen":
                ComprasAlmacen(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/ComprasDetalles":
                CompraDetalleAdmin(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void CompraDetalleAdmin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json; charset=UTF-8"); // Establecer UTF-8
        resp.setCharacterEncoding("UTF-8");

        try {
            // Leer el ID de la compra desde el cuerpo de la solicitud
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = req.getReader().readLine()) != null) {
                sb.append(line);
            }

            Gson gson = new Gson();
            JsonObject jsonRequest = gson.fromJson(sb.toString(), JsonObject.class);
            int purchaseId = jsonRequest.get("id").getAsInt();

            // Obtener datos generales de la compra
            PurcharseDto purchase = purchaseService.getPurchaseById(purchaseId);
            if (purchase == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write("Compra no encontrada.");
                return;
            }

            // Obtener detalles de la compra
            List<PurcharseDetailDto> details = purcharseDetailService.getPurchaseDetailsByPurchaseId(purchaseId);

            // Crear respuesta JSON
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.add("purchase", gson.toJsonTree(purchase));
            jsonResponse.add("details", gson.toJsonTree(details));

            resp.getWriter().write(gson.toJson(jsonResponse));

        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("Error al obtener los datos: " + e.getMessage());
        }
    }

    private void ComprasAlmacen(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener todos los proveedores activos
        List<SupplierDto> suppliers = supplierService.getSuppliers();
        request.setAttribute("suppliers", suppliers);

        String supplierIdParam = request.getParameter("supplierId");
        List<PurcharseDto> purchases = new ArrayList<>();

        if (supplierIdParam != null && !supplierIdParam.isEmpty()) {
            // Si hay un proveedor seleccionado, filtrar las compras por proveedor
            int supplierId = Integer.parseInt(supplierIdParam);
            purchases = purchaseService.listarComprasBySupplier(supplierId);
        } else {
            // Si no hay filtro, obtener todas las compras
            purchases = purchaseService.listarCompras();
        }

        // Pasar las compras al JSP
        request.setAttribute("purchases", purchases);

        // Despachar al JSP
        request.getRequestDispatcher("/Compra/purchase.jsp").forward(request, response);
    }

    private void ComprasAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener todos los proveedores activos
        List<SupplierDto> suppliers = supplierService.getSuppliers();
        request.setAttribute("suppliers", suppliers);

        String supplierIdParam = request.getParameter("supplierId");
        List<PurcharseDto> purchases = new ArrayList<>();

        if (supplierIdParam != null && !supplierIdParam.isEmpty()) {
            // Si hay un proveedor seleccionado, filtrar las compras por proveedor
            int supplierId = Integer.parseInt(supplierIdParam);
            purchases = purchaseService.listarComprasBySupplier(supplierId);
        } else {
            // Si no hay filtro, obtener todas las compras
            purchases = purchaseService.listarCompras();
        }

        // Pasar las compras al JSP
        request.setAttribute("purchases", purchases);

        // Despachar al JSP
        request.getRequestDispatcher("purchase.jsp").forward(request, response);
    }
}
