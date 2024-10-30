-- Crear la base de datos InventarioReposteria
CREATE DATABASE VentaReposteria;

-- Usar la base de datos creada
USE VentaReposteria;

-- Tabla Productos
CREATE TABLE Productos (
    productoID INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
	marca VARCHAR(100),
	categoria VARCHAR(100),
    precioVenta DECIMAL(10,2) NOT NULL,
	descuento DECIMAL(5, 2) ,
    stock INT NOT NULL,
    estatus CHAR(1) NOT NULL DEFAULT 'A' CHECK (Estatus IN ('A', 'I')),
    fechaIngreso DATE NOT NULL DEFAULT GETDATE()
);

INSERT INTO Productos (Nombre, Descripcion, Marca, Categoria, PrecioVenta, Descuento, Stock, Estatus)
VALUES 
-- Tortas y Pasteles
('Torta de Fresas con Crema', 'Torta con capas de fresas frescas y crema chantilly', 'Delicia Dulce', 'Tortas y Pasteles', 25.00, 5.00, 10, 'A'),
('Pastel de Chocolate con Ganache', 'Pastel de chocolate cubierto con ganache oscuro', 'Delicia Dulce', 'Tortas y Pasteles', 30.00, NULL, 6, 'A'),

-- Galletas
('Galletas de Chocolate', 'Galletas crujientes con trozos de chocolate', 'Delicia Dulce', 'Galletas', 7.50, 2.50, 45, 'A'),
('Galletas Integrales con Avena', 'Galletas saludables con avena y poca azúcar', 'Delicia Dulce', 'Galletas', 6.00, 3.00, 50, 'A'),

-- Cupcakes y Muffins
('Cupcake Red Velvet', 'Cupcake esponjoso con cobertura de queso crema', 'Sweet Treats', 'Cupcakes y Muffins', 9.00, 1.50, 20, 'A'),
('Muffin de Chocolate Blanco', 'Muffin con chips de chocolate blanco', 'DulceManía', 'Cupcakes y Muffins', 8.00, NULL, 25, 'A'),

-- Brownies y Barras
('Brownie de Almendra', 'Brownie de chocolate con almendras troceadas', 'ChocoBites', 'Brownies y Barras', 12.00, 10.00, 15, 'A'),
('Barra Energética de Nueces', 'Barra con mezcla de nueces y frutos secos', 'Energía Natural', 'Brownies y Barras', 5.00, NULL, 30, 'A'),

-- Macarons
('Macarons de Chocolate', 'Macarons franceses rellenos de ganache de chocolate', 'Delicias Francesas', 'Macarons', 15.00, 4.00, 20, 'A'),
('Macarons de Frambuesa', 'Macarons franceses rellenos de mermelada de frambuesa', 'Delicias Francesas', 'Macarons', 15.00, 5.00, 15, 'A');




select * from Productos;
DROP TABLE Productos;





-- Tabla Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    TipoDocumento VARCHAR(20) NOT NULL,
    NumeroDocumento VARCHAR(20) NOT NULL UNIQUE,
    FechaNacimiento DATE,
    Celular VARCHAR(15),
    Email VARCHAR(100) UNIQUE, -- Único para evitar duplicados en correos
    Direccion VARCHAR(255),
    FechaRegistro DATE NOT NULL DEFAULT GETDATE(),
    Estatus CHAR(1) DEFAULT 'A' CHECK (Estatus IN ('A', 'I'))
);

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (Nombre, Apellido, TipoDocumento, NumeroDocumento, FechaNacimiento, Celular, Email, Direccion)
VALUES
('Juan', 'Pérez', 'DNI', '12345678', '1985-02-15', '987654321', 'juan.perez@email.com', 'Av. Siempre Viva 123'),
('María', 'González', 'DNI', '87654321', '1990-08-25', '998877665', 'maria.gonzalez@email.com', 'Calle Falsa 456'),
('Carlos', 'Lopez', 'Pasaporte', 'AB123456', '1980-06-10', '956732812', 'carlos.lopez@email.com', 'Av. San Martín 789');


select * from Clientes;



-- Tabla Ventas
CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY IDENTITY(1,1),
	TotalProductoVendidos INT NOT NULL,
	FechaVenta DATE DEFAULT GETDATE(),
	FK_ClienteID INT NOT NULL,
	CONSTRAINT Ventas_Clientes FOREIGN KEY (FK_ClienteID) REFERENCES Clientes (ClienteID)
);



CREATE TABLE DetalleVentas (
		DetalleVentaID INT PRIMARY KEY IDENTITY(1,1),
		CantidadProduc INT NOT NULL,
		PrecioUnitario INT NOT NULL,
		TotalDetalle INT NOT NULL,
		FK_productoID INT NOT NULL,
		FK_VentasID INT NOT NULL,
		CONSTRAINT DetalleVentas_Productos FOREIGN KEY (FK_productoID) REFERENCES Productos (productoID),
		CONSTRAINT DetalleVentas_Ventas FOREIGN KEY (FK_VentasID) REFERENCES Ventas (VentaID),
	);

