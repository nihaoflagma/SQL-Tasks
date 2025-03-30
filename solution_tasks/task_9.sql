WITH CustomerBookings AS (
    
    SELECT 
        b.ID_customer,
        c.name,
        COUNT(b.ID_booking) AS total_bookings,
        COUNT(DISTINCT h.ID_hotel) AS unique_hotels,
        SUM(r.price * (b.check_out_date - b.check_in_date)) AS total_spent  
    FROM Booking b
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    JOIN Customer c ON b.ID_customer = c.ID_customer
    GROUP BY b.ID_customer, c.name
),
FilteredCustomers AS (
    
    SELECT * FROM CustomerBookings
    WHERE total_bookings > 2 AND unique_hotels > 1
),
HighSpendingCustomers AS (
    
    SELECT * FROM CustomerBookings
    WHERE total_spent > 500
)

SELECT 
    fc.ID_customer,
    fc.name,
    fc.total_bookings,
    fc.total_spent,
    fc.unique_hotels
FROM FilteredCustomers fc
JOIN HighSpendingCustomers hsc ON fc.ID_customer = hsc.ID_customer
ORDER BY fc.total_spent ASC;
