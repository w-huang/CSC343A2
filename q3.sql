SET search_path TO artistdb;
SELECT label_name as record_label, year, sum(sales) as total_sales
FROM RecordLabel, ProducedBy, Album
WHERE RecordLabel.label_id = ProducedBy.label_id and ProducedBy.album_id = Album.album_id
GROUP BY RecordLabel.label_id, year
HAVING sum(sales) > 0
ORDER BY label_name ASC, year ASC;

