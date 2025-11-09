-- SQL1625: Số lượng giếng được khoan ở Mỹ và Canada
-- Bảng: wells(well_id, country)
-- Output: country | num_wells (2 hàng: Canada, USA)

SELECT country,
       COUNT(*) AS num_wells
FROM wells
WHERE country IN ('Canada', 'USA')
GROUP BY country
ORDER BY country;
