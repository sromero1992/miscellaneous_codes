#include <iostream>
#include <cstdlib>
#include <time.h>

using namespace std;

int main(){

	//srand(1015); //set initial seed value 1015 every compilation produces the same numbers
	srand( time(0) );// the seed depends on time

	//now it will print 100 random numbers
	for (int count=1; count <= 100; count++){

		cout << rand() << "\t";

		//print every 5 numbers a new row of 5 numbers
		if ( count % 5 == 0)
			cout<<"\n";
	}
	return 0;

}
