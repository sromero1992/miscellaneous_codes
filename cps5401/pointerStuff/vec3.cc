#include <cstdio>
#include <cstdlib>
#include "vec3.h"

VEC3::VEC3(void) {
  VEC3(0.0);
}

VEC3::VEC3(const double val) {
  for ( int i = 0; i < 3; i++ )
    data[i] = val;
}

VEC3::VEC3(const VEC3& vec) {
  for ( int i = 0; i < 3; i++ )
    data[i] = vec[i];
}

void VEC3::rand(void) {
  for ( int i = 0; i < 3; i++ )
    data[i] = ( double )std::rand()/RAND_MAX;
  return;
}

double& VEC3::operator[] (int i) {
  return data[i];
}

const double& VEC3::operator[] (int i) const {
  return data[i];
}

void VEC3::operator= (const VEC3& vec) {
  for ( int i = 0; i < 3; i++ )
    data[i] = vec[i];
  return;
}

void VEC3::operator+= (const VEC3& vec) {
  for ( int i = 0; i < 3; i++ )
    data[i] += vec[i];
  return;
}

void VEC3::operator-= (const VEC3& vec) {
  for ( int i = 0; i < 3; i++ )
    data[i] -= vec[i];
  return;
}

void VEC3::operator*= (const double val) {
  for ( int i = 0; i < 3; i++ )
    data[i] *= val;
  return;
}

void VEC3::operator/= (const double val) {
  for ( int i = 0; i < 3; i++ )
    data[i] /= val;
  return;
}

VEC3 operator+ (const VEC3& input_1, const VEC3& input_2) {
  VEC3 vec;
  for ( int i = 0; i < 3; i++ )
    vec[i] = input_1[i] + input_2[i];
  return vec;
}

VEC3 operator+ (const VEC3& input_1) {
  VEC3 vec;
  for ( int i = 0; i < 3; i++ )
    vec[i] = input_1[i];
  return vec;
}

VEC3 operator- (const VEC3& input_1, const VEC3& input_2) {
  VEC3 vec;
  for ( int i = 0; i < 3; i++ )
    vec[i] = input_1[i] - input_2[i];
  return vec;
}

VEC3 operator- (const VEC3& input_1) {
  VEC3 vec;
  for ( int i = 0; i < 3; i++ )
    vec[i] = -input_1[i];
  return vec;
}

VEC3 operator* (const double& input_s, const VEC3& input_v) {
  VEC3 vec;
  for ( int i = 0; i < 3; i++ )
    vec[i] = input_s * input_v[i];
  return vec;
}

VEC3 operator* (const VEC3& input_v, const double& input_s) {
  VEC3 vec;
  for ( int i = 0; i < 3; i++ )
    vec[i] = input_s * input_v[i];
  return vec;
}

VEC3 operator/ (const VEC3& input_v, const double& input_s) {
  VEC3 vec;
  for ( int i = 0; i < 3; i++ )
    vec[i] = input_v[i]/input_s;
  return vec;
}

VEC3 operator| (const VEC3& input_1, const VEC3& input_2) {
  VEC3 vec;
	vec[0] = input_1[1]*input_2[2]-input_1[2]*input_2[1];
	vec[1] = input_1[2]*input_2[0]-input_1[0]*input_2[2];
	vec[2] = input_1[0]*input_2[1]-input_1[1]*input_2[0];
  return vec;
} 

std::ostream& operator<< (std::ostream& os, const VEC3& vec) {
  os << std::endl;
  for ( int i = 0; i < 3; i++ )
    os << vec.data[i] << '\t';
  os << std::endl;
  return os;
}

