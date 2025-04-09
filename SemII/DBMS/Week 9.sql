---- 1. PLSQL code to find sum of two numbers

ACCEPT num1 CHAR PROMPT 'Enter the first number: '
ACCEPT num2 CHAR PROMPT 'Enter the second number: '

DECLARE
   num1 NUMBER := &num1;
   num2 NUMBER := &num2;
   sum_result NUMBER;
BEGIN
   sum_result := num1 + num2;
   DBMS_OUTPUT.PUT_LINE('The sum of ' || num1 || ' and ' || num2 || ' is ' || sum_result || '.');
END;
/

---- 2. PLSQL code to print Fibonacci series

ACCEPT n CHAR PROMPT 'Enter number of terms for fibonacci series: '

DECLARE
   a NUMBER := 0; b NUMBER := 1; c NUMBER;
   n NUMBER := &n; i NUMBER := 3;
BEGIN
	IF n <= 0 THEN
		DBMS_OUTPUT.PUT_LINE('Input a valid positive integer.'); 
	ELSIF n = 1 THEN
		DBMS_OUTPUT.PUT_LINE(a);
	ELSIF n = 2 THEN
		DBMS_OUTPUT.PUT_LINE(a || ', ' || b);
	ELSE
		DBMS_OUTPUT.PUT(a || ', ' || b);
	
	WHILE i <= n LOOP
		c := a+b; 
		DBMS_OUTPUT.PUT(', ' || c);
		
		a := b;
		b := c;
		
		i := i+1;
		END LOOP;
        DBMS_OUTPUT.PUT_LINE(''); -- Flush, show output.
	END IF;
END;
/

---- 3. PLSQL code to find whether given number is even or odd

ACCEPT n CHAR PROMPT 'Enter number of terms for fibonacci series: '

DECLARE
   n NUMBER := &n; 
BEGIN
	IF n = 0 THEN
		DBMS_OUTPUT.PUT_LINE(n || ' is Zero. Don''t judge.'); 
	ELSIF MOD(n, 2) = 0 THEN
      DBMS_OUTPUT.PUT_LINE(n || ' is an even number.');
   ELSE
      DBMS_OUTPUT.PUT_LINE(n || ' is an odd number.');
   END IF;

END;
/

---- 4. Create function to display square of given number.

ACCEPT n CHAR PROMPT 'Enter number for its square: '

DECLARE
   n NUMBER := &n; 
BEGIN
    DBMS_OUTPUT.PUT_LINE(n*n || ' is the square of ' || n || '.');
END;
/

---- 5. Create procedure to display division of student.

CREATE OR REPLACE PROCEDURE display_division (marks IN NUMBER) IS
BEGIN
   IF marks >= 60 THEN
      DBMS_OUTPUT.PUT_LINE('First Division');
   ELSIF marks >= 50 THEN
      DBMS_OUTPUT.PUT_LINE('Second Division');
   ELSIF marks >= 40 THEN
      DBMS_OUTPUT.PUT_LINE('Third Division');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Your life is about to be divided.');
   END IF;
END;
/

---- 6. Create package having one procedure to add two numbers and one function to subtract two numbers.

-- Package Declaration
CREATE OR REPLACE PACKAGE question_six AS
   PROCEDURE add_numbers(a IN NUMBER, b IN NUMBER);
   FUNCTION subtract_numbers(a IN NUMBER, b IN NUMBER) RETURN NUMBER;
END question_six;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY question_six AS

   PROCEDURE add_numbers(a IN NUMBER, b IN NUMBER) IS
   BEGIN
      DBMS_OUTPUT.PUT_LINE('Sum: ' || (a + b));
   END add_numbers;

   FUNCTION subtract_numbers(a IN NUMBER, b IN NUMBER) RETURN NUMBER IS
   BEGIN
      RETURN a - b;
   END subtract_numbers;

END question_six;
/

-- Call Procedure & Function
ACCEPT n1 CHAR PROMPT 'Enter the first number: '
ACCEPT n2 CHAR PROMPT 'Enter the second number: '

DECLARE
	n1 NUMBER := &n1;
	n2 NUMBER := &n2;
BEGIN
   question_six.add_numbers(n1, n2);
   DBMS_OUTPUT.PUT_LINE('Difference: ' || question_six.subtract_numbers(n1, n2));
END;
/

---- 7. Demonstrate cursor.

DECLARE
  CURSOR low_salary_cursor IS
    SELECT emp_id, salary FROM employee WHERE salary < 25000;

  v_id     employee.emp_id%TYPE;
  v_salary employee.salary%TYPE;

BEGIN
  OPEN low_salary_cursor; -- Creating result set in memory; make space.

  LOOP
    FETCH low_salary_cursor INTO v_id, v_salary; -- Fetch one row at a time into variables.
    EXIT WHEN low_salary_cursor%NOTFOUND; -- When to end; when there's none left.

    -- Give bonus to the struggling.
    UPDATE employee
    SET salary = v_salary + 1000
    WHERE emp_id = v_id;
	
    DBMS_OUTPUT.PUT_LINE('Updated Employee ID ' || v_id || ' with new salary: ' || (v_salary + 1000));
  END LOOP;

  CLOSE low_salary_cursor;
END;
/

---- 8. Demonstrate trigger.

CREATE OR REPLACE TRIGGER trg_before_insert_emp

BEFORE INSERT ON emp
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('Inserting employee: ' || :NEW.ename);
END;
/

CREATE OR REPLACE TRIGGER trg_after_insert_emp

AFTER INSERT ON emp
FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('Inserted employee: ' || :NEW.ename);
END;
/

CREATE OR REPLACE TRIGGER trigger_created_at

BEFORE INSERT ON emp
FOR EACH ROW
BEGIN
  :NEW.created_at := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER trigger_created_at

BEFORE UPDATE ON emp
FOR EACH ROW
BEGIN
  :NEW.modified_at := SYSDATE;
END;
/
