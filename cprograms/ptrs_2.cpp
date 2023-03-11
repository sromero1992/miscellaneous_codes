//my first pointer
#include<iostream>
using namespace std;

int main(){

int val1=5,val2=15;
int *p1,*p2;

p1 = &val1;//p1 takes the addressof val1
p2 = &val2;//p2 //
*p1 = 10; //Value pointed to p1=10
*p2 = *p1;// value pointed to p2=value pointed from p1 (same val)
p1=p2;    //p1=p2 (value of pointer is copied) 
*p1=20;   //value pointed to p1=20 which is val1


cout<< "First value is : " << val1<<'\n';
cout<< "Second value is : "<< val2<<'\n';

return 0;


}
