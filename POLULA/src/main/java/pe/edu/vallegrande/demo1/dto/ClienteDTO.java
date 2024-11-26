package pe.edu.vallegrande.demo1.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class ClienteDTO {

    int ClienteID;
    String nombre;
    String apellido;
    String tipoDocumento;
    String numeroDocumento;
    String fechaNacimiento;
    String celular;
    String email;
    String direccion;
    String fechaRegistro;
    String estatus;

}
