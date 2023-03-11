#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

int main( int argc, char** argv ) {
#pragma omp parallel
  {
    int nthreads = omp_get_num_threads();
    int tid = omp_get_thread_num();
    printf( "Hellow world from thread %d ( out of %d ).\n",
            tid, nthreads );
  }

  return 0;
}
