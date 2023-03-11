#include <stdio.h>

int main(){
int n=3;
float A[n][n];
printf("please enter the elements of your matrix \n");
for (int i=0; i<n;i++)
    for (int j = 0; j<n; j++){
        printf("Write the element A[%d][%d] : \n",i+1,j+1);
        scanf("%f", &A[i][j]);
    }
printf("Your matrix was :\n");
for(int i = 0; i < n; i++){
    for(int j = 0; j< n; j++){
        printf("%f  ", A[i][j]);
    }
    printf("\n");
}
return 0;
}
