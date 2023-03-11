//This program contains a multiplication function
#include <stdio.h>

int mult(int x, int y); //Just declaring the variable

int main(){
    int x;
    int y;
    printf("Please enter two values to multiply\n");
    printf("Enter x : ");
    scanf("%d", &x);
    printf("Enter y : ");
    scanf("%d", &y);
    //Call the function mult
    printf( "The multiplication is : %d " , mult(x,y) );
    getchar();//this replaces return 0
}
int mult(int x, int y){
    return x * y;
}
