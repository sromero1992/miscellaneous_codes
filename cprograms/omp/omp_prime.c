#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

int main( int argc, char** argv ) {
  int n = 200000;
  int not_primes = 0, i, j;
 
#pragma omp parallel for private(j) \
            reduction(+: not_primes)
  for ( i = 2; i <= n; i++ ) {
    for ( j = 2; j < i; j++ ) 
      if ( i % j == 0 ) {
        not_primes++;
        break;
      }
  }

  printf( "Primes: %d.\n", n - not_primes );
  return 0;
}


