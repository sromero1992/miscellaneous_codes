#include<stdlib.h>
#include<stdio.h>
int main(){
int *n = malloc(sizeof *n);
*n=20;

printf("%i\n", *n);
free(n);

}
