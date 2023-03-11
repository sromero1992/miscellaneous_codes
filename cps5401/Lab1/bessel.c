//This program computes the bessel functions of the first kind with non-negative integer indices: Jn; n0,1,3...

#include <math.h>
#include <stdio.h>
#include "factorial.h"
#include <stdlib.h>

int main(){

int i,m,n;
double xval, x, prodfact, j, jless, jdiff, eps, alfa;//del is the machine smallest number that can be representes
double delmin = powf(10,-20); //delta for currency
double delmax = powf(10,19); //delta to stop powers, we dont need to much presicion here, because it decreases so fast


printf("This program calculates the bessel function of first kind, Jn(x)\n");
printf("remember that n=0,1,2,...\n");

printf("capture the the index n:\n");
scanf("%d", &n);

if ( n < 0 ){
 goto ends;
}

printf("capture the x value:\n");
scanf("%le", &x);

printf("capture the tolerance epsilon (smallest precision 1e-11):\n");
scanf("%le", &eps);

printf("******************************************************\n");

//Main function to calclate bessel functions

j=0;//bessel value
i=100;

	for( m = 0; m < i ; m++)
	{
		

		xval = powf( 0.5*x,2*m+n);
		prodfact = fact(m) * fact(m+n);	
	        if ( xval/ prodfact > delmax){
			printf("The tolerance is smaller than the minimum allowed by the machine.\nTry it again. :-)\n ");
			break;
		}	
	 
		alfa = pow(-1,m)*xval/prodfact;
		jless=j;
		j = j + alfa;
	        
                if (abs(alfa/jless)  >= 1) 
			break; 
                else if ( fabs (xval) > delmax  ){
			printf("The program has stopped because the power has become too large.\n");
			break;
                }
		else if ( prodfact > delmax ){
			printf("The factorial is too large and won't be nessesary keep calculations.\n");
			break;
		}
			
		else if ( fabs( alfa /j) < eps){// pow is needed to dont break to inf or nan 	
		printf("The iterations are not changing the result, given the \ndifference between (Jn-J(n-1))=alfa,\niteration value of alfa is: %le\n",alfa);
			break;
		}
		// This section is to check the iterations rate		
		printf("Actual iteration: %d\n",m); //iterations display
		printf("Value of alfa=%le\n",alfa);
		printf("Value of J=%le\n\n",j);
	

	}

printf("******************************************************\n");
if ( eps > delmin ){	
   printf("The Bessel function value reported at iteration %d  is: %le\n",m,j);
}

if (n < 0){
   ends: printf("You must entry a positive integer number, try it again :-)\n");
}

}

