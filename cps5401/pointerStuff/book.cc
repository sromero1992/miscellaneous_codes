#include <iostream>
#include <cstring>
using namespace std;

struct Book {
  public:
    bool setTitle( const char* title );
    void printTitle( void );
  private:
    char title_[255];
};

int main( int argc, char** argv ) {
  Book myBook;
  if ( !myBook.setTitle(argv[1]) ) {
    cout << "Error: The title is too long" << endl;
  }
  else
    //cout << myBook.title_ << endl;
    myBook.printTitle();

  return 0;
}

bool Book::setTitle( const char* title ) {
  if ( strlen( title ) > 255 )
    return false;
  else
    strcpy( title_, title );
  return true;
}

void Book::printTitle( void ) {
  cout << title_ << endl;
  return;
}

