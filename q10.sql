SET search_path TO artistdb;

CREATE TABLE Thriller_Songs AS
(SELECT Song.song_id as song_id, Album.album_id as a
FROM Song, Album, BelongsToAlbum
WHERE Song.song_id = BelongsToAlbum.song_id AND Album.album_id = BelongsToAlbum.album_id AND Album.title = 'Thriller');

DELETE FROM BelongsToAlbum
WHERE BelongsToAlbum.song_id IN (SELECT song_id from Thriller_Songs) OR BelongsToAlbum.album_id = (SELECT Album.album_id FROM Album WHERE Album.title = 'Thriller');

DELETE FROM Collaboration
WHERE song_id IN (SELECT song_id from Thriller_Songs);


DELETE FROM ProducedBy 
WHERE ProducedBy.album_id IN (SELECT Album.album_id FROM Album WHERE Album.title = 'Thriller');


DELETE FROM Song 
WHERE Song.song_id IN (SELECT song_id from Thriller_Songs);


DELETE FROM Album WHERE Album.title = 'Thriller';


DROP TABLE Thriller_Songs CASCADE;
