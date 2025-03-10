//  In a program with a simple array,
// find the base address,
// and let the user select one of the elements and display its specific address.

#include <iostream.h> 
#include <stdio.h>
#include <conio.h>

int main() {
    clrscr();
    
    int ar[7];
    
    for (int i=0; i < sizeof(ar)/sizeof(ar[0]) ; i++) {
        cout << "Please enter the value of element " << i+1 << ": ";
        cin >> ar[i];
    }
    
    cout << "Input finished." << "\n\n";
    for (i=0; i < sizeof(ar)/sizeof(ar[0]); i++) {
        cout << "Array[" << i << "] = " << ar[i] << "\n";
    }   
    
    int *BA = ar; // name of array in context of pointer arithmetic, automatically decays to a pointer to its first element: &ar[0]
    int a;
    
    cout << "\nBase address of the array: " << BA;
    cout << "\nPlease enter index number of the element you want to see the specific address of: ";
    
    cin >> a;
    
    /* Pointer specific logic makes it so that CPP understands that (BA+a) isn't simple addition,
     but rather just moving to the specified index.
     The type size calculation is done automatically. */
    
    cout << "Specific address of element with index [" << a << "]: " << (BA+a) << endl;
    
    // For validation, this accesses the memory address of a directly.
    cout << "For validation: " << &ar[a];
    
    //  Initially wrote this.
    //  cout << "Specific address of element with index [" << a << "]: " << (BA+((sizeof(ar[0]))*a));
    
    getch();
    return 0;
}
