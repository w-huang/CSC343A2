SET search_path TO artistdb;

CREATE VIEW Canadian_Albums AS(
SELECT album, artist_id, name, year
FROM Album, Artist
WHERE Album.artist_id = Artist.artist_id and nationality  = 'Canadian'
);

SELECT album, artist_id, name,
FROM Canadian_Albums
GROUP BY artist_id
HAVING year = min(SELECT year FROM Canadian_Albums)


CREATE VIEW Indie_Canadians AS(
SELECT artist_id, name
FROM Canadian_Albums
GROUP BY artist_id

)
