#include <iostream>
#include <cstdlib>
#include "geom.h"
using namespace std;

int main( int argc, char** argv ) {

  Square sqre;

  sqre.setSide( 1.0 );

  Circle circ;

  circ.setRadius( 1.0 );

  Geometry* geoms[2];

  geoms[0] = &sqre;
  geoms[1] = &circ;

  for ( int i = 0; i < 2; i++ )
  {
    geoms[i]->calcArea();
    geoms[i]->calcDiam();
  }

  for ( int i = 0; i < 2; i++ )
  {
    geoms[i]->print();
  }

  return 0;
}
