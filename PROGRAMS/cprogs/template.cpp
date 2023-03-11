#include <iostream>
using namespace std;
//my_type represents a generic class (can be int, char, etc)
template <class my_type>
my_type sum ( my_type a, my_type b){
	return a+b;
}
template <class my_type2>
my_type2 subs(my_type2 a, my_type2 b){
	return a-b;
}

template <class my_type3>
my_type3 div(my_type3 a, my_type3 b){
	return a/b;
}


//it must be instantiated as sum<int> (10,20)



int main(int argc, char** argv){

	int x=6 , y=3,i,j;
	double z=2.0 , w=1.5,k,l;

	k= sum<double>(z,w);
	i= sum<int>(x,y);
	j= div<double>(z,w);
	l= div<int>(x,y);
	cout << "double sum:"<< k <<'\n';
	cout << "integer sum:"<< i <<'\n';
	cout << "double div:"<<j <<'\n';
	cout << "integer div:"<<l <<'\n';
	return 0;
}

