#ifndef __FIND_ROOT_H__
#define __FIND_ROOT_H__

typedef double (*TargetFunc)(double);

extern double eps_x;
extern double eps_f;
extern int iter_max;

int bisection( int* niter, double* xstar, double x0, double x1, TargetFunc f );

int secant( int* niter, double* xstar, double x0, double x1, TargetFunc f );

int newton( int* niter, double* xstar, double x0, TargetFunc f, TargetFunc df );

#endif
