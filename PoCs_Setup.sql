/* Crear BD si no existe */
IF DB_ID('PoCs') IS NULL
    CREATE DATABASE PoCs;
GO

/* Usar la BD */
USE PoCs;
GO

/* ----- Tabla: dbo.Items ----- */
IF OBJECT_ID('dbo.Items','U') IS NOT NULL
    DROP TABLE dbo.Items;
GO

CREATE TABLE dbo.Items
(
    Id         INT IDENTITY(1,1) PRIMARY KEY,
    Nombre     VARCHAR(100) NOT NULL,
    Categoria  VARCHAR(50)  NOT NULL,
    Cantidad   INT          NOT NULL,
    Precio     INT          NOT NULL,
    Activo     INT          NOT NULL,
    FechaAlta  VARCHAR(30)  NOT NULL,
    Nota       VARCHAR(200) NULL
);
GO

/* ----- Tabla: dbo.Clientes ----- */
IF OBJECT_ID('dbo.Clientes','U') IS NOT NULL
    DROP TABLE dbo.Clientes;
GO

CREATE TABLE dbo.Clientes
(
    Id             INT IDENTITY(1,1) PRIMARY KEY,
    Nombres        VARCHAR(100) NOT NULL,
    Apellidos      VARCHAR(100) NOT NULL,
    Email          VARCHAR(150) NOT NULL,
    Telefono       VARCHAR(30)  NULL,
    Pais           VARCHAR(60)  NOT NULL,
    FechaRegistro  VARCHAR(30)  NOT NULL,
    Comentario     VARCHAR(200) NULL
);
GO

/* ----- Datos de ejemplo ----- */
INSERT INTO dbo.Items (Nombre, Categoria, Cantidad, Precio, Activo, FechaAlta, Nota)
VALUES
  ('Alpha','Hardware',10,1999,1,'2025-01-01 00:00:00','Initial load'),
  ('Beta','Software',20,2999,1,'2025-01-02 00:00:00','First batch'),
  ('Gamma','Accessories',30,950,1,'2025-01-03 00:00:00','Edition'),
  ('Delta','Services',40,9900,0,'2025-01-04 00:00:00','Annual plan');
GO

INSERT INTO dbo.Clientes (Nombres, Apellidos, Email, Telefono, Pais, FechaRegistro, Comentario)
VALUES
  ('Ana','Lopez','ana@example.com','+50370000001','El Salvador','2025-01-05 12:00:00','Demo client'),
  ('Bruno','Molina','bruno@example.com','+50370000002','El Salvador','2025-01-06 12:00:00','Preferred'),
  ('Clara','Nunez','clara@example.com','+50370000003','Guatemala','2025-01-07 12:00:00','New'),
  ('Diego','Ramos','diego@example.com','+50370000004','Honduras','2025-01-08 12:00:00','No comments');
GO

/* ----- Consultas ----- */
SELECT * FROM dbo.Items;
GO
SELECT * FROM dbo.Clientes;
GO
