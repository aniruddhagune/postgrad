/* For learning purposes,
make a similar program to before,
  but have the user enter values of 5 values and
loop the array to show values of ten elements.
*/

#include <iostream.h> 
#include <conio.h>
#include <stdio.h>

int main()
{
    clrscr();
    int ar[10];
    
    for (int i=0; i < 5; i++) {
        cout << "Please enter the value of element " << i+1 << ": ";
        cin >> ar[i];
    }
    
    cout << "Input finished." << "\n\n";
    for (i=0; i < sizeof(ar)/sizeof(ar[0]); i++) {
        cout << "Array[" << i << "] = " << ar[i] << "\n";
    }   
    
    getch();
    return 0;
}
