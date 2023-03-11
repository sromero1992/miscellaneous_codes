#ifndef __GEOM_H__
#define __GEOM_H__

#include <iostream>
#include <cmath>

class Geometry {
  public:
    double getArea() {return area;}
    double getDiam() {return diam;}

    virtual void calcArea() {
      std::cout << "Oops: No generic way to compute the area." << std::endl;
    };

    virtual void calcDiam() {
      std::cout << "Oops: No generic way to compute the diameter." << std::endl;
    };

    virtual void print() {
      std::cout << "Area:     " << area << std::endl;
      std::cout << "Diameter: " << diam << std::endl;
    }

    Geometry() {
      area = 0.0;
      diam = 0.0;
      std::cout << "Creating a Geometry" << std::endl;
    }
    virtual ~Geometry() {
      std::cout << "Deleting a Geometry" << std::endl;
    }
    
  protected:
    double area;
    double diam;
};

class Circle : public Geometry {
  public:
    double getRadius() {return radius;}

    void   calcArea() {
      area = 3.1415926 * radius * radius;
    };
    void   calcDiam() {
      diam = 2.0 * radius;
    };

    void print() {
      Geometry::print();
      std::cout << "Radius:   " << radius << std::endl;
    }

    Circle() {
      radius = 0.0;
      std::cout << "Creating a Circle" << std::endl;
    }
    ~Circle() {
      std::cout << "Deleting a Circle" << std::endl;
    }
    
  private:
    double radius;

  public:
    void setRadius(double radius_) {
      radius = radius_;
    }
};

class Square : public Geometry {
  public:
    double getSide() {return side;}

    void   calcArea() {
      area = side * side;
    };
    void   calcDiam() {
      diam = sqrt(2.0) * side;
    };

    void print() {
      Geometry::print();
      std::cout << "Side:     " << side << std::endl;
    }

    Square() {
      side = 0.0;
      std::cout << "Creating a Square" << std::endl;
    }
    ~Square() {
      std::cout << "Deleting a Square" << std::endl;
    }
    
  private:
    double side;

  public:
    void setSide(double side_) {
      side = side_;
    }
};

#endif
