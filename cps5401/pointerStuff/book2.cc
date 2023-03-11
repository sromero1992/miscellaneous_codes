#include <iostream>
#include <cstring>
#include <cstdlib>
#include <cmath>
using namespace std;

struct Book {
  public:
    void setTitle( const char* title );
    void getTitle ( char* title_out ) const;
    int  getMaxLen( void ) const { return max_len; }
    void printTitle( void ) const;

    Book( const char* title ) : max_len(255) {
      if ( strlen( title ) > max_len )
        cout << "Warning: The title is too long, will be truncated" << endl;
      title_ = new char[ min( static_cast<int>(strlen( title )), max_len ) ];
      setTitle( title );
    }

    Book( const Book& book ) : max_len(255) {
      char* title_buf;
      title_buf = new char[book.getMaxLen()];
      book.getTitle( title_buf );
      title_ = new char[ min( static_cast<int>(strlen( title_buf )), max_len ) ];
      setTitle( title_buf );
      delete[] title_buf;
    }

    ~Book(void) {
      if ( title_!=NULL)
        delete[] title_;
      cout << "Allocated space freed!" << endl;
    }

  private:

    Book(void) : max_len(255) {}; 

