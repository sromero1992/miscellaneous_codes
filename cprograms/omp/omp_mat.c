#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

int main( int argc, char** argv ) {
  int m[3][4], i, j;

  for ( i = 0; i < 3; i++ )
    for ( j = 0; j < 4; j++ ) m[i][j] = 0;

#pragma omp parallel for private(j)
//#pragma omp parallel for
  for ( i = 0; i < 3; i++ ) {
    sleep( 0.2 );
    for ( j = 0; j < 4; j++ ) {
      m[i][j] = i + j; sleep( 0.2 ); }
  }

  for ( i = 0; i < 3; i++ ) {
    for ( j = 0; j < 4; j++ )
      printf( "%2d\t", m[i][j] );
    printf( "\n" );
  }

  return 0;
}


