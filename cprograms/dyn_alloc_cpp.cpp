#include<iostream>
using namespace std;

int main () {
//dynamic allocation cpp

int n = 2;
int *ptr=new int;

ptr=&n;

cout<< " pointer value :"<<*ptr<<'\n';

delete ptr; //Memory returned to the system, but ptr is dangling pointer
ptr=0;// now is null pinter

cout<< " pointer value :"<<ptr<<'\n';


return 0;
}
