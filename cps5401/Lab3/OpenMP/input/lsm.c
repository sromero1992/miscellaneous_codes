#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <omp.h>
#include <string.h>
#define NB 6

// The basis function, j=0,...,NB
// j=0,...,NB/2,   basis is cos(jx) 
// j=NB/2+1,..,NB, basis is sin((j-NB/2)x)
double ls_basis(int j, double x);

//DGESV solves a real linear equation 
extern void dgesv_(int *N, int *NRHS, double *A, int *LDA, int *IPIV, double *B, int *LDB, int *INFO);

int main(int argc, char** argv) {

  int n; // Number of data pair (x_i, y_i);
  double* x;
  double* y;

  // Preparation
  assert( NB%2 == 0 );


  // Part (1) -- Read the data
  FILE* data_file = fopen("trial.txt", "r");
  fscanf( data_file, "%d\n", &n );
  x = (double*) malloc( n * sizeof( double ) );
  y = (double*) malloc( n * sizeof( double ) );
  #pragma omp parallel for 
  for ( int i = 0; i < n; i++ ) 
    fscanf( data_file, "%lf\t%lf\n", x+i, y+i );
  fclose( data_file );


  // Part (2) -k- Assemble the matrix
  double* A; // Size is (NB+1)*(NB+1);
  double* B; // Size is (NB+1)
  double* a; // Size is (NB+1)
  
  // Allocate and initialize to zero
  A = (double*) calloc( (NB+1) * (NB+1), sizeof( double ) );
  B = (double*) calloc( (NB+1), sizeof( double ) );
  a = (double*) calloc( (NB+1), sizeof( double ) );
  
  double* f; // Size is NB+1
  f = (double*) malloc( (NB+1) * sizeof( double ) );

  // Outer loop: iterate over each data pair
  for ( int i = 0; i < n; i++ ) {
    // All basis functions at x_i
    #pragma omp sections
    {
    #pragma omp section
    for ( int j = 0; j <= NB; j++ )
      f[j] = ls_basis(j,x[i]);
    // Assemble in B
    #pragma omp section
    for ( int j = 0; j <= NB; j++ )
      B[j] += y[i] * f[j];
    // Assemble in A
    }
    #pragma omp parallel for
    for ( int j1 = 0; j1 <= NB; j1++ )
      for ( int j2 = 0; j2 <= NB; j2++ )
        A[j1*(NB+1)+j2] += f[j1] * f[j2];
  }


  // Part (3) -- Solve for the coefficients and report
  // Use Lapack to solve for Aa=B
  int  N    = NB;
  int  NRHS = 1;
  int  LDA  = NB;
  int* IPIV = (int*) malloc( NB * sizeof( int ) );
  int  LDB  = NB;
  int  INFO;
  double* MAT = (double*) malloc( NB * NB * sizeof( double ) );
  double* RHS = (double*) malloc( NB * sizeof( double ) );
  memcpy( MAT, A,  NB * NB * sizeof(double) );
  memcpy( RHS, B,  NB * sizeof(double) );
  dgesv_(&N, &NRHS, &(MAT[0]), &LDA, &(IPIV[0]), &(RHS[0]), &LDB, &INFO);

  // Print out coefficients in a
  printf("The fitted coefficients are:\n");
  for ( int j = 0; j <= NB; j++ ){
    a[j]=RHS[j];
    printf("\t%f,", a[j]);
  printf("\n");
  }

  // Clean-up
  free( x );
  free( y );
  free( f );

  free( A );
  free( B );
  free( a );
  
  free( MAT );
  free( RHS );
  free( IPIV );
  return 0;
}

double ls_basis(int j, double x) {
  assert( (j>=0) && (j<=NB) );
  if ( j<=NB/2 ) // cos
    return cos(j*x);
  else // sin
    return sin((j-0.5*NB)*x);
}
