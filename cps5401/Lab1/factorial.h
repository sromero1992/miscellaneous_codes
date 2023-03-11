//This section calculates the factorial of n
#include <math.h>
#include <stdio.h>


int fact(int n){
int i;
int fact = n;

if  ( n == 0 ){
fact=1;
}

   for (i=1; n-1; i++)
   {
      if (n-i<=0)
      {
             fact=fact;
             break;
      }
      fact=fact*(n-i);
   }
return (double) fact;
}

