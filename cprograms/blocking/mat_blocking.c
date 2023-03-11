#include <stdio.h>
#include <stdlib.h>

#define BLKSIZE 126
#define NUM_BLK 190
#define MAX (NUM_BLK*BLKSIZE)

int main( int argc, char** argv ) {

  double* A = (double*)malloc(MAX*MAX*sizeof(double));
  double* B = (double*)malloc(MAX*MAX*sizeof(double));

  for ( int i = 0; i < MAX; i+=BLKSIZE )
    for ( int j = 0; j < MAX; j+=BLKSIZE )
      for ( int ii = i; ii < i + BLKSIZE; ii++ )
        for ( int jj = j; jj < j + BLKSIZE; jj++ )
          A[ii*MAX+jj] = A[ii*MAX+jj] + B[jj*MAX+ii];

  free( A );
  free( B );

  return 0;
}

