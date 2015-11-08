SET search_path TO artistdb;

CREATE VIEW Not_Being_Yourself AS
SELECT DISTINCT Album.album_id
FROM Album, BelongsToAlbum, Song
WHERE Album.album_id = BelongsToAlbum.album_id AND BelongsToAlbum.song_id = Song.song_id AND Song.songwriter_id != Album.artist_id;

SELECT Artist.name, Album.name
FROM Artist, Album
WHERE Album.album_id NOT IN Not_Being_Yourself AND Artist.artist_id = Album.artist_id
ORDER BY Artist.name ASC; 
