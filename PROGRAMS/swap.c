#include <stdio.h>

//passing by address
/* 
 void swap( int *a, int *b ){
 int c = *a;
 *a=*b;
 *b=c;
 return ;
}*/

//passing same, by value
int swap( int* c, int* d){
int e = *c;
*c=*d;
*d=e;
return *c,*d;
}

int main (int argc, char** argv){

int a, b; 
scanf("%d", &a);
scanf("%d", &b);

swap( &a , &b);
printf("passing 1 :%d \t %d \n",a,b);

return 0;

}

