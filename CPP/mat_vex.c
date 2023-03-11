#include <stdio.h>

int main(){
int n = 3;
float A[n][n], x[n],Ax[n];

printf("Write your 3x3 matrix \n");

for(int i = 0; i < n; i++)
    for(int j = 0; j<n ;j++){
        printf("Write the element A[%d][%d] : \n",i+1,j+1);
        scanf("%f", &A[i][j]);
    }

printf("Your matrix is : \n");
for(int i=0; i<n;i++){
    for (int j=0; j<n ;j++){
        printf("  %f  ",A[i][j]);
    }
    printf("\n");
}

printf("Now write the vector to multiply with the matrix :\n");
for(int i=0 ; i<n ; i++){
    printf("Write the element X[%d] : \n", i+1);
    scanf("%f", &x[i]);
}

printf("The operation Ax = \n");
for(int i = 0; i<n; i++){
    Ax[i] = 0;
    for(int j = 0; j<n ;j++){
        Ax[i] = Ax[i] + A[i][j]*x[j];
    }
    printf(" %f \n", Ax[i]);
}


return 0;
}
