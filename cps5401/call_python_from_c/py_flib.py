#!/usr/bin/python
import math

def my_exp( x ) :
  return 3.0 - math.exp( x )

def my_exp_der( x ) :
  return - math.exp( x )

def my_cubic( x ) :
  return 3.0 * x**3 + 2.0 * x**2 + x - 15.0

def my_cubic_der( x ) :
  return 9.0 * x**2 + 4.0 * x + 1.0

def my_linear( x ) :
  return 5.0 - x

def my_linear_der( x ) :
  return -1.0
