#include <iostream>
#include "vec3.h"
#include "mat3.h"
using namespace std;

int main( int argc, char** argv ) {
  MAT3 mat_1;
  mat_1.rand();
  cout << "Matrix 1: " << mat_1;

  MAT3 mat_2(mat_1);
  cout << "Matrix 2: " << mat_2;

  MAT3 mat_3(2.0);
  cout << "Matrix 3: " << mat_3;

  VEC3 vec_1;
  vec_1.rand();
  cout << "Vector 1: " << vec_1;

  VEC3 vec_2(2.0);

  MAT3 mat_4(vec_1);
  cout << "Matrix 4: " << mat_4;

  cout << "Matrix 1 + Matrix 2: " << mat_1 + mat_2;
  cout << "Matrix 1 + 1.0: " << mat_1 + 1.0;
  cout << "Matrix 1 + Matrix 2 / 2 - Matrix 3: " << mat_1 + mat_2/2 - mat_3;
  cout << "-Matrix 3: " << - mat_3;
  cout << "Matrix 1 * Vector 1: " << mat_1 * vec_1;
  cout << "Matrix 1 * Matrix 2: " << mat_1 * mat_2;
  cout << "Vector 1 tensor product with Vector 2: " << ( vec_1 ^ vec_2 );

  return 1;
}
