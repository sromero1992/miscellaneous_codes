#include <stdio.h>

int main( int agrc, char** agrv){

	int a=5;
	{
		int a=3;
		printf("%d\n",a);

	}
	printf("%d\n",a);
	return 1;

}
