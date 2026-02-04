

CREATE OR ALTER PROCEDURE GetPdDeltaMatrix
    @IntervalMinutes INT = 15
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX) = N'';
    DECLARE @i INT = 1;

    -- Build a UNION ALL of (Timestamp, SeriesName, Delta)
    WHILE @i <= 20
    BEGIN
        DECLARE @table SYSNAME = N'pd_' + CAST(@i AS NVARCHAR(10));

        SET @sql +=
            CASE WHEN @i > 1 THEN N'
UNION ALL
' ELSE N'' END
            + N'
SELECT
    [timestamp] AS [Timestamp],
    N''' + @table + N''' AS Series,
    CASE
        WHEN DATEDIFF(MINUTE, [timestamp],
             LEAD([timestamp]) OVER (ORDER BY [timestamp])) = ' + CAST(@IntervalMinutes AS NVARCHAR(10)) + N'
        THEN
             LEAD([value]) OVER (ORDER BY [timestamp]) - [value]
        ELSE NULL
    END AS Delta
FROM ' + QUOTENAME(@table) + N'
';
        SET @i += 1;
    END;

    -- Now pivot into columns pd_1..pd_20
    DECLARE @pivotCols NVARCHAR(MAX) = N'';
    SET @i = 1;
    WHILE @i <= 20
    BEGIN
        SET @pivotCols += CASE WHEN @i > 1 THEN N',' ELSE N'' END
                       + QUOTENAME(N'pd_' + CAST(@i AS NVARCHAR(10)));
        SET @i += 1;
    END;

    SET @sql = N'
;WITH AllDeltas AS (
' + @sql + N'
)
SELECT
    [Timestamp],
    ' + @pivotCols + N'
FROM AllDeltas
PIVOT (
    MAX(Delta) FOR Series IN (' + @pivotCols + N')
) p
ORDER BY [Timestamp];
';

    EXEC sp_executesql @sql;
END;
GO


EXEC GetPdDeltaMatrix @IntervalMinutes = 15;
