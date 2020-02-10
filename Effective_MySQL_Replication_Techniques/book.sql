SET GLOBAL sql_slave_skip_counter  = 1;
START SLAVE SQL_THREAD;

GRANT ALL ON *.*

mysqlbinlog ..\data\mysql-bin.000001

SHOW MASTER LOGS;

SHOW MASTER STATUS;

SHOW GLOBAL STATUS LIKE 'Com_insert%'

