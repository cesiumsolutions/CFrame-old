#include <CFrameDemo/osgHello.hpp>

#include <osg/ArgumentParser>
#include <osg/Group>
#include <osgGA/StateSetManipulator>
#include <osgGA/TrackballManipulator>
#include <osgViewer/Viewer>
#include <osgViewer/ViewerEventHandlers>

#include <iostream>

int main( int argc, char * argv[] )
{
  // Based on osgviewer.cpp
  osg::ArgumentParser arguments(&argc, argv);
  arguments.getApplicationUsage()->setApplicationName(arguments.getApplicationName());
  arguments.getApplicationUsage()->setDescription(arguments.getApplicationName() + " CFrame Hello World test with OpenSceneGraph.");
  arguments.getApplicationUsage()->setCommandLineUsage(arguments.getApplicationName() + " [options] <model files...>");
  arguments.getApplicationUsage()->addCommandLineOption("--to-whom", "Who should we say hello to.");
  osgViewer::Viewer viewer(arguments);

  unsigned int helpType = 0;
  if ( (helpType = arguments.readHelpType()) ) {
    arguments.getApplicationUsage()->write(std::cout, helpType);
    return 1;
  }

  // report any errors if they have occurred when parsing the program arguments.
  if ( arguments.errors() ) {
    arguments.writeErrorMessages(std::cout);
    return 1;
  }

  std::string toWhom = "World";
  while ( arguments.read("--to-whom", toWhom) ) {}

  // Set up the root scene node
  auto rootNode = new osg::Group;
  viewer.setSceneData(rootNode);

  rootNode->addChild(cframe::createHelloNode( toWhom.c_str()) );

  // Set up some standard viewer stuff
  viewer.setCameraManipulator(new osgGA::TrackballManipulator);
  viewer.addEventHandler(new osgGA::StateSetManipulator(viewer.getCamera()->getOrCreateStateSet()));
  viewer.addEventHandler(new osgViewer::WindowSizeHandler);

  osgViewer::StatsHandler* statsHandler = new osgViewer::StatsHandler;
  viewer.addEventHandler(statsHandler);
  viewer.addEventHandler(new osgViewer::HelpHandler(arguments.getApplicationUsage()));

  viewer.realize();
  return viewer.run();
}
