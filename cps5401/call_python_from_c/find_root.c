#include "find_root.h"
#include <stdio.h>
#include <math.h>
#include <float.h>

int bisection( int* niter, double* xstar, double x0, double x1, TargetFunc f ) {
  double x_l, x_r;

  x_l = fmin( x0, x1 );
  x_r = fmax( x0, x1 );

  *niter = 0;

  if ( (*f)(x_l) * (*f)(x_r) > 0.0 )
    return 0;

  while ( fabs( x_r - x_l ) > eps_x && *niter < iter_max ) {
    (*niter)++;
    double x_m = 0.5 * ( x_l + x_r );
    double f_m = (*f)(x_m);

    if ( fabs( f_m ) < eps_f )
      break;
    else if ( f_m * (*f)(x_l) < 0.0 )
      x_r = x_m;
    else
      x_l = x_m;
  }

  *xstar = 0.5 * ( x_l + x_r );

  return *niter <  iter_max;
}

int secant( int* niter, double* xstar, double x0, double x1, TargetFunc f ) {
  double x_old[2];
  x_old[0] = x0;
  x_old[1] = x1;

  *niter = 0;

  if ( (*f)(x_old[0]) * (*f)(x_old[1]) > 0.0 )
    return 0;

  while ( fabs( x_old[0] - x_old[1] ) > eps_x && *niter < iter_max ) {
    double f0 = (*f)(x_old[0]);
    double f1 = (*f)(x_old[1]);
    *xstar = (x_old[0]*f1 - x_old[1]*f0) / (f1-f0);
    double f_new = (*f)(*xstar);

    (*niter)++;
   
    if ( isnan(*xstar) )
      return 0;
    else if ( fabs(f_new) < eps_f ) 
      break;
    //else {
    //  x_old[0] = x_old[1];
    //  x_old[1] = *xstar;
    //}
    else if ( f0 * f_new < 0.0 ) {
      x_old[1] = *xstar;
    }
    else
      x_old[0] = *xstar;

  }

  return *niter < iter_max;
}

int newton( int* niter, double* xstar, double x0, TargetFunc f, TargetFunc df ) {
  double x_old, f_old, df_old;

  x_old = x0;
  f_old = (*f)(x_old);

  *niter = 0;

  while ( fabs( f_old ) > eps_f && *niter < iter_max ) {
    (*niter)++;
    df_old = (*df)(x_old);
    x_old -= f_old/df_old;
    f_old = (*f)(x_old);
  }

  *xstar = x_old;

  return *niter < iter_max;
}

