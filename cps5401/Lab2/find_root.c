#include "find_root.h"
#include <stdio.h>
#include <math.h>
#include <stdlib.h>


int bisection( int* niter, double* xstar, double x0, double x1, TargetFunc f ) {
  double x_l, x_r;
  double f_l, f_r;

  x_l = fmin( x0, x1 );
  x_r = fmax( x0, x1 );

  f_l = (*f)(x_l);
  f_r = (*f)(x_r);

  *niter = 0;

  if ( fabs(f_l) < EPS_F ) {
    *xstar = x_l;
    return 1;
  }

  if ( fabs(f_r) < EPS_F ) {
    *xstar = x_r;
    return 1;
  }

  if ( f_l * f_r > 0.0 )
    return 0;

  while ( fabs( x_r - x_l ) > EPS_X && *niter < ITER_MAX ) {
    (*niter)++;
    double x_m = 0.5 * ( x_l + x_r );
    double f_m = (*f)(x_m);

    if ( fabs( f_m ) < EPS_F )
      break;
    else if ( f_m * f_l < 0.0 ) {
      x_r = x_m;
      f_r = f_m;
    }
    else {
      x_l = x_m;
      f_l = f_m;
    }
  }

  *xstar = 0.5 * ( x_l + x_r );

  return *niter <  ITER_MAX;
}

int regula_falsi( int* niter, double* xstar, double x0, double x1, TargetFunc f ) {
  double x_old[2];
  x_old[0] = x0;
  x_old[1] = x1;

  *niter = 0;

  double fval[2];
  for ( int i = 0; i < 2; i++ ) {
    fval[i] = (*f)(x_old[i]);
    if ( fabs( fval[i] ) < EPS_F ) {
      *xstar = x_old[i];
      return 1;
    }
  }

  if ( fval[0] * fval[1] > 0.0 )
    return 0;

  while ( fabs( x_old[0] - x_old[1] ) > EPS_X && *niter < ITER_MAX ) {
    *xstar = (x_old[0]*fval[1] - x_old[1]*fval[0]) / (fval[1]-fval[0]);
    double f_new = (*f)(*xstar);

    (*niter)++;
   
    if ( fabs(f_new) < EPS_F ) 
      break;
    else if ( fval[0] * f_new < 0.0 ) {
      x_old[1] = *xstar;
      fval[1]  = f_new;
    }
    else {
      x_old[0] = *xstar;
      fval[0]  = f_new;
    }

  }

  return *niter < ITER_MAX;
}




int hybrid( int* niter, double* xstar, double x0, double x1, TargetFunc f){
  
	double x_l, x_r;
  	double f_l, f_r;
	double x_old[2];

  	x_l = fmin( x0, x1 );
  	x_r = fmax( x0, x1 );

  	f_l = (*f)(x_l);
  	f_r = (*f)(x_r);
        
	x_old[0]=x_l;
	x_old[1]=x_r;

  	*niter=0;


  	if (f_l * f_r > 0.0 )
    		return 0;


	if ( fabs(f_l) < EPS_F ) {
    		*xstar = x_l;
    		return 1;
  	}
        if ( fabs(f_r) < EPS_F ) {
    		*xstar = x_r;
    		return 1;
  	}


	while ( fabs ( x_r - x_l ) > EPS_X   &&  *niter < ITER_MAX ) {

  	double x_new = ( x_old[0] * f_r - x_old[1] * f_l) / ( f_r - f_l);
  	double f_new = (*f)(x_new);

    	(*niter)++;

  	double x_m = 0.5 * ( x_l + x_r );
  	double f_m = (*f)(x_m);


    	if ( fabs( f_new ) < EPS_F ){
      		*xstar = x_new;
		break;
	}
	else if ( fabs( f_m) < EPS_F ){
		*xstar = x_m;
		break;
	}	
    	

  	if ( f_m * f_l < 0.0 ) {
      		x_r = x_m;
      		f_r = f_m;
  	}
  	else {
      		x_l = x_m;
      		f_l = f_m;
    	} 
  
   

  	if ( 0.5 * fabs ( x_r - x_l) < fabs ( x_old[1] - x_old[0] ) ){
      		*xstar = x_m;
  	    	x_old[0]=x_l;
		x_old[1]=x_r;
	}
  	else{
  		*xstar = x_new;
	        x_l = fmin( x_old[0] , x_old[1] );
  		x_r = fmax( x_old[0] , x_old[1] );
  	}
  	} 
 return *niter < ITER_MAX;
}
