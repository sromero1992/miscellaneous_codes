#include <stdio.h>
#include <stdlib.h>

#define BLKSIZE 126
#define NUM_BLK 190
#define MAX (NUM_BLK*BLKSIZE)

int main( int argc, char** argv ) {

  double* A = (double*)malloc(MAX*MAX*sizeof(double));
  double* B = (double*)malloc(MAX*MAX*sizeof(double));

  for ( int i = 0; i < MAX; i++ )
    for ( int j = 0; j < MAX; j++ )
      A[i*MAX+j] = A[i*MAX+j] + B[j*MAX+i];

  free( A );
  free( B );

  return 0;
}

