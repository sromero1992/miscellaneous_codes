#include <cstdio>
#include <cstdlib>

template<int dim>
VEC<dim>::VEC(void) {
  VEC<dim>(0.0);
}

template<int dim>
VEC<dim>::VEC(const double val) {
  for ( int i = 0; i < dim; i++ )
    data[i] = val;
}

template<int dim>
VEC<dim>::VEC(const VEC<dim>& vec) {
  for ( int i = 0; i < dim; i++ )
    data[i] = vec[i];
}

template<int dim>
void VEC<dim>::rand(void) {
  for ( int i = 0; i < dim; i++ )
    data[i] = ( double )std::rand()/RAND_MAX;
  return;
}

template<int dim>
double& VEC<dim>::operator[] (int i) {
  return data[i];
}

template<int dim>
const double& VEC<dim>::operator[] (int i) const {
  return data[i];
}

template<int dim>
void VEC<dim>::operator= (const VEC<dim>& vec) {
  for ( int i = 0; i < dim; i++ )
    data[i] = vec[i];
  return;
}

template<int dim>
void VEC<dim>::operator+= (const VEC<dim>& vec) {
  for ( int i = 0; i < dim; i++ )
    data[i] += vec[i];
  return;
}

template<int dim>
void VEC<dim>::operator-= (const VEC<dim>& vec) {
  for ( int i = 0; i < dim; i++ )
    data[i] -= vec[i];
  return;
}

template<int dim>
void VEC<dim>::operator*= (const double val) {
  for ( int i = 0; i < dim; i++ )
    data[i] *= val;
  return;
}

template<int dim>
void VEC<dim>::operator/= (const double val) {
  for ( int i = 0; i < dim; i++ )
    data[i] /= val;
  return;
}

template<int dim>
void VEC<dim>::operator= (const double val) {
  for ( int i = 0; i < dim; i++ )
    data[i] = val;
  return;
}

template<int dim>
void VEC<dim>::operator+= (const double val) {
  for ( int i = 0; i < dim; i++ )
    data[i] += val;
  return;
}

template<int dim>
void VEC<dim>::operator-= (const double val) {
  for ( int i = 0; i < dim; i++ )
    data[i] -= val;
  return;
}

template<int dim>
VEC<dim> operator+ (const VEC<dim>& input_1, const VEC<dim>& input_2) {
  VEC<dim> vec;
  for ( int i = 0; i < dim; i++ )
    vec[i] = input_1[i] + input_2[i];
  return vec;
}

template<int dim>
VEC<dim> operator+ (const VEC<dim>& input_1) {
  VEC<dim> vec;
  for ( int i = 0; i < dim; i++ )
    vec[i] = input_1[i];
  return vec;
}

template<int dim>
VEC<dim> operator- (const VEC<dim>& input_1, const VEC<dim>& input_2) {
  VEC<dim> vec;
  for ( int i = 0; i < dim; i++ )
    vec[i] = input_1[i] - input_2[i];
  return vec;
}

template<int dim>
VEC<dim> operator- (const VEC<dim>& input_1) {
  VEC<dim> vec;
  for ( int i = 0; i < dim; i++ )
    vec[i] = -input_1[i];
  return vec;
}

template<int dim>
VEC<dim> operator* (const double& input_s, const VEC<dim>& input_v) {
  VEC<dim> vec;
  for ( int i = 0; i < dim; i++ )
    vec[i] = input_s * input_v[i];
  return vec;
}

template<int dim>
VEC<dim> operator* (const VEC<dim>& input_v, const double& input_s) {
  VEC<dim> vec;
  for ( int i = 0; i < dim; i++ )
    vec[i] = input_s * input_v[i];
  return vec;
}

template<int dim>
VEC<dim> operator/ (const VEC<dim>& input_v, const double& input_s) {
  VEC<dim> vec;
  for ( int i = 0; i < dim; i++ )
    vec[i] = input_v[i]/input_s;
  return vec;
}

VEC<3> operator| (const VEC<3>& input_1, const VEC<3>& input_2) {
  VEC<3> vec;
	vec[0] = input_1[1]*input_2[2]-input_1[2]*input_2[1];
	vec[1] = input_1[2]*input_2[0]-input_1[0]*input_2[2];
	vec[2] = input_1[0]*input_2[1]-input_1[1]*input_2[0];
  return vec;
} 

template<int dim>
VEC<dim> operator+ (const VEC<dim>& input_v, const double& input_s) {
  VEC<dim> vec;
  for ( int i = 0; i < dim; i++ )
    vec[i] = input_v[i] + input_s;
  return vec;
}

template<int dim>
VEC<dim> operator+ (const double& input_s, const VEC<dim>& input_v) {
  VEC<dim> vec;
  for ( int i = 0; i < dim; i++ )
    vec[i] = input_v[i] + input_s;
  return vec;
}

template<int dim>
VEC<dim> operator- (const VEC<dim>& input_v, const double& input_s) {
  VEC<dim> vec;
  for ( int i = 0; i < dim; i++ )
    vec[i] = input_v[i] - input_s;
  return vec;
}

template<int dim>
VEC<dim> operator- (const double& input_s, const VEC<dim>& input_v) {
  VEC<dim> vec;
  for ( int i = 0; i < dim; i++ )
    vec[i] = input_s - input_v[i];
  return vec;
}

template<int dim>
std::ostream& operator<< (std::ostream& os, const VEC<dim>& vec) {
  os << std::endl;
  for ( int i = 0; i < dim; i++ )
    os << vec.data[i] << '\t';
  os << std::endl;
  return os;
}

