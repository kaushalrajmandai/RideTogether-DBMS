USE RideTogether;

-- Blocks a booking if confirmed seats on the ride would go past the
-- vehicle's seat capacity. Runs on insert and on update (e.g. Pending -> Confirmed).

DROP TRIGGER IF EXISTS trg_booking_capacity_ins;
DROP TRIGGER IF EXISTS trg_booking_capacity_upd;

DELIMITER $$

CREATE TRIGGER trg_booking_capacity_ins
BEFORE INSERT ON Booking
FOR EACH ROW
BEGIN
    DECLARE cap INT;
    DECLARE taken INT;

    IF NEW.Status = 'Confirmed' THEN
        SELECT v.SeatCapacity INTO cap
        FROM Ride r JOIN Vehicle v ON v.VehicleID = r.VehicleID
        WHERE r.RideID = NEW.RideID;

        SELECT COALESCE(SUM(SeatsBooked), 0) INTO taken
        FROM Booking
        WHERE RideID = NEW.RideID AND Status = 'Confirmed';

        IF taken + NEW.SeatsBooked > cap THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Booking rejected: not enough seats left on this ride';
        END IF;
    END IF;
END$$

CREATE TRIGGER trg_booking_capacity_upd
BEFORE UPDATE ON Booking
FOR EACH ROW
BEGIN
    DECLARE cap INT;
    DECLARE taken INT;

    IF NEW.Status = 'Confirmed' THEN
        SELECT v.SeatCapacity INTO cap
        FROM Ride r JOIN Vehicle v ON v.VehicleID = r.VehicleID
        WHERE r.RideID = NEW.RideID;

        -- exclude this booking's own old row so it isn't counted twice
        SELECT COALESCE(SUM(SeatsBooked), 0) INTO taken
        FROM Booking
        WHERE RideID = NEW.RideID AND Status = 'Confirmed'
          AND BookingID <> NEW.BookingID;

        IF taken + NEW.SeatsBooked > cap THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Booking rejected: not enough seats left on this ride';
        END IF;
    END IF;
END$$

DELIMITER ;
