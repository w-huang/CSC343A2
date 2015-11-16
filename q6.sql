SET search_path TO artistdb;

CREATE VIEW Canadian_Albums AS (
SELECT album_id, Album.artist_id AS artist_id, name, year
FROM Album, Artist
WHERE Album.artist_id = Artist.artist_id AND lower(nationality)  = 'canada'
);

CREATE VIEW First_Year AS (
SELECT min(year) AS first_year, artist_id, name
FROM Canadian_Albums
GROUP BY artist_id, name);

CREATE VIEW First_Album AS (
SELECT album_id, First_Year.artist_id, First_Year.name
FROM Canadian_Albums, First_Year
WHERE Canadian_Albums.year = First_Year AND First_Year.artist_id = Canadian_Albums.artist_id AND First_Year.name = Canadian_Albums.name);

CREATE VIEW Indie_First AS (
SELECT album_id,artist_id, name
FROM First_Album
WHERE album_id NOT IN (SELECT album_id FROM ProducedBy)
);

CREATE VIEW Not_First_Album AS (
(SELECT album_id, artist_id, name FROM Canadian_Albums)
EXCEPT
(SELECT * FROM Indie_First)
);

SELECT Indie_First.name
FROM Indie_First, Not_First_Album
WHERE Indie_First.name = Not_First_Album.name AND Indie_First.artist_id = Not_First_Album.artist_id AND Not_First_Album.album_id in (SELECT album_id FROM ProducedBy, RecordLabel WHERE ProducedBy.label_id = RecordLabel.label_id AND lower(country) = 'america');

DROP VIEW Not_First_Album CASCADE;
DROP VIEW Indie_First CASCADE;
DROP VIEW First_Album CASCADE;
DROP VIEW First_Year CASCADE;
DROP VIEW Canadian_Albums CASCADE;
