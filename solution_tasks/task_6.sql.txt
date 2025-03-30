WITH ClassAvg AS (
    -- Вычисляем среднюю позицию для каждого класса автомобилей
    SELECT 
        c.class AS car_class,
        AVG(r.position) AS class_avg_position,
        COUNT(DISTINCT c.name) AS car_count
    FROM Results r
    JOIN Cars c ON r.car = c.name
    GROUP BY c.class
    HAVING COUNT(DISTINCT c.name) > 1 -- Оставляем только классы, в которых больше одного автомобиля
),
CarAvg AS (
    -- Вычисляем среднюю позицию и количество гонок для каждого автомобиля
    SELECT 
        r.car AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Results r
    JOIN Cars c ON r.car = c.name
    GROUP BY r.car, c.class
)
SELECT 
    ca.car_name,
    ca.car_class,
    ca.average_position,
    ca.race_count,
    cl.country AS car_country
FROM CarAvg ca
JOIN ClassAvg cla ON ca.car_class = cla.car_class
JOIN Classes cl ON ca.car_class = cl.class
WHERE ca.average_position < cla.class_avg_position -- Выбираем автомобили с позицией лучше среднего в их классе
ORDER BY ca.car_class, ca.average_position;
