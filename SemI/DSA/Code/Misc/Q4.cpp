// Fibonacci Series with Stop Value (Iterative)

#include <iostream.h>
#include <stdio.h>
#include <conio.h>

int main() {
    clrscr();
    
    int a = 0, b = 1, s;

    while (1) {
        cout << "Please enter the stop value for the Fibonacci series: ";
        cin >> s;
        
        if (cin.fail() || s < 2) {
            cin.clear();
            cout << "Please enter a valid value.\n\n";
        } else {
            break;
        }
    }

    cout << a << ", " << b;

    for (int i = 0; ; i++) {
        int c = a + b;

        if (c > s) { 
            break;
        }

        cout << ", " << c; 
        
        a = b; 
        b = c; 
    }

    getch();
    return 0;
}
