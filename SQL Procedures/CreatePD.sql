

CREATE  OR ALTER PROCEDURE CreatePdTables
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;
    DECLARE @tableName NVARCHAR(50);
    DECLARE @columnName NVARCHAR(50);
    DECLARE @sql NVARCHAR(MAX);

    WHILE @i <= 20
    BEGIN
        -- Construct names dynamically
        SET @tableName = 'pd_' + CAST(@i AS NVARCHAR(10));
        SET @columnName = 'pd_id_' + CAST(@i AS NVARCHAR(10));

        -- Build the CREATE TABLE statement
        SET @sql = '
      
        BEGIN
            CREATE TABLE ' + QUOTENAME(@tableName) + ' (
                ' + QUOTENAME(@columnName) + ' INT PRIMARY KEY,
                [timestamp] SMALLDATETIME UNIQUE,
                [value] INT
            )
        END';

        -- Execute the dynamic SQL
        EXEC sp_executesql @sql;

        SET @i = @i + 1;
    END

    PRINT 'Successfully processed 20 tables.';
END;
GO


EXEC CreatePdTables;



