// This program calculate a grade from 0-100 to A-F
//Version 1 in cases (second will be with just if)
#include <stdio.h>

int main ()
{

	int  g;
	printf("This program reads a point grade and print out a letter grade.\n");

	printf("Enter the point grade between 100-0 : \n");
	scanf( "%d", &g);


        

	if ( g >= 90)
		{
		printf("The grade is : A \n");
		}
	else if ( 90 > g && g  >= 80)
        	{
        	printf("The grade is : B \n");
        	}

	else if ( 80 > g && g >= 70)
        	{
        	printf("The grade is : C \n");
        	}

	else if ( 70 > g && g  >= 60)
        	{
        	printf("The grade is : D \n");
        	}

  	else 
	      	{
        	printf("The grade is : F \n");
        	}

	return 0;
}
