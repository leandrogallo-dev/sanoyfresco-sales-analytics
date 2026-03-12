/*
================================================================================
                           CREATE DATABASE 'sanoyfresco'
================================================================================
[!] DESCRIPTION:
    This script automates the creation of the 'sanoyfresco' database and the 'tickets' table. Use Dynamic SQL to allow file paths via variables
    and safely handle bulk data imports (BULK INSERT).

[!] STRUCTURE:
    1. Verify and create the database if it doesn't exist.
    2. Change the context to 'sanoyfresco'.
    3. Create the 'tickets' table only if it doesn't already exist.
    4. Execute the bulk load within a transaction to ensure data integrity.
    5. Catch errors and perform a ROLLBACK if the load fails.

[X] WARNING:
    - SQL Server requires READ permissions on the 'C:\Data\' folder.
    - Access is required by the "SQL Server Service Account"
    (e.g., NT Service\MSSQLSERVER), not just your Windows user account.
    - Ensure that the 'tickets.csv' file is not open in Excel during execution.

================================================================================
*/

USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'sanoyfresco')
BEGIN
    ALTER DATABASE sanoyfresco 
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE sanoyfresco;
    PRINT '[+] Base de datos eliminada correctamente.';
END

CREATE DATABASE sanoyfresco;
GO

USE sanoyfresco;
GO

IF OBJECT_ID(N'dbo.tickets', N'U') IS NULL
BEGIN
    -- BLOQUE 1: CREACIÓN DE TABLA
    BEGIN TRY
        BEGIN TRANSACTION;
            CREATE TABLE [dbo].[tickets] (
                id_pedido INT NOT NULL,
                id_cliente INT NOT NULL,
                fecha DATE,
                hora INT,
                id_departamento INT NOT NULL,
                id_seccion INT NOT NULL,
                id_producto INT NOT NULL,
                nombre_producto NVARCHAR(255),
                precio_unitario DECIMAL(18,2),
                cantidad INT,
                precio_total DECIMAL(18,2)
            );
        COMMIT TRANSACTION;
        PRINT '[+] Proceso completado: Tabla creada.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        PRINT '[x] ERROR en creación de tabla: ' + ERROR_MESSAGE();
    END CATCH


    -- BLOQUE 2: IMPORTACIÓN Y TIEMPO
    BEGIN TRY
        DECLARE @StartTime DATETIME2 = SYSDATETIME();
        DECLARE @path NVARCHAR(255) = 'C:\Data\';
        DECLARE @csvPath NVARCHAR(255) = @path + 'tickets.csv';
        DECLARE @logPath NVARCHAR(255) = @path + 'tickets_errores.log';

        -- SQL Dinámico con corrección de comas y formato CSV
        DECLARE @bulkSql NVARCHAR(MAX) = N'
        BULK INSERT [dbo].[tickets]
        FROM ''' + @csvPath + '''
        WITH (
            FORMAT = ''CSV'',
            FIELDQUOTE = ''"'',
            FIRSTROW = 2,
            FIELDTERMINATOR = '','',
            ROWTERMINATOR = ''\n'',
            TABLOCK,
            ERRORFILE = ''' + @logPath + ''' -- Coma eliminada aquí
        );';

        BEGIN TRANSACTION; -- Iniciamos transacción para la carga
            EXEC sp_executesql @bulkSql;
        COMMIT TRANSACTION;

        DECLARE @EndTime DATETIME2 = SYSDATETIME();
        PRINT '[+] Tiempo total de ejecución: ' + CAST(DATEDIFF(SECOND, @StartTime, @EndTime) AS VARCHAR(10)) + ' segundos.';
        PRINT '[+] Datos importados correctamente.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        PRINT '[x] ERROR en importación:';
        PRINT '[!] Mensaje: ' + ERROR_MESSAGE();
    END CATCH
END
ELSE
BEGIN
    PRINT '[!] Table dbo.tickets already exists.';
END
