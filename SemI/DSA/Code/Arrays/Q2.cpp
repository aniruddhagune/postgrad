// Print a simple 2D array like a Matrix.

#include <iostream.h>
#include <conio.h>

int main() {
	clrscr();
	int ar[3][2];
	for (int i=0; i<3; i++) {
		for (int j=0; j<2; j++) {
			cout << "Please enter a value for ar[" << i << "][" << j << "]: ";
			cin >> ar[i][j];
		}
	}

	for (i=0; i<3; i++) {
		for (int j=0; j<2; j++) {
			cout << ar[i][j] << " ";
			//cout << "\n\n The value of ar[" << i << "][" << j << "]: " << ar[i][j] << endl;
		} cout << endl;
	}

// Gets first dimension of an array.
sizeof(array)/sizeof(array[0])

// Gets second dimenstion of an array.
sizeof(array[0])/sizeof(array[0][0])
  
getch();
return 0;
}



/*
Explanation:
- `sizeof(array)` gives the total size of the 2D array in bytes.
- `sizeof(array[0])` gives the size of the first row (which is the size of one row of the array).
- `sizeof(array[0][0])` gives the size of one element in the array (which is the size of one column entry).
*/
