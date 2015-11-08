SET search_path TO artistdb;
CREATE VIEW AS Artist_Many_Genres(
SELECT Artist.name as artist, 'Musician/band' as capacity, count(Album.genre) as genres
FROM Artist, Album
WHERE Artist.artist_id = Album.artist_id
GROUP BY Artist.artist_id
HAVING count(Album.genre) >= 3
);

CREATE VIEW AS Songwriter_Many_Genres(
--SELECT Artist.name as artist, 'song writer' as capacity, count(Album.genre) as genres
--FROM Artist, Album
--WHERE Artist.artist_id = Album.artist_id,
--GROUP BY Artist.artist_id
--HAVING count(Album.genre) >= 3

);
