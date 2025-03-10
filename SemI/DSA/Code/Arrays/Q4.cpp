// Make a simple array but this time,
// the user will input the number of elements in the array,
// as well as the values themselves.
// Then display the array values.

#include <iostream.h> 
#include <conio.h>
#include <stdio.h>

int main() {
    clrscr();
    
    int n;
    
    cout << "Please enter the total number of elements for the array: ";
    cin >> n;
    cout << "\n" << "The array will have " << n << " elements. \n";
    
    int *ar;
    
    ar = new int[n];
    
    for (int i=0; i < n; i++) {
        cout << "Please enter the value of element " << i+1 << ": ";
        cin >> ar[i];
    }
    
    cout << "Array finished." << "\n\n";
    for (i=0; i < n; i++) {
        cout << "Array element " << i+1 << ": " << ar[i] << "\n";
    }   
    
    cout << "\nMemory used by the array: " << (sizeof(ar[0])) << " x " << n << " = " << (sizeof(ar[0])*n) << " bytes.";
    
    getch();
    return 0;
}

// ###### Notes: 
// The problem with this is that Variable-Length arrays (VLAs) are a feature in some compilers like GCC,
// they aren't part of the C++ standard. 
// The second thing is that even though the value of `n` is provided by then, C++ is a compiled language.
// It needs specifics when you click "run".
