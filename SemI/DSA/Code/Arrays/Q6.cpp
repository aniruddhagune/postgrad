// Take number inputs and output alphabets that correspond to the number.
// Ex. 1 -> A, 2 -> B. And 12 -> AB.

#include <iostream.h>
#include <stdio.h>
#include <conio.h>

void numToChars(int inp) {
    int rem = inp, temp, count=0;
    char ar[20]; // Yeah I made it an int array first :  )
    
    //cout << count;
    
    if (rem <= 9) {
        cout << char(rem+64);
    } else {
        for (int i=0; rem>0; i++) {
        
        temp = rem % 10;
        rem = rem / 10;
        
        // cout << char(temp+64); // This prints it in reverse order because modulo would give us rtl, not ltr.
        
        ar[i] = char(temp+64);
        count++;
        
        }
    }
	
	// Array iteration for display.
    for (int i=count-1; i>=0; i--) {
        cout << ar[i];
    }
}

int main()
{
    clrscr();
    int inp;
    
    cout << "Please input some numbers: ";
    cin >> inp;
    
    numToChars(inp);
    
    getch();
    return 0;
}
