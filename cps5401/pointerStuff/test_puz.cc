#include <iostream>
#include "puz_class.h"
using namespace std;

int main( int argc, char** argv ) {
  PrintMyDate* pd = new PrintMyDate;

  MyYear*  my = pd;
  MyMonth* mm = pd;

  pd->print_from_month();
  my->print_from_month();
  mm->print_from_month();

  pd->print_from_year();
  my->print_from_year();
  mm->print_from_year();

  delete pd;

  return 0;
}
