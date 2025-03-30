WITH CarAvg AS (
    
    SELECT 
        r.car AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Results r
    JOIN Cars c ON r.car = c.name
    GROUP BY r.car, c.class
),
ClassStats AS (
    
    SELECT 
        c.class AS car_class,
        COUNT(DISTINCT r.race) AS total_races,  
        COUNT(DISTINCT CASE WHEN ca.average_position > 3.0 THEN ca.car_name END) AS low_position_count
    FROM Results r
    JOIN Cars c ON r.car = c.name
    JOIN CarAvg ca ON c.name = ca.car_name
    GROUP BY c.class
),
MaxLowPositionCount AS (
    
    SELECT MAX(low_position_count) AS max_low_position_count
    FROM ClassStats
)
SELECT 
    ca.car_name,
    ca.car_class,
    ca.average_position,
    ca.race_count,
    cl.country AS car_country,
    cs.total_races,
    cs.low_position_count
FROM CarAvg ca
JOIN Classes cl ON ca.car_class = cl.class
JOIN ClassStats cs ON ca.car_class = cs.car_class
JOIN MaxLowPositionCount mpc ON cs.low_position_count = mpc.max_low_position_count
WHERE ca.average_position > 3.0 
ORDER BY cs.low_position_count DESC, ca.car_name; 
