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
  double sum3 = 0.0;
  double sum4 = 0.0;
  double sum5 = 0.0;

  double* a = A;
  double* b = B;

  for ( int i = 0; i < MAX/5; i++ ) {
    sum1 += *(a+0) * *(b+0);
    sum2 += *(a+1) * *(b+1);
    sum3 += *(a+2) * *(b+2);
    sum4 += *(a+3) * *(b+3);
    sum5 += *(a+4) * *(b+4);
    a += 5; b+= 5;
  }

  double sum = sum1 + sum2 + sum3 + sum4 + sum5;

  free( A );
  free( B );

  return 0;
}

