SET search_path TO artistdb;

CREATE VIEW MusicianID_Genres AS(
SELECT DISTINCT Artist.artist_id as artist, Album.genre_id as genre
FROM Artist, Album, Role
WHERE Artist.artist_id = Album.artist_id and lower(Role.role) = 'musician' and Artist.artist_id = Role.artist_id
);

CREATE VIEW BandID_Genres AS(
SELECT DISTINCT Artist.artist_id as artist, Album.genre_id as genre
FROM Artist, Album, Role
WHERE Artist.artist_id = Album.artist_id and lower(Role.role) = 'band' and Artist.artist_id = Role.artist_id
);

CREATE VIEW SongwriterID_Genres AS(
SELECT DISTINCT Song.songwriter_id as writer, Album.genre_id as genre
FROM Song, Album, BelongsToAlbum
WHERE Song.song_id = BelongsToAlbum.song_id and Album.album_id = BelongsToAlbum.album_id
);

CREATE VIEW Many_Genres AS(
(SELECT Artist.name as artist, 'Songwriter' as capacity, count(SongwriterID_Genres.genre) as genres, 2 as priority
FROM SongwriterID_Genres, Artist
WHERE SongwriterID_Genres.writer = Artist.artist_id
GROUP BY Artist.name
HAVING count(SongwriterID_Genres.genre) >= 3
ORDER BY genres)

UNION
(
(SELECT Artist.name as artist, 'Band' as capacity, count(BandID_Genres.genre) as genres, 1 as priority
FROM BandID_Genres, Artist
WHERE BandID_Genres.artist = Artist.artist_id
GROUP BY Artist.name
HAVING count(BandID_Genres.genre) >= 3)

UNION

(SELECT Artist.name as artist, 'Musician' as capacity, count(MusicianID_Genres.genre) as genres, 1 as priority
FROM MusicianID_Genres, Artist
WHERE MusicianID_Genres.artist = Artist.artist_id
GROUP BY Artist.name
HAVING count(MusicianID_Genres.genre) >= 3)
)
ORDER BY priority ASC, genres DESC
);

SELECT artist, capacity, genres FROM MANY_GENRES;

DROP VIEW Many_Genres CASCADE;
DROP VIEW MusicianID_Genres CASCADE;
DROP VIEW SongwriterID_Genres CASCADE;
DROP VIEW BandID_Genres CASCADE;

