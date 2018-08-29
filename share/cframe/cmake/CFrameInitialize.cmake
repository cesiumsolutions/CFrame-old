# -----------------------------------------------------------------------------
#
# Initializes various settings and variables.
#
# -----------------------------------------------------------------------------


# Needed for the named parameter arguments
include( CMakeParseArguments )

set( CFRAME_PRODUCTS_DIR ${${PROJECT_NAME}_SOURCE_DIR}/products
    CACHE PATH "Parent directory for all products to be compiled."
)
option( CFRAME_FLAT_SOURCE_TREE "Determines whether project subfolders are automatically created in IDES" ON )
set( CFRAME_INSTALL_BIN_DIR bin
    CACHE STRING "Directory where binaries will be installed"
)
set( CFRAME_INSTALL_LIB_DIR bin
    CACHE STRING "Directory where runtimme libraries will be installed"
)
set( CFRAME_INSTALL_DEV_DIR lib
    CACHE STRING "Directory where development libraries will be installed"
)

set( BUILD_SHARED_LIBS ON )
set( CMAKE_DEBUG_POSTFIX d )
set( CMAKE_CXX_STANDARD 11 )
set_property( GLOBAL PROPERTY USE_FOLDERS ON )

if ( WIN32 )
  set( PLATFORM_FLAGS "/EHsc /bigobj" CACHE STRING "Platform specific compile flags" )
  set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${PLATFORM_FLAGS}" )
  set( CMAKE_C_FLAGS   "${CMAKE_C_FLAGS} ${PLATFORM_FLAGS}" )

  foreach( CONFIG ${CMAKE_CONFIGURATION_TYPES} )
    string( TOUPPER ${CONFIG} UCONFIG )
    set( CMAKE_CXX_FLAGS_${UCONFIG} "${CMAKE_CXX_FLAGS_${UCONFIG}} ${PLATFORM_FLAGS}" )
    set( CMAKE_C_FLAGS_${UCONFIG} "${CMAKE_C_FLAGS_${UCONFIG}} ${PLATFORM_FLAGS}" )
  endforeach()
endif()

include_directories( testtools )

include( CFrameInternal )
include( CFrameUtilities )
include( CFrameExternalPackages )
include( CFrameProjects )
include( CFrameBuildFunctions )
