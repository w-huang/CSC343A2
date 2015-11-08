SET search_path TO artistdb;

CREATE VIEW Thriller_Songs AS
SELECT Song.song_id
FROM Song, Album, BelongsToAlbum
WHERE Song.song_id = BelongsToAlbum.Songid AND Album.album_id = BelongsToAlbum.album_id AND Album.title = 'Thriller';

DELETE FROM Collaboration
WHERE song_id IN Thriller_Songs;

DELETE FROM Song 
WHERE Song.song_id IN Thriller_Songs;

DELETE FROM ProducedBy
WHERE ProducedBy.album_id IN (SELECT Album.album_id FROM Album WHERE Album.title = 'Thriller');

DELETE FROM BelongsToAlbum 
WHERE BelongsToAlbum.song_id IN Thriller_Songs OR BelongsToAlbum.album_id = (SELECT Album.album_id FROM Album WHERE Album.title = 'Thriller');

DELETE FROM Album
Where Album.title = 'Thriller'



---update Role?

