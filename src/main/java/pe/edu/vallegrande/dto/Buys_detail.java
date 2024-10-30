package pe.edu.vallegrande.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Buys_detail {

    private int buyDetailId;         // ID del detalle de compra
    private int quantity;             // Cantidad del producto
    private BigDecimal unitPrice;     // Precio unitario
    private BigDecimal totalDetail;    // Total del detalle (cantidad * precio unitario)
    private String batch;             // Lote del producto
    private String expireDate;          // Fecha de caducidad
    private String presentation;       // Presentación del producto
    private String healthRecord;       // Registro sanitario
    private int fkBuysId;             // ID de la compra
    private String comercialName;      // ID del producto
    private int fkproduct_id;
    private String descriptionProduct;


}
