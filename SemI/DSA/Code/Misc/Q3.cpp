// Factorial calculator.

#include <iostream.h>
#include <stdio.h>
#include <conio.h>

int main() {
    clrscr();
    
    int n, f=1;
	
    while(1) {
        
        cout << "Enter number to caluclate its factorial: ";
        cin >> n;
        
        if (cin.fail() || n < 0) {
            cin.clear();
            cout << "Please enter a valid positive integer.\n\n";
        } else {
            break;
        }
    }
    
    for (int i=1; i<=n; i++) {
        f=f*i;
    }
    
    cout << endl << f;
    
    getch();
    return 0;
}
