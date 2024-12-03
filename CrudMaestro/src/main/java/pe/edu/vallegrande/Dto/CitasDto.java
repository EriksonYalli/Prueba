package pe.edu.vallegrande.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CitasDto {

    private int id; // ID de la cita
    private LocalDate date; // Fecha de la cita
    private LocalTime hour; // Hora de la cita
    private String description; // Descripción de la cita
    private String status; // Estado de la cita
    private int vehicleId; // ID del vehículo
    private int customerId; // ID del cliente
    private String diagnosticResult; // Resultado del diagnóstico
    private String diagnosisType; // Tipo de diagnóstico
    private int workerId; // ID del trabajador asociado (nuevo campo)

    private WorkerDto worker;
    private ClienteDto customer; // Relación con la entidad Customer
    private VehicleDto vehicle; // Relación con la entidad Vehicle

    private List<CitasDetalleDto> detalles; // Relación con la entidad CitaDetalle
}
