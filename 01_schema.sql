-- RideTogether: Campus Carpool & Ride Sharing Management System
-- DBMS Case Study 84 | MySQL 8.0

DROP DATABASE IF EXISTS RideTogether;
CREATE DATABASE RideTogether;
USE RideTogether;

CREATE TABLE Driver (
    DriverID    INT AUTO_INCREMENT PRIMARY KEY,
    FullName    VARCHAR(60)  NOT NULL,
    Phone       VARCHAR(15)  NOT NULL UNIQUE,
    Email       VARCHAR(80)  NOT NULL UNIQUE,
    LicenseNo   VARCHAR(20)  NOT NULL UNIQUE
);

CREATE TABLE Rider (
    RiderID     INT AUTO_INCREMENT PRIMARY KEY,
    FullName    VARCHAR(60)  NOT NULL,
    Phone       VARCHAR(15)  NOT NULL UNIQUE,
    Email       VARCHAR(80)  NOT NULL UNIQUE,
    Department  VARCHAR(40)  NOT NULL
);

-- seating capacity and model live here once, not on every ride (2NF)
CREATE TABLE Vehicle (
    VehicleID    INT AUTO_INCREMENT PRIMARY KEY,
    RegNo        VARCHAR(15) NOT NULL UNIQUE,
    Model        VARCHAR(40) NOT NULL,
    SeatCapacity INT         NOT NULL,
    CHECK (SeatCapacity > 0)
);

CREATE TABLE Ride (
    RideID        INT AUTO_INCREMENT PRIMARY KEY,
    DriverID      INT          NOT NULL,
    VehicleID     INT          NOT NULL,
    Source        VARCHAR(60)  NOT NULL,
    Destination   VARCHAR(60)  NOT NULL,
    RideDate      DATE         NOT NULL,
    DepartureTime TIME         NOT NULL,
    FarePerSeat   DECIMAL(6,2) NOT NULL,
    CHECK (FarePerSeat >= 0),
    FOREIGN KEY (DriverID)  REFERENCES Driver(DriverID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);

CREATE TABLE Booking (
    BookingID   INT AUTO_INCREMENT PRIMARY KEY,
    RideID      INT         NOT NULL,
    RiderID     INT         NOT NULL,
    SeatsBooked INT         NOT NULL DEFAULT 1,
    Status      VARCHAR(10) NOT NULL DEFAULT 'Confirmed',
    BookedAt    DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (SeatsBooked > 0),
    CHECK (Status IN ('Confirmed', 'Cancelled', 'Pending')),
    FOREIGN KEY (RideID)  REFERENCES Ride(RideID),
    FOREIGN KEY (RiderID) REFERENCES Rider(RiderID)
);
