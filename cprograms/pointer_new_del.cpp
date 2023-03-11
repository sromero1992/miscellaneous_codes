// rememb-o-matic
#include<iostream>
#include<new>
using namespace std;

int main (){

int i,n;
int * p;//pointing to an integer

cout<< " How many numbers would you like to type? ";
cin>>i;

p= new (nothrow) int [i];// used to allocate a block (an array) 
			 //of elements of type int, so it points to a block of integers
			// nothrow does given a memory allocation failed, instead of throwing a bad_alloc exception
			// or terminating the prog. the pointer returned by new is a null ptr and the prog. continues normally.
if (p==nullptr)//check for failure 
	cout<< "Error allocating dynamic array "<<'\n';
else{
	cout<<"Array allocated!"<<'\n';


	for (n=0;n<i; n++){
		cout<< "Enter number : "<<'\n';
		cin>> p[n];//also *(p+n)
	}	
		cout<< " You have entered : ";
		for(n=0;n<i;n++)
			cout<< p[n]<<" , ";;//also *(p+n)
		cout<<endl;			
	delete[] p;
	p=nullptr;	//making pointer null, if we dont do this, it will keep its previous address
	cout<<" Pointer deletedi "<<endl;
	for(n=0;n<i;n++)
		cout<<"Pointer "<<n<<" has a direction : "<< &p[n]<<endl;
	
}
return 0;
}
