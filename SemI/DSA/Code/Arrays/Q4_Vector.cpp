#include <iostream> 
#include <vector>

using namespace std;

int main()
{
    int n;
    cout << "Please enter the total number of elements for the array: ";
    cin >> n;
    cout << "\nThe array will have " << n << " elements. \n";
    
    vector<int> ar(n);
    
    for (int i=0; i < ar.size(); i++) {
        cout << "Please enter the value of element " << i+1 << ": ";
        cin >> ar[i];
    }
    
    cout << "Array finished." << "\n\n";
    for (int i=0; i < ar.size(); i++) {
        cout << "Array element " << i+1 << ": " << ar[i] << "\n";
    }   
    
    cout << "\nMemory used by the array elements: " << (sizeof(ar[0])) << " x " << ar.size() << " = " << (sizeof(ar[0])*ar.size()) << " bytes.";
    cout << "\nTotal memory used by the vector: " << (sizeof(ar[0])) << " x " << ar.capacity() << " = " << (sizeof(ar[0])*ar.capacity()) << " bytes.";
    
    return 0;
}

// Pretty much like arrays, also use contiguous memory locations.

// Main difference is the overhead they have when they need to actually grow in size,
// which is when they'll copy the entire array into another (bigger) contiguous memory location and
// then delete the existing array.

// Size when growing is generally 1.5x or 2x the current size.
// The resizing process is also O(n) due to the copying operation,
// but it’s generally less frequent because vectors use a strategy to grow their capacity in larger increments
// to reduce the number of resizes.

// Another notable overhead is insertion at the beginning or middle,
// because elements may be shifted.
// This operation takes linear time, `O(n)`. It's `O(1)` for inserting at the end.

// They do automatically manage memory, in comparison to arrays where it's manual. Dynamic and static nature.
