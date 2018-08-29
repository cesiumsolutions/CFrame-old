# --------------------------------------
# Library for console-based demo library
# --------------------------------------
cframe_build_target(
    TARGET_NAME   cframedemo
    PROJECT_LABEL CDemo
    TYPE          Library
    GROUP         CFrameDemo/Libraries
    INCLUDE_DIRS
        ..
    HEADERS_PUBLIC
        API.h
        hello.h
    SOURCES
        hello.c
    HEADERS_INSTALL_DIR
        include/CFrameDemo
`)

# ----------------------------------
# Library for osg-based demo library
# ----------------------------------
cframe_build_target(
    TARGET_NAME   CFrameOSGDemo
    PROJECT_LABEL OSGDemo
    TYPE          Library
    GROUP         CFrameDemo/Libraries
    INCLUDE_DIRS
        ..
    HEADERS_PUBLIC
        API.h
        osgHello.hpp
    SOURCES
        osgHello.cpp
    LIBRARIES
        ${OPENSCENEGRAPH_LIBRARIES}
    HEADERS_INSTALL_DIR
        include/CFrameDemo
)

# ---------------------------------
# Library for qt-based demo library
# ---------------------------------
cframe_build_target(
    TARGET_NAME   CFrameQtDemo
    PROJECT_LABEL QtDemo
    TYPE          Library
    GROUP         CFrameDemo/Libraries
    INCLUDE_DIRS
        ..
    HEADERS_PUBLIC
        API.h
        QHello.hpp
    SOURCES
        QHello.cpp
    QT_MOCFILES
        QHello.hpp
    LIBRARIES
        ${QT_LIBRARIES}
    HEADERS_INSTALL_DIR
        include/CFrameDemo
)

# By default, CMake defines ${TARGET}_EXPORTS, but we want to
# share the API.h between these three libraries
# Normally you would have a separate one though.
# Note: Modern CMake has new automated ways of handling this. 

set_target_properties(
    cframedemo CFrameOSGDemo CFrameQtDemo
    PROPERTIES
        DEFINE_SYMBOL cframedemo_EXPORTS
)
