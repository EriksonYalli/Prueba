package pe.edu.vallegrande.prueba;

import pe.edu.vallegrande.service.SparePartService;

public class SparePartEliminar {
    public static void main(String[] args) {
        SparePartService service = new SparePartService();
        int sparePartIdToDelete = 1; // Cambia este ID por el ID del repuesto que deseas eliminar

        // Elimina el repuesto lógicamente
        service.deleteSparePart(sparePartIdToDelete);

    }
}
