/* Q2. Write a program to accept 2 arguments from the command line
 * where 1st argument is the choice that works on the 2nd argument
 * , and 2nd argument is the input variable.
 * The choices are: Square, Cube, or Factorial.
 */

// For scanner.
import java.util.*;

class driverFunctions {

    int nSquare(int n) {
        return n*n;
    }

    int nCube(int n) {
        return n*n*n;
    }

    int nFactorial(int n) {
        int result = n;
        for (int i = 1; i<n; i++) {
            result *= i;
        }
        return result;
    }

}

public class Q2 {
    public static void main(String s[]) {
        
        if (s.length < 2) {
            System.out.println("Please provide two arguments: choice (1-3) and a number.");
            return;
        }

        int ch = Integer.parseInt(s[0]);
        int n = Integer.parseInt(s[1]);
        driverFunctions df = new driverFunctions();

        System.out.print("Arguments: " + ch + ", " + n + "\n");

        switch(ch) {
            case 1:
                System.out.println("Square of " + n + ": " + df.nSquare(n));
                break;
            case 2:
                System.out.println("Cube of " + n + ": " + df.nCube(n));
                break;
            case 3:
                System.out.println("Factorial of " + n + ": " + df.nFactorial(n));
                break;
            default:
                System.out.println("bad argument.");
                break;
        }
    }
}
