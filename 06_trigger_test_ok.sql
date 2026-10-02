USE RideTogether;

-- Ride 6 has 2 of 4 seats taken, asking for 2 more should work
INSERT INTO Booking (RideID, RiderID, SeatsBooked, Status) VALUES (6, 5, 2, 'Confirmed');
-- now it is full, one more must fail
INSERT INTO Booking (RideID, RiderID, SeatsBooked, Status) VALUES (6, 7, 1, 'Confirmed');
