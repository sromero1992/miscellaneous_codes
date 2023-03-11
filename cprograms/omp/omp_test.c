#include <stdio.h>
#include <omp.h>
int main (int argc, char* argv){
int fib[20];

fib[0]=fib[1]=1;

#pragma omp parallel for
for (int i=2; i<20; i++){
	fib[i]=fib[i-1]+fib[i-2];
printf("%d\n",fib[i]);
}
printf("%d\n",fib[19]);

return 0;




}
