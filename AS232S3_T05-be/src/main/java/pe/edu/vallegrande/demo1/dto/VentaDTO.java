package pe.edu.vallegrande.demo1.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;


@Data
@NoArgsConstructor
@AllArgsConstructor

public class VentaDTO {
     int ventaID;
     int clienteID;
     String dni;
     String nombre;
     String apellido;
     Date fechaVenta;
     int totalProductosVendidos;
     BigDecimal precioTotal;
}
