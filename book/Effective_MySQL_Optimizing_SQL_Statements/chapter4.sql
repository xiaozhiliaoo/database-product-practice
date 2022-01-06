CREATE TABLE artist (
    artist_id INT UNSIGNED NOT NULL,
    type ENUM('Band', 'Person', 'Unknown', 'Combination') NOT NULL,
    name VARCHAR(255) NOT NULL,
    gender ENUM('Male', 'Female') DEFAULT NULL,
    founded YEAR DEFAULT NULL,
    country_id SMALLINT UNSIGNED DEFAULT NULL,
    PRIMARY KEY (artist_id),
    KEY `name` (`name`)
)  ENGINE=INNODB;

CREATE TABLE album (
    album_id INT UNSIGNED NOT NULL,
    artist_id INT UNSIGNED NOT NULL,
    album_type_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    first_released YEAR NOT NULL,
    country_id SMALLINT UNSIGNED DEFAULT NULL,
    PRIMARY KEY (album_id)
)  ENGINE=INNODB;

SELECT ar.name,ar.founded,al.name,al.first_released FROM artist ar  INNER JOIN album al USING(artist_id) WHERE ar.name='Queen';
ALTER TABLE artist ADD INDEX(name);
ALTER TABLE artist ADD INDEX(founded);
ALTER TABLE album ADD INDEX(artist_id);
ALTER TABLE artist ADD INDEX(type);
SET @@SESSION.optimizer_switch='index_merge_intersection=off';
SELECT artist_id,name,country_id FROM artist WHERE type ='Band' AND founded=1980;
SHOW INDEX FROM artist;
SELECT artist_id,name,country_id FROM artist WHERE name  LIKE 'Queue%';
SELECT artist_id,name,country_id FROM artist WHERE name  LIKE '%Queue';
SELECT artist_id,name,country_id FROM artist WHERE UPPER(name) = UPPER('Li Li');

INSERT INTO `book`.`artist` (`artist_id`, `type`, `name`, `gender`, `founded`, `country_id`) VALUES ('1', 'Person', 'lili', 'Male', 1993, '1');
FLUSH STATUS;
SHOW SESSION STATUS LIKE 'Handler_read_next';
SELECT name FROM artist WHERE name = 'lili';
SHOW SESSION STATUS LIKE 'Handler_read_next';

-- unique index
ALTER TABLE artist DROP INDEX name, ADD UNIQUE INDEX(name);
FLUSH STATUS;
SHOW SESSION STATUS LIKE 'Handler_read_next';
SELECT name FROM artist WHERE name = 'lili';
SHOW SESSION STATUS LIKE 'Handler_read_next';

FLUSH STATUS;
SELECT name,founded FROM artist WHERE name LIKE 'li%' ORDER BY founded;
SHOW SESSION STATUS LIKE '%sort%';
SELECT name,founded FROM artist WHERE name LIKE 'li%' ORDER BY name;
SHOW SESSION STATUS LIKE '%sort%';

ALTER TABLE album ADD INDEX(country_id),ADD INDEX(album_type_id);

ALTER TABLE album ADD INDEX m1(country_id,album_type_id);
ALTER TABLE album ADD INDEX m2(album_type_id,country_id);
SHOW INDEX FROM album;  -- see the index cardinality

ALTER TABLE artist ADD INDEX (type,gender,country_id);
SELECT name FROM artist WHERE type='Person' AND gender='Male' AND country_id='1';
SELECT name FROM artist WHERE type='Person' AND gender='Male';

ALTER TABLE album ADD INDEX(name);
SELECT al.name,ar.name,al.first_released FROM album al INNER JOIN artist ar USING(artist_id) WHERE al.name='lili' ORDER BY al.first_released;
ALTER TABLE album ADD INDEX name_release(name,first_released); -- no filesort

SET @@SESSION.optimizer_switch='index_merge_intersection=on';
SELECT artist_id,name from artist WHERE name='lili' OR founded ='1993';

SELECT al.name,ar.name,al.first_released FROM album al INNER JOIN artist ar USING(artist_id) WHERE al.name='lili' ORDER BY al.first_released;
EXPLAIN SELECT STRAIGHT_JOIN al.name,ar.name,al.first_released FROM album al INNER JOIN artist ar USING(artist_id) WHERE al.name='lili' ORDER BY al.first_released;
SELECT artist_id,name,country_id FROM artist WHERE founded='1993' AND type='Person';
EXPLAIN SELECT artist_id,name,country_id FROM artist USE INDEX(FOUNDED) WHERE founded='1993' AND type='Person';







