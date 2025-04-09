--
----
------ Week V & VI
----
--


---- 1. List total loan.

SELECT SUM(amount) AS `Total Loan` FROM borrow;

---- 2. List total deposit

SELECT SUM(amount) AS `Total Deposit` FROM deposit;

---- 3. List total loan taken from Andheri branch.

SELECT SUM(amount) AS `Total Loan` FROM borrow
WHERE bname = "Andheri";

---- 4. List total deposit of customer having account date later than 1-Jan-2006.

SELECT SUM(amount) AS `Total Deposit` FROM deposit
WHERE adate > '2006-01-06';

---- 5. List total deposit of customers living in city Nagpur.

SELECT SUM(amount) FROM deposit d
JOIN customer c ON c.cname=d.cname
WHERE c.city = "Nagpur";

---- 6. List maximum deposit of customer living in Bombay.

SELECT SUM(amount) FROM deposit d
JOIN customer c ON c.cname=d.cname
WHERE c.city = "Bombay";

---- 7. List total deposit of customers having branch city Delhi.

SELECT SUM(amount) FROM deposit d
JOIN branch b ON b.bname=d.bname
WHERE city = "Delhi";

---- 8. List total deposit of customers living in the city where Sunil is living.

SELECT SUM(amount) FROM deposit d
JOIN customer c ON c.cname=d.cname
JOIN customer c2 ON c2.cname="Sunil"
WHERE c.city = c2.city;

SELECT SUM(amount) FROM deposit d
JOIN customer c ON c.cname = d.cname
WHERE c.city = (SELECT city FROM customer WHERE cname = "Sunil");

---- 9. Count total number of branch cities.

SELECT COUNT(DISTINCT(city)) FROM branch;

---- 10. Count total number of customer cities.

SELECT COUNT(DISTINCT(city)) FROM customer;

---- 11. Give branch name and branch-wise deposit.

SELECT bname AS Branch, SUM(amount) AS `Branch Amount` FROM deposit
GROUP BY bname;

---- 12. Give city name and city wise deposit.

SELECT DISTINCT(c.city) AS City, SUM(d.amount) AS Amount FROM customer c
JOIN deposit d ON d.cname = c.cname
GROUP by city;

---- 13. Give city wise name and branch wise deposit.

SELECT b.city, d.bname, SUM(d.amount) AS total_deposit FROM deposit d
JOIN branch b ON b.bname = d.bname
GROUP BY b.city, d.bname;

---- 14. Give the branch wise deposit of customer after account date 1-jan-2006.

-- Branch wise total deposits.
SELECT bname, SUM(amount) AS `Total Deposit` FROM deposit
WHERE STR_TO_DATE(adate, '%d-%b-%Y') > '2006-01-06'
GROUP BY bname ORDER BY bname;

-- If asking for branch wise individual customer deposits.
SELECT bname, cname, amount FROM deposit
WHERE STR_TO_DATE(adate, '%d-%b-%Y') > '2006-01-06'
ORDER BY bname;

---- 15. Give branch wise loan of customer living in Nagpur.

SELECT b.bname AS Branch, SUM(l.amount) AS Amount FROM customer c
JOIN borrow l ON l.cname = c.cname
JOIN branch b ON b.bname = l.bname
WHERE c.city = "Nagpur"
GROUP BY b.bname;

---- 16. Count total no. of customers.

SELECT city, COUNT(cname) FROM customer GROUP BY city;

---- 17. Count total no. of depositor branch wise.

SELECT bname AS Branch, COUNT(cname) AS Customers FROM deposit GROUP BY bname;

-- For Verification
SELECT city, COUNT(cname) FROM deposit d
JOIN branch b ON b.bname = d.bname
GROUP BY city;

---- 18. Give maximum loan from branch VRCE.

SELECT MAX(amount) FROM borrow WHERE bname = "VRCE";

---- 19. Give living city wise loan of borrowers.

SELECT c.city AS City, SUM(l.amount) AS Amount FROM borrow l
JOIN customer c ON c.cname = l.cname
GROUP BY c.city;

---- 20. Give the number of customers who are depositor as well as borrowers.

SELECT COUNT(l.cname) AS `Depositor as well as Borrower` FROM borrow l
JOIN deposit d ON d.cname = l.cname;

--
----
------ Group By & Having Clause
----
--

---- 1. List the branches having sum of deposit more than 4000.

SELECT bname, SUM(amount) FROM deposit
GROUP BY bname
HAVING SUM(amount) > 4000;

---- 2. List the branches having a sum deposit more than 1000 and location in city Bombay.

SELECT d.bname, SUM(d.amount) FROM deposit d
JOIN branch b ON d.bname=b.bname
WHERE b.city = "Bombay"
GROUP BY bname
HAVING SUM(amount) > 1000;

---- 3. List the names of customers having deposit in the branches where the average deposit is more than 1000.

SELECT DISTINCT d.cname, d.bname 
FROM deposit d
WHERE d.bname IN (
    SELECT bname 
    FROM deposit 
    GROUP BY bname 
    HAVING AVG(amount) > 1000
);



























