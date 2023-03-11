#include <stdio.h>
#include <math.h>
#include <time.h>
#include <sys/time.h>
#define NUMINT 800000000

int main(int argc, char** argv) {

  struct timeval start, end;
  gettimeofday(&start, NULL);

  double mypi = 0.0, x;
  double h = 2.0/NUMINT;
  
/#pragma omp parallel for private(x) reduction(+:mypi)
  for ( int i = 0; i < NUMINT; i++ ) {
    x = 1.0-i*h; 
    mypi += 2.0 * h * sqrt(1-x*x);
  }

  gettimeofday(&end, NULL);
  
  printf("My Pi: %1.10f.\n", mypi);
  printf("Time used: %f sec.\n", ((end.tv_sec-start.tv_sec)*1000000u+end.tv_usec-start.tv_usec)/1.e6);

  return 0;
}
