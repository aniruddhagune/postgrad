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

---- 4. List the name of customers having maximum deposit in respective branches.

SELECT d.bname, d.cname, d.amount FROM deposit d
GROUP BY d.bname HAVING MAX(d.amount);

---- 5. List the name of customers having maximum deposit from all the customers living in Nagpur.

SELECT d.bname, d.cname, d.amount
FROM deposit d

JOIN (
    SELECT bname, MAX(amount) AS max_amount
    FROM deposit
    GROUP BY bname
) AS max_deposits

ON d.bname = max_deposits.bname 
AND d.amount = max_deposits.max_amount;


-- So, you can get the branch max amounts from the subquery alone
-- but the reason we use JOIN is because we need names of the customers that have the max deposit amounts
-- and GROUP BY needs every column to be in GROUP BY
-- or be inside an aggregate function.

---- 6. List the name of branch having highest number of depositors.

-- Shows only 1 entry.
SELECT bname, COUNT(DISTINCT cname) AS num_depositors
FROM deposit
GROUP BY bname
ORDER BY num_depositors DESC
LIMIT 1;

-- Window Functions

WITH ranked_branches AS (
  SELECT bname, COUNT(DISTINCT cname) AS num_depositors,
         RANK() OVER (ORDER BY COUNT(DISTINCT cname) DESC) AS rank
  FROM deposit
  GROUP BY bname
)
SELECT bname FROM ranked_branches
WHERE rank = 1;


-- CTE
WITH branch_counts AS (
  SELECT bname, COUNT(DISTINCT cname) AS depositor_count
  FROM Deposit
  GROUP BY bname
)
SELECT bname
FROM branch_counts
WHERE depositor_count = (SELECT MAX(depositor_count) FROM branch_counts);

-- 
SELECT bname
FROM Deposit
GROUP BY bname
HAVING COUNT(DISTINCT cname) >= ALL (
  SELECT COUNT(DISTINCT cname)
  FROM Deposit
  GROUP BY bname
);


---- 7. Count the number of depositors living in Nagpur.

SELECT COUNT(DISTINCT d.cname)
FROM Deposit d
JOIN Customer c ON d.cname = c.cname
WHERE c.city = 'Nagpur';


---- 8. Give the name of customers in Powai branch having more deposit than all customer VRCE branch.

SELECT cname
FROM Deposit
WHERE bname = 'Powai'
  AND amount > (
    SELECT SUM(amount)
    FROM Deposit
    WHERE bname = 'VRCE'
  );


---- 9. Give names of customers in Karolbagh branch having more deposit than any other in Virar branch.

SELECT cname
FROM Deposit
WHERE bname = 'Karolbagh'
  AND amount > (
    SELECT MAX(amount)
    FROM Deposit
    WHERE bname = 'Virar'
  );


---- 10. Give names of customers having highest deposit in the branch where Sunil is having deposit.

WITH sunil_branch AS (
  SELECT bname
  FROM Deposit
  WHERE cname = 'Sunil'
),
max_deposit AS (
  SELECT MAX(amount) AS max_amt
  FROM Deposit
  WHERE bname = (SELECT bname FROM sunil_branch)
)
SELECT cname
FROM Deposit
WHERE bname = (SELECT bname FROM sunil_branch)
  AND amount = (SELECT max_amt FROM max_deposit);



---- 11. Give the highest deposit of the city where branch of Sunil is located.

-- Join
SELECT MAX(d1.amount) AS highest_deposit
FROM Deposit d1
JOIN Branch b1 ON d1.bname = b1.bname
JOIN Deposit d2 ON d2.cname = 'Sunil'
JOIN Branch b2 ON d2.bname = b2.bname
WHERE b1.city = b2.city;

-- CTE
WITH sunil_city AS (
  SELECT b.city
  FROM Deposit d
  JOIN Branch b ON d.bname = b.bname
  WHERE d.cname = 'Sunil'
)
SELECT MAX(d.amount) AS highest_deposit
FROM Deposit d
JOIN Branch b ON d.bname = b.bname
WHERE b.city = (SELECT city FROM sunil_city);


---- 12. Give names of customers having more deposit than the average deposit in their respective branches.

-- CTE
WITH branch_avg AS (
  SELECT bname, AVG(amount) AS avg_amt
  FROM Deposit
  GROUP BY bname
)
SELECT d.cname
FROM Deposit d
JOIN branch_avg b ON d.bname = b.bname
WHERE d.amount > b.avg_amt;

-- Join
SELECT d1.cname
FROM Deposit d1
JOIN (
  SELECT bname, AVG(amount) AS avg_amt
  FROM Deposit
  GROUP BY bname
) AS avg_table ON d1.bname = avg_table.bname
WHERE d1.amount > avg_table.avg_amt;

---- 13. Give names of customers having maximum deposit among deposits of Nagpur for branch VRCE.

-- JOIN + Subquery
SELECT d.cname
FROM Deposit d
JOIN Customer c ON d.cname = c.cname
WHERE d.bname = 'VRCE' AND c.city = 'Nagpur'
  AND d.amount = (
    SELECT MAX(d2.amount)
    FROM Deposit d2
    JOIN Customer c2 ON d2.cname = c2.cname
    WHERE d2.bname = 'VRCE' AND c2.city = 'Nagpur'
);

-- CTE
WITH target_deposits AS (
  SELECT d.cname, d.amount AS t_amount
  FROM Deposit d
  JOIN Customer c ON d.cname = c.cname
  WHERE d.bname = 'VRCE' AND c.city = 'Nagpur'
)
SELECT cname
FROM target_deposits
WHERE t_amount = (SELECT MAX(t_amount) FROM target_deposits);

---- 14. Give the name of branch there are less than 2 depositors.

SELECT bname
FROM Deposit
GROUP BY bname
HAVING COUNT(DISTINCT cname) < 2;

---- 15. Give name of the city having more customers living in it than Nagpur.

SELECT city, COUNT(*) AS num_customers
FROM Customer
GROUP BY city
HAVING COUNT(*) > (
  SELECT COUNT(*)
  FROM Customer
  WHERE city = 'Nagpur'
);

---- 16. Give names of branches having more depositors than borrowers.

SELECT bname
FROM Deposit
GROUP BY bname
HAVING COUNT(DISTINCT cname) > (
  SELECT COUNT(DISTINCT cname)
  FROM Borrow
  WHERE Borrow.bname = Deposit.bname
);

---- 17. Give the names of customers living in the city where the maximum numbers of depositors are located.

WITH city_counts AS (
  SELECT c.city, COUNT(DISTINCT d.cname) AS cnt
  FROM Deposit d
  JOIN Customer c ON d.cname = c.cname
  GROUP BY c.city
),
max_city AS (
  SELECT city
  FROM city_counts
  WHERE cnt = (SELECT MAX(cnt) FROM city_counts)
)

SELECT cname
FROM Customer
WHERE city IN (SELECT city FROM max_city);

---- 18. Give the name of cities in which the maximum numbers of branches are located.

-- Uses All
SELECT city
FROM Branch
GROUP BY city
HAVING COUNT(*) >= ALL (
  SELECT COUNT(*)
  FROM Branch
  GROUP BY city
);

-- Rank Function
SELECT city
FROM (
  SELECT city, DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
  FROM Branch
  GROUP BY city
) AS ranked
WHERE rnk = 1;

-- Non CTE
SELECT city
FROM Branch
GROUP BY city
HAVING COUNT(*) = (
  SELECT MAX(branch_count)
  FROM (
    SELECT city, COUNT(*) AS branch_count
    FROM Branch
    GROUP BY city
  ) AS sub
);

-- CTE
WITH branch_counts AS (
  SELECT city, COUNT(*) AS branch_count
  FROM Branch
  GROUP BY city
)
SELECT city
FROM branch_counts
WHERE branch_count = (SELECT MAX(branch_count) FROM branch_counts);


---- 19. Give the names of borrowers having the same branch city as highest borrower.

-- Join
SELECT b1.cname
FROM Borrow b1
JOIN Branch br1 ON b1.bname = br1.bname
JOIN Borrow b2 ON b2.amount = (SELECT MAX(amount) FROM Borrow)
JOIN Branch br2 ON b2.bname = br2.bname
WHERE br1.city = br2.city;

-- CTE
WITH highest_borrower AS (
  SELECT bname, amount
  FROM Borrow
  WHERE amount = (SELECT MAX(amount) FROM Borrow)
),
target_city AS (
  SELECT DISTINCT b.city
  FROM highest_borrower hb
  JOIN Branch b ON hb.bname = b.bname
)
SELECT l.cname
FROM Borrow l
JOIN Branch b ON l.bname = b.bname
WHERE b.city IN (SELECT city FROM target_city);


---- 20. Count the number of customers living in the city where branch is located.

-- What is that phrasing?
SELECT COUNT(DISTINCT c.cname) AS customer_count
FROM Customer c
JOIN Branch b ON c.city = b.city;

-- For customers in the same city as their branch city.
SELECT COUNT(DISTINCT d.cname) AS matching_customers
FROM Customer c
JOIN Deposit d ON d.cname = c.cname
JOIN Branch b ON d.bname = b.bname
WHERE c.city = b.city;



