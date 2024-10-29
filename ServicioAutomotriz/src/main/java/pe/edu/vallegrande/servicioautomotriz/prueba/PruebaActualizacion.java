package pe.edu.vallegrande.servicioautomotriz.prueba;

import pe.edu.vallegrande.servicioautomotriz.dto.SparePartDto;
import pe.edu.vallegrande.servicioautomotriz.service.SparePartService;

import java.math.BigDecimal;
import java.sql.Date;

public class PruebaActualizacion {
    public static void main(String[] args) {
        SparePartService service = new SparePartService();

        SparePartDto repuestoExistente = new SparePartDto();
        repuestoExistente.setId(1);
        repuestoExistente.setName("Filtro de Aire");
        repuestoExistente.setDescription("Filtro de aire modificado");
        repuestoExistente.setPriceUnit(new BigDecimal("18.99"));
        repuestoExistente.setBrand("Chevrolet");
        repuestoExistente.setStock(120);
        repuestoExistente.setCompatibleModel("Orignial");
        repuestoExistente.setEntryDate(Date.valueOf("2024-10-29"));

        service.updateSparePart(repuestoExistente);
    }
}
