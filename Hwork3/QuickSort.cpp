#include <iostream> 
#include <stack>


using namespace std;

int partition( int arr[], int low, int high ) {
  int pivot = arr[ high ]; // Choosing the last element as pivot
  int i = low - 1; // Index for smaller elements

  for ( int j = low; j < high; j++ ) {
    if ( arr[ j ] < pivot ) {
      i++;
      swap( arr[ i ], arr[ j ] );
    }
  }
  swap( arr[ i + 1 ], arr[ high ] ); // Place pivot in correct position
  return i + 1; // Return pivot index
}

void quickSort( int arr[], int low, int high ) {
  stack<pair<int, int>> qsStack; // Stack to store subarray indices

  // Push initial range onto stack
  qsStack.push( { low, high } );

  while ( !qsStack.empty() ) {
    auto [l, h] = qsStack.top(); // Get current subarray range
    qsStack.pop();

    if ( l < h ) {
      int p = partition( arr, l, h ); // Partition the array

      // Push right subarray if it has elements
      if ( p + 1 < h ) {
        qsStack.push( { p + 1, h } );
      }
      // Push left subarray if it has elements
      if ( l < p - 1 ) {
        qsStack.push( { l, p - 1 } );
      }
    }
  }
}
void printArray( int arr[], int size ) {
  for ( int i = 0; i < size; i++ )
    cout << arr[ i ] << " ";
  cout << endl;
}
int main() {
  int arr[ 10 ];
  const int size = 10;
  cout << "Enter " << size << " integers for the array to sort: ";
  for(int i = 0; i < size; i++){
    cin >> arr[i];
  }

  cout << "Original array: ";
  printArray( arr, size );

  quickSort( arr, 0, size - 1 );

  cout << "Sorting array...\nSorted array: ";
  printArray( arr, size );

  return 0;
}