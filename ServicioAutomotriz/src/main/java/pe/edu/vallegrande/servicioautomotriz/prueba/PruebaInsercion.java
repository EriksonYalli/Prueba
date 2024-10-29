package pe.edu.vallegrande.servicioautomotriz.prueba;

import pe.edu.vallegrande.servicioautomotriz.dto.SparePartDto;
import pe.edu.vallegrande.servicioautomotriz.service.SparePartService;

import java.math.BigDecimal;
import java.sql.Date;

public class PruebaInsercion {
    public static void main(String[] args) {
        SparePartService service = new SparePartService();

        SparePartDto nuevoRepuesto = new SparePartDto();
        nuevoRepuesto.setName("Filtro de Aceite");
        nuevoRepuesto.setDescription("Filtro de aceite para motor");
        nuevoRepuesto.setPriceUnit(new BigDecimal("15.99"));
        nuevoRepuesto.setBrand("Ford");
        nuevoRepuesto.setStock(100);
        nuevoRepuesto.setCompatibleModel("Compatible");
        nuevoRepuesto.setEntryDate(Date.valueOf("2024-10-29"));

        service.insertSparePart(nuevoRepuesto);
    }
}
