package pe.edu.vallegrande.demo1.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class DetalleDTO {

     int detalleVentaID;           // Identificador único del detalle de venta
     int fkVentaID;                // Identificador de la venta (clave foránea)
     int fkProductoID;             // Identificador del producto (clave foránea)
     String nombreProducto;        // Nombre del producto en el momento de la venta
     int cantidad;                 // Cantidad del producto vendido
     BigDecimal precioVenta;       // Precio unitario de venta al momento de la venta
     BigDecimal descuento;         // Descuento específico para este producto en la venta
     BigDecimal subtotal;          // Subtotal calculado (al aplicar el descuento)
     BigDecimal montoRecibido;     // Monto que el cliente entrega para el pago
     BigDecimal vuelto;            // Calculado automáticamente según el monto recibido
     String fechaVenta;         // Fecha y hora de la venta
     String estadoDetalle;         // Estado del detalle de venta (Ej.: Activo, Cancelado)
}
