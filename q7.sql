SET search_path TO artistdb;

CREATE VIEW Covered_Songs AS
SELECT song_id
FROM BelongsToAlbum
GROUP BY song_id
HAVING count(song_id) > 1;

SELECT * From Covered_Songs;

SELECT Song.title, Album.year, Artist.name
FROM Song, Album, Artist, BelongsToAlbum
WHERE Song.song_id = BelongsToAlbum.song_id AND Album.album_id = BelongsToAlbum.album_id AND Song.song_id IN (SELECT song_id FROM Covered_Songs) AND Artist.artist_id = Album.artist_id
ORDER BY Song.title, Album.year, Artist.name;

DROP VIEW Covered_Songs CASCADE;
