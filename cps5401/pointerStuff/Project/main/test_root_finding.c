#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "control.h"
#include "find_root.h"

double my_exp_func( double );
double my_exp_func_der( double );

double my_cubic_func( double );
double my_cubic_func_der( double );

int main( int argc, char** argv ) {

  double range = 10.0;

  struct Control control;
  control.eps_x    = 1e-10;
  control.eps_f    = 1e-10;
  control.iter_max = 100;

  if ( argc > 2 )
    range = atof( argv[2] );
  if ( argc > 1 )
    control.iter_max = atoi( argv[1] );

  int niter;
  double x;
  int success;

  fprintf( stdout, "\nFirst equation: sin(x): \n " );

  fprintf( stdout, "\tBisection method: \n" );
  success = bisection( control, &niter, &x, -range, range, &sin);
  fprintf( stdout, "\t\t%s with %d iterations, final solution: %lf.\n", (success) ? "Success" : "Fail", niter, x );

  fprintf( stdout, "\tSecant method: \n" );
  success = secant( control, &niter, &x, -range, range, &sin);
  fprintf( stdout, "\t\t%s with %d iterations, final solution: %lf.\n", (success) ? "Success" : "Fail", niter, x );

  fprintf( stdout, "\tNewton-Raphson method: \n" );
  success = newton( control, &niter, &x, 0.0, &sin, &cos);
  fprintf( stdout, "\t\t%s with %d iterations, final solution: %lf.\n", (success) ? "Success" : "Fail", niter, x );

  fprintf( stdout, "\nFirst equation: 3-exp(x): \n " );

  fprintf( stdout, "\tBisection method: \n" );
  success = bisection( control, &niter, &x, -range, range, &my_exp_func );
  fprintf( stdout, "\t\t%s with %d iterations, final solution: %lf.\n", (success) ? "Success" : "Fail", niter, x );

  fprintf( stdout, "\tSecant method: \n" );
  success = secant( control, &niter, &x, -range, range, &my_exp_func );
  fprintf( stdout, "\t\t%s with %d iterations, final solution: %lf.\n", (success) ? "Success" : "Fail", niter, x );

  fprintf( stdout, "\tNewton-Raphson method: \n" );
  success = newton( control, &niter, &x, 0.0, &my_exp_func, &my_exp_func_der );
  fprintf( stdout, "\t\t%s with %d iterations, final solution: %lf.\n", (success) ? "Success" : "Fail", niter, x );


  fprintf( stdout, "\nSecond equation: 3x^3+2x^2+x-15: \n " );

  fprintf( stdout, "\tBisection method: \n" );
  success = bisection( control, &niter, &x, -range, range, &my_cubic_func );
  fprintf( stdout, "\t\t%s with %d iterations, final solution: %lf.\n", (success) ? "Success" : "Fail", niter, x );

  fprintf( stdout, "\tSecant method: \n" );
  success = secant( control, &niter, &x, -range, range, &my_cubic_func );
  fprintf( stdout, "\t\t%s with %d iterations, final solution: %lf.\n", (success) ? "Success" : "Fail", niter, x );

  fprintf( stdout, "\tNewton-Raphson method: \n" );
  success = newton( control, &niter, &x, 0.0, &my_cubic_func, &my_cubic_func_der );
  fprintf( stdout, "\t\t%s with %d iterations, final solution: %lf.\n", (success) ? "Success" : "Fail", niter, x );

  return 0;
}

double my_exp_func( double x ) {
  return 3.0-exp(x);
}

double my_exp_func_der( double x ) {
  return -exp(x);
}

double my_cubic_func( double x ) {
  return 3.0*x*x*x+2.0*x*x+x-15.0;
}

double my_cubic_func_der( double x ) {
  return 9.0*x*x+4.0*x+1.0;
}
