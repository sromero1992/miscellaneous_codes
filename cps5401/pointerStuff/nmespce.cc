#include <iostream>
using namespace std;

namespace intVar {
  int x, y;
}

namespace doubleVar {
  double x,y;
}

int main( int argc, char** argv ) {
  intVar::x = 3;
  intVar::y = 5;
  using namespace intVar;
  doubleVar::x = 0.123;
  doubleVar::y = 1.234;
  
  cout << x << " " << y << endl;
  cout << doubleVar::x << " " << doubleVar::y << endl;
  return 0;
}
