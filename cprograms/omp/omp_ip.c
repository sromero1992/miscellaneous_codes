#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

//omp_lock_t my_lock;

int main( int argc, char** argv ) {
  int a[10000], b[10000];
  for ( int i = 0; i < 10000; i++ ) {
    a[i] = i+1; b[i] = 1;}

  int sum = 0;
//  omp_init_lock(&my_lock);

#pragma omp parallel for reduction(+:sum)
  for ( int i = 0; i < 10000; i++ ) {
    sum += a[i] * b[i];

   //int loc_prod = a[i] * b[i];
  // omp_set_lock(&my_lock);
#pragma omp critical
   // sum += loc_prod;
   //omp_unset_lock(&my_lock);
    
    sum += a[i] * b[i];
  }

 // omp_destroy_lock(&my_lock);
  printf( "Parallel inner product: %d.\n", sum );

  return 0;
}
