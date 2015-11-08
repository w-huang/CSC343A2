SET search_path TO artistdb;
CREATE VIEW Solo AS(
SELECT album_id, sales, artist_id
FROM Album
WHERE album_id NOT IN (SELECT DISTINCT album_id
FROM BelongsToAlbum, Collaboration
WHERE BelongsToAlbum.song_id = Collaboration.song_id)
);

CREATE VIEW Collab AS(
(SELECT album_id, sales, artist_id
FROM Album, Artist
WHERE Album.artist_id = Artist.artist_id)
EXCEPT
(Solo)
);

SELECT name as artists, avg(Collab.sales) as avg_collab_sales
FROM Solo, Collab
WHERE Solo.artist_id = Collab.artist_id
HAVING avg(Collab.sales) > any(Solo.sales)
GROUP BY artist_id;
--consider case where there is only collab albums
