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

- **Function**: Like a vending machine. Input → Output.
- **Procedure**: Like a shopkeeper. You ask for something, and they may do 5 different things to deliver it — even if you don’t get a return value directly.

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



---- 8. Demonstrate trigger.


