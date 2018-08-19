#include "osgHello.hpp"

#include <osg/Geode>
#include <osgText/Text3D>

#include <sstream>

namespace cframe {

osg::Node * createHelloNode( char const * const toWhom )
{
  auto text = new osgText::Text3D;
  std::ostringstream oss;
  oss << "Hello " << (toWhom ? toWhom : "World") << '!';
  text->setText( oss.str() );
  text->setAxisAlignment( osgText::TextBase::XZ_PLANE );
  text->setFont( "arial.ttf" );

  auto geode = new osg::Geode;
  geode->addDrawable( text );
  return geode;
}

} // namespace cframe