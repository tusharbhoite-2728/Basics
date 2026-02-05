CREATE OR ALTER PROCEDURE CreatePdTables

AS

BEGIN

    SET NOCOUNT ON;



    DECLARE @i INT = 1;

    DECLARE @tableName NVARCHAR(50);

    DECLARE @columnName NVARCHAR(50);

    DECLARE @sql NVARCHAR(MAX);



    WHILE @i <= 20

    BEGIN

       

        SET @tableName = 'pd_' + CAST(@i AS NVARCHAR(10));

        SET @columnName = 'pd_id_' + CAST(@i AS NVARCHAR(10));



        

        SET @sql = '

        IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''' + @tableName + ''') AND type in (N''U''))

        BEGIN

            CREATE TABLE ' + QUOTENAME(@tableName) + ' (

                ' + QUOTENAME(@columnName) + ' INT PRIMARY KEY,

                [timestamp] DATETIME2 UNIQUE,

                [value] FLOAT

            )

        END';



      

        EXEC sp_executesql @sql;



        SET @i = @i + 1;

    END



    PRINT 'Successfully processed 20 tables.';

END;

GO





EXEC CreatePdTables;