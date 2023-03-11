#include<iostream>

using namespace std;

int main (int argc, char** argv){
	
	int array[5]={ 9,7,5,6,3 };
	int *ptr;
	
	//print address of the array elements
	for (int i=0; i<5; i++){
	cout << "Element "<< i <<"  has the address :" << &array[i]<<'\n';
	}
	
	for (int i=0; i<5; i++){
     	cout << "The value of the element " << i <<" is :"<< array[i]<<'\n';
	}
	
		
	for (int i=0; i<5; i++){
	ptr= &array[i]; 
	cout << "The value of the element "<< i <<" by pointer is :" << *ptr <<'\n';
	}
	
	ptr= &array[0]; //once defined
	for (int i=0; i<5; i++){
	cout << "The value of the element "<< i <<" by pointer is :" << *(ptr+i) <<'\n';
	}
	
	return 0;

}
