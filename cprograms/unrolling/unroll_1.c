#include <stdlib.h>
#include <stdio.h>

#define BLKUNIT 60
#define NUMUNIT 10000000
#define MAX (BLKUNIT*NUMUNIT)

int main( int argc, char** argv ) {

  double* A = (double*)malloc(MAX*sizeof(double));
  double* B = (double*)malloc(MAX*sizeof(double));

  double sum = 0.0;

  for ( int i = 0; i < MAX; i++ )
    sum += A[i] * B[i];

  free( A );
  free( B );

  return 0;
}

