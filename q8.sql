SET search_path TO artistdb;

CREATE VIEW ACDCMembers AS
SELECT WasInBand.artist_id, WasInBand.band_id, WasInBand.start_year, WasInBand.end_year
FROM WasInBand, Artist
WHERE WasInBand.band_id = Artist.artist_id AND Artist.name = 'AC/DC';

INSERT INTO WasInBand (artist_id, band_id, start_year, end_year)
SELECT artist_id, band_id, 2014, 2015 FROM ACDCMembers;

DROP VIEW ACDCMembers CASCADE;

