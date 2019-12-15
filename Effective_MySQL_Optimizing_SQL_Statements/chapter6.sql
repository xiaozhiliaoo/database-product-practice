SHOW GLOBAL VARIABLES LIKE 'key_cache%';
SHOW GLOBAL VARIABLES LIKE 'preload%';
SHOW GLOBAL VARIABLES LIKE 'key_buffer_size%';

SHOW GLOBAL VARIABLES LIKE 'key_cache%';
SHOW GLOBAL VARIABLES LIKE 'preload%';
SHOW GLOBAL VARIABLES LIKE 'key_buffer_size%';
SHOW GLOBAL VARIABLES LIKE 'innodb_buffer_pool_size';
SHOW GLOBAL VARIABLES LIKE 'innodb_buffer%';
SHOW ENGINE INNODB STATUS;
SHOW VARIABLES LIKE 'have_query_cache';
SHOW VARIABLES LIKE 'query_cache%'; -- remove mysql8
SHOW STATUS LIKE 'Qcache%';
SHOW SESSION STATUS LIKE 'create%tables';
SHOW VARIABLES LIKE 'join_buffer_size';
SHOW VARIABLES LIKE 'sort_buffer_size';
-- slow query and general log is csv storage engine
SHOW VARIABLES LIKE 'read_%';
SHOW VARIABLES LIKE 'slow_query%';
SHOW VARIABLES LIKE 'long_query_time';
SELECT * FROM mysql.slow_log;
SHOW VARIABLES LIKE 'general%';
SHOW VARIABLES LIKE 'profiling%';
SHOW VARIABLES LIKE 'default%';
SHOW VARIABLES LIKE 'max_allowed_packet%';
SHOW VARIABLES LIKE 'sql_mode%';
SHOW VARIABLES LIKE 'innodb_strict%';
SHOW VARIABLES LIKE 'transaction_isolation%'






