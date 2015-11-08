SET search_path TO artistdb;
SELECT name, year, sum(sales) as total_sales
FROM RecordLabel, ProducedBy, Album
WHERE RecordLabel.label_id = Produced_by.label_id and ProducedBy.album_id = Album.album_id
GROUP BY label_id, year
HAVING sum(sales) > 0 --maybe check case if no album was made?
ORDER BY name ASC, year ASC;

