#include <stdio.h> 
#include <string.h>
#include <stdlib.h>

int main( int argc, char** argv ){

	double grade_point = atof(argv[1]);
	char   grade_letter;


	if (grade_point<0.0 || grade_point >100){
		printf("Warning: please enter a number between 0.0 and 100.0. Exit \n");
		return 0;
	}

	if (grade_point < 60.0)
		grade_letter = 'F';
	else if (grade_point < 70)
		grade_letter = 'D';
	else if (grade_point < 80.0)
		grade_letter = 'C';
	else if (grade_point < 90.0)
		grade_letter = 'B';
	else 
		grade_letter = 'A';

	printf("The letter grade is %c .\n", grade_letter);
	
	return 0;
}



