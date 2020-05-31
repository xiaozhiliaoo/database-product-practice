Jeremy Zawodny : http://jeremy.zawodny.com/mysql/

Giuseppe Maxia

https://use-the-index-luke.com/


好的资料：https://www.kawabangga.com/db

 show variables where variable_name like '%innodb_buffer_pool_size%';
 
 http://www.thecompletelistoffeatures.com/


explain format=json select * from engine_cost\G;
 
SELECT event_id, sql_text FROM performance_schema.events_statements_history_long WHERE sql_text like '%select * from engine_cost%';

SELECT event_name AS Stage,round(timer_wait/pow(10,12),6) AS Duration FROM events_stages_history_long WHERE nesting_event_id = 54;

SELECT SQL_NO_CACHE count(1) FROM sakila.rental WHERE last_update>'2006-02-18 00:00:00'\G
SELECT count(1) FROM sakila.rental WHERE last_update>'2006-02-18 00:00:00'\G

