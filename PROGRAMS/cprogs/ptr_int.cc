#include <iostream>
using namespace std;
int main(){
	int x=5;
	cout << x <<"  value of 'x'"<< '\n';
        cout << &x << "  address of 'x'"<<'\n';
	cout << *&x<< " value that contains the addres of 'x'"<<'\n';
	return 0;
}
