package pe.edu.vallegrande.prueba;

import pe.edu.vallegrande.Dto.ClienteDto;
import pe.edu.vallegrande.service.ClienteService;

import java.util.List;

public class TestClienteService {

    public static void main(String[] args) {
        ClienteService clienteService = new ClienteService();

        // Prueba de personas naturales activas
        System.out.println("Personas Naturales Activas:");
        List<ClienteDto> naturalesActivos = clienteService.listarPersonasNaturalesActivas();
        naturalesActivos.forEach(cliente -> System.out.println(cliente));

        // Prueba de personas naturales inactivas
        System.out.println("\nPersonas Naturales Inactivas:");
        List<ClienteDto> naturalesInactivos = clienteService.listarPersonasNaturalesInactivas();
        naturalesInactivos.forEach(cliente -> System.out.println(cliente));

        // Prueba de personas jurídicas activas
        System.out.println("\nPersonas Jurídicas Activas:");
        List<ClienteDto> juridicasActivos = clienteService.listarPersonasJuridicasActivas();
        juridicasActivos.forEach(cliente -> System.out.println(cliente));

        // Prueba de personas jurídicas inactivas
        System.out.println("\nPersonas Jurídicas Inactivas:");
        List<ClienteDto> juridicasInactivos = clienteService.listarPersonasJuridicasInactivas();
        juridicasInactivos.forEach(cliente -> System.out.println(cliente));
    }

}
