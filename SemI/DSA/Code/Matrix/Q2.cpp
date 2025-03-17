// Print the transpose of a matrix.

#include <iostream.h>
#include <conio.h>
#define mRows 12
#define mCols 12

int main(){
	clrscr();
	
	int r, c;
	
	cout << "Please enter the number of rows: "; cin >> r;
	cout << "Please enter the number of columns: "; cin >> c;
	
	int matn[mRows][mCols];
	int matt[mRows][mCols];
	
	for (int i=0; i<r; i++) {
		for (int j=0; j<c; j++) {
			cout <<"Please enter value for [" << i << "][" << j << "]: ";
			cin >> matn[i][j];
		}
	}
	
	cout << "\nMatrix: \n";
	for (i=0; i<r; i++) {
		for (int j=0; j<c; j++) {
			cout << matn[i][j] << " ";
		}
	cout << endl;
	}
	
	// Transpose
	for (i=0; i<r; i++) {
		for (int j=0; j<c; j++) {
			matt[j][i] = matn[i][j]; // Swap i and j
		}
	}
	
	cout << "\nTranspose: \n";
	for (i=0; i<c; i++) { // Swap r and c in loops
		for (int j=0; j<r; j++) {
			cout << matt[i][j] << " ";
		}
		cout << endl;
	}
	
	getch();
	return 0;
	
}
