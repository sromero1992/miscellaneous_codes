#include<iostream>
using namespace std;

int main () {

	int *ptr{NULL};
	int val=3;

	cout <<" Address of the pointer : "<< ptr <<'\n';
//	cout <<" Value of the address of the pointer :"<< *ptr <<'\n';
	ptr=&val;
	cout <<" New address of the pointer :"<< ptr<<'\n';
	cout <<" New value of the pointer :" << *ptr<<endl;
	return 0;

}
