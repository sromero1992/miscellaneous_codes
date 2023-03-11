#include <stdio.h>
/*#define  SQR( val )  (val) *( val)*/
#define SQR(val) val* val

int main(int argc, char** argv){

        printf("%d\n",SQR(-5));
        printf("%d\n",SQR(2+3));
        printf("%d\n",SQR(1+2*2));
        printf("%d\n",SQR((9-4)));
        printf("%d\n\n",SQR((6-1)*2));
	
	return 1;

}
