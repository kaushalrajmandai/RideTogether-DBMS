USE RideTogether;

INSERT INTO Driver (FullName, Phone, Email, LicenseNo) VALUES
('Rahul Deshmukh', '9820011122', 'rahul.d@itmsu.edu',  'MH43-20190011'),
('Sneha Kulkarni', '9821034455', 'sneha.k@itmsu.edu',  'MH46-20200234'),
('Amit Patil',     '9833077788', 'amit.p@itmsu.edu',   'MH43-20180876'),
('Neha Joshi',     '9870122334', 'neha.j@itmsu.edu',   'MH04-20210555');

INSERT INTO Rider (FullName, Phone, Email, Department) VALUES
('Aarav Mehta',    '9004411001', 'aarav.m@itmsu.edu',  'CSE'),
('Isha Nair',      '9004411002', 'isha.n@itmsu.edu',   'CSE'),
('Karan Shah',     '9004411003', 'karan.s@itmsu.edu',  'Design'),
('Pooja Iyer',     '9004411004', 'pooja.i@itmsu.edu',  'Management'),
('Rohan Gupta',    '9004411005', 'rohan.g@itmsu.edu',  'CSE'),
('Tanvi More',     '9004411006', 'tanvi.m@itmsu.edu',  'Design'),
('Vikram Singh',   '9004411007', 'vikram.s@itmsu.edu', 'Management'),
('Ananya Rao',     '9004411008', 'ananya.r@itmsu.edu', 'CSE');

INSERT INTO Vehicle (RegNo, Model, SeatCapacity) VALUES
('MH43AB1234', 'Maruti Swift',   4),
('MH46CD5678', 'Hyundai i20',    4),
('MH43EF9012', 'Toyota Innova',  6),
('MH04GH3456', 'Honda Activa',   1);

INSERT INTO Ride (DriverID, VehicleID, Source, Destination, RideDate, DepartureTime, FarePerSeat) VALUES
(1, 1, 'Vashi',        'ITM Campus',  '2026-10-05', '08:00:00',  60.00),
(1, 1, 'ITM Campus',   'Vashi',       '2026-10-05', '17:30:00',  60.00),
(2, 2, 'Panvel',       'ITM Campus',  '2026-10-05', '07:45:00',  80.00),
(3, 3, 'Thane',        'ITM Campus',  '2026-10-06', '07:30:00', 100.00),
(4, 4, 'Nerul',        'ITM Campus',  '2026-10-06', '08:15:00',  40.00),
(2, 2, 'Vashi',        'ITM Campus',  '2026-10-06', '08:00:00',  60.00);

-- ride 1 (cap 4) gets filled up on purpose; ride 5 (cap 1) is a bike
INSERT INTO Booking (RideID, RiderID, SeatsBooked, Status) VALUES
(1, 1, 1, 'Confirmed'),
(1, 2, 2, 'Confirmed'),
(1, 3, 1, 'Confirmed'),
(2, 1, 1, 'Confirmed'),
(2, 4, 1, 'Cancelled'),
(3, 5, 2, 'Confirmed'),
(3, 6, 1, 'Confirmed'),
(4, 7, 3, 'Confirmed'),
(4, 8, 1, 'Pending'),
(5, 2, 1, 'Confirmed'),
(6, 3, 2, 'Confirmed');
