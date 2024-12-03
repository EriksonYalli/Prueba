package pe.edu.vallegrande.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClienteDto {

    private int id;                 // ID del cliente
    private String typePerson;      // Tipo de persona (natural o jurídica)
    private String name;            // Nombre del cliente
    private String lastName;        // Apellido del cliente
    private String email;           // Correo electrónico
    private String documentType;    // Tipo de documento (DNI, RUC, etc.)
    private String documentNumber;  // Número de documento (ahora es String)
    private LocalDate birthdate;    // Fecha de nacimiento (puede ser null)
    private String status;          // Estado del cliente
    private String phone;           // Teléfono
    private String address;         // Dirección
    private String companyName;     // Nombre de la empresa (puede ser null)
    private String ruc;             // RUC (Registro Único de Contribuyentes)
}
