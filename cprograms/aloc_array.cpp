#include<iostream>

using namespace std;

int main (int argc,char** argv) {
	int n = 2;
	int *ptr, *ptr3; //= new int; //dynamically allocate an integer and assign the address to ptr se we can access it later
	*ptr=7; //assign value of 7 to allocated memory
	int *ptr2 = new int (5); // Direct initialization
	//ptr3=&n;
	cout<< n <<'\n';
	cout<< *ptr <<'\n';
	cout<< *ptr2 << '\n';
	cout<< "Address of pointers "<<'\n';
	cout<< ptr <<"   "<<ptr2<<'\n';
//	cout<< "Adress of integer n "<<'\n'<< &n;
//	delete ptr; //to delete a single variable 	also ptr=0;		

//	cout<< *ptr;
//	delete ptr;


	return 0;

}
