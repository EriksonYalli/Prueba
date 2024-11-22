package pe.edu.vallegrande.demo1.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor


public class DetalleVentaDTO {

       String nombreProducto;
       int detalleVentaID;
       int ventaID;
       int productoID;
       int cantidad;
       BigDecimal precioUnitario;
       BigDecimal descuento;
       BigDecimal totalDetalle;
}
