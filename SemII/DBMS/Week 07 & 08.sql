---- 1. Give 10% interest to all depositors.

UPDATE Deposit SET amount = amount * 1.10;


---- 2. Give 10% interest to all depositors having branch VRCE.

UPDATE Deposit SET amount = amount * 1.10 WHERE bname = 'VRCE';


---- 3. Give 10% interest to all depositors living in Nagpur.

UPDATE Deposit SET amount = amount * 1.10
WHERE actno IN (SELECT actno FROM Customer WHERE city = 'Nagpur');


---- 4. Give 10% interest to all depositors living in Nagpur and having branch in city Bombay.

UPDATE Deposit SET amount = amount * 1.10
WHERE actno IN (
  SELECT actno FROM Customer WHERE city = 'Nagpur'
) AND bname = 'Bombay';


---- 5. Add hundred rupees to the deposit of Anil and assign it to Sunil.

UPDATE Deposit SET amount = amount + 100 WHERE actno = (SELECT actno FROM Customer WHERE cname = 'Anil');
UPDATE Deposit SET amount = amount + 100 WHERE actno = (SELECT actno FROM Customer WHERE cname = 'Sunil');


---- 6. Change the deposit of VCRE branch to 1000 and change the branch as VCRE_Ambhazari.

UPDATE Deposit SET amount = 1000, bname = 'VCRE_Ambhazari' WHERE bname = 'VCRE';


---- 7. Assign to all deposit of Anil the maximum deposit from VRCE branch.

UPDATE deposit
JOIN (
    SELECT MAX(amount) AS max_amt FROM deposit WHERE bname = 'VRCE'
) AS max_table
SET deposit.amount = max_table.max_amt
WHERE deposit.cname = 'Anil';


---- 8. Change the living city of VRCE branch borrowers to Nagpur.

UPDATE customer
SET city = 'Nagpur'
WHERE cname IN (
    SELECT cname FROM borrow WHERE bname = 'VRCE'
);

-- Common Expression Table

WITH vrce_borrowers AS (
    SELECT cname FROM borrow WHERE bname = 'VRCE'
)
UPDATE customer
JOIN vrce_borrowers USING (cname)
SET customer.city = 'Nagpur';




---- 9. Update deposit of Anil give him maximum deposit from depositors in living city Nagpur.

WITH max_nagpur AS (
	SELECT MAX(d.amount) AS max_amount
	FROM deposit d
	JOIN customer c ON c.cname = d.cname
	WHERE c.city = "Nagpur"
)
UPDATE Deposit d
JOIN max_nagpur m
SET d.amount = m.max_amount
WHERE cname = "Anil"; 

-- Alternate

UPDATE deposit d
SET d.amount = (
	SELECT MAX(d2.amount)
	FROM deposit d2
	JOIN customer c ON c.cname = d2.cname
	WHERE c.city = 'Nagpur'
)
WHERE d.cname = 'Anil';



---- 10. Deposit the sum of the deposits of Sunil and Vijay in an account of Anil.

WITH sum_amount AS (
  SELECT SUM(amount) AS total FROM deposit WHERE cname IN ('Sunil', 'Vijay')
)
UPDATE deposit d
JOIN sum_amount s
SET d.amount = s.total
WHERE d.cname = 'Anil';

-- Alternate CTE

WITH sum_amount AS (
  SELECT 
    (SELECT amount FROM deposit WHERE cname = 'Sunil') +
    (SELECT amount FROM deposit WHERE cname = 'Vijay') AS total
)
UPDATE deposit d
JOIN sum_amount s
SET d.amount = s.total
WHERE d.cname = 'Anil';



---- 11. Transfer Rs 10 from the account of Anil to the account of Sunil.

-- A transaction:
START TRANSACTION;

UPDATE deposit
SET amount = amount - 10
WHERE cname = 'Anil';

UPDATE deposit
SET amount = amount + 10
WHERE cname = 'Sunil';

COMMIT;

-- Transfer using a CTE.

WITH t AS (
  SELECT cname, amount FROM deposit WHERE cname IN ('Anil', 'Sunil')
)
UPDATE deposit d
JOIN t ON d.cname = t.cname
SET d.amount = 
  CASE 
    WHEN d.cname = 'Anil' THEN d.amount - 10
    WHEN d.cname = 'Sunil' THEN d.amount + 10
  END;

-- Procedure

DELIMITER //

CREATE OR REPLACE PROCEDURE transfer(IN from_name VARCHAR(40), IN to_name VARCHAR(40), IN amt BIGINT)
BEGIN
  DECLARE from_balance BIGINT;

  SELECT amount INTO from_balance FROM deposit WHERE cname = from_name;

  IF from_balance >= amt THEN
    START TRANSACTION;

    UPDATE deposit SET amount = amount - amt WHERE cname = from_name;
    UPDATE deposit SET amount = amount + amt WHERE cname = to_name;

    COMMIT;
  ELSE
    SELECT 'Insufficient funds' AS status;
  END IF;
END //

DELIMITER ;

-- Interestingly this will show 0 rows affected.
-- This is because the update worked but 
-- there is no net change in the amount.




---- 12. Transfer Rs 10 from the account of Anil to the account of Sunil if both are having the same branch.

UPDATE deposit d
JOIN (
  SELECT d1.bname
  FROM deposit d1
  JOIN deposit d2 ON d1.bname = d2.bname
  WHERE d1.cname = 'Anil' AND d2.cname = 'Sunil'
) AS common_branch
SET d.amount = CASE
    WHEN d.cname = 'Anil' THEN d.amount - 10
    WHEN d.cname = 'Sunil' THEN d.amount + 10
END
WHERE d.cname IN ('Anil', 'Sunil');


---- 13. Transfer Rs 10 from the account of Madhuri to the account of Pramod if both are living in Nagpur.

UPDATE deposit
SET amount = CASE
    WHEN cname = 'Madhuri' THEN amount - 10
    WHEN cname = 'Pramod' THEN amount + 10
    ELSE amount
END
WHERE cname IN ('Madhuri', 'Pramod')
  AND cname IN (
      SELECT cname FROM customer WHERE city = 'Nagpur'
  );

-- 
WITH eligible AS (
  SELECT cname FROM customer
  WHERE city = 'Nagpur' AND cname IN ('Madhuri', 'Pramod')
)
UPDATE deposit
SET amount = CASE
  WHEN cname = 'Madhuri' THEN amount - 10
  WHEN cname = 'Pramod' THEN amount + 10
END
WHERE cname IN (SELECT cname FROM eligible);



---- 14. Delete from customer.

-- ...uh huh.
DELETE FROM customer;

---- 15. Delete depositors of branches having number of customer between 1 and 3.

Select * FROM deposit 
WHERE bname IN (
    SELECT bname FROM (
        SELECT d.bname
        FROM deposit d
        GROUP BY d.bname
        HAVING COUNT(DISTINCT d.cname) > 1 AND COUNT(DISTINCT d.cname) < 3
    ) AS subquery
);

-- BETWEEN is inclusive.
-- It will nuke the entire table if you use it.
-- Up to you.


---- 16. Delete branches having average deposit less than 5000.

DELETE FROM deposit
WHERE bname IN (
    SELECT bname
    FROM deposit
    GROUP BY bname
    HAVING AVG(amount) < 5000
);


---- 17. Delete branches having maximum loan more than 5000.

-- This quesiton is precarious because bname is in 3 tables.
-- So. Yeah.

WITH MaxLoan AS (
    SELECT bname
    FROM Borrow
    GROUP BY bname
    HAVING MAX(amount) > 5000
)
DELETE FROM branch
WHERE bname IN (SELECT bname FROM MaxLoan);


-- Probably ask Ma'am for clarification.


---- 18. Delete branches having deposit from Nagpur.

WITH NagpurBranches AS (
    SELECT DISTINCT d.bname
    FROM Deposit d
    JOIN Customer c ON d.cname = c.cname
    WHERE c.city = 'Nagpur'
)
DELETE FROM Branch
WHERE bname IN (SELECT bname FROM NagpurBranches);


---- 19. Delete deposit of Anil and Sunil if both are having branch Virar.

-- CTE
WITH CountMatch AS (
  SELECT COUNT(DISTINCT cname) AS del_count
  FROM Deposit
  WHERE bname = 'Virar' AND cname IN ('Anil', 'Sunil')
)
DELETE FROM Deposit
WHERE bname = 'Virar'
  AND cname IN ('Anil', 'Sunil')
  AND (SELECT del_count FROM CountMatch) = 2;

-- Alternate Non-CTE

DELETE FROM Deposit
WHERE bname = 'Virar'
  AND cname IN ('Anil', 'Sunil')
  AND (
    SELECT COUNT(DISTINCT cname)
    FROM Deposit
    WHERE bname = 'Virar' AND cname IN ('Anil', 'Sunil')
  ) = 2;



---- 20. Delete deposit of Anil and Sunil if both are having living city Nagpur.

WITH NagpurMatch AS (
  SELECT COUNT(DISTINCT cname) AS del_count
  FROM Customer
  WHERE city = 'Nagpur' AND cname IN ('Anil', 'Sunil')
)
DELETE FROM Deposit
WHERE cname IN ('Anil', 'Sunil')
  AND (SELECT del_count FROM NagpurMatch) = 2;


---- 21. Delete deposit of Anil and Sunil if both are having same living city.

-- CTE
WITH CityMatch AS (
  SELECT COUNT(DISTINCT city) AS city_count
  FROM Customer
  WHERE cname IN ('Anil', 'Sunil')
)
DELETE FROM Deposit
WHERE cname IN ('Anil', 'Sunil')
  AND (SELECT city_count FROM CityMatch) = 1;

-- Non CTE
DELETE FROM Deposit
WHERE cname IN ('Anil', 'Sunil')
  AND (
    SELECT COUNT(DISTINCT city)
    FROM Customer
    WHERE cname IN ('Anil', 'Sunil')
  ) = 1;

-- Possible to do with self joins as well.

DELETE FROM Deposit
WHERE cname IN ('Anil', 'Sunil')
  AND EXISTS (
    SELECT 1
    FROM Customer c1
    JOIN Customer c2 ON c1.city = c2.city
    WHERE c1.cname = 'Anil' AND c2.cname = 'Sunil'
  );



---- 22. Delete deposit of Anil and Sunil if they are having less deposit than Vijay.

-- Using Sum because there may be multiple accounts under one person. 
WITH VijayAmount AS (
  SELECT SUM(amount) AS vijay_total FROM Deposit WHERE cname = 'Vijay'
),
LowDepositors AS (
  SELECT cname
  FROM Deposit
  WHERE cname IN ('Anil', 'Sunil')
  GROUP BY cname
  HAVING SUM(amount) < (SELECT vijay_total FROM VijayAmount)
)
DELETE FROM Deposit
WHERE cname IN (SELECT cname FROM LowDepositors);


---- 23. Delete deposit of Vijay.

DELETE FROM deposit
WHERE cname = "Vijay";


---- 24. Delete deposit of Ajay if Vijay is not a depositor.

WITH vijayCheck AS 
(SELECT COUNT(*) AS cnt FROM Deposit WHERE cname = 'Vijay' )
DELETE FROM Deposit
WHERE cname = 'Naren'
  AND (SELECT cnt FROM vijayCheck) = 0;


---- 25. Delete customer from Bombay city.

DELETE FROM Deposit
WHERE cname IN (
  SELECT cname
  FROM Customer
  WHERE city = 'Bombay'
);

-- Join
DELETE d
FROM Deposit d
JOIN Customer c ON d.cname = c.cname
WHERE c.city = 'Bombay';


---- 26. Delete depositors if the branch is Virar and depositor name is Ajay.

DELETE FROM Deposit
WHERE bname = 'Virar' AND cname = 'Ajay';


---- 27. Delete depositors having deposit less than 500.

-- Per deposit
DELETE FROM deposit
WHERE amount < 500;

-- Per Person
WITH low_deposit AS (
  SELECT DISTINCT cname AS poor
  FROM deposit
  WHERE amount < 500
)
DELETE FROM deposit
WHERE cname IN (SELECT poor FROM low_deposit);


---- 28. Delete borrower having loan more than 10000.

DELETE FROM borrow
WHERE amount > 10000;


---- 29. Delete borrower having loan more than 10000 and branch Karolbagh.

DELETE FROM borrow
WHERE amount > 10000
AND bname IN ('Karolbagh');


---- 30. Delete the names of those depositors of VRCE branch who live in the city Bombay.

WITH matched AS (
SELECT d.cname AS names FROM deposit d
JOIN customer c ON c.cname=d.cname
WHERE c.city = 'Bombay' AND d.bname = 'VRCE'
)
DELETE FROM deposit
WHERE cname IN (SELECT names FROM matched);


---- 31. Delete borrower having branch name Chandani.

DELETE FROM borrow
WHERE bname IN ('Chandani');


---- 32. Delete borrower of branches having average loan less than 1000.

WITH low_avg_branches AS (
  SELECT bname, AVG(amount) AS average
  FROM Borrow
  GROUP BY bname
  HAVING average < 1000
)
DELETE FROM Borrow
WHERE bname IN (SELECT bname FROM low_avg_branches);


---- 33. Delete borrower of branches having the minimum number of customers.


WITH branch_customer_count AS (
  SELECT bname, COUNT(DISTINCT cname) AS cust_count
  FROM Deposit
  GROUP BY bname
),
branch_min AS (
  SELECT bname
  FROM branch_customer_count
  WHERE cust_count = (
    SELECT MIN(cust_count) FROM branch_customer_count
  )
)
DELETE FROM Borrow
WHERE bname IN (SELECT bname FROM branch_min);

