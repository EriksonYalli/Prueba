package pe.edu.vallegrande.demo1.dto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class ProductoDTO {

    int productoID;
    String codeBarra;
    String nombre;
    String descripcion;
    String marca;
    String categoria;
    BigDecimal precioVenta;
    BigDecimal descuento;
    int stock;
    String estatus;
    String fechaIngreso;

}



