package pe.edu.vallegrande.prueba;

import pe.edu.vallegrande.Dto.SparePartDto;
import pe.edu.vallegrande.service.SparePartService;

import java.sql.Date;

public class SparePartInsercion {
    public static void main(String[] args) {
        SparePartService service = new SparePartService();

        // Crear un nuevo objeto SparePartDto con los datos del repuesto
        SparePartDto nuevoRepuesto = new SparePartDto();
        nuevoRepuesto.setName("Filtro de Aceite");
        nuevoRepuesto.setDescription("Filtro de aceite para motor");
        nuevoRepuesto.setCompatibilityType("Original");
        nuevoRepuesto.setEntryDate(Date.valueOf("2024-10-29"));
        nuevoRepuesto.setCategoryId(2); // ID de categoría existente
        nuevoRepuesto.setBrandId(1); // ID de marca existente

        // Insertar el nuevo repuesto usando el servicio
        service.insertSparePart(nuevoRepuesto);

    }
}