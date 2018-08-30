#include <CFrameDemo/QHello.hpp>

#include <QtWidgets/QApplication>

int main( int argc, char * argv[] )
{
  auto app = new QApplication( argc, argv );

  auto qhello = new cframe::QHello( QObject::tr("Everybody") );
  qhello->show();

  app->exec();
}
