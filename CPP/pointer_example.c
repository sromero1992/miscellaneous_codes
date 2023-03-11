#include <stdio.h>

int main () {
    int x;
    int *p;
    printf("Put an integer number :");
    scanf("%d", &x);
    printf("The address of the pointer is : %d\n", &p);
    printf("The address of the variable is : %d\n", &x );
    p = &x;
    printf("The value of x is : %d\n", x);
    printf("The value of the pointer p is : %d\n", *p);

    return 0;
}
