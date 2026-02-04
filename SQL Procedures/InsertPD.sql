use University;
select * from dbo.pd_1;

select count(*) from pd_1;

select * from pd_20;


truncate table pd_1;

;


SELECT  t.name  AS table_name,
        c.name  AS column_name,
        ty.name AS data_type
FROM sys.tables t
JOIN sys.columns c ON c.object_id = t.object_id
JOIN sys.types ty ON ty.user_type_id = c.user_type_id
WHERE t.name LIKE 'pd[_]%'   -- pd_01, pd_02...
ORDER BY t.name, c.column_id;

use EMS;
create database EMS;
drop database EMS;


