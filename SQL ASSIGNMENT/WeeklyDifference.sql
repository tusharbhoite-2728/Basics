CREATE OR ALTER PROCEDURE GetPdWeeklyDeltaMatrix
AS
BEGIN
    
    SET DATEFIRST 7; 

    WITH Marks AS
    (
        SELECT p1.[timestamp]
        FROM pd_1 p1
        CROSS JOIN (SELECT MIN([timestamp]) AS MinTs, MAX([timestamp]) AS MaxTs FROM pd_1) b
        WHERE
            p1.[timestamp] = b.MinTs
            OR p1.[timestamp] = b.MaxTs
            OR (
                DATEPART(HOUR,   p1.[timestamp]) = 0
                AND DATEPART(MINUTE, p1.[timestamp]) = 0
                AND DATEPART(WEEKDAY, p1.[timestamp]) = 1
            )
    )
    SELECT TOP (SELECT COUNT(*) - 1 FROM Marks)
        CAST(pd_1.[timestamp] AS smalldatetime) AS [TimeStamp],

        LEAD(pd_1.[value])  OVER (ORDER BY pd_1.[timestamp]) - pd_1.[value]  AS pd_1,
        LEAD(pd_2.[value])  OVER (ORDER BY pd_1.[timestamp]) - pd_2.[value]  AS pd_2,
        LEAD(pd_3.[value])  OVER (ORDER BY pd_1.[timestamp]) - pd_3.[value]  AS pd_3,
        LEAD(pd_4.[value])  OVER (ORDER BY pd_1.[timestamp]) - pd_4.[value]  AS pd_4,
        LEAD(pd_5.[value])  OVER (ORDER BY pd_1.[timestamp]) - pd_5.[value]  AS pd_5,
        LEAD(pd_6.[value])  OVER (ORDER BY pd_1.[timestamp]) - pd_6.[value]  AS pd_6,
        LEAD(pd_7.[value])  OVER (ORDER BY pd_1.[timestamp]) - pd_7.[value]  AS pd_7,
        LEAD(pd_8.[value])  OVER (ORDER BY pd_1.[timestamp]) - pd_8.[value]  AS pd_8,
        LEAD(pd_9.[value])  OVER (ORDER BY pd_1.[timestamp]) - pd_9.[value]  AS pd_9,
        LEAD(pd_10.[value]) OVER (ORDER BY pd_1.[timestamp]) - pd_10.[value] AS pd_10,
        LEAD(pd_11.[value]) OVER (ORDER BY pd_1.[timestamp]) - pd_11.[value] AS pd_11,
        LEAD(pd_12.[value]) OVER (ORDER BY pd_1.[timestamp]) - pd_12.[value] AS pd_12,
        LEAD(pd_13.[value]) OVER (ORDER BY pd_1.[timestamp]) - pd_13.[value] AS pd_13,
        LEAD(pd_14.[value]) OVER (ORDER BY pd_1.[timestamp]) - pd_14.[value] AS pd_14,
        LEAD(pd_15.[value]) OVER (ORDER BY pd_1.[timestamp]) - pd_15.[value] AS pd_15,
        LEAD(pd_16.[value]) OVER (ORDER BY pd_1.[timestamp]) - pd_16.[value] AS pd_16,
        LEAD(pd_17.[value]) OVER (ORDER BY pd_1.[timestamp]) - pd_17.[value] AS pd_17,
        LEAD(pd_18.[value]) OVER (ORDER BY pd_1.[timestamp]) - pd_18.[value] AS pd_18,
        LEAD(pd_19.[value]) OVER (ORDER BY pd_1.[timestamp]) - pd_19.[value] AS pd_19,
        LEAD(pd_20.[value]) OVER (ORDER BY pd_1.[timestamp]) - pd_20.[value] AS pd_20
    FROM Marks m
    JOIN pd_1 ON pd_1.[timestamp] = m.[timestamp]
    LEFT JOIN pd_2  ON pd_2.[timestamp]  = pd_1.[timestamp]
    LEFT JOIN pd_3  ON pd_3.[timestamp]  = pd_1.[timestamp]
    LEFT JOIN pd_4  ON pd_4.[timestamp]  = pd_1.[timestamp]
    LEFT JOIN pd_5  ON pd_5.[timestamp]  = pd_1.[timestamp]
    LEFT JOIN pd_6  ON pd_6.[timestamp]  = pd_1.[timestamp]
    LEFT JOIN pd_7  ON pd_7.[timestamp]  = pd_1.[timestamp]
    LEFT JOIN pd_8  ON pd_8.[timestamp]  = pd_1.[timestamp]
    LEFT JOIN pd_9  ON pd_9.[timestamp]  = pd_1.[timestamp]
    LEFT JOIN pd_10 ON pd_10.[timestamp] = pd_1.[timestamp]
    LEFT JOIN pd_11 ON pd_11.[timestamp] = pd_1.[timestamp]
    LEFT JOIN pd_12 ON pd_12.[timestamp] = pd_1.[timestamp]
    LEFT JOIN pd_13 ON pd_13.[timestamp] = pd_1.[timestamp]
    LEFT JOIN pd_14 ON pd_14.[timestamp] = pd_1.[timestamp]
    LEFT JOIN pd_15 ON pd_15.[timestamp] = pd_1.[timestamp]
    LEFT JOIN pd_16 ON pd_16.[timestamp] = pd_1.[timestamp]
    LEFT JOIN pd_17 ON pd_17.[timestamp] = pd_1.[timestamp]
    LEFT JOIN pd_18 ON pd_18.[timestamp] = pd_1.[timestamp]
    LEFT JOIN pd_19 ON pd_19.[timestamp] = pd_1.[timestamp]
    LEFT JOIN pd_20 ON pd_20.[timestamp] = pd_1.[timestamp]
    ORDER BY pd_1.[timestamp];
    

  

   
END;
GO

EXEC GetPdWeeklyDeltaMatrix;
