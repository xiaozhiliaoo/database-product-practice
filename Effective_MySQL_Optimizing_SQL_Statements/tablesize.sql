SET @schema = IFNULL(@schema, DATABASE());
SELECT @schema AS table_schema , CURDATE() AS today;
SELECT
    table_name,
    engine,
    row_format,
    table_rows,
    avg_row_length AS avg_row,
    ROUND((data_length + index_length) / 1024 / 1024,
            2) AS total_mb,
    ROUND((data_length) / 1024 / 1024, 2) AS data_mb,
    ROUND((index_length) / 1024 / 1024, 2) AS index_mb
FROM
    information_schema.tables
WHERE
    table_schema = @schema
AND table_name = @table;