#ifndef __MAT_3_H__
#define __MAT_3_H__

#include <iostream>
#include "vec3.h"

class MAT3 {
  private:
    VEC3 data[3];

  public:
    MAT3(void);
    MAT3(const double val);
    MAT3(const VEC3& vec);
    MAT3(const MAT3& mat);

    void rand(void);
    VEC3& operator[] (int i);
    const VEC3& operator[] (int i) const;

    void operator= (const MAT3& mat);
    void operator+= (const MAT3& mat);
    void operator-= (const MAT3& mat);
    void operator*= (const double val);
    void operator*= (const MAT3& mat);

    void operator/= (const double val);

    friend std::ostream& operator<< (std::ostream& os, const MAT3& mat);
};

MAT3 operator+ (const MAT3& input_1, const MAT3& input_2);
MAT3 operator+ (const MAT3& input_1);
MAT3 operator- (const MAT3& input_1, const MAT3& input_2);
MAT3 operator- (const MAT3& input_1);
MAT3 operator* (const double& input_s, const MAT3& input_m);
MAT3 operator* (const MAT3& input_m, const double& input_s);
MAT3 operator* (const MAT3& input_1, const MAT3& input_2);
MAT3 operator/ (const MAT3& input_m, const double& input_s);

VEC3 operator* (const MAT3& input_m, const VEC3& input_v);
// This is the tensor product
MAT3 operator^ (const VEC3& input_1, const VEC3& input_2);

std::ostream& operator<< (std::ostream& os, const MAT3& mat);

#endif
