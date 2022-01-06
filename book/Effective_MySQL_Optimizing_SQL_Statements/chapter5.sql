SELECT artist_id,name,founded FROM artist WHERE founded='1993';
ALTER TABLE artist DROP INDEX founded, ADD INDEX founded_name(founded,name);
SELECT artist_id,name,founded FROM artist WHERE founded='1993';
ALTER TABLE artist DROP INDEX founded_name, ADD INDEX founded_name_type(founded,name,type);
SELECT artist_id,name,founded FROM artist WHERE founded='1993' and 	type='Person';
