#include <stdlib.h>
#include <stdio.h>
#include <string.h>

//int my_sum( int val_1, int val_2 );

int main( int argc, char** argv ) {
  
  double my_sum( double val_1, double val_2 );

  //int val_i_1 = atoi( argv[1] );
  //int val_i_2 = atoi( argv[2] );

  double val_f_1 = atof( argv[1] );
  double val_f_2 = atof( argv[2] );

  //printf( "%d\n", my_sum( val_i_1, val_i_2 ) );
  printf( "%lf\n", my_sum( val_f_1, val_f_2 ) );

  return 0;
}

//int my_sum( int val_1, int val_2 ) {
//  return val_1 + val_2;
//}

double my_sum( double val_1, double val_2 ) {
  return val_1 + val_2;
}

