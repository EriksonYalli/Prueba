-- Cambia a la base de datos master
USE master;
GO

-- Cambia la base de datos a modo de usuario �nico
ALTER DATABASE TallerMecanica SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- Elimina la base de datos si existe
DROP DATABASE IF EXISTS TallerMecanica;
GO

-- Crear la base de datos
CREATE DATABASE TallerMecanica;
GO

-- Usar la base de datos reci�n creada
USE TallerMecanica;
GO

-- Tabla: Category
CREATE TABLE Category (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Incrementable
    name VARCHAR(50) NOT NULL,
    description VARCHAR(100) NOT NULL
);

-- Tabla: Brand
CREATE TABLE Brand (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Incrementable
    name VARCHAR(50) NOT NULL,
    status CHAR(1) NOT NULL DEFAULT 'A' CHECK (status IN ('A', 'I')) -- Estado por defecto
);

-- Tabla: Supplier
CREATE TABLE Supplier (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Incrementable
    RUC BIGINT NOT NULL,
    Empresa VARCHAR(50) NOT NULL,
    status CHAR(1) NOT NULL DEFAULT 'A' CHECK (status IN ('A', 'I')), -- Estado por defecto
    Contacto BIGINT NOT NULL
);

-- Table: bill
CREATE TABLE bill (
    id int identity(1,1) NOT NULL,
    issue_date date  NOT NULL,
    total_amount decimal(8,2)  NOT NULL,
    igv decimal(8,2)  NOT NULL,
    discount decimal(8,2)  NOT NULL,
    payment_method varchar(15)  NOT NULL,
    status varchar(20)  NOT NULL,
    payment_date date  NOT NULL,
    service_orders_id int  NOT NULL,
    CONSTRAINT bill_pk PRIMARY KEY  (id)
);

-- Table: customer
CREATE TABLE customer (
    id int identity(1,1) NOT NULL,
	type_person varchar(20)NOT NULL, 
    name varchar(30)   ,
    last_name varchar(40)   ,
    email varchar(100)   ,
    document_type char(3),
    document_number varchar(20),
    birthdate date,
    status varchar(1) ,
    phone char(9)   ,
    address varchar(100)   ,
    company_name varchar(100)   ,
	ruc varchar(30)  ,
    CONSTRAINT customer_pk PRIMARY KEY  (id)
);

-- Table: detail_spare_parts
CREATE TABLE detail_spare_parts (
    id int  NOT NULL,
    amonunt int  NOT NULL,
    price_unit decimal(8,2)  NOT NULL,
    spare_parts_id int  NOT NULL,
    CONSTRAINT detail_spare_parts_pk PRIMARY KEY  (id)
);

-- Tabla: Purchase
CREATE TABLE Purchase (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Incrementable
    date DATE NOT NULL,
    total_amount DECIMAL(8,2) NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    status CHAR(1) NOT NULL, 
    Supplier_id INT NOT NULL
);

-- Tabla: Purchase_detail
CREATE TABLE Purchase_detail (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Incrementable
    quantity INT NOT NULL,
    subtotal DECIMAL(8,2) NOT NULL,
    price_unit DECIMAL(8,2) NOT NULL,
    spare_parts_id INT NOT NULL,
    purchase_id INT NOT NULL
);

-- Table: quotes
CREATE TABLE quotes (
    id int identity(1,1) NOT NULL,
    date date  NOT NULL,
    hour time  NOT NULL,
    description varchar(25)  NOT NULL,
    status varchar(20) default('Pendiente') ,
    vehicle_id int  NOT NULL,
    customer_id int  NOT NULL,
    diagnostic_result Varchar(200)  NOT NULL,
    diagnosis_type Varchar(15)  NOT NULL,
    worker_id int  NOT NULL,
    CONSTRAINT quotes_pk PRIMARY KEY  (id)
);

-- Table: quotes_detail
CREATE TABLE quotes_detail (
    id int identity(1,1) NOT NULL,
    result varchar(200)  NOT NULL,
    quotes_id int  NOT NULL,
    description Varchar(200)  NOT NULL,
    cost decimal(8,2)  NOT NULL,
    service_id int  NOT NULL,
    CONSTRAINT quotes_detail_pk PRIMARY KEY  (id)
);

-- Table: service
CREATE TABLE service (
    id int identity(1,1) NOT NULL,
    name varchar(50)  NOT NULL,
    description varchar(100)  NOT NULL,
    cost decimal(8,2)  NOT NULL,
    duration varchar(20)  NOT NULL,
    CONSTRAINT service_pk PRIMARY KEY  (id)
);

-- Table: service_orders
CREATE TABLE service_orders (
    id int identity(1,1) NOT NULL,
    worker_id int  NOT NULL,
    start_date date  NOT NULL,
    end_date date  NOT NULL,
    status varchar(10)  NOT NULL,
    comment varchar(100)  NOT NULL,
    detail_spare_parts_id int  NOT NULL,
    quotes_id int  NOT NULL,
    CONSTRAINT service_orders_pk PRIMARY KEY  (id)
);


-- Tabla: Spare_parts
CREATE TABLE Spare_parts (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Incrementable
    name VARCHAR(50) NOT NULL, -- Nombre del repuesto
    description TEXT NOT NULL, -- Descripci�n del repuesto
    compatibility_type VARCHAR(10) NOT NULL, -- Tipo de compatibilidad
    stock INT NOT NULL DEFAULT 0, -- Validaci�n para que el stock no sea negativo
    entry_date DATE NOT NULL, -- Fecha de ingreso
    state CHAR(1) NOT NULL DEFAULT 'A' CHECK (state IN ('A', 'I')), -- Estado por defecto
    category_id INT NOT NULL, -- Llave for�nea a Categor�a
    brand_id INT NOT NULL -- Llave for�nea a Marca
);

-- Table: vehicle
CREATE TABLE vehicle (
    id int identity(1,1)  NOT NULL,
    customer_id int  NOT NULL,
    model varchar(30)  NOT NULL,
    brand varchar(10)  NOT NULL,
    year int  NOT NULL,
    plate varchar(10)  NOT NULL,
    CONSTRAINT vehicle_pk PRIMARY KEY  (id)
);

CREATE TABLE worker (
    id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(30) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    email VARCHAR(100) NOT NULL,
    post VARCHAR(30) NOT NULL,
    specialty VARCHAR(50) NOT NULL,
    phone CHAR(9) NOT NULL,
    password VARCHAR(255) NOT NULL  -- Campo de la contraseña
);

-- foreign keys
-- Reference: Compra_detalle_spare_parts (table: purchase_detail)
ALTER TABLE purchase_detail ADD CONSTRAINT Compra_detalle_spare_parts
    FOREIGN KEY (spare_parts_id)
    REFERENCES spare_parts (id);

-- Reference: bill_service_orders (table: bill)
ALTER TABLE bill ADD CONSTRAINT bill_service_orders
    FOREIGN KEY (service_orders_id)
    REFERENCES service_orders (id);

-- Reference: citas_customer (table: quotes)
ALTER TABLE quotes ADD CONSTRAINT citas_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id);

-- Reference: citas_vehicle (table: quotes)
ALTER TABLE quotes ADD CONSTRAINT citas_vehicle
    FOREIGN KEY (vehicle_id)
    REFERENCES vehicle (id);

-- Reference: detail_spare_parts_spare_parts (table: detail_spare_parts)
ALTER TABLE detail_spare_parts ADD CONSTRAINT detail_spare_parts_spare_parts
    FOREIGN KEY (spare_parts_id)
    REFERENCES spare_parts (id);

-- Reference: purchase_Supplier (table: purchase)
ALTER TABLE purchase ADD CONSTRAINT purchase_Supplier
    FOREIGN KEY (Supplier_id)
    REFERENCES Supplier (id);

-- Reference: purchase_detail_purchase (table: purchase_detail)
ALTER TABLE purchase_detail ADD CONSTRAINT purchase_detail_purchase
    FOREIGN KEY (purchase_id)
    REFERENCES purchase (id);

-- Reference: quotes_detail_quotes (table: quotes_detail)
ALTER TABLE quotes_detail ADD CONSTRAINT quotes_detail_quotes
    FOREIGN KEY (quotes_id)
    REFERENCES quotes (id);

-- Reference: quotes_detail_service (table: quotes_detail)
ALTER TABLE quotes_detail ADD CONSTRAINT quotes_detail_service
    FOREIGN KEY (service_id)
    REFERENCES service (id);

-- Reference: quotes_worker (table: quotes)
ALTER TABLE quotes ADD CONSTRAINT quotes_worker
    FOREIGN KEY (worker_id)
    REFERENCES worker (id);

-- Reference: service_orders_detail_spare_parts (table: service_orders)
ALTER TABLE service_orders ADD CONSTRAINT service_orders_detail_spare_parts
    FOREIGN KEY (detail_spare_parts_id)
    REFERENCES detail_spare_parts (id);

-- Reference: service_orders_quotes (table: service_orders)
ALTER TABLE service_orders ADD CONSTRAINT service_orders_quotes
    FOREIGN KEY (quotes_id)
    REFERENCES quotes (id);

-- Reference: service_orders_user (table: service_orders)
ALTER TABLE service_orders ADD CONSTRAINT service_orders_user
    FOREIGN KEY (worker_id)
    REFERENCES worker (id);

-- Reference: spare_parts_Category (table: spare_parts)
ALTER TABLE spare_parts ADD CONSTRAINT spare_parts_Category
    FOREIGN KEY (Category_id)
    REFERENCES Category (id);

-- Reference: spare_parts_brand (table: spare_parts)
ALTER TABLE spare_parts ADD CONSTRAINT spare_parts_brand
    FOREIGN KEY (brand_id)
    REFERENCES brand (id);

-- Reference: vehicle_customer (table: vehicle)
ALTER TABLE vehicle ADD CONSTRAINT vehicle_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id);

INSERT INTO Category (name, description)
VALUES 
('Lubricantes', 'Aceites y lubricantes para motores'),
('Frenos', 'Componentes y sistemas de frenos'),
('Suspensión', 'Amortiguadores y partes de suspensión'),
('Neumáticos', 'Ruedas y neumáticos para automóviles'),
('Eléctricos', 'Sistemas eléctricos y baterías'),
('Aceites', 'Aceites para transmisión y motor'),
('Filtros', 'Filtros de aire, aceite y combustible'),
('Iluminación', 'Luces y sistemas de iluminación'),
('Interior', 'Accesorios y partes del interior del vehículo');

INSERT INTO Supplier (RUC, Empresa, Contacto)
VALUES 
(20412345678, 'Lubricantes Martínez SAC', 987654321),
(20587654321, 'Frenos y Más EIRL', 987654322),
(20345678901, 'Suspensiones Modernas SAC', 987654323),
(20456789012, 'Neumáticos y Servicios SAC', 987654324),
(20234567890, 'ElectroAuto Perú EIRL', 987654325),
(20398765432, 'Aceites Castrol SAC', 987654326),
(20123456789, 'Luces y Accesorios SAC', 987654327),
(20211234567, 'Filtros del Perú EIRL', 987654328),
(20467890123, 'Pirelli Neumáticos SAC', 987654329),
(20334455667, 'Interior Auto SAC', 987654330);

INSERT INTO Brand (name, status)
VALUES 
('Mobil', 'A'),
('Brembo', 'A'),
('Monroe', 'A'),
('Michelin', 'A'),
('Bosch', 'A'),
('Castrol', 'A'),
('Philips', 'A'),
('Pirelli', 'A'),
('Osram', 'A'),
('K&N', 'A');

INSERT INTO worker (name, last_name, email, post, specialty, phone, password)
VALUES 
('Carlos', 'González', 'carlos.gonzalez@example.com', 'Administrador', 'Gestión', '987654321', 'admin123'),
('Marta', 'Sánchez', 'marta.sanchez@example.com', 'Almacenero', 'Inventario', '963258741', 'almacen456'),
('José', 'Ramírez', 'jose.ramirez@example.com', 'Recepcionista', 'Atención al cliente', '912345678', 'recepcion789'),
('Pedro', 'López', 'pedro.lopez@example.com', 'Técnico', 'Mantenimiento', '934567890', 'tecnico321');

select * from Category;
select * from Supplier;
select * from Brand;
select * from Purchase_detail;
select * from Purchase;
select * from worker;