#include<iostream>

using namespace std;
int main (){

	int val=5;
	int val2=10;
	int *ptr;
	ptr= &val;//here ptr is getting the address number directly
	cout <<"The pointing address is : " << ptr << endl;
	cout <<"The pointing integer is : " << *ptr<<'\n';
 	*ptr =*ptr+val2;
	cout << "Adding another integer to the pointer value : " << *ptr<<endl;
	cout << " The value of the integer is (initial one) : " << val<<endl;
	return 0;
	
}
