#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

int main( int argc, char** argv ) {
  int a[10], b[10], c[10], d[10];
  for ( int i = 0; i < 10; i++ ) a[i] = b[i] = i;

#pragma omp parallel sections
  {
#pragma omp section
    for ( int i = 0; i < 10; i++ ) {
      printf( "Executing sum at index %d by tread %d.\n",
          i, omp_get_thread_num() );
      c[i] = a[i] + b[i]; sleep( 1 );}

#pragma omp section
    for ( int i = 0; i < 10; i++ ) {
      printf( "Executing product at index %d by thread %d.\n",
          i, omp_get_thread_num() );
      d[i] = a[i] * b[i]; sleep( 1 );}
  }

  return 0;
}


