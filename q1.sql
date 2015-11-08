SET search_path TO artistdb;
CREATE VIEW Steppenwolf_Album_Years AS(
SELECT year FROM Artist, Album where Artist.name = 'Steppenwolf' and Artist.artist_id = Album.artist_id);

SELECT DISTINCT name, nationality
FROM Artist, Role
WHERE Artist.artist_id = Role.artist_id and Role.role = 'Musician' and Extract( year FROM birthdate ) =( SELECT min(year) FROM Steppenwolf_Album_Years ) 
ORDER BY name ASC;
