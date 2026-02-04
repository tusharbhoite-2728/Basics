CREATE OR ALTER PROCEDURE GetPdHourlyDeltaMatrix
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX) = N'';
    DECLARE @i INT = 1;

    -- Build UNION ALL: (Timestamp, Series, DeltaHour)
    WHILE @i <= 20
    BEGIN
        DECLARE @table SYSNAME = N'pd_' + CAST(@i AS NVARCHAR(10));

        SET @sql +=
            CASE WHEN @i > 1 THEN N'
UNION ALL
' ELSE N'' END
            + N'
SELECT
    CAST(t1.[timestamp] AS SMALLDATETIME) AS [Timestamp],
    N''' + @table + N''' AS Series,
    (t2.[value] - t1.[value]) AS Delta
FROM ' + QUOTENAME(@table) + N' t1
LEFT JOIN ' + QUOTENAME(@table) + N' t2
    ON t2.[timestamp] = DATEADD(HOUR, 1, t1.[timestamp])
WHERE DATEPART(MINUTE, t1.[timestamp]) = 0
';
        SET @i += 1;
    END;

    -- Pivot columns pd_1..pd_20
    DECLARE @pivotCols NVARCHAR(MAX) = N'';
    SET @i = 1;
    WHILE @i <= 20
    BEGIN
        SET @pivotCols += CASE WHEN @i > 1 THEN N',' ELSE N'' END
                       + QUOTENAME(N'pd_' + CAST(@i AS NVARCHAR(10)));
        SET @i += 1;
    END;

    SET @sql = N'
;WITH AllHourly AS (
' + @sql + N'
)
SELECT
    [Timestamp],
    ' + @pivotCols + N'
FROM AllHourly
PIVOT (
    MAX(Delta) FOR Series IN (' + @pivotCols + N')
) p
ORDER BY [Timestamp];
';

    EXEC sp_executesql @sql;
END;
GO


EXEC GetPdHourlyDeltaMatrix;