SET search_path TO artistdb;
CREATE VIEW Solo AS(
SELECT album_id, sales, Album.artist_id, Artist.name
FROM Album, Artist
WHERE Album.artist_id = Artist.artist_id and album_id NOT IN (SELECT DISTINCT album_id
FROM BelongsToAlbum, Collaboration
WHERE BelongsToAlbum.song_id = Collaboration.song_id)
);

CREATE VIEW Collab AS(
(SELECT album_id, sales, Album.artist_id, Artist.name
FROM Album, Artist
WHERE Album.artist_id = Artist.artist_id)
EXCEPT
(SELECT * FROM Solo)
);

SELECT Collab.name AS artists, avg(Collab.sales) AS avg_collab_sales
FROM Solo, Collab
WHERE Solo.artist_id = Collab.artist_id
GROUP BY Collab.artist_id, Collab.name
HAVING avg(Collab.sales) > all(SELECT sales FROM Solo WHERE artist_id = Collab.artist_id);

DROP VIEW Solo CASCADE;
DROP VIEW Collab CASCADE;
