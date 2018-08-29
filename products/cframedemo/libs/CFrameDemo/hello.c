#include "hello.h"

#include <stdio.h>

#if defined __cplusplus
extern "C"
#endif

void sayHello( const char * toWhom )
{
  if ( toWhom ) {
    printf( "Hello %s!\n", toWhom );
  }
  else {
    printf( "Hello World!\n" );
  }
}

#if defined __cplusplus
} /* extern "C" */
#endif