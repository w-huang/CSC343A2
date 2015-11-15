--SET search_path TO artistdb;

CREATE VIEW Canadian_Albums AS(
SELECT album_id, Album.artist_id as artist_id, name, year
FROM Album, Artist
WHERE Album.artist_id = Artist.artist_id and lower(nationality)  = 'canada'
);

SELECT album_id, artist_id, name
FROM Canadian_Albums
GROUP BY artist_id
HAVING year = 2011;


--CREATE VIEW Indie_Canadians AS(
--SELECT artist_id, name
--FROM Canadian_Albums
--GROUP BY artist_id

--);

--DROP VIEW Indie_Canadians CASCADE;
DROP VIEW Canadian_Albums CASCADE;
