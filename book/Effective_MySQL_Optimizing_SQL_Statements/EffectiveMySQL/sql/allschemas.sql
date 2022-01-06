################################################################################
# Name     :  allschemas.sql
# Purpose  :  List a summary of all Instance Schemas including disk size
# Author   :  Ronald Bradford  http://ronaldbradford.com
# Version  :  3 3/4/11 - Added Storage Engines
################################################################################

SELECT   NOW(), VERSION();

-- 统计数据库所有schema占用空间
SELECT   table_schema,
         SUM(data_length+index_length)/1024/1024 AS total_mb,
         SUM(data_length)/1024/1024 AS data_mb,
         SUM(index_length)/1024/1024 AS index_mb,
         COUNT(*) AS tables,
         CURDATE() AS today
FROM     information_schema.tables
GROUP BY table_schema
ORDER BY 2 DESC;

-- 统计数据库所有schema存储引擎的种类
SELECT   table_schema,engine,table_collation,
         COUNT(*) AS tables
FROM     information_schema.tables
GROUP BY table_schema,engine,table_collation;

-- 存储过程，视图，触发器
select 'routines',count(*) from information_schema.routines
union
select 'views',count(*) from information_schema.views
union
select 'triggers',count(*) from information_schema.triggers;


# Set a session variable for the largest schema for later use
SELECT   @schema := table_schema,
         SUM(data_length+index_length)/1024/1024 AS total_mb
FROM     information_schema.tables
GROUP BY table_schema
ORDER BY 2 DESC
LIMIT 1;

