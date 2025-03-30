SELECT 
    c.name AS client_name,
    c.email,
    c.phone,
    COUNT(b.ID_booking) AS total_bookings,
    STRING_AGG(DISTINCT h.name, ', ') AS hotel_list,
    ROUND(AVG(b.check_out_date - b.check_in_date), 4) AS avg_stay_length
FROM Booking b
JOIN Room r ON b.ID_room = r.ID_room
JOIN Hotel h ON r.ID_hotel = h.ID_hotel
JOIN Customer c ON b.ID_customer = c.ID_customer
GROUP BY c.ID_customer, c.name, c.email, c.phone
HAVING COUNT(DISTINCT h.ID_hotel) > 1 AND COUNT(b.ID_booking) > 2
ORDER BY total_bookings DESC;
