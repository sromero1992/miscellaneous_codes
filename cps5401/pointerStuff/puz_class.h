#ifndef __PUZ_CLASS_H__
#define __PUZ_CLASS_H__
#include <ctime>
#include <iostream>

// Base
class MyDate {
  public:
    virtual void print_from_year() = 0;
    virtual void print_from_month() = 0;
};

class MyYear : public virtual MyDate {
  public:
    void print_from_year() {
      time_t l_time = std::time(NULL);
      std::cout << "Year: " << std::localtime(&l_time)->tm_year+1900 << std::endl;
    }
};

class MyMonth : public virtual MyDate {
  public:
    void print_from_month() {
      //this->print_from_year();
      print_from_year();
      time_t l_time = std::time(NULL);
      std::cout << "Month: " << std::localtime(&l_time)->tm_mon+1 << std::endl;
    }
};

class PrintMyDate : public MyYear, public MyMonth {
};

#endif
