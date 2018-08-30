#pragma once

#include <CFrameDemo/API.h>

namespace osg {
  class Node;
}

namespace cframe {

extern CFRAMEDEMO_API osg::Node * createHelloNode( char const * const toWhom = "World" );

} // namespace cframe
