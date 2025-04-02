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
