# RideTogether - Campus Carpool & Ride Sharing Management System

DBMS (SQL & NoSQL) case study 84, B.Tech CSE Semester III, ITM Skills University.

A MySQL database for a campus carpool app. Drivers offer rides with a fixed number of seats, riders book seats, and a trigger makes sure a ride can never take more bookings than its vehicle has room for.

## Tables
Driver, Rider, Vehicle, Ride, Booking

Vehicle is kept in its own table (linked to Ride by VehicleID) so seat capacity and model are not repeated on every ride (2NF). All tables are in 3NF.

## Files
| File | What it does |
|---|---|
| `01_schema.sql` | Creates the RideTogether database and all tables (PK, FK, NOT NULL, CHECK) |
| `02_trigger.sql` | Seat capacity triggers (insert and update) |
| `03_data.sql` | Sample data |
| `04_queries.sql` | SELECT queries with JOIN, subquery and aggregates |
| `05_trigger_test.sql` | Booking on a full ride, gets rejected |
| `06_trigger_test_ok.sql` | Booking that fits works, the next one is rejected |
| `er_diagram.png` / `RideTogether_ER.drawio` | ER diagram (draw.io source included) |
| `RideTogether_Case_Study.docx` | Full report with outputs |

## How to run
MySQL 8.0 or above. Run the files in this order:

```
mysql -u root -p < 01_schema.sql
mysql -u root -p < 02_trigger.sql
mysql -u root -p < 03_data.sql
mysql -u root -p < 04_queries.sql
mysql -u root -p < 05_trigger_test.sql
```

The last test is supposed to fail with `Booking rejected: not enough seats left on this ride`.

## Author
Kaushal Dinesh Rajmandai - Roll No. 150096725111
