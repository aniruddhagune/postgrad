// Check if the matrix entered is a sparse matrix.

#include <iostream.h>
#include <conio.h>
#define mRows 12
#define mCols 12

int main(){
	clrscr();
	
	int r, c, zC=0;
	
	cout << "Please enter the number of rows: "; cin >> r;
	cout << "Please enter the number of columns: "; cin >> c;
	
	int matr[mRows][mCols];
	
	for (int i=0; i<r; i++) {
		for (int j=0; j<c; j++) {
			cout <<"Please enter value for [" << i << "][" << j << "]: ";
			cin >> matr[i][j];
			if (matr[i][j] == 0) {
			    zC++;
			}
		}
	}
	
	cout << "\nMatrix: \n";
	for (i=0; i<r; i++) {
		for (int j=0; j<c; j++) {
			cout << matr[i][j] << " ";
		}
	cout << endl;
	}
	
	
	if (zC >= (r*c)/2) {
        cout << "\nThe matrix created is a sparse matrix." << endl;
    } else {
        cout << "\nThe matrix created is not a sparse matrix." << endl;
    }
	
	getch();
	return 0;
	
}
