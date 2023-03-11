//This program tells you if you are old
#include<stdio.h>

int main(){
int age;

printf("This program will tell you if you are old\n");
printf("Put your age :  ");
scanf("%d" , &age);
if( age < 20){
    printf("You are pretty young\n");
}
else if(age < 45){
    printf("You are not that young\n");
}
else {
    printf("You are old");
}
return 0;
}


