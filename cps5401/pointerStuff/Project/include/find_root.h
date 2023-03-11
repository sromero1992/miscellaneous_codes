#ifndef __FIND_ROOT_H__
#define __FIND_ROOT_H__

#include "control.h"

typedef double (*TargetFunc)(double);

int bisection( struct Control control, int* niter, double* xstar, double x0, double x1, TargetFunc f );

int secant( struct Control control, int* niter, double* xstar, double x0, double x1, TargetFunc f );

int newton( struct Control control, int* niter, double* xstar, double x0, TargetFunc f, TargetFunc df );

#endif
