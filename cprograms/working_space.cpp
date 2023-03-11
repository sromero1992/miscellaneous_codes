#include <iostream>
using namespace std;
namespace normal_op {
	
	double add(double x, double y){
		return x+y;
	}
	double div(double x, double y){
		return x/y;
	}
	double mult(double x, double y){
		return x*y;
	}

}

namespace reverse_op {
	
	double subs(double x, double y){
		return x-y;
	}
	double div(double x, double y){
		return y/x;
	}

}


int main (int argc, char ** argv){

	cout << normal_op::add(4,5)<<endl;
	cout << reverse_op::subs(4,5)<<endl;
	cout << normal_op::div(4,5)<<endl;
	cout << reverse_op::div(4,5)<<endl;
	cout << normal_op::mult(4,5)<<endl;

	return 0;
}

