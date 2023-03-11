#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

int main( int argc, char** argv ) {
  int maxn=100;
  int a[maxn], b[maxn], c[maxn];

  for ( int i = 0; i < maxn; i++ ) {a[i] = 11*i; b[i] = -i; }

  for ( int i = 0; i < maxn; i++ ) printf( "%3d ", a[i] );
  printf( "\n" );

  for ( int i = 0; i < maxn; i++ ) printf( "%3d ", b[i] );
  printf( "\n" );

#pragma omp parallel
  {
#pragma omp parallel for
//#pragma omp for
    for ( int i = 0; i < maxn; i++ ) c[i] = a[i] + b[i];
  }

  for ( int i = 0; i < maxn; i++ ) printf( "%3d ", c[i] );
  printf( "\n" );

  return 0;
}


