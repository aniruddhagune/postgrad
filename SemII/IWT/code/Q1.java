/* Q1. Write a program to read `n` values
 * in form of numbers from command line
 * & display average, sum, minimum & maximum among all `n` values.
 */

// For scanner.
import java.util.*;

class driverFunctions {

    int[] initArray(int n, Scanner sc) {
        int[] ar = new int[n];
        for (int i=0;i<n;i++) {
            System.out.print("\nPlease enter value for number " + i + ": ");
            ar[i] = sc.nextInt();
        }
        return ar;
    }

    int sum(int[] ar) {
        int sum = 0;
        for (int i : ar) {
            sum += i;
        }
        return sum;
    }

    double average(int s, int n) {
        return (double) s/n;
    }

    int max(int[] ar) {
        int maxVal = ar[0];
        for (int i : ar) {
            if (i > maxVal) maxVal = i;
        }
        return maxVal;
    }

    int min(int[] ar) {
        int minVal = ar[0];
        for (int i : ar) {
            if (i < minVal) minVal = i;
        }
        return minVal;
    }

}

public class Q1 {
    public static void main(String s[]) {
        
        // Ask user for total numbers.
        System.out.print("Value of n: ");
        
        // Create object for the driver functions.
        driverFunctions dF = new driverFunctions();
        
        // Take input from user.
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();

        // Make an array of size n.
        // Initialize it with the function from inside the driverFunction class.
        int[] ar = dF.initArray(n, sc);

        // Calculate the calculables™
        int sum = dF.sum(ar);
        double average = dF.average(sum, n);
        int max = dF.max(ar);
        int min = dF.min(ar);

        System.out.println("------ Results ------");

        // Display the result to the user.
        System.out.println("\nMax value: " + max);
        System.out.println("Min value: " + min);
        System.out.println("Sum of the values: " + sum);
        System.out.println("Average of the values: " + average);
    }
}
