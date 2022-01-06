-- 查看instance下所有schema的数据量
SELECT   table_schema,
         SUM(data_length+index_length)/1024/1024 AS total_mb,
         SUM(data_length)/1024/1024 AS data_mb,
         SUM(index_length)/1024/1024 AS index_mb,
         COUNT(*) AS tables,
         CURDATE() AS today
FROM     information_schema.tables
GROUP BY table_schema
ORDER BY 2 DESC;

SELECT   table_schema,
         SUM(data_length+index_length)/1024/1024/1024 AS total_GB,
         SUM(data_length)/1024/1024/1024 AS data_GB,
         SUM(index_length)/1024/1024/1024 AS index_GB,
         COUNT(*) AS tables,
         CURDATE() AS today
FROM     information_schema.tables
GROUP BY table_schema
ORDER BY 2 DESC;

-- 查看schema里面表的数据量
SELECT table_schema,table_name, table_rows,
       ROUND((data_length+index_length)/1024/1024) AS total_mb,
       ROUND(data_length/1024/1024) AS data_mb,
       ROUND(index_length/1024/1024) AS index_mb
FROM INFORMATION_SCHEMA.TABLES
WHERE engine='InnoDB' order by 4 desc;

SELECT table_schema,table_name, table_rows,
       ROUND((data_length+index_length)/1024/1024/1024) AS total_GB,
       ROUND(data_length/1024/1024/1024) AS data_GB,
       ROUND(index_length/1024/1024/1024) AS index_GB
FROM INFORMATION_SCHEMA.TABLES
WHERE engine='InnoDB' order by 4 desc;


-- 每个schema的表
SELECT   table_schema,engine,table_collation,
         COUNT(*) AS tables
FROM     information_schema.tables
GROUP BY table_schema,engine,table_collation
ORDER BY tables desc;

-- 所有schema的表数量
SELECT COUNT(*) AS tables FROM information_schema.tables;

--
select 'routines',count(*) from information_schema.routines
union
select 'views',count(*) from information_schema.views
union
select 'triggers',count(*) from information_schema.triggers;





