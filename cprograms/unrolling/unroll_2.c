#include <stdlib.h>
#include <stdio.h>

#define BLKUNIT 60
#define NUMUNIT 10000000
#define MAX (BLKUNIT*NUMUNIT)

int main( int argc, char** argv ) {

  double* A = (double*)malloc(MAX*sizeof(double));
  double* B = (double*)malloc(MAX*sizeof(double));

  double sum1 = 0.0;
  double sum2 = 0.0;

  double* a = A;
  double* b = B;

  for ( int i = 0; i < MAX/2; i++ ) {
    sum1 += *(a+0) * *(b+0);
    sum2 += *(a+1) * *(b+1);
    a += 2; b+= 2;
  }

  double sum = sum1 + sum2;

  free( A );
  free( B );

  return 0;
}

