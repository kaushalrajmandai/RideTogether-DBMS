USE RideTogether;

-- Q1. Rides with free seats for a given route and date (subquery on COUNT/SUM vs SeatCapacity)
SELECT r.RideID, r.Source, r.Destination, r.RideDate, r.DepartureTime,
       v.SeatCapacity,
       v.SeatCapacity - IFNULL((SELECT SUM(b.SeatsBooked)
                                FROM Booking b
                                WHERE b.RideID = r.RideID AND b.Status = 'Confirmed'), 0) AS FreeSeats
FROM Ride r
JOIN Vehicle v ON v.VehicleID = r.VehicleID
WHERE r.Source = 'Vashi'
  AND r.Destination = 'ITM Campus'
  AND r.RideDate = '2026-10-06'
  AND v.SeatCapacity > IFNULL((SELECT SUM(b.SeatsBooked)
                               FROM Booking b
                               WHERE b.RideID = r.RideID AND b.Status = 'Confirmed'), 0);

-- Q2. Same idea, but across every ride, using COUNT(Booking) as the objective states
SELECT r.RideID, r.Source, r.Destination, v.SeatCapacity,
       (SELECT COUNT(*) FROM Booking b
        WHERE b.RideID = r.RideID AND b.Status = 'Confirmed') AS ConfirmedBookings
FROM Ride r
JOIN Vehicle v ON v.VehicleID = r.VehicleID
ORDER BY r.RideID;

-- Q3. Driver participation history (Ride JOIN Driver)
SELECT d.DriverID, d.FullName, r.RideID, r.Source, r.Destination, r.RideDate
FROM Driver d
JOIN Ride r ON r.DriverID = d.DriverID
ORDER BY d.FullName, r.RideDate;

-- Q4. Number of rides and seats filled per driver
SELECT d.FullName,
       COUNT(DISTINCT r.RideID)          AS TotalRides,
       IFNULL(SUM(b.SeatsBooked), 0)     AS SeatsFilled
FROM Driver d
JOIN Ride r ON r.DriverID = d.DriverID
LEFT JOIN Booking b ON b.RideID = r.RideID AND b.Status = 'Confirmed'
GROUP BY d.DriverID, d.FullName;

-- Q5. Full booking details (Booking + Rider + Ride)
SELECT b.BookingID, ri.FullName AS Rider, r.Source, r.Destination,
       r.RideDate, b.SeatsBooked, b.Status
FROM Booking b
JOIN Rider ri ON ri.RiderID = b.RiderID
JOIN Ride  r  ON r.RideID   = b.RideID
ORDER BY b.BookingID;

-- Q6. Fully booked rides
SELECT r.RideID, r.Source, r.Destination
FROM Ride r
JOIN Vehicle v ON v.VehicleID = r.VehicleID
WHERE v.SeatCapacity <= (SELECT IFNULL(SUM(b.SeatsBooked), 0)
                         FROM Booking b
                         WHERE b.RideID = r.RideID AND b.Status = 'Confirmed');
