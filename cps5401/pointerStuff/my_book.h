#ifndef __MY_BOOK_H__
#define __MY_BOOK_H__

#include <iostream>
using namespace std;

class Book {
  public:
    bool setTitle( const char* title );
    void printTitle( void );
    void getTitle( char* title ) const;
    void print() {
      printTitle();
      return;
    }

    Book() {};
    Book( const char* title ) {
      strcpy( title_, title );
    }

  protected:
    char title_[255];
};

class AuthoredBook : public Book {
  public:
    bool setAuthor( const char* author );
    void printAuthor( void );
    void getAuthor( char* author ) const;

    void print( const char* prefix=" by " ) {
      Book::print();
      cout << prefix;
      printAuthor();
      return;
    }

    AuthoredBook() {};
    AuthoredBook( const char* title, const char* author ) : Book( title ) {
      strcpy( author_, author );
    }

  protected:
    char author_[255];
};

#endif
