# -------------------------------------------
# Application for console-based hello library
# -------------------------------------------
cframe_build_target(
    BASENAME hello
    TYPE     Executable
    GROUP    CFrameDemo
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
    BASENAME qHello
    TYPE     Executable
    GROUP    CFrameDemo
    INCLUDE_DIRS
        ../libs
    SOURCES
        qHello.cpp
    LIBRARIES
        QtCFrameDemo
        ${QT_LIBRARIES}
)

# -----------------------------------
# Library for osg-based hello library
# -----------------------------------
cframe_build_target(
    BASENAME osgHello
    TYPE     Executable
    GROUP    CFrameDemo
    INCLUDE_DIRS
        ../libs
    SOURCES
        osgHello.cpp
    LIBRARIES
        osgCFrameDemo
        ${OPENSCENEGRAPH_LIBRARIES}
)
