WITH HotelCategory AS (
    SELECT
        h.ID_hotel,
        h.name,
        CASE
            WHEN AVG(r.price) < 175 THEN 'Дешевый'
            WHEN AVG(r.price) BETWEEN 175 AND 300 THEN 'Средний'
            ELSE 'Дорогой'
        END AS hotel_category
    FROM Hotel h
    JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel, h.name
),
CustomerPreferences AS (
    SELECT
        c.ID_customer,
        c.name,
        STRING_AGG(DISTINCT h.name, ', ' ORDER BY h.name) AS visited_hotels,
        CASE
            WHEN STRING_AGG(DISTINCT hc.hotel_category, ', ' ORDER BY hc.hotel_category) LIKE '%Дорогой%' THEN 'Дорогой'
            WHEN STRING_AGG(DISTINCT hc.hotel_category, ', ' ORDER BY hc.hotel_category) LIKE '%Средний%' THEN 'Средний'
            ELSE 'Дешевый'
        END AS preferred_hotel_type
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    JOIN HotelCategory hc ON h.ID_hotel = hc.ID_hotel
    GROUP BY c.ID_customer, c.name
)
SELECT 
    ID_customer, 
    name, 
    preferred_hotel_type, 
    visited_hotels
FROM CustomerPreferences
ORDER BY
    CASE 
        WHEN preferred_hotel_type = 'Дешевый' THEN 1
        WHEN preferred_hotel_type = 'Средний' THEN 2
        WHEN preferred_hotel_type = 'Дорогой' THEN 3
    END,
    ID_customer;  
