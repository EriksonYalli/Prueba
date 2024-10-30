
-- Crear base de datos
drop database T06_AGROZAM
CREATE DATABASE T06_AGROZAM;
USE T06_AGROZAM;

-- Tabla: Suppliers
CREATE TABLE Suppliers (
    suppliers_id INT NOT NULL IDENTITY(1, 1),
    name VARCHAR(50) NOT NULL,
    phone CHAR(9) NOT NULL,
    email VARCHAR(100) NOT NULL,
    ruc CHAR(11) NOT NULL,
    Status CHAR(1) NOT NULL DEFAULT 'A',
    CONSTRAINT Suppliers_pk PRIMARY KEY (suppliers_id)
);

-- Tabla: Category
CREATE TABLE Category (
    category_id INT NOT NULL IDENTITY(1, 1),
    category_name VARCHAR(50) NOT NULL,
    CONSTRAINT Category_pk PRIMARY KEY (category_id)
);

-- Tabla: Crops
CREATE TABLE Crops (
    crops_id INT NOT NULL IDENTITY(1, 1),
    name VARCHAR(100) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT crops_id_pk PRIMARY KEY (crops_id)
);

-- Tabla: Inventory
CREATE TABLE Inventory (
    inventory_id INT NOT NULL IDENTITY(1, 1),
    quantity INT NOT NULL,
    update_date DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT Inventory_pk PRIMARY KEY (inventory_id)
);

-- Tabla: Products
CREATE TABLE Products (
    products_id INT NOT NULL IDENTITY(1, 1),
    comercial_name VARCHAR(100) NOT NULL,
    generic_name VARCHAR(100) NOT NULL,
    formulation VARCHAR(100) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    sale_price NUMERIC(10, 2) NOT NULL,
    unit VARCHAR(20) NOT NULL,
    fk_suppliers_id INT NULL,
    fk_category_id INT NULL,
    status CHAR(1) NOT NULL DEFAULT 'A',
    concentration DECIMAL(8, 2) NULL,
    concentration_unit VARCHAR(30) NULL,
    action_mode VARCHAR(100) NULL,
    fk_crops_id INT NULL,
    pests_diseases VARCHAR(100) NULL,
    recomended_dose VARCHAR(100) NULL,
    precautions VARCHAR(255) NULL,
    fk_inventory_id INT NULL,
    CONSTRAINT Products_pk PRIMARY KEY (products_id),
    CONSTRAINT Products_Suppliers FOREIGN KEY (fk_suppliers_id) REFERENCES Suppliers (suppliers_id),
    CONSTRAINT Products_Category FOREIGN KEY (fk_category_id) REFERENCES Category (category_id),
    CONSTRAINT Products_Inventory FOREIGN KEY (fk_inventory_id) REFERENCES Inventory (inventory_id),
    CONSTRAINT Products_Crops FOREIGN KEY (fk_crops_id) REFERENCES Crops (crops_id)
);

-- Tabla: Customer
CREATE TABLE Customer (
    customer_id INT NOT NULL IDENTITY(1, 1),
    name VARCHAR(50) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    phone CHAR(9) NOT NULL,
    email VARCHAR(200) NOT NULL,
    document_type VARCHAR(10) NOT NULL CHECK (document_type IN ('DNI', 'RUC', 'CE')),
    doc_number CHAR(11) NOT NULL,
    Status CHAR(1) NOT NULL DEFAULT 'A',
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT Customer_pk PRIMARY KEY (customer_id)
);

-- Tabla: Buys
CREATE TABLE Buys (
    buys_Id INT NOT NULL IDENTITY(1, 1),
    buys_price DECIMAL(10, 2) NOT NULL,  -- Precio total de la compra
    buys_date DATE NOT NULL,              -- Fecha de la compra
    fk_suppliers_id INT NOT NULL,         -- ID del proveedor
    CONSTRAINT Buys_pk PRIMARY KEY (buys_Id),
    CONSTRAINT Buys_Suppliers FOREIGN KEY (fk_suppliers_id) REFERENCES Suppliers (suppliers_id)
);

-- Tabla: Buys_detail
CREATE TABLE Buys_detail (
    buy_detail_id INT NOT NULL IDENTITY(1, 1),
    quantity INT NOT NULL,                     -- Cantidad de este producto en la compra
    unit_price DECIMAL(10, 2) NOT NULL,       -- Precio por unidad
    total_detail DECIMAL(10, 2) NOT NULL,      -- Total para este detalle (cantidad * precio unitario)
    batch VARCHAR(50) NOT NULL,                -- Lote del producto
    expire_date DATE NOT NULL,                 -- Fecha de caducidad
    presentation VARCHAR(50) NOT NULL,         -- Presentación del producto
    health_record VARCHAR(200) NOT NULL,       -- Registro sanitario
    fk_buys_Id INT NOT NULL,                   -- ID de Buys
    fk_products_id INT NOT NULL,               -- ID del producto
    CONSTRAINT Buys_detail_pk PRIMARY KEY (buy_detail_id),
    CONSTRAINT Buys_detail_Products FOREIGN KEY (fk_products_id) REFERENCES Products (products_id),
    CONSTRAINT fk_detail_Buys FOREIGN KEY (fk_buys_Id) REFERENCES Buys (buys_Id)
);

-- Tabla: Sale_details



-- Tabla: Sales
CREATE TABLE Sales (
    sale_id INT NOT NULL IDENTITY(1, 1),
    sale_date DATETIME NOT NULL DEFAULT GETDATE(),
    total DECIMAL(10, 2) NOT NULL,
    fk_customer_id INT NULL,
    CONSTRAINT Sales_pk PRIMARY KEY (sale_id),
    CONSTRAINT Sales_Customer FOREIGN KEY (fk_customer_id) REFERENCES Customer (customer_id)
);
CREATE TABLE Sale_details (
    sale_details_id INT NOT NULL IDENTITY(1, 1),
    quantity INT NOT NULL,
    sale_price DECIMAL(10, 2) NOT NULL,
    fk_products_id INT NOT NULL,
    fk_sale_id INT NULL,
    CONSTRAINT Sale_details_pk PRIMARY KEY (sale_details_id),
    CONSTRAINT Sale_details_Products FOREIGN KEY (fk_products_id) REFERENCES Products (products_id),
    CONSTRAINT Sale_details_Sales FOREIGN KEY (fk_sale_id) REFERENCES Sales (sale_id)
);

