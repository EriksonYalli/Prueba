USE master
GO

/* Crear base de datos dbCompuTech */
IF DB_ID (N'VentaReposteria') IS NOT NULL
	DROP DATABASE VentaReposteria
GO
CREATE DATABASE VentaReposteria
GO

/* Poner en uso base de datos dbCompuTech */
USE VentaReposteria
GO

	-- Crear la tabla Productos
	CREATE TABLE Productos (
		productoID INT PRIMARY KEY IDENTITY(1,1),
		codeBarra VARCHAR(20) NULL,
		nombre VARCHAR(100) NOT NULL,
		descripcion VARCHAR(255),
		marca VARCHAR(100),
		categoria VARCHAR(100),
		precioVenta DECIMAL(10,2) NOT NULL,
		descuento DECIMAL(5,2),
		stock INT NOT NULL,
		Estatus CHAR(1) DEFAULT 'A' CHECK (Estatus IN ('A', 'I')),
		fechaIngreso DATE NOT NULL DEFAULT GETDATE()
	);

	select * from Productos

	-- Crear la tabla Clientes
	CREATE TABLE Clientes (
		ClienteID INT PRIMARY KEY IDENTITY(1,1),
		Nombre VARCHAR(100) NOT NULL,
		Apellido VARCHAR(100) NOT NULL,
		TipoDocumento VARCHAR(20) NOT NULL,
		NumeroDocumento VARCHAR(20) NOT NULL UNIQUE,
		FechaNacimiento DATE,
		Celular VARCHAR(15),
		Email VARCHAR(100) UNIQUE,
		Direccion VARCHAR(255),
		FechaRegistro DATE NOT NULL DEFAULT GETDATE(),
		Estatus CHAR(1) DEFAULT 'A' CHECK (Estatus IN ('A', 'I'))
	);

	select * from Clientes;

	-- Crear la tabla Ventas
	CREATE TABLE Ventas (
		VentaID INT PRIMARY KEY IDENTITY(1,1),
		FK_ClienteID INT NOT NULL,
		FechaVenta DATE DEFAULT GETDATE(),
		TotalProductoVendidos INT NULL,
		PrecioTotal DECIMAL(10, 2) NOT NULL,
		CONSTRAINT FK_Ventas_Clientes FOREIGN KEY (FK_ClienteID) REFERENCES Clientes (ClienteID) ON DELETE CASCADE
	);


	SELECT v.VentaID, v.FK_ClienteID, v.FechaVenta, v.TotalProductoVendidos, v.PrecioTotal, c.Nombre
	FROM Ventas v
	JOIN Clientes c ON v.FK_ClienteID = c.ClienteID


	select * from Ventas;



	-- Crear la tabla DetalleVentas
	CREATE TABLE DetalleVentas (
		DetalleVentaID INT PRIMARY KEY IDENTITY(1,1),
		FK_VentaID INT NOT NULL,
		FK_ProductoID INT NOT NULL,
		CantidadProducto INT NOT NULL,
		PrecioUnitario DECIMAL(10, 2) NOT NULL,
		Descuento DECIMAL(5, 2) NULL,
		TotalDetalle DECIMAL(10, 2) NOT NULL,
		CONSTRAINT FK_DetalleVentas_Ventas FOREIGN KEY (FK_VentaID) REFERENCES Ventas (VentaID) ON DELETE CASCADE,
		CONSTRAINT FK_DetalleVentas_Productos FOREIGN KEY (FK_ProductoID) REFERENCES Productos (productoID) ON DELETE CASCADE
	);

	select * from DetalleVentas;

	update DetalleVentas set Descuento = 3.00 where DetalleVentaID = 7
	update DetalleVentas set Descuento = 3.00 where DetalleVentaID = 8

	CREATE TABLE EMPLEADO
	( 
		idemp                int IDENTITY ,
		nombre               varchar(50)  NOT NULL ,
		apellido             varchar(50)  NOT NULL ,
		email                varchar(50)  NOT NULL ,
		telefono             varchar(20)  NULL ,
		CONSTRAINT XPKEMPLEADO PRIMARY KEY  NONCLUSTERED (idemp ASC)
	);
	go


	CREATE TABLE USUARIO
	( 
		idemp                int  NOT NULL ,
		usuario              varchar(20)  NOT NULL ,
		clave                varbinary(100)  NOT NULL ,
		estado               smallint  NOT NULL 
		CONSTRAINT CHK_USUARIO_ESTADO CHECK  ( estado=1 OR estado=0 ),
		CONSTRAINT XPKUSUARIO PRIMARY KEY  NONCLUSTERED (idemp ASC),
		CONSTRAINT FK_USUARIO_EMPLEADO FOREIGN KEY (idemp) REFERENCES EMPLEADO(idemp)

	)
	go




-- Consultar las tablas creadas
SELECT * FROM sys.tables;