package pe.edu.vallegrande.prueba;

import pe.edu.vallegrande.Dto.SparePartDto;
import pe.edu.vallegrande.service.SparePartService;

import java.util.List;

public class SparePartListar {
    public static void main(String[] args) {
        SparePartService service = new SparePartService();

        // Obtener la lista de repuestos
        List<SparePartDto> repuestos = service.getSpareParts();

        // Mostrar cada repuesto en la lista
        if (repuestos.isEmpty()) {
            System.out.println("No hay repuestos disponibles.");
        } else {
            for (SparePartDto repuesto : repuestos) {
                System.out.println("ID: " + repuesto.getId());
                System.out.println("Nombre: " + repuesto.getName());
                System.out.println("Descripción: " + repuesto.getDescription());
                System.out.println("Tipo de Compatibilidad: " + repuesto.getCompatibilityType());
                System.out.println("ID Categoría: " + repuesto.getCategoryId());
                System.out.println("ID Marca: " + repuesto.getBrandId());
                System.out.println("Stock: " + repuesto.getStock());
                System.out.println("Fecha de Ingreso: " + repuesto.getEntryDate());
                System.out.println("-----------------------------------");
            }
        }
    }
}