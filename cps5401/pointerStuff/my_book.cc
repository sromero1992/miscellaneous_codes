#include "my_book.h"

bool Book::setTitle( const char* title ) {
  if ( strlen( title ) > 255 )
    return false;
  else
    strcpy( title_, title );
  return true;
}

void Book::getTitle( char* title ) const {
  strcpy( title, title_ );
  return;
}

void Book::printTitle( void ) {
  cout << title_ << endl;
  return;
}

bool AuthoredBook::setAuthor( const char* author ) {
  if ( strlen( author ) > 255 )
    return false;
  else
    strcpy( author_, author );
  return true;
}

void AuthoredBook::getAuthor( char* author ) const {
  strcpy( author, author_ );
  return;
}

void AuthoredBook::printAuthor( void ) {
  cout << author_ << endl;
  return;
}
