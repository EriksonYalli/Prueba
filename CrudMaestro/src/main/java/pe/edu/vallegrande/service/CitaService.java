package pe.edu.vallegrande.service;

import pe.edu.vallegrande.Dto.*;
import pe.edu.vallegrande.db.AccesoDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class CitaService {

    // Definimos las consultas SQL como variables
    private static final String INSERT_QUOTE_SQL = "INSERT INTO quotes (date, hour, description, status, vehicle_id, customer_id, diagnostic_result, diagnosis_type, worker_id) " +
            "VALUES (?, ?, ?, 'pendiente', ?, ?, ?, ?, ?)";
    private static final String INSERT_DETAIL_SQL = "INSERT INTO quotes_detail (quotes_id, description, result, cost, service_id) " +
            "VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_CLIENTES_SQL = "SELECT id, type_person, name, last_name, company_name FROM customer WHERE status = 'A'";

    private static final String SELECT_VEHICLES_BY_CUSTOMER_SQL =
            "SELECT id, plate FROM vehicle WHERE customer_id = ?";

    private static final String SELECT_CITA_BY_ID_SQL =
            "SELECT id, date, hour, description, status, vehicle_id, customer_id, diagnostic_result, diagnosis_type, worker_id " +
                    "FROM quotes WHERE id = ?";

    private static final String SELECT_ALL_CITAS_SQL =
            "SELECT id, date, hour, description, status, vehicle_id, customer_id, diagnostic_result, diagnosis_type, worker_id " +
                    "FROM quotes";

    private static final String SELECT_DETALLES_BY_CITA_ID_SQL =
            "SELECT id, quotes_id, description, result, cost, service_id " +
                    "FROM quotes_detail WHERE quotes_id = ?";


    public List<VehicleDto> obtenerVehiculosPorCliente(int customerId) {
        List<VehicleDto> vehicles = new ArrayList<>();

        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_VEHICLES_BY_CUSTOMER_SQL)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    VehicleDto vehicle = new VehicleDto();
                    vehicle.setId(rs.getInt("id"));
                    vehicle.setPlate(rs.getString("plate"));
                    vehicles.add(vehicle);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vehicles;
    }

    // Método para insertar la cita y el detalle de la cita
    public boolean insertarCitaConDetalle(String date, String hour, String description,
                                          int vehicleId, int customerId, int workerId, // Nuevo parámetro workerId
                                          String detailDescription, String detailResult,
                                          double detailCost, int serviceId) { // Nuevo parámetro serviceId
        boolean success = false;

        // Usamos una conexión a la base de datos
        try (Connection conn = AccesoDB.getConnection()) {
            // Desactivar autocommit para manejar transacciones
            conn.setAutoCommit(false);

            try {
                // 1. Insertar en la tabla 'quotes' (Cita)
                try (PreparedStatement ps = conn.prepareStatement(INSERT_QUOTE_SQL, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, date);
                    ps.setString(2, hour);
                    ps.setString(3, description);
                    ps.setInt(4, vehicleId);
                    ps.setInt(5, customerId);
                    ps.setString(6, "Pendiente");  // Resultado diagnóstico por defecto
                    ps.setString(7, "General");    // Tipo de diagnóstico por defecto
                    ps.setInt(8, workerId);        // Asignar workerId
                    ps.executeUpdate();

                    // Obtener el ID de la cita recién insertada
                    ResultSet generatedKeys = ps.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int quoteId = generatedKeys.getInt(1);  // ID de la cita recién insertada

                        // 2. Insertar en la tabla 'cita_detalle' (Detalles de la cita)
                        try (PreparedStatement psDetail = conn.prepareStatement(INSERT_DETAIL_SQL)) {
                            psDetail.setInt(1, quoteId);
                            psDetail.setString(2, detailDescription);
                            psDetail.setString(3, detailResult);
                            psDetail.setDouble(4, detailCost);
                            psDetail.setInt(5, serviceId); // Asignar serviceId
                            psDetail.executeUpdate();
                        }
                    }
                }

                // Si todo ha ido bien, confirmamos la transacción
                conn.commit();
                success = true;
            } catch (SQLException e) {
                // Si ocurre algún error, revertimos la transacción
                conn.rollback();
                throw new SQLException("Error en la inserción de la cita y detalles.", e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    public boolean insertarCitaConDetalles(String date, String hour, String description,
                                           int vehicleId, int customerId, int workerId,
                                           List<CitasDetalleDto> detalles) { // Cambiar a lista de detalles
        boolean success = false;

        // Usamos una conexión a la base de datos
        try (Connection conn = AccesoDB.getConnection()) {
            // Desactivar autocommit para manejar transacciones
            conn.setAutoCommit(false);

            try {
                // 1. Insertar en la tabla 'quotes' (Cita)
                try (PreparedStatement ps = conn.prepareStatement(INSERT_QUOTE_SQL, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, date);
                    ps.setString(2, hour);
                    ps.setString(3, description);
                    ps.setInt(4, vehicleId);
                    ps.setInt(5, customerId);
                    ps.setString(6, "Pendiente");  // Resultado diagnóstico por defecto
                    ps.setString(7, "General");    // Tipo de diagnóstico por defecto
                    ps.setInt(8, workerId);        // Asignar workerId
                    ps.executeUpdate();

                    // Obtener el ID de la cita recién insertada
                    ResultSet generatedKeys = ps.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int quoteId = generatedKeys.getInt(1);  // ID de la cita recién insertada

                        // 2. Insertar en la tabla 'cita_detalle' (Detalles de la cita)
                        for (CitasDetalleDto detalle : detalles) {
                            try (PreparedStatement psDetail = conn.prepareStatement(INSERT_DETAIL_SQL)) {
                                psDetail.setInt(1, quoteId);
                                psDetail.setString(2, detalle.getDescription());
                                psDetail.setString(3, detalle.getResult());
                                psDetail.setDouble(4, detalle.getCost());
                                psDetail.setInt(5, detalle.getServiceId()); // Asignar serviceId
                                psDetail.executeUpdate();
                            }
                        }
                    }
                }

                // Si todo ha ido bien, confirmamos la transacción
                conn.commit();
                success = true;
            } catch (SQLException e) {
                // Si ocurre algún error, revertimos la transacción
                conn.rollback();
                throw new SQLException("Error en la inserción de la cita y detalles.", e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }


    // Método para obtener los clientes activos
    public List<ClienteDto> obtenerClientes() {
        List<ClienteDto> clientes = new ArrayList<>();

        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_CLIENTES_SQL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ClienteDto cliente = new ClienteDto();
                cliente.setId(rs.getInt("id"));
                cliente.setTypePerson(rs.getString("type_person"));
                cliente.setName(rs.getString("name"));
                cliente.setLastName(rs.getString("last_name"));
                cliente.setCompanyName(rs.getString("company_name"));
                clientes.add(cliente);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return clientes;
    }

    public CitasDto obtenerCitaPorId(int citaId) {
        CitasDto cita = null;

        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_CITA_BY_ID_SQL)) {
            ps.setInt(1, citaId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cita = new CitasDto();
                    cita.setId(rs.getInt("id"));
                    cita.setDate(LocalDate.parse(rs.getString("date")));
                    cita.setHour(LocalTime.parse(rs.getString("hour")));
                    cita.setDescription(rs.getString("description"));
                    cita.setStatus(rs.getString("status"));
                    cita.setVehicleId(rs.getInt("vehicle_id"));
                    cita.setCustomerId(rs.getInt("customer_id"));
                    cita.setDiagnosticResult(rs.getString("diagnostic_result"));
                    cita.setDiagnosisType(rs.getString("diagnosis_type"));
                    cita.setWorkerId(rs.getInt("worker_id")); // Asignar workerId

                    // Puedes añadir también la lógica para obtener detalles de la cita, si es necesario
                    // O utilizar un método adicional para obtener los detalles de la cita
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cita;
    }

    public List<CitasDetalleDto> obtenerDetallesPorCitaId(int citaId) {
        List<CitasDetalleDto> detalles = new ArrayList<>();

        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_DETALLES_BY_CITA_ID_SQL)) {
            ps.setInt(1, citaId); // Asignamos el ID de la cita a la consulta

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CitasDetalleDto detalle = new CitasDetalleDto();
                    detalle.setId(rs.getInt("id"));
                    detalle.setCitaId(rs.getInt("quotes_id"));
                    detalle.setDescription(rs.getString("description"));
                    detalle.setResult(rs.getString("result"));
                    detalle.setCost(rs.getDouble("cost"));
                    detalle.setServiceId(rs.getInt("service_id")); // Asignar serviceId
                    detalles.add(detalle);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return detalles;
    }

    public List<CitasDto> obtenerTodasLasCitas() {
        List<CitasDto> citas = new ArrayList<>();

        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_CITAS_SQL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CitasDto cita = new CitasDto();
                cita.setId(rs.getInt("id"));
                cita.setDate(rs.getDate("date").toLocalDate());
                cita.setHour(rs.getTime("hour").toLocalTime());
                cita.setDescription(rs.getString("description"));
                cita.setStatus(rs.getString("status"));
                cita.setVehicleId(rs.getInt("vehicle_id"));
                cita.setCustomerId(rs.getInt("customer_id"));
                cita.setDiagnosticResult(rs.getString("diagnostic_result"));
                cita.setDiagnosisType(rs.getString("diagnosis_type"));
                cita.setWorkerId(rs.getInt("worker_id"));
                citas.add(cita);
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener las citas: " + e.getMessage());
            throw new RuntimeException("Error al obtener las citas", e);
        }

        return citas;
    }

    public List<WorkerDto> obtenerEmpleados() {
        List<WorkerDto> empleados = new ArrayList<>();
        // Lógica para obtener los empleados desde la base de datos
        // Puede ser algo como:
        String sql = "SELECT id, name , last_name FROM Worker"; // Ajusta la consulta según tu estructura
        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                WorkerDto empleado = new WorkerDto();
                empleado.setId(rs.getInt("id"));
                empleado.setName(rs.getString("name"));
                empleado.setName(rs.getString("last_name"));
                empleados.add(empleado);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de excepciones
        }
        return empleados;
    }



    // New method to get service cost by service ID
    public double obtenerCostoPorServicio(int serviceId) {
        double cost = 0.0;
        String sql = "SELECT cost FROM service WHERE id = ?";

        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, serviceId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cost = rs.getDouble("cost");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cost;
    }

    // Modify existing obtenerServicios method to include cost
    public List<ServicioDto> obtenerServicios() {
        List<ServicioDto> servicios = new ArrayList<>();
        String sql = "SELECT id, name, cost FROM service";
        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ServicioDto servicio = new ServicioDto();
                servicio.setId(rs.getInt("id"));
                servicio.setName(rs.getString("name"));
                servicio.setCost(rs.getDouble("cost")); // Add this line
                servicios.add(servicio);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return servicios;
    }

    public List<CitasDto> obtenerCitasConDetalles() {
        List<CitasDto> citas = new ArrayList<>();
        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_CITAS_SQL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CitasDto cita = new CitasDto();
                cita.setId(rs.getInt("id"));
                cita.setDate(rs.getDate("date").toLocalDate());
                cita.setHour(rs.getTime("hour").toLocalTime());
                cita.setDescription(rs.getString("description"));
                cita.setStatus(rs.getString("status"));
                cita.setVehicleId(rs.getInt("vehicle_id"));
                cita.setCustomerId(rs.getInt("customer_id"));
                cita.setDiagnosticResult(rs.getString("diagnostic_result"));
                cita.setDiagnosisType(rs.getString("diagnosis_type"));
                cita.setWorkerId(rs.getInt("worker_id"));


                // Cargar información del cliente
                ClienteDto cliente = obtenerClientePorId(cita.getCustomerId());
                cita.setCustomer(cliente);

                // Cargar información del vehículo
                VehicleDto vehiculo = obtenerVehiculoPorId(cita.getVehicleId());
                cita.setVehicle(vehiculo);

                // Cargar información del trabajador
                WorkerDto trabajador = obtenerTrabajadorPorId(cita.getWorkerId());
                cita.setWorker(trabajador);

                // Obtener los detalles para cada cita
                List<CitasDetalleDto> detalles = obtenerDetallesPorCitaId(cita.getId());
                cita.setDetalles(detalles);  // Seteamos los detalles en el objeto CitasDto

                citas.add(cita);
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Log para ver detalles
            throw new RuntimeException("Error al obtener las citas con detalles", e);  // Propagar excepción
        }
        return citas;
    }
        public ClienteDto obtenerClientePorId(int clienteId) {
            ClienteDto cliente = null;
            String sql = "SELECT id, type_person, name, last_name, company_name FROM customer WHERE id = ?";

            try (Connection conn = AccesoDB.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, clienteId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        cliente = new ClienteDto();
                        cliente.setId(rs.getInt("id"));
                        cliente.setTypePerson(rs.getString("type_person"));
                        cliente.setName(rs.getString("name"));
                        cliente.setLastName(rs.getString("last_name"));
                        cliente.setCompanyName(rs.getString("company_name"));
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            return cliente;
        }


    public VehicleDto obtenerVehiculoPorId(int vehiculoId) {
        VehicleDto vehiculo = null;
        String sql = "SELECT id, plate FROM vehicle WHERE id = ?";

        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, vehiculoId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    vehiculo = new VehicleDto();
                    vehiculo.setId(rs.getInt("id"));
                    vehiculo.setPlate(rs.getString("plate"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vehiculo;
    }


    public WorkerDto obtenerTrabajadorPorId(int trabajadorId) {
        WorkerDto trabajador = null;
        String sql = "SELECT id, name, last_name FROM worker WHERE id = ?";

        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, trabajadorId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    trabajador = new WorkerDto();
                    trabajador.setId(rs.getInt("id"));
                    trabajador.setName(rs.getString("name"));
                    trabajador.setLastName(rs.getString("last_name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return trabajador;
    }


    // CitasService.java
    public static ServicioDto obtenerServicioPorId(int servicioId) {
        ServicioDto servicio = null;
        String sql = "SELECT id, name, cost FROM service WHERE id = ?";

        try (Connection conn = AccesoDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, servicioId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    servicio = new ServicioDto();
                    servicio.setId(rs.getInt("id"));  // Se obtiene el ID del resultado
                    servicio.setName(rs.getString("name"));
                    servicio.setCost(rs.getDouble("cost"));
                }
            }
        } catch (SQLException e) {
            // Puedes agregar aquí un logger para registrar el error
            System.err.println("Error al obtener servicio con ID: " + servicioId);
            e.printStackTrace();
        }

        return servicio;
    }



}








