SET @schema = IFNULL(@schema, DATABASE());
SET @table = 'user';
SELECT @schema AS table_schema , CURDATE() AS today;
SELECT table_name,engine,row_format,table_rows,avg_row_length AS avg_row,ROUND((data_length + index_length)/1024/1024,2)
 AS  total_mb,ROUND((data_length)/1024/1024,2) AS data_mb, ROUND((index_length)/1024/1024,2) AS index_mb
FROM information_schema.tables WHERE table_schema=@schema and table_name=@table;

SHOW GLOBAL STATUS LIKE 'Created_tmp_%tables';
SHOW SESSION STATUS LIKE 'Created_tmp_%tables';

FLUSH STATUS;
SELECT * FROM mysql.user;
SHOW SESSION STATUS LIKE 'handler_read%';

SELECT
    'SESSION' AS scope, variable_name, variable_value
FROM
    information_schema.session_variables
WHERE
    variable_name IN ('tmp_table_size' , 'max_heap_table_size')
UNION SELECT
    'GLOBAL' AS scope, variable_name, variable_value
FROM
    information_schema.global_variables
WHERE
    variable_name IN ('tmp_table_size' , 'max_heap_table_size')


CREATE SCHEMA IF NOT EXISTS book;
USE book;
CREATE TABLE source_words (
    word VARCHAR(50) NOT NULL,
    INDEX (word)
)  ENGINE=MYISAM;

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 'ON';
-- quit and relogin mysql --local-infile=1 -u root -p123456
LOAD DATA LOCAL INFILE 'D:/mysql/testfile/Master_Word_List.txt' INTO TABLE source_words(word);

CREATE TABLE million_words (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    word VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE INDEX (word)
)  ENGINE=INNODB;

INSERT INTO book.million_words(word) SELECT DISTINCT word FROM book.source_words;
INSERT INTO book.million_words(word) SELECT DISTINCT REVERSE(word) FROM book.source_words WHERE REVERSE(word) NOT IN (SELECT word FROM book.source_words);
SELECT @cnt := COUNT(*) FROM book.million_words;
SELECT @diff := 1000000 - @cnt;
SET @sql = CONCAT("insert into book.million_words(word) select distinct concat(word,'X1Y') from book.source_words limit ",@diff);
PREPARE cmd FROM @sql;
select @sql;
EXECUTE cmd;
SELECT COUNT(*) FROM book.million_words;

CREATE TABLE no_index_words LIKE book.million_words;
DESC no_index_words;
ALTER TABLE book.no_index_words DROP INDEX word;
INSERT INTO book.no_index_words SELECT * FROM book.million_words;
SELECT * FROM book.no_index_words WHERE word = 'aa';
SELECT * FROM book.million_words WHERE word = 'aa';

-- 主键索引，唯一索引，非主键索引
CREATE TABLE color (
    name VARCHAR(20) NOT NULL,
    items VARCHAR(255) NOT NULL
)  ENGINE=MYISAM;
INSERT INTO color(name,items) VALUE('RED','333'),('ORANGE','333eee'),('YELLOW','333'),('GREEN','333'),('WHITE','333');
ALTER TABLE color ADD INDEX(name);
od -c color.MYI
ls -lh ibdata1


SET SESSION max_heap_table_size = 1024 *1024 * 100;
CREATE TABLE memory_words (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    word VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE INDEX (word)
)  ENGINE=MEMORY;

INSERT INTO memory_words(id,word) SELECT id,word FROM million_words;
SET profiling =1;
SELECT * FROM book.memory_words WHERE word LIKE '%aa';
SHOW PROFILES;
SHOW WARNINGS;

SET SESSION max_heap_table_size = 1024 *1024 * 150;
ALTER TABLE memory_words DROP INDEX word;
ALTER TABLE memory_words ADD INDEX memory_words(word) USING BTREE;
