CREATE DATABASE IF NOT EXISTS airline_dbms;
USE airline_dbms;

CREATE TABLE airline(
code VARCHAR(10) PRIMARY KEY,
name CHAR(64) NOT NULL UNIQUE
);

CREATE TABLE aircraft(
model_id VARCHAR(10) PRIMARY KEY, 
model_name CHAR(64) NOT NULL UNIQUE, 
manufactured_year INT, 
capacity INT,
airline_code VARCHAR(10), 
FOREIGN KEY (airline_code) REFERENCES airline(code) 
ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE airport(
code VARCHAR(10) PRIMARY KEY,
name CHAR(64) NOT NULL,
street VARCHAR(64) NOT NULL, 
city CHAR(20) NOT NULL, 
zipcode INT NOT NULL UNIQUE
);

CREATE TABLE staff(
staff_id VARCHAR(10) PRIMARY KEY,
first_name CHAR(20) NOT NULL,
last_name CHAR(20) NOT NULL, 
job_description VARCHAR(20),
email_id VARCHAR(64) UNIQUE,
phone_number INT UNIQUE
);

CREATE TABLE crew(
crew_id VARCHAR(5) PRIMARY KEY,
description VARCHAR(64) NOT NULL
);

CREATE TABLE flight(
flight_no VARCHAR(10) PRIMARY KEY, 
dep_date DATE, 
dep_time TIME, 
gate_no VARCHAR(4), 
status VARCHAR(10), 
seats_available INT,
aircraft_id VARCHAR(10) NOT NULL,
assigned_crew VARCHAR(5),
dep_airport VARCHAR(10) NOT NULL,
arr_airport VARCHAR(10) NOT NULL,
FOREIGN KEY (aircraft_id) REFERENCES aircraft(model_id)
ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (assigned_crew) REFERENCES crew(crew_id) 
ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (dep_airport) REFERENCES airport(code)
ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (arr_airport) REFERENCES airport(code)
ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE customer(
customer_id INT PRIMARY KEY AUTO_INCREMENT, 
first_name CHAR(20) NOT NULL, 
last_name CHAR(20) NOT NULL, 
id_type CHAR(20) DEFAULT NULL, 
credit_card_number INT DEFAULT NULL UNIQUE
);


CREATE TABLE reservation(
reservation_no INT PRIMARY KEY AUTO_INCREMENT, 
is_seat_assigned BOOL,
flight_no VARCHAR(10) NOT NULL, 
customer INT NOT NULL,
FOREIGN KEY (flight_no) REFERENCES flight(flight_no)
ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (customer) REFERENCES customer(customer_id)
ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE staff_assigned_crew(
staff_id VARCHAR(10), 
crew_id VARCHAR(5), 
PRIMARY KEY (staff_id, crew_id), 
FOREIGN KEY (staff_id) REFERENCES staff(staff_id) 
ON UPDATE CASCADE ON DELETE RESTRICT, 
FOREIGN KEY (crew_id) REFERENCES crew(crew_id) 
ON UPDATE CASCADE ON DELETE RESTRICT
);

/*Creating Procedures, Functions and Triggers */

-- Create a function to get the customer_id
DROP FUNCTION IF EXISTS get_cust_id;
DELIMITER $$
CREATE FUNCTION get_cust_id(first_name CHAR(20), last_name CHAR(20), ccn INT)
RETURNS INT NO SQL
BEGIN
RETURN (SELECT customer_id FROM customer 
WHERE first_name = first_name AND last_name = last_name AND credit_card_number = ccn 
LIMIT 1);
END $$

DELIMITER ;

-- Create a procedure to add and delete a customer from the customer table
DROP PROCEDURE IF EXISTS add_customer;
DELIMITER $$
CREATE PROCEDURE add_customer(
    IN first_name CHAR(20),
    IN last_name CHAR(20),
    IN id_type CHAR(20), 
    IN credit_card_number INT	
)
BEGIN
-- Insert the customer record
IF (SELECT get_cust_id(first_name, last_name, credit_card_number)) IS NULL THEN
SET @customer_id = LAST_INSERT_ID();
INSERT INTO customer (first_name, last_name, id_type, credit_card_number) 
VALUES (first_name, last_name, id_type, credit_card_number);
ELSE 
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Customer with the given details already exists',
MYSQL_ERRNO = 1644;
END IF;
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS delete_customer;
DELIMITER $$
CREATE PROCEDURE delete_customer(
IN cust_id INT
)
BEGIN
DELETE FROM customer WHERE customer_id = cust_id;
END $$
DELIMITER ;

-- Create a procedure to get the flight numbers based on dep and arr airports
DROP PROCEDURE IF EXISTS get_flights;
DELIMITER $$
CREATE PROCEDURE get_flights(
IN dep_air VARCHAR(10),
IN arr_air VARCHAR(10)
)
BEGIN
SELECT flight_no, dep_date, dep_time, seats_available, dep_airport, arr_airport
FROM flight WHERE dep_airport = dep_air AND arr_airport = arr_air;
END $$
DELIMITER ;


-- Procedure to create a new reservation
DROP PROCEDURE IF EXISTS create_reservation;
DELIMITER $$
CREATE PROCEDURE create_reservation(
IN f_name CHAR(20),
IN l_name CHAR(20),
IN f_no VARCHAR(10),
IN assign_seat BOOL,
IN id CHAR(20), 
IN ccn INT
)
BEGIN
CALL add_customer(f_name, l_name, id, ccn);
SET @cust_id = (SELECT get_cust_id(f_name, l_name, ccn));
INSERT INTO reservation (is_seat_assigned, flight_no, customer) 
VALUES (assign_seat, f_no, @cust_id);
END $$
DELIMITER ;

-- Procedure to delete an existing reservation
DROP PROCEDURE IF EXISTS delete_reservation;
DELIMITER $$
CREATE PROCEDURE delete_reservation(
IN res_no INT
)
BEGIN
SET @cust_id = (SELECT customer FROM reservation WHERE reservation_no = res_no);
CALL delete_customer(@cust_id);
DELETE FROM reservation WHERE reservation_no = res_no;
END $$
DELIMITER ;

-- Procedure to update an existing reservation

DROP PROCEDURE IF EXISTS update_reservation;
DELIMITER $$
CREATE PROCEDURE update_reservation(
IN res_no INT,
IN new_fli_no VARCHAR(10), 
IN assign_seat BOOL
)
BEGIN
UPDATE reservation
SET flight_no = new_fli_no, is_seat_assigned = assign_seat
WHERE reservation_no = res_no;
END $$
DELIMITER ;

-- Procedure to read a reservation
DROP PROCEDURE IF EXISTS read_reservations;
DELIMITER $$
CREATE PROCEDURE read_reservation(
IN res_no INT
)
BEGIN
SELECT reservation_no, customer, first_name, last_name, r.flight_no, 
dep_date, dep_time, gate_no, status, 
is_seat_assigned, dep_airport, 
arr_airport FROM reservation r 
LEFT OUTER JOIN flight f 
ON r.flight_no = f.flight_no
LEFT OUTER JOIN customer c ON c.customer_id = r.customer
WHERE reservation_no = res_no;
END $$
DELIMITER ;

-- Triggers to update the number of seats available in flights on 
-- create, update and delete on reservation tables
DROP TRIGGER IF EXISTS update_seats_available_on_insert;
DELIMITER $$
CREATE TRIGGER update_seats_available_on_insert
AFTER INSERT ON reservation
FOR EACH ROW
BEGIN
IF (NEW.is_seat_assigned = 1) THEN
UPDATE flight
SET seats_available = seats_available - 1
WHERE flight_no = NEW.flight_no ;
END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS update_seats_available_on_update
DELIMITER $$
CREATE TRIGGER update_seats_available_on_update
AFTER UPDATE ON reservation
FOR EACH ROW
BEGIN
-- Case 1
IF (OLD.is_seat_assigned = 1 AND NEW.is_seat_assigned = 1) THEN
UPDATE flight
SET seats_available = seats_available + 1
WHERE flight_no = OLD.flight_no;
UPDATE flight
SET seats_available = seats_available - 1
WHERE flight_no = NEW.flight_no;
END IF;
-- Case 2
IF (OLD.is_seat_assigned = 1 AND NEW.is_seat_assigned = 0) THEN
UPDATE flight
SET seats_available = seats_available + 1
WHERE flight_no = OLD.flight_no;
END IF;

-- Case 3
IF (OLD.is_seat_assigned = 0 AND NEW.is_seat_assigned = 1) THEN
UPDATE flight
SET seats_available = seats_available - 1
WHERE flight_no = NEW.flight_no;
END IF;

-- Case 4 No updates needed.
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS update_seats_available_on_delete;
DELIMITER $$
CREATE TRIGGER update_seats_available_on_delete
BEFORE DELETE ON reservation
FOR EACH ROW
BEGIN
UPDATE flight
SET seats_available = seats_available + 1
WHERE flight_no = OLD.flight_no;
END $$
DELIMITER ;

-- Inserting values into the tables

INSERT INTO airline (code, name) VALUES
('DL', 'Delta Airlines');


INSERT INTO aircraft (model_id, model_name, manufactured_year, capacity, airline_code) VALUES
('B737', 'Boeing 737', 2000, 150, 'DL'),
('A320', 'Airbus A320', 2010, 170, 'DL'),
('B777', 'Boeing 777', 2015, 300, 'DL'),
('A380', 'Airbus A380', 2010, 550, 'DL'),
('B787', 'Boeing 787', 2018, 250, 'DL'),
('A330', 'Airbus A330', 2005, 250, 'DL'),
('B747', 'Boeing 747', 2008, 400, 'DL'),
('MD11', 'McDonnell Douglas MD-11', 1995, 320, 'DL'),
('CRJ7', 'Bombardier CRJ700', 2012, 70, 'DL'),
('E190', 'Embraer E190', 2016, 100, 'DL');

INSERT INTO airport (code, name, street, city, zipcode) VALUES
('YYZ', 'Toronto Pearson International Airport', '6301 Silver Dart Dr', 'Mississauga', 12345),
('LAX', 'Los Angeles International Airport', '1 World Way', 'Los Angeles', 67890),
('SFO', 'San Francisco International Airport', 'International Terminal', 'San Francisco', 12354),
('LHR', 'London Heathrow Airport', 'Longford', 'London', 67809),
('JFK', 'John F. Kennedy International Airport', 'JFK Expressway', 'New York', 54321),
('CDG', 'Paris Charles de Gaulle Airport', '95700 Roissy-en-France', 'Paris', '95700'),
('HND', 'Tokyo International Airport (Haneda)', '4-chome Hanedakuko', 'Ota City', '1440041'),
('DXB', 'Dubai International Airport', 'Dubai - United Arab Emirates', 'Dubai', '00000'),
('SYD', 'Sydney Kingsford Smith Airport', 'Airport Dr', 'Mascot', '2020'),
('MAD', 'Adolfo Suárez Madrid–Barajas Airport', 'Avenida de la Hispanidad s/n', 'Madrid', '28042'),
('PEK', 'Beijing Capital International Airport', 'Airport Rd', 'Beijing', '100621'),
('MEX', 'Mexico City International Airport', 'Av. Capitán Carlos León S/N', 'Mexico City', '15620'),
('SIN', 'Changi Airport', 'Airport Blvd', 'Singapore', '819642'),
('IST', 'Istanbul Atatürk Airport', 'Yesilkoy', 'Istanbul', '34149'),
('ICN', 'Incheon International Airport', '272 Gonghang-ro', 'Jung-gu', '22382');

INSERT INTO staff (staff_id, first_name, last_name, job_description, email_id, phone_number)
VALUES 
('S001', 'John', 'Smith', 'Pilot', 'jsmith@airline.com', 5551234),
('S002', 'Jane', 'Doe', 'Flight Attendant', 'jdoe@airline.com', 5555678),
('S003', 'Mike', 'Johnson', 'Mechanic', 'mjohnson@airline.com', 5559876),
('S004', 'Sarah', 'Lee', 'Ticket Agent', 'slee@airline.com', 5554321),
('S005', 'David', 'Brown', 'Baggage Handler', 'dbrown@airline.com', 5558765),
('S006', 'Adam', 'Zampa', 'Pilot', 'azampa@airline.com', 5553214),
('S007', 'Sophie', 'Buttler', 'Flight Attendant', 'sbuttler@airline.com', 5555865),
('S008', 'Johnson', 'Mike', 'Mechanic', 'jmike@airline.com', 5559654),
('S009', 'Ash', 'Lee', 'Ticket Agent', 'alee@airline.com', 5557755),
('S010', 'Susan', 'Brown', 'Baggage Handler', 'dsbrown@airline.com', 5558220),
('S011', 'Robert', 'Johnson', 'Pilot', 'rjohnson@airline.com', 5550111),
('S012', 'Linda', 'Davis', 'Flight Attendant', 'ldavis@airline.com', 5550222),
('S013', 'Mark', 'Wilson', 'Mechanic', 'mwilson@airline.com', 5550333),
('S014', 'Karen', 'Lee', 'Ticket Agent', 'klee@airline.com', 5550444),
('S015', 'Jason', 'Brown', 'Baggage Handler', 'jbrown@airline.com', 5550555),
('S016', 'Peter', 'Garcia', 'Pilot', 'pgarcia@airline.com', 5550666),
('S017', 'Emily', 'Clark', 'Flight Attendant', 'eclark@airline.com', 5550777),
('S018', 'Olivia', 'Anderson', 'Mechanic', 'oanderson@airline.com', 5550888),
('S019', 'Ethan', 'Hall', 'Ticket Agent', 'ehall@airline.com', 5550999),
('S020', 'Mia', 'Gonzalez', 'Baggage Handler', 'mgonzalez@airline.com', 5550000);

INSERT INTO crew (crew_id, description)
VALUES 
('CR001', 'Cabin Crew'),
('CR002', 'Baggage Crew'),
('CR003', 'Customer Service Crew'),
('CR004', 'Cabin Crew'),
('CR005', 'Cabin Crew'),
('CR006', 'Maintenance Crew'),
('CR007', 'Cabin Crew'),
('CR008', 'Cabin Crew'),
('CR009', 'Baggage Crew'),
('CR010', 'Customer Service Crew');

INSERT INTO flight (flight_no, dep_date, dep_time, gate_no, status, seats_available, aircraft_id, assigned_crew, dep_airport, arr_airport) VALUES
('DL001', '2023-05-01', '08:00:00', 'A1', 'On time', 150, 'B737', 'CR001', 'JFK', 'LAX'),
('DL002', '2023-05-02', '09:00:00', 'B2', 'On time', 170, 'A320', 'CR004', 'LHR', 'CDG'),
('DL003', '2023-05-03', '10:00:00', 'C3', 'Delayed', 300, 'B777', 'CR001', 'DXB', 'JFK'),
('DL004', '2023-05-04', '11:00:00', 'D4', 'On time', 550, 'A380', 'CR005', 'LAX', 'JFK'),
('DL005', '2023-05-05', '12:00:00', 'E5', 'Delayed', 250, 'B787', 'CR004','LAX', 'SFO'),
('DL006', '2023-05-06', '13:00:00', 'F6', 'On time', 150, 'B737', 'CR002', 'YYZ', 'LAX'),
('DL007', '2023-05-07', '14:00:00', 'G7', 'Delayed', 170, 'A320', 'CR007', 'JFK', 'LHR'),
('DL008', '2023-05-08', '15:00:00', 'H8', 'On time', 300, 'B777', 'CR003', 'CDG', 'JFK'),
('DL009', '2023-05-09', '16:00:00', 'I9', 'Delayed', 550, 'A380', 'CR006', 'LHR', 'DXB'),
('DL010', '2023-05-10', '17:00:00', 'J10', 'On time', 250, 'B787', 'CR008', 'SFO', 'LAX');

INSERT INTO customer (customer_id, first_name, last_name, id_type, credit_card_number) 
VALUES 
('1001', 'William', 'Shatner', 'Passport', 12345678),
('1002', 'Robert', 'Downey', 'Driver License', 23456789),
('1003', 'Steve', 'Smith', 'Passport', 34567890),
('1004', 'Trent', 'Boult', 'National ID', 45678901),
('1005', 'Emma', 'Stone', 'Passport', 56789012),
('1006', 'Bradley', 'Cooper', 'Driver License', 67890123),
('1007', 'Jennifer', 'Lawrence', 'Passport', 78901234),
('1008', 'Chris', 'Hemsworth', 'National ID', 89012345),
('1009', 'Scarlett', 'Johansson', 'Driver License', 90123456),
('1010', 'Ryan', 'Reynolds', 'Passport', 12347890);


INSERT INTO reservation (reservation_no, is_seat_assigned, flight_no, customer) 
VALUES 
('101', true, 'DL001', '1001'),
('102', false, 'DL002', '1002'),
('103', true, 'DL003', '1003'),
('104', false, 'DL004', '1004'),
('105', true, 'DL001', '1005'),
('106', false, 'DL002', '1006'),
('107', true, 'DL003', '1007'),
('108', false, 'DL004', '1008');

INSERT INTO staff_assigned_crew (staff_id, crew_id) 
VALUES 
('S001', 'CR001'),
('S002', 'CR002'),
('S003', 'CR001'),
('S004', 'CR003'),
('S005', 'CR004'),
('S006', 'CR001'),
('S007', 'CR003'),
('S008', 'CR002'),
('S009', 'CR001'),
('S010', 'CR004');



-- /*Testing the procedures, functions and triggers*/
-- /*Uncomment the below commands and run them one by one*/


-- /* Create a reservation*/
-- CALL get_flights('LAX', 'JFK');
-- CALL create_reservation('Faf', 'Duplessis', 'DL004', true, 'National ID', 7868755);
-- CALL create_reservation('Glenn', 'Maxwell', 'DL004', false, 'Passport', 6453782);

-- -- Number of seats in flight is reduced by 1 (seat assigned in second new reservation is false)
-- CALL get_flights('LAX', 'JFK');
-- -- New customers added in customer and reservation table
-- SELECT * FROM customer;
-- SELECT * FROM reservation;
-- CALL read_reservation(109);
-- CALL read_reservation(110);

-- /* Update a reservation*/
-- CALL get_flights('LAX', 'SFO');
-- CALL update_reservation(109, 'DL005', true);
-- CALL update_reservation(110, 'DL005', false);

-- -- Number of seats in first flight is incresed and second flight isdecreased
-- CALL get_flights('LAX', 'SFO');
-- CALL get_flights('LAX', 'JFK');
-- -- Customers updated in customer and reservation table
-- SELECT * FROM customer;
-- SELECT * FROM reservation;
-- CALL read_reservation(109);
-- CALL read_reservation(110);

-- /* Delete a reservation*/
-- CALL delete_reservation(109);
-- CALL delete_reservation(110);
-- -- Customers deleted in customer and reservation table
-- SELECT * FROM customer;
-- SELECT * FROM reservation;




