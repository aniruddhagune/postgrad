----  Initialization of Database

SHOW databases;
CREATE database dbms_practical;
USE dbms_practical;

----  Creation of Tables

CREATE TABLE Deposit (actno INT, cname VARCHAR(40), bname VARCHAR(40), amount BIGINT, adate Varchar(11));
CREATE TABLE Branch (bname VARCHAR(30), city VARCHAR(30));
CREATE TABLE Customer (cname VARCHAR(30), city VARCHAR(30));
CREATE TABLE Borrow (loanno INT, cname VARCHAR(30), bname VARCHAR(30), amount BIGINT);

---- Data Insertion

-- For Deposit:

INSERT INTO Deposit VALUES
(100, "Anil", "VRCE", 1000, "1-Mar-2005"),
(101, "Sunil", "Ajni", 5000, "4-Jan-2006"),
(102, "Mehul", "Karolbagh", 3500, "17-Nov-2005"),
(104, "Madhuri", "Chandani", 1200, "17-Dec-2006"),
(105, "Pramod", "M.G Road", 3000, "27-Mar-2006"),
(106, "Sandip", "Andheri", 2000, "31-Mar-2006"),
(107, "Shivani", "Virar", 1000, "5-Sep-2005"),
(108, "Kranti", "Nehru Place", 5000, "2-Jul-2005"),
(109, "Naren", "Powai", 7000, "10-Aug-2005");

-- For Branch:

INSERT INTO Branch VALUES
("VRCE", "Nagpur"),
("Ajni", "Nagpur"),
("Karolbagh", "Delhi"),
("Chandani", "Delhi"),
("Dharmpheth", "Nagpur"),
("M.G Road", "Banglore"),
("Andheri", "Bombay"),
("Virar", "Bombay"),
("Nehru Place", "Delhi"),
("Powai", "Bombay");

-- For Customer:

INSERT INTO Customer VALUES
("Anil", "Calcultta"),
("Sunil", "Delhi"),
("Mehul", "Baroda"),
("Mandar", "Patna"),
("Madhuri", "Nagpur"),
("Pramod", "Nagpur"),
("Sandip", "Surat"),
("Shivani", "Bombay"),
("Kranti", "Bombay"),
("Naren", "Bombay");

-- For Borrow:

INSERT INTO Borrow VALUES
(201, "Anil", "VRCE", 1000),
(206, "Mehul", "Ajni", 5000),
(311, "Sunil", "Dharampeth", 3000),
(321, "Madhuri", "Andheri", 2000),
(375, "Pramod", "Virar", 8000),
(481, "Kranti", "Nehru Place", 3000);

# Week I & II

-- 1. List all the data from table deposit. 
SELECT * FROM deposit;

-- 2. List all the data from table borrow. 
SELECT * FROM borrow;


-- 3. List all the data from table customer. 
SELECT * FROM customer;

-- 4. List all the data from table branch. 
SELECT * FROM branch;

-- 5. Give account no. and amount of depositors. 
SELECT actno, amount FROM deposit;

-- 6. Give cname and account no. of depositors. 
SELECT actno, cname FROM deposit;

-- 7. Give names of customers. 
SELECT cname FROM customer;

-- 8. Give names of branches. 
SELECT bname FROM branch;

-- 9. Give names of borrowers 
SELECT cname FROM borrow;

-- 10.  Give names of customers living in city Nagpur. 

SELECT cname FROM customer WHERE city="Nagpur";

-- OR

SELECT cname FROM customer WHERE city LIKE "Nagpur";

-- 11. Give names of depositors having amount greater than 4000. 
SELECT cname FROM deposit WHERE amount>4000;

-- 12. Give account date of customer Anil. 
SELECT adate FROM deposit where cname="Anil";

-- 13. Give names of all branches located in city Bombay.
SELECT bname FROM branch where city="Bombay";

-- 14. Give names of borrower having loan no. 206. 
SELECT cname FROM borrow where loanno=206;

-- 15. Give names of depositor having account at VCRE. 
SELECT cname FROM deposit where bname="VRCE";

-- 16. Give names of all branches located in Delhi; 
SELECT bname FROM branch where city="Delhi";

-- 17. Give account number and deposit amount of customer having account opened between 1-12-2005 and 1-6-2005. 

---- PATH 1: Using a Function

SELECT actno, amount, adate FROM deposit
WHERE STR_TO_DATE(adate, '%d-%b-%Y') BETWEEN STR_TO_DATE('01-Jun-2005', '%d-%b-%Y') AND STR_TO_DATE('01-Dec-2005', '%d-%b-%Y');

---- PATH 2: Changing the column to a proper Date type:

-- Had to drop that column and remake it.
ALTER TABLE deposit DROP COLUMN adate;

-- Add it back.
ALTER TABLE deposit ADD COLUMN (adate DATE);

-- Inserting values
INSERT INTO deposit (adate) VALUES
('2005-3-1'),
('2006-1-4'),
('2005-11-17'),
('2006-12-17'),
('2006-3-27'),
('2006-3-31'),
('2005-9-5'),
('2005-7-2'),
('2005-8-10');

-- Deletes values inserted because they made new entries
DELETE FROM deposit where actno IS NULL; 

-- Updating adate, which is null for relevant entries.
UPDATE deposit SET adate=CASE
WHEN actno=100 THEN '2005-3-1'
WHEN actno=101 THEN '2006-1-4'
WHEN actno=102 THEN '2005-11-17'
WHEN actno=104 THEN '2006-12-17'
WHEN actno=105 THEN '2006-3-27'
WHEN actno=106 THEN '2006-3-31'
WHEN actno=107 THEN '2005-9-5'
WHEN actno=108 THEN '2005-7-2'
WHEN actno=109 THEN '2005-8-10'
END
WHERE actno IN (100, 101, 102, 104, 105, 106, 107, 108, 109);

-- Then using `DATE_FORMAT`:

SELECT actno, amount, DATE_FORMAT(adate, '%d-%b-%Y') AS adate FROM deposit WHERE adate BETWEEN '2005-06-01' AND '2005-12-01';

-- And making a `VIEW` if it’s convenient:

CREATE VIEW deposit_a AS
SELECT actno, cname, bname, amount, DATE_FORMAT(adate, '%d-%b-%Y') AS adate FROM deposit;

-- 18. Give details of customer Anil. 

SELECT * from customer where cname="Anil";
OR, if we need more,
SELECT * from deposit where cname="Anil";

-- 19. Give name of the city where branch Karolbagh is located.
SELECT city FROM Branch where bname="Karolbagh";


