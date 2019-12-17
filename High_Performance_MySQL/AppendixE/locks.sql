SELECT r.trx_id AS waiting_trx_id,  r.trx_mysql_thread_id AS waiting_thread,
       TIMESTAMPDIFF(SECOND, r.trx_wait_started, CURRENT_TIMESTAMP) AS wait_time,
       r.trx_query AS waiting_query,
       l.lock_table AS waiting_table_lock,
       b.trx_id AS blocking_trx_id, b.trx_mysql_thread_id AS blocking_thread,
       SUBSTRING(p.host, 1, INSTR(p.host, ':') - 1) AS blocking_host,
       SUBSTRING(p.host, INSTR(p.host, ':') +1) AS blocking_port,
       IF(p.command = "Sleep", p.time, 0) AS idle_in_trx,
       b.trx_query AS blocking_query
FROM          INFORMATION_SCHEMA.INNODB_LOCK_WAITS AS w
   INNER JOIN INFORMATION_SCHEMA.INNODB_TRX        AS b ON  b.trx_id = w.blocking_trx_id
   INNER JOIN INFORMATION_SCHEMA.INNODB_TRX        AS r ON  r.trx_id = w.requesting_trx_id
   INNER JOIN INFORMATION_SCHEMA.INNODB_LOCKS      AS l ON  w.requested_lock_id = l.lock_id
   LEFT JOIN  INFORMATION_SCHEMA.PROCESSLIST       AS p ON  p.id     = b.trx_mysql_thread_id
ORDER BY wait_time DESC\G


SELECT CONCAT('thread ', b.trx_mysql_thread_id, ' from ', p.host) AS who_blocks,
       IF(p.command = "Sleep", p.time, 0) AS idle_in_trx,
       MAX(TIMESTAMPDIFF(SECOND, r.trx_wait_started, CURRENT_TIMESTAMP)) AS max_wait_time,
       COUNT(*) AS num_waiters
FROM          INFORMATION_SCHEMA.INNODB_LOCK_WAITS AS w
   INNER JOIN INFORMATION_SCHEMA.INNODB_TRX        AS b ON  b.trx_id = w.blocking_trx_id
   INNER JOIN INFORMATION_SCHEMA.INNODB_TRX        AS r ON  r.trx_id = w.requesting_trx_id
   LEFT JOIN  INFORMATION_SCHEMA.PROCESSLIST       AS p ON  p.id     = b.trx_mysql_thread_id
GROUP BY who_blocks ORDER BY num_waiters DESC\G