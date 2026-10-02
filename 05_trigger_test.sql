USE RideTogether;

-- Ride 1 has 4 of 4 seats taken, so this must fail
INSERT INTO Booking (RideID, RiderID, SeatsBooked, Status) VALUES (1, 5, 1, 'Confirmed');
