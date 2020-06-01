Jeremy Zawodny : http://jeremy.zawodny.com/mysql/

Giuseppe Maxia

https://use-the-index-luke.com/


好的资料：https://www.kawabangga.com/db

 show variables where variable_name like '%innodb_buffer_pool_size%';
 
 http://www.thecompletelistoffeatures.com/
 
 http://www.markleith.co.uk/presentations/
 


explain format=json select * from engine_cost\G;
 
EXPLAIN SELECT * FROM staff;
SELECT event_id, sql_text FROM performance_schema.events_statements_history_long WHERE sql_text like '%select * from city%';
SELECT event_name AS Stage,round(timer_wait/pow(10,12),6) AS Duration FROM events_stages_history_long WHERE nesting_event_id = 54;

SELECT SQL_NO_CACHE count(1) FROM sakila.rental WHERE last_update>'2006-02-18 00:00:00'\G;
SELECT count(1) FROM sakila.rental WHERE last_update>'2006-02-18 00:00:00'\G

SELECT f.rating,sum(p.amount) as income FROM film f JOIN inventory i ON i.film_id = f.film_id JOIN rental r ON r.inventory_id = i.inventory_id JOIN payment p ON p.rental_id=r.rental_id GROUP BY f.rating ORDER BY income DESC;

SELECT count(1) FROM rental WHERE customer_id=148 AND return_date BETWEEN '2005-08-29 00:00:00' AND '2005-09-05 23:59:59' AND last_update BETWEEN '2006-02-15 00:00:00' AND '2006-02-15 23:59:59';

SELECT COUNT(1) FROM rental WHERE customer_id=148 AND return_date BETWEEN '2005-08-29 00:00:00' AND '2005-09-05 23:59:59' UNION SELECT COUNT(1) FROM rental WHERE customer_id=148 AND last_update BETWEEN '2006-02-15 00:00:00' AND '2006-02-15 23:59:59';

EXPLAIN SELECT COUNT(1) FROM rental WHERE customer_id=148 AND return_date BETWEEN '2005-08-29 00:00:00' AND '2005-09-05 23:59:59' UNION SELECT COUNT(1) FROM rental WHERE customer_id=148 AND last_update BETWEEN '2006-02-15 00:00:00' AND '2006-02-15 23:59:59';

Metadata:Information Schema
Runtime:Performance Schema

PS:
 select thread_id, EVENT_NAME, sum(NUMBER_OF_BYTES/1024) sum_kb from events_waits_history where NUMBER_OF_BYTES > 0 group by thread_id, EVENT_NAME order by sum_kb desc;

SELECT THREAD_ID TID, SUBSTR(SQL_TEXT, 1, 50) SQL_TEXT, ROWS_SENT RS,ROWS_EXAMINED RE,CREATED_TMP_TABLES,NO_INDEX_USED,NO_GOOD_INDEX_USED FROM performance_schema.events_statements_history WHERE NO_INDEX_USED=1 OR NO_GOOD_INDEX_USED=1\G

SELECT eshl.event_name, sql_text, eshl.timer_wait/1000000000000 w_s FROM performance_schema.events_stages_history_long eshl JOIN performance_schema.events_statements_history_long esthl ON (eshl.nesting_event_id = esthl.event_id) WHERE eshl.timer_wait > 1*10000000000\G

select SQL_TEXT, sum(COUNT_EXECUTE) from prepared_statements_instances group by SQL_TEXT;
 
select thread_id, event_name, sql_text from events_statements_history  where event_name like 'statement/sp%';
 
select id, db, state, info, time from information_schema.processlist;
  
select processlist_id, object_type, lock_type, lock_status, source from metadata_locks join threads on (owner_thread_id=thread_id)  where object_schema=’sbtest’ and object_name='sbtest1';
   
select event_name, count_alloc, count_free,CURRENT_NUMBER_OF_BYTES_USED/1024/1024 as used_mb from memory_summary_global_by_event_name where CURRENT_NUMBER_OF_BYTES_USED > 0 order by used_mb desc limit 8;
   
 select * from variables_by_thread where variable_name='join_buffer_size';   
 
  select * from status_by_thread where variable_name='Handler_write';
  
  select * from user_variables_by_thread;
  
   select ERROR_NUMBER NUM, ERROR_NAME, SUM_ERROR_RAISED SUM, FIRST_SEEN, LAST_SEEN from events_errors_summary_global_by_error where SUM_ERROR_RAISED > 0 order by SUM_ERROR_RAISED desc;
   
   select * from setup_actors;
   
   select * from setup_threads;
    
   select * from setup_objects;
   
   select * from setup_consumers;
   
   select NAME, ENABLED, TIMED, PROPERTIES, VOLATILITY from setup_instruments order by rand() limit 3;
   
   show processlist;
   explain for connection 18;
   
SELECT NAME, COMMENT FROM INFORMATION_SCHEMA.INNODB_METRICS WHERE NAME LIKE '%ibuf%'\G

SELECT @@default_storage_engine;

SHOW TABLE STATUS FROM sakila like '%staff%'  \G;

