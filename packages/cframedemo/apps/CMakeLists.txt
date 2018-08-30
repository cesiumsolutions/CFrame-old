# -------------------------------------------
# Application for console-based hello library
# -------------------------------------------
cframe_build_target(
    TARGET_NAME   cframeHello
    PROJECT_LABEL hello
    TYPE          Executable
    GROUP         CFrameDemo/Tests
    INCLUDE_DIRS
        ../libs
    SOURCES
        hello.c
    LIBRARIES
        cframedemo
)

# --------------------------------------
# Application for qt-based hello library
# --------------------------------------
cframe_build_target(
    TARGET_NAME   cframeQHello
    PROJECT_LABEL QHello
    TYPE          Executable
    GROUP         CFrameDemo/Tests
    INCLUDE_DIRS
        ../libs
    SOURCES
        qHello.cpp
    LIBRARIES
        CFrameQtDemo
        ${QT_LIBRARIES}
)

# -----------------------------------
# Library for osg-based hello library
# -----------------------------------
cframe_build_target(
    TARGET_NAME   cframeOSGHello
    PROJECT_LABEL OSGHello
    TYPE          Executable
    GROUP         CFrameDemo/Tests
    INCLUDE_DIRS
        ../libs
    SOURCES
        osgHello.cpp
    LIBRARIES
        CFrameOSGDemo
        ${OPENSCENEGRAPH_LIBRARIES}
)
