SHOW FULL PROCESSLIST;
SELECT * FROM information_schema.PROCESSLIST;
SELECT * FROM performance_schema.threads;
SHOW CREATE TABLE traning.person;
SHOW TABLE STATUS LIKE 'mysql.general_log';
EXPLAIN SELECT host,user FROM mysql.user WHERE user LIKE 'r%';
EXPLAIN SELECT host,user FROM mysql.user WHERE host	='localhost' AND user LIKE 'r%';
EXPLAIN SELECT host,user FROM mysql.user WHERE host	='localhost' AND user LIKE 'r%';
SHOW WARNINGS;
SHOW CREATE TABLE mysql.user;
SHOW INDEX FROM mysql.user;
SHOW TABLE STATUS LIKE 'mysql.user';
SELECT * FROM information_schema.tables;

