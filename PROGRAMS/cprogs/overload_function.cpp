#include <iostream>
using namespace std;
//the compiler will complain which to use given the type of variable
int operate ( int x, int y ){
	return (x*y);
}

double operate ( double x, double y ){
	return (x/y);
}

int main (int argc, char** argv){

	int a=2,b=3;
	double c=.5,d=1.0;
	cout<< operate(a,b)<<endl;
	cout<< operate(d,c)<<endl;

	return 0;



}


