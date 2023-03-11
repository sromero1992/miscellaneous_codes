#include "my_book.h"

int main( int argc, char** argv ) {
  AuthoredBook myBook( argv[1], argv[2] );
  myBook.print();

  return 0;
}

