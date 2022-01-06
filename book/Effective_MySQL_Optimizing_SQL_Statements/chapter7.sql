-- sql lifecycle

-- general log
SET GLOBAL general_log = 'ON';
SHOW VARIABLES LIKE 'general_log%';
SHOW VARIABLES LIKE 'log_output%';
SET GLOBAL log_output = 'TABLE';
SELECT * FROM mysql.general_log;
SHOW FULL PROCESSLIST;

-- slow query log
SHOW VARIABLES LIKE 'slow_query%';
SET GLOBAL slow_query_log = 'ON';
SHOW GLOBAL VARIABLES LIKE 'long_query_time';
SET GLOBAL long_query_time = 0.1;
SELECT SLEEP(0.1);
SELECT SLEEP(0.2);
SELECT SLEEP(0.3);
SELECT SLEEP(1);
SELECT SLEEP(2);

-- bin log
SHOW GLOBAL VARIABLES LIKE 'log_bin%'
mysqlbinlog.exe -uroot -p123456 D:\mysql\mysql-8.0.18-winx64\data\binlog


-- proess list
SHOW FULL PROCESSLIST;
mysqladmin.exe -uroot -p123456 processlist   -- 这里没有；号
SELECT * FROM information_schema.PROCESSLIST;
mysqladmin.exe -uroot -p123456 version


-- innodb status
SHOW ENGINES; -- list all engine
SHOW ENGINE INNODB STATUS;
SHOW ENGINE INNODB MUTEX;
SHOW ENGINE PERFORMANCE_SCHEMA STATUS
SELECT * FROM information_schema.INNODB_TRX;

-- audit
SHOW VARIABLES LIKE 'audit_log%';
-- sql优化:1 执行频率最高，2 执行时间最久 一条执行频率百万次查询10ms收益大于一条执行几次1s

sudo tcpdump -l -i eth0 -w - src or dst port 3306 -c 1000 | strings

mysqlbinlog.exe -uroot -p123456 D:\mysql\mysql-8.0.18-winx64\data\binlog.000001


SET profiling=1;
SELECT NOW();
SELECT BENCHMARK(1+1,100000);
SELECT BENCHMARK('1'+'1',100000);
SELECT SLEEP(1);
SELECT SLEEP(2);
SHOW PROFILES;



