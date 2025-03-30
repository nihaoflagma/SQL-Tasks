WITH AvgClassPositions AS (
    SELECT 
        c.class AS car_class,
        cl.country AS car_country,
        AVG(r.position) AS average_position,
        COUNT(DISTINCT r.race) AS total_races
    FROM Results r
    JOIN Cars c ON r.car = c.name
    JOIN Classes cl ON c.class = cl.class
    GROUP BY c.class, cl.country
),
MinClassAvg AS (
    SELECT MIN(average_position) AS min_position FROM AvgClassPositions
),
SelectedClasses AS (
    SELECT acp.car_class, acp.car_country, acp.average_position, acp.total_races
    FROM AvgClassPositions acp
    JOIN MinClassAvg mca ON acp.average_position = mca.min_position
)
SELECT 
    r.car AS car_name,
    sc.car_class,
    AVG(r.position) AS average_position,
    COUNT(r.race) AS race_count,
    sc.car_country,
    sc.total_races
FROM Results r
JOIN Cars c ON r.car = c.name
JOIN SelectedClasses sc ON c.class = sc.car_class
GROUP BY r.car, sc.car_class, sc.car_country, sc.total_races
ORDER BY car_class, car_name;
