CREATE DATABASE TallerMecanica;

USE TallerMecanica;
GO

--------------------------------------------------------------------------------------------------------------------
----���������������������������| CREACION DE TABLAS MAESTRAS Y TRANSACCIONALES |�������������������������������-----
--------------------------------------------------------------------------------------------------------------------


-- Crear la tabla de Factura
CREATE TABLE bill (
    id INT IDENTITY(1,1) NOT NULL,            -- Columna autoincrementable
    formatted_id VARCHAR(20) ,                     -- Columna para el ID en formato personalizado
    issue_date DATE NOT NULL,                              -- Fecha de emisi�n
    total_amount DECIMAL(8,2),                             -- Monto total
    igv DECIMAL(8,2),                                      -- IGV
    discount DECIMAL(8,2),                                 -- Descuento
    payment_method VARCHAR(15) NOT NULL,                   -- M�todo de pago
    status VARCHAR(20) NOT NULL,                           -- Estado de la factura
    payment_date DATE,                                    -- Fecha de pago
    service_orders_id INT NOT NULL,                        -- ID de la orden de servicio
    CONSTRAINT bill_pk PRIMARY KEY (id)                    -- Clave primaria
);
GO

-- Tabla de Cliente
CREATE TABLE customer (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),                        -- ID del cliente
    name VARCHAR(30) NOT NULL,                          -- Nombre del cliente
    last_name VARCHAR(40) NOT NULL,                     -- Apellido del cliente
    email VARCHAR(100) NOT NULL,                        -- Correo electr�nico
    document_type CHAR(3) NOT NULL,                     -- Tipo de documento
    document_number VARCHAR(20) NOT NULL,               -- N�mero de documento
    birthdate DATE NOT NULL,                            -- Fecha de nacimiento
    status VARCHAR(1) NOT NULL,                         -- Estado del cliente
    phone CHAR(9) NOT NULL,                             -- Tel�fono
    address VARCHAR(100) NOT NULL,                      -- Direcci�n
    company_name VARCHAR(100) NOT NULL                  -- Nombre de la empresa (si aplica)
);
GO

-- Tabla de Detalle de Repuestos
CREATE TABLE detail_spare_parts (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),                        -- ID del detalle de repuesto
    spare_parts_id INT NOT NULL,                        -- ID del repuesto
    amount INT NOT NULL,                                -- Cantidad
    price_unit DECIMAL(8,2) NOT NULL                    -- Precio unitario
);
GO

-- Tabla de Citas
CREATE TABLE quotes (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),                        -- ID de la cita
    date DATE NOT NULL,                                -- Fecha de la cita
    hour TIME NOT NULL,                                -- Hora de la cita
    description VARCHAR(100) NOT NULL,                  -- Descripci�n
    status VARCHAR(15) NOT NULL,                         -- Estado de la cita
    vehicle_id INT NOT NULL,                           -- ID del veh�culo
    customer_id INT NOT NULL,                          -- ID del cliente
    diagnostic_result VARCHAR(200) NOT NULL,           -- Resultado del diagn�stico
    diagnosis_type VARCHAR(15) NOT NULL                 -- Tipo de diagn�stico
);
GO


-- Tabla de Servicios
CREATE TABLE service (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),                        -- ID del servicio
    name VARCHAR(50) NOT NULL,                          -- Nombre del servicio
    description VARCHAR(100) NOT NULL,                  -- Descripci�n
    cost DECIMAL(8,2) NOT NULL,                         -- Costo del servicio
    duration VARCHAR(20) NOT NULL                       -- Duraci�n del servicio
);
GO

-- Tabla de �rdenes de Servicio
CREATE TABLE service_orders (
    id INT NOT NULL IDENTITY(1,1),                        -- ID de la orden de servicio
    quotes_id INT NOT NULL,                             -- ID de la cita
    worker_id INT NOT NULL,                             -- ID del trabajador
    start_date DATE NOT NULL,                           -- Fecha de inicio
    end_date DATE NOT NULL,                             -- Fecha de finalizaci�n
    status VARCHAR(15) NOT NULL,                        -- Estado de la orden
    comment VARCHAR(100) NOT NULL,                      -- Comentario
    service_id INT NOT NULL,                            -- ID del servicio
    detail_spare_parts_id INT NOT NULL,                 -- ID del detalle de repuestos
    CONSTRAINT service_orders_pk PRIMARY KEY (id)       -- Clave primaria
);
GO


-- Tabla de Repuestos
CREATE TABLE spare_parts (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),                        -- ID del repuesto
    name VARCHAR(40) NOT NULL,                          -- Nombre del repuesto
    description VARCHAR(50) NOT NULL,                   -- Descripci�n
    price_unit DECIMAL(8,2) NOT NULL,                   -- Precio unitario
    brand VARCHAR(15) NOT NULL,                         -- Marca
    stock INT NOT NULL,                                -- Stock disponible
    compatible_model VARCHAR(20) NOT NULL,              -- Modelo compatible
    entry_date DATE NOT NULL,                          -- Fecha de entrada
	state CHAR(1) NOT NULL DEFAULT 'A' CHECK (state IN ('A', 'I')) -- Estado predeterminado a 'A'
);
GO



-- Tabla de Veh�culos
CREATE TABLE vehicle (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),                        -- ID del veh�culo
    customer_id INT NOT NULL,                           -- ID del cliente
    model VARCHAR(30) NOT NULL,                         -- Modelo del veh�culo
    brand VARCHAR(10) NOT NULL,                         -- Marca del veh�culo
    year INT NOT NULL,                                 -- A�o del veh�culo
    plate VARCHAR(10) NOT NULL,                         -- Placa del veh�culo
    CONSTRAINT vehicle_customer_fk FOREIGN KEY (customer_id) REFERENCES customer (id) -- Clave for�nea
);
GO


-- Tabla de Trabajadores
CREATE TABLE worker (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),                        -- ID del trabajador
    name VARCHAR(30) NOT NULL,                          -- Nombre del trabajador
    last_name VARCHAR(40) NOT NULL,                     -- Apellido del trabajador
    email VARCHAR(100) NOT NULL,                        -- Correo electr�nico
    post VARCHAR(30) NOT NULL,                          -- Cargo del trabajador
    specialty VARCHAR(50) NOT NULL,                     -- Especialidad
    phone CHAR(9) NOT NULL                              -- Tel�fono
);
GO



----------------------------------------------------------------------------
--||||||||RSTRICCIONES EN LAS TABLAS MAESTRAS Y TRANSACCIONALES |||||||||||---
----------------------------------------------------------------------------

-----CUTOMER 

-- Restricci�n para asegurar que el correo tenga formato v�lido
ALTER TABLE customer
ADD CONSTRAINT chk_email_format CHECK (email LIKE '%_@_%.__%');

-- Restricci�n para asegurar que el tel�fono contenga solo n�meros y tenga exactamente 9 caracteres
ALTER TABLE customer
ADD CONSTRAINT chk_phone_format CHECK (phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');

-- Restricci�n para asegurar que el n�mero de documento contenga solo n�meros
ALTER TABLE customer
ADD CONSTRAINT chk_document_number_format CHECK (document_number NOT LIKE '%[^0-9]%');


----- DETALLES DE REPUESTOS

-- Restricci�n para asegurar que la cantidad de repuestos sea mayor a 0
ALTER TABLE detail_spare_parts
ADD CONSTRAINT chk_amount_positive CHECK (amount > 0);


-- Restricci�n para asegurar que el precio unitario sea mayor a 0
ALTER TABLE detail_spare_parts
ADD CONSTRAINT chk_price_unit_positive CHECK (price_unit > 0);


----- REPUESTOS 

-- Restricci�n para asegurar que el stock no sea negativo
ALTER TABLE spare_parts
ADD CONSTRAINT chk_stock_non_negative CHECK (stock >= 0);

-- Restricci�n para asegurar que el precio unitario sea mayor a 0
ALTER TABLE spare_parts
ADD CONSTRAINT chk_spare_parts_price_positive CHECK (price_unit > 0);


------ CITAS 

-- Restricci�n para asegurar que la fecha de la cita no sea una fecha pasada
ALTER TABLE quotes
ADD CONSTRAINT chk_quote_date_future CHECK (date >= GETDATE());

-- Restricci�n para asegurar que la hora est� dentro del rango de horario laboral (ejemplo: de 8 AM a 6 PM)
ALTER TABLE quotes
ADD CONSTRAINT chk_quote_hour_valid CHECK (hour >= '08:00' AND hour <= '18:00');


------ SERVICIOS

-- Restricci�n para asegurar que el costo del servicio sea mayor a 0
ALTER TABLE service
ADD CONSTRAINT chk_service_cost_positive CHECK (cost > 0);


------ ORDEN DE SERVICIO

-- Restricci�n para asegurar que la fecha de finalizaci�n sea mayor o igual a la fecha de inicio
ALTER TABLE service_orders
ADD CONSTRAINT chk_service_dates_valid CHECK (end_date >= start_date);




----- VEHICULO

-- Restricci�n para asegurar que el a�o del veh�culo est� en un rango razonable (ejemplo: mayor a 1950 y no futuro)
ALTER TABLE vehicle
ADD CONSTRAINT chk_vehicle_year_valid CHECK (year >= 1950 AND year <= YEAR(GETDATE()));

-- Restricci�n para asegurar que la placa tenga un formato espec�fico (ejemplo: 3 letras y 3 n�meros)
ALTER TABLE vehicle
ADD CONSTRAINT chk_vehicle_plate_format CHECK (plate LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]');


------- TRABAJADOR 

-- Restricci�n para asegurar que el tel�fono tenga exactamente 9 d�gitos
ALTER TABLE worker
ADD CONSTRAINT chk_worker_phone_format CHECK (phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');


----------------------------------------------------------------------------
--|||||||| RELACIONES ENTRE TABLAS MAESTRAS Y TRANSACCIONALES |||||||||||---
----------------------------------------------------------------------------

-- Claves For�neas

-- Relaci�n: factura - �rdenes de servicio
ALTER TABLE bill ADD CONSTRAINT fk_bill_service_orders
    FOREIGN KEY (service_orders_id)
    REFERENCES service_orders (id);
GO


-- Relaci�n: citas - cliente
ALTER TABLE quotes ADD CONSTRAINT fk_quotes_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id);
GO



-- Relaci�n: citas - veh�culo
ALTER TABLE quotes ADD CONSTRAINT fk_quotes_vehicle
    FOREIGN KEY (vehicle_id)
    REFERENCES vehicle (id);
GO


-- Relaci�n: detalle repuesto - repuestos
ALTER TABLE detail_spare_parts ADD CONSTRAINT fk_detail_spare_parts_spare_parts
    FOREIGN KEY (spare_parts_id)
    REFERENCES spare_parts (id);
GO


-- Relaci�n: �rdenes de servicio - detalle repuesto
ALTER TABLE service_orders ADD CONSTRAINT fk_service_orders_detail_spare_parts
    FOREIGN KEY (detail_spare_parts_id)
    REFERENCES detail_spare_parts (id);
GO


-- Relaci�n: �rdenes de servicio - citas
ALTER TABLE service_orders ADD CONSTRAINT fk_service_orders_quotes
    FOREIGN KEY (quotes_id)
    REFERENCES quotes (id);
GO


-- Relaci�n: �rdenes de servicio - servicios
ALTER TABLE service_orders ADD CONSTRAINT fk_service_orders_service
    FOREIGN KEY (service_id)
    REFERENCES service (id);
GO


-- Relaci�n: �rdenes de servicio - trabajadores
ALTER TABLE service_orders ADD CONSTRAINT fk_service_orders_worker
    FOREIGN KEY (worker_id)
    REFERENCES worker (id);
GO
