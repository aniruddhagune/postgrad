#include <iostream.h>
#include <conio.h>
#define maxNumber 12

int main() {
	clrscr();
	int ar[maxNumber] = {3, 5, 6};
	
	cout << "The address of the array: " << ar << endl;
	cout << "Size of array (bytes): " << sizeof(ar) << endl;
	cout << "Size of one element: " << sizeof(ar[0]) << endl;
	
    for (int i = 0; i < (sizeof(ar) / sizeof(ar[0])); i++) {
        cout << "The value of ar[" << i << "]: " << ar[i] << endl;
    }

getch();
return 0;
}

/*
Notes:
- Size of int in Turbo C++ is usually **2 bytes**, while in most modern compilers an int would be 4 bytes.
- `cout << ar` is equivalent to `cout << &ar[0]`; address of the first element.
- `#define` directive is a preprocessor command, so it's processed before actual compilation of code begins.
  Since those are text replacements, there's no type checking meaning inapt macros won't generate compile-time errors.
*/
