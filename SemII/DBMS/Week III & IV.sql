--
----
------ Join & Cartesian Product
----
--

---- 1. Give name of customer having living city Bombay and branch city Delhi.

SELECT Customer.cname, Customer.city, Branch.bname, Branch.city
FROM Customer
INNER JOIN Deposit ON Customer.cname = Deposit.cname
INNER JOIN Branch ON Deposit.bname = Branch.bname
WHERE Customer.city = "Bombay" AND Branch.city = "Delhi";

---- 2. Give name of customers having same living city as their branch city. 

SELECT Customer.cname, Customer.city, Branch.bname, Branch.city
FROM Customer
INNER JOIN Deposit ON Customer.cname = Deposit.cname
INNER JOIN Branch ON Deposit.bname = Branch.bname
WHERE Customer.city = Branch.city;

---- 3. Give names of customers who are borrowers as well as depositors and having living city Nagpur. 

SELECT Customer.cname, Customer.city
FROM Customer
INNER JOIN Deposit ON Customer.cname = Deposit.cname
INNER JOIN Borrow ON Customer.cname = Borrow.cname
WHERE Customer.city = "Nagpur";

---- 4. Give names of customers who are   depositors and having the same branch city as that of Sunil. 

SELECT Customer.cname
FROM Customer
INNER JOIN Deposit ON Customer.cname = Deposit.cname
INNER JOIN Branch ON Deposit.bname = Branch.bname
WHERE Branch.city = (
    SELECT Branch.city
    FROM Customer
    INNER JOIN Deposit ON Customer.cname = Deposit.cname
    INNER JOIN Branch ON Deposit.bname = Branch.bname
    WHERE Customer.cname = 'Sunil'
);

---- 5. Give the names of depositors having the same city as that of Shivani and having deposit amount greater than 2000. 

SELECT Customer.cname, Customer.city
FROM Customer
INNER JOIN Deposit ON Customer.cname = Deposit.cname
INNER JOIN Borrow ON Customer.cname = Borrow.cname
WHERE Customer.city = "Nagpur";

---- 6. Give the names of borrowers having deposit amount greater than 1000 and the loan amount greater than 2000. 

SELECT b.cname
FROM borrow b
INNER JOIN deposit d ON b.cname = d.cname
WHERE d.amount > 1000 AND b.amount > 2000;

---- 7. Give names of depositors having the same branch as the branch of Sunil. 

SELECT d.cname
FROM deposit d
JOIN borrow b ON b.cname = d.cname
WHERE b.bname IN (SELECT bname FROM borrow WHERE cname = "Sunil");

---- 8. Give names of borrowers having loan amount greater than the loan amount of Anil. 

-- Subquery:
SELECT cname
FROM borrow
WHERE amount > (SELECT amount FROM borrow WHERE cname="Anil");

-- Self-Join:
SELECT b1.cname
FROM borrow b1
JOIN borrow b2 ON b2.cname = "Anil"
WHERE b1.amount > b2.amount;

---- 9. Give the names of customers living city where branch of depositor sunil is located.  

SELECT DISTINCT c.cname, c.city
FROM customer c
JOIN branch b ON c.city = b.city
JOIN deposit d ON d.bname = b.bname
WHERE d.cname = "Sunil";

---- 10. Give loan no and loan amount of borrower having the same branch as that of depositor Sunil. 

SELECT l.loanno, l.amount 
FROM borrow l
JOIN deposit d ON d.cname=l.cname
WHERE l.bname IN (SELECT bname FROM deposit WHERE cname="Sunil");

---- 11. Give loan no., loan amount, account no. and deposit amount of customers living in city Nagpur.

SELECT l.loanno, l.amount, d.actno, d.amount
FROM borrow l
JOIN deposit d ON d.cname=l.cname
JOIN customer c ON c.cname=l.cname
WHERE c.city IN ('Nagpur');

---- 12. Give loan no., loan amount , account no. and deposit amount of customers having deposit branch located in Delhi 

SELECT l.loanno, l.amount, d.actno, d.amount
FROM borrow l
JOIN deposit d ON d.cname=l.cname
JOIN customer c ON c.cname=l.cname
JOIN branch b ON b.bname=d.bname
WHERE b.city = 'Delhi';

---- 13. Give loan no., loan amount, account no., deposit amount, branch name, branch city and living city of Pramod. 

SELECT c.cname, l.loanno, l.amount, d.actno, d.amount, d.bname, b.city, c.city 
FROM borrow l
JOIN deposit d ON d.cname=l.cname
JOIN branch b ON b.bname=d.bname
JOIN customer c ON c.cname=d.cname
WHERE l.cname = "Pramod";

---- 14. Give deposit details and loan details of customer in the city where Pramod is living. 

-- Subquery
SELECT d.cname, d.actno, d.amount, l.loanno, l.amount  
FROM deposit d 
JOIN borrow l ON d.cname=l.cname
JOIN customer c ON c.cname=d.cname
WHERE c.city IN (SELECT city FROM customer WHERE cname="Pramod");

-- Self Join
SELECT d.cname, d.actno, d.amount, l.loanno, l.amount  
FROM deposit d 
JOIN borrow l ON d.cname = l.cname
JOIN customer c1 ON c1.cname = d.cname
JOIN customer c2 ON c2.city = c1.city
WHERE c2.cname = "Pramod";

---- 15.  Give name of depositors having the same branch city as that of sunil and having the same living city as that of Anil. 

-- Join & Subquery
SELECT d.cname
FROM deposit d
JOIN branch b ON b.bname = d.bname
JOIN customer c ON c.cname = d.cname
WHERE b.city IN (SELECT city FROM branch WHERE bname IN (SELECT bname FROM deposit WHERE cname = "Sunil"))
AND
c.city IN (SELECT city FROM customer WHERE cname = "Anil");

-- Join & Self-Join
SELECT DISTINCT d.cname
FROM deposit d
JOIN branch b ON b.bname = d.bname
JOIN customer c ON c.cname = d.cname

JOIN deposit d_sunil ON d_sunil.cname = "Sunil"
JOIN branch b_sunil ON b_sunil.bname = d_sunil.bname
JOIN customer c_anil ON c_anil.cname = "Anil"

WHERE b.city = b_sunil.city
AND c.city = c_anil.city;


---- 16. Give names of depositors having amount greater than 1000 and having the same living city as Pramod. 

-- Join & Subquery
SELECT d.cname
FROM deposit d
JOIN customer c ON c.cname=d.cname
WHERE d.amount > 1000 
AND 
c.city = (SELECT city FROM customer WHERE cname="Pramod");

-- Join & Self-Join
SELECT d.cname
FROM deposit d
JOIN customer c ON c.cname=d.cname
JOIN customer c_pramod ON c_pramod.cname="Pramod"
WHERE d.amount > 1000 
AND 
c.city = c_pramod.city;

---- 17.  Give living city of customer having the same branch city as that of Pramod. 

SELECT c.cname, c.city
FROM customer c
JOIN deposit d ON d.cname=c.cname
JOIN branch b ON b.bname=d.bname

JOIN deposit d2 ON d2.cname="Pramod"
JOIN branch b2 ON b2.bname=d2.bname

WHERE b.city = b2.city;

---- 18. Give branch city and living city of Pramod. 

SELECT b.city, c.city
FROM deposit d
JOIN customer c ON c.cname=d.cname
JOIN branch b ON b.bname=d.bname
WHERE d.cname="Pramod";

---- 19. Give branch city of Sunil or branch city of Anil.

SELECT b.city
FROM deposit d
JOIN branch b ON b.bname=d.bname
WHERE d.cname="Sunil"
OR
d.cname="Anil";

---- 20. Give the living city of Anil and living city of Sunil. 

SELECT c.city
FROM customer c
JOIN deposit d ON d.cname=c.cname
WHERE c.cname="Anil"
OR
c.cname="Sunil";


--
----
------ Set Operations
----
--


---- 1. List all the customers who are depositors but not borrowers. 

SELECT d.cname
FROM deposit d

EXCEPT

SELECT l.cname
FROM borrow l;

---- 2. List all the customers who are both depositors and borrowers. 

SELECT cname 
FROM deposit

INTERSECT

SELECT cname
FROM borrow;

---- 3. List all the customers, along with their amount, who are either borrowers or depositors and living in city Nagpur. 

SELECT c.cname, d.amount
FROM customer c
JOIN deposit d ON c.cname = d.cname
WHERE c.city = 'Nagpur'

UNION

SELECT c.cname, l.amount
FROM customer c
JOIN borrow l ON c.cname = l.cname
WHERE c.city = 'Nagpur';

---- 4. List all the depositors having in all the branches where Sunil is having account. 

-- ?? 
-- depositors having what, a child?

---- 5. List all the customers living in city Nagpur and having branch city Bombay or Delhi. 

-- Intersect
SELECT c.cname
FROM customer c
WHERE c.city="Nagpur"

INTERSECT -- Can only return it if the columns match. Can't display c.city and d.city.

SELECT d.cname
FROM deposit d
JOIN branch b ON b.bname=d.bname
WHERE b.city IN ('Bombay', 'Delhi');

-- Explicit Join
SELECT c.cname, c.city AS "Living City", b.city AS "Branch City"
FROM customer c
JOIN deposit d ON c.cname = d.cname
JOIN branch b ON b.bname = d.bname
WHERE c.city = 'Nagpur'
AND b.city IN ('Bombay', 'Delhi');

-- Implied Join
SELECT c.cname, c.city AS "Living City", b.city AS "Branch City"
FROM customer c, branch b, deposit d
WHERE d.bname = b.bname
AND c.cname = d.cname
AND c.city = 'Nagpur'
AND b.city IN ('Bombay', 'Delhi');

---- 6. List all the depositors living in city Nagpur. 

SELECT cname
FROM customer
WHERE city = "Nagpur"

INTERSECT

SELECT cname
FROM deposit;

---- 7. List all the depositors living in city Nagpur and having branch in city Delhi. 

SELECT cname
FROM customer
WHERE city = "Nagpur"

INTERSECT

SELECT cname
FROM deposit d
JOIN branch b ON b.bname=d.bname
WHERE b.city IN ('Delhi');

---- 8. List the branch cities of Anil and Sunil. 

SELECT b.city
FROM branch b
JOIN deposit d ON d.bname=b.bname
WHERE cname="Anil"

UNION

SELECT b.city
FROM branch b
JOIN deposit d ON d.bname=b.bname
WHERE cname="Sunil";

---- 9. List the borrowers having branch city same as that of Sunil. 

-- Using Intersect
SELECT l.cname
FROM borrow l
JOIN branch b ON b.bname = l.bname
    
INTERSECT

SELECT l.cname
FROM borrow l
JOIN branch b ON b.bname = l.bname
WHERE b.city
IN (SELECT b2.city
    FROM branch b2
    JOIN borrow l2 ON l2.bname=b2.bname
    WHERE l2.cname = "Sunil");

-- Using Self Joins
SELECT DISTINCT l.cname
FROM borrow l
JOIN branch b ON b.bname = l.bname
    
JOIN borrow l_sunil ON l_sunil.cname = 'Sunil'
JOIN branch b_sunil ON b_sunil.bname = l_sunil.bname
WHERE b.city = b_sunil.city;

---- 10. List the customer having deposit greater than 1000 and loan less than 10000. 




---- 11. List the borrowers having branch city same as that of Sunil. 



---- 12. List the cities of depositors having branch VRCE.



---- 13. List the depositors having the same living city as that of Sunil and the same branch city as that of Anil. 



---- 14. List the depositors having amount less than 8000 and living in the same city as Ms. Shivani. 



---- 15. List all the customers who are both depositors and borrowers and living in the same city as Anil. 



---- 16. List all the cities where branches of Anil and Sunil are located. 



---- 17. List all the customer names and the amount for depositors living in the city where either Anil or Sunil is living. 



---- 18. List the amount for the depositors living in the city where Anil is living. 



---- 19. List the cities which are either branch city of Anil or living city of Sunil. 



---- 20. List the customers who are borrowers and depositors and having living city Bombay and branch city same as that of Sandip. 



---- 21. List the customers who are both borrowers and depositors and having the same branch city as that of Anil.



