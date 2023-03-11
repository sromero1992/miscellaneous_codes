#include <stdio.h>
#include <stdlib.h>
#include <float.h>
#include <omp.h>
#define VSIZE 62

int main (int argc, char** argv){
	double A[VSIZE];
	
	FILE* fp=fopen(argv[1],"r");
	for (int n = 0; n< VSIZE; n++)
		fscanf(fp,"%lf \n", &(A[n]) );
	fclose(fp);

	double cur_max= - DBL_MAX;
	int i_max;
	#pragma omp parallel for private(cur_max, i_max) 
	for (int n = 0; n < VSIZE; n++)
	if( A[n] > cur_max ){
		cur_max=A[n];
		i_max = n;
	}

	fprintf(stdout, "%d: %lf \n", i_max, cur_max);
	return 0;
}
