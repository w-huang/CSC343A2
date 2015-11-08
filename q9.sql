---NEEDS FIXING BASED ON PIAZZA RESPONSES: THE MAIN CONCERN IS WHETHER MICK JAGGER LEFT ROLLING STONES YEARS AGO, IN WHICH CASE WE DO NOT NEED TO UPDATE HIS END YEAR IN THE WAS_IN_BAND RELATION
SET search_path TO artistdb;
--- updates the WasInBand relation so that Adam Levine was w/ M5 up until 2014, and MJ was w/ R.S. til 2014. Need to check of MJ was in Rolling Stones up until 2015?

UPDATE WasInBand
SET end_year = '2014' 
---we are given the assumption that adam levine and mick jagger only appear in this relation once, since they have "only ever been in one bad, uninterrupted time frame"
WHERE artist_id IN (SELECT artist_id FROM Artist WHERE name = 'Adam Levine' OR name = 'Mick Jagger');
---Insert a new entry to WasInBand with Mick Jagger belonging to Maroon 5, starting from 
INSERT INTO WasInBand
VALUES ((SELECT artist_id FROM Artist WHERE name = 'Mick Jagger'),(SELECT artist_id FROM Artist WHERE name = 'Maroon 5'), 2014, 2015);
