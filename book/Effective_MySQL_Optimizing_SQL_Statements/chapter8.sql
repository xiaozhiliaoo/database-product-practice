ALTER TABLE test ADD INDEX(username);
ALTER TABLE test DROP INDEX username, ADD INDEX name(last_name,first_name);
ALTER TABLE test ADD COLUMN last_visit DATE NULL;

-- combine DDL
ALTER TABLE test ADD INDEX (username),DROP INDEX name,ADD INDEX name (last_name, first_name),ADD COLUMN last_visit DATE NULL;

CREATE TABLE test (
    id INT UNSIGNED NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    joined DATE NOT NULL,
    PRIMARY KEY (id),
    INDEX (id)
)

CREATE TABLE test (
    id INT UNSIGNED NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    joined DATE NOT NULL,
    PRIMARY KEY (id),
    INDEX name1 (last_name),
    INDEX name2 (last_name , first_name)
);

BIGINT AUTO_INCREMENT -> INT UNSIGNED AUTO_INCREMENT

-- ipv4 INT UNSIGNED 4 bytes vs VARCHAR(15) 15bytes
SET @ip='123.100.0.16';
SELECT @ip,INET_ATON(@ip) AS str_to_i,INET_NTOA(INET_ATON(@ip)) AS i_to_str;

SET @str = 'somevalue';
SELECT MD5(@str), LENGTH(MD5(@str)) AS len_md5, LENGTH(UNHEX(MD5(@str))) AS len_unhex;

SHOW PROFILE SOURCE FOR QUERY 7;

SELECT
    'Sum Individual Queries' AS txt, SUM(DURATION) AS total_time
FROM
    INFORMATION_SCHEMA.PROFILING
WHERE
    QUERY_ID BETWEEN 1 AND 12
UNION SELECT
    'Combined Query', SUM(DURATION)
FROM
    INFORMATION_SCHEMA.PROFILING
WHERE
    QUERY_ID = 13;


SET GLOBAL query_cache_size=1024*1024*16;
SET GLOBAL query_cache_type=1;
SET PROFILING=1;
SELECT name FROM firms WHERE id=727;
SELECT name FROM firms WHERE id=727; -- in cache will be fast
SHOW PROFILES;


SELECT id, label
FROM code_opts
WHERE code_id = (SELECT id FROM codes WHERE typ='CATEGORIES')
ORDER BY seq

SELECT o.id, o.label
FROM code_opts o INNER JOIN codes c ON o.code_id = c.id
WHERE c.typ='CATEGORIES'
ORDER BY o.seq

