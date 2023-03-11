//Array example
#include <stdio.h>

int main(){
int x[5] = {1,2,3,4,5};
int n, result =  0;


for(n =0; n < 5;n++){
// result = result + x[i];
    result += x[n];
    printf("The current value of result is : %d\n", result);

}
printf("The value of result is : %d\n", result);

for ( n=0 ; n < 5; n++){
printf("The address of the X[%d] is : %d\n", n ,&x[n]);
}

return 0;
}
