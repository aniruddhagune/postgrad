/* 
 * Q3.
 * WAP to accept `n` number of elements 
 * and display elements having minimum and maximum divergence
 * from the average of the given numbers.
 */

import java.util.*;
import java.lang.*;

public class Q3 {

    static class driverfunctions {
        
        float[] takeValues(int n, Scanner sc) {
            float[] ar = new float[n];
            for (int i=0; i<n; i++) {
                System.out.print("Value of number "+(i+1)+": ");
                ar[i] = sc.nextInt();
            } 
                return ar;
            }
        
        float averageOfValues(float ar[]) {
            float avg=0;
            for (int i=0; i<ar.length; i++) {
                avg += ar[i];
            }
            avg /= ar.length;
            return avg;
        }

        float[] calculateDivergence(float ar[], float avg) {
            
            float[] divergence = new float[2];
            float diff=0;
            
            divergence[0] = Float.MAX_VALUE;
            divergence[1] = -Float.MAX_VALUE;
            
            for (int i=0;i<ar.length;i++) {
                diff = Math.abs(avg-ar[i]);

                if (diff<divergence[0]) {
                    divergence[0] = diff;
                }
                if (diff>divergence[1]) {
                    divergence[1] = diff;
                }
            }
        return divergence;
        }
    }

    public static void main(String s[]) {
        
        Scanner sc = new Scanner(System.in);
        driverfunctions df = new driverfunctions();

        System.out.print("Enter number of \"n\": ");
        int n = sc.nextInt();
        
        if (n<=0) {System.out.println("Invalid input. Goodbye."); System.exit(0);}
            
        float[] ar = df.takeValues(n, sc);
        
        float avg = df.averageOfValues(ar);
        float[] divergence = df.calculateDivergence(ar, avg);

        System.out.printf("\nAverage: %.2f",avg);
        System.out.printf("\nMinimum Divergence: %.2f",divergence[0]);
        System.out.printf("\nMaximum Divergence: %.2f",divergence[1]);
            
    }
}
