package pe.edu.vallegrande.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.sql.Date;



@Data
@NoArgsConstructor
@AllArgsConstructor
public class Buys {

    int Buys_Id;
    Date buys_date;
    BigDecimal Buys_price;
    String SupplierName;
    int supplierId;
    private int totalQuantity;
    String ruc_supplier;
    String phone_supplier;
    String email_supplier;

}
