#!/usr/bin/python
import math

def my_exp( x ) :
  return 3.0 - math.exp( x )

def my_sincos( x ):
    return ( math.sin(x) )**3 - math.cos(x)

def my_cubic( x ) :
  return 3.0 * x**3 + 2.0 * x**2 + x - 15.0

def my_gamma( x ):
  return math.gamma( x + 0.1 ) - 2


