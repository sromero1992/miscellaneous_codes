#ifndef __VEC_3_H__
#define __VEC_3_H__

#include <iostream>

class VEC3 {
  private:
    double data[3];

  public:
    VEC3(void);
    VEC3(const double val);
    VEC3(const VEC3& vec);

    void rand(void);

    double& operator[] (int i);
    const double& operator[] (int i) const;
    void operator= (const VEC3& vec);
    void operator+= (const VEC3& vec);
    void operator-= (const VEC3& vec);
    void operator*= (const double val);
    void operator/= (const double val);

    friend std::ostream& operator<< (std::ostream& os, const VEC3& vec); 
};

VEC3 operator+ (const VEC3& input_1, const VEC3& input_2);
VEC3 operator+ (const VEC3& input_1);
VEC3 operator- (const VEC3& input_1, const VEC3& input_2);
VEC3 operator- (const VEC3& input_1);
VEC3 operator* (const double& input_s, const VEC3& input_v);
VEC3 operator* (const VEC3& input_v, const double& input_s);
VEC3 operator/ (const VEC3& input_v, const double& input_s);

// The cross product of two 3-vectors
VEC3 operator| (const VEC3& input_1, const VEC3& input_2);

std::ostream& operator<< (std::ostream& os, const VEC3& vec); 

#endif
