package pe.edu.vallegrande.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import java.math.BigDecimal;
import java.sql.Date;

@ToString
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PurcharseDto {
    private int id;
    private Date date;
    private BigDecimal totalAmount;
    private String paymentMethod;
    private String status;
    private int supplierId;
    private String supplierName; // Nuevo campo
}
