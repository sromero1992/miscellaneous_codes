#ifndef __FIND_ROOT_H__
#define __FIND_ROOT_H__
#define EPS_X 1e-10
#define EPS_F 1e-10
#define ITER_MAX 100000

typedef double (*TargetFunc)(double);

int bisection( int* niter, double* xstar, double x0, double x1, TargetFunc f );

int regula_falsi( int* niter, double* xstar, double x0, double x1, TargetFunc f );

int hybrid( int* niter, double* xstar, double x0, double x1, TargetFunc f);

#endif
