#include <stdio.h>

int * a,al1,al2,al3;

double seq(int &n , int i ){
	
	if(i==0){
		a=0;
		al3=0;
	}
	else if(i==1){
		a=1;
		al2=1;
	}
	else if(i==2){
		a=1;
		al3=1;
	}
	else if(i>2)
	a=6*al1-11*al2+6*al3;
	
	if (i<=n){
		printf("%d\n", a);	
	}
	else 	
		return 0;
	al1=&a;
	al2=&al1;
	al3=&al2;
	
	return seq(n,i+1);
}

int main(){
	
	int n;
	printf("Capture the value (n) for the sequence given:");
	scanf("%d",&n);
	int i=0;
	
	seq(n,i );
	return 1;



}
