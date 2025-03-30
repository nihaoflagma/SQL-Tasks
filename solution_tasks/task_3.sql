WITH CarAvgPositions AS (
    
    SELECT
        r.car,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Results r
    JOIN Cars c ON r.car = c.name
    GROUP BY r.car, c.class
),
MinAvgPositions AS (
    
    SELECT
        car_class,
        MIN(average_position) AS min_average_position
    FROM CarAvgPositions
    GROUP BY car_class
)

SELECT
    cap.car AS car_name,
    cap.car_class,
    cap.average_position,
    cap.race_count
FROM CarAvgPositions cap
JOIN MinAvgPositions map ON cap.car_class = map.car_class
                         AND cap.average_position = map.min_average_position
ORDER BY cap.average_position, cap.car;  
