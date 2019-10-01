# -----------------------------------------------------------------------------
#
# Contains CFrame Initialization functions
#
# -----------------------------------------------------------------------------

# Store the path of the Core subdirectory so it can be referenced in functions
# because the CMAKE_CURRENT_LIST_DIR when used in a function reports the
# directory location of the calling script.
set( CFrameCorePath ${CMAKE_CURRENT_LIST_DIR} )
set( CFrameSubSystemsPath ${CFrameCorePath}/../subsystems )

# Include core implementation files
include( ${CFrameCorePath}/Messaging.cmake )
include( ${CFrameCorePath}/UnitTestInternal.cmake )
include( ${CFrameCorePath}/ListUtils.cmake )
include( ${CFrameCorePath}/SubsystemUtils.cmake )

#include core implementation unit test files
option( CFRAME_UNIT_TEST "Toggle unit testing of CFrame functions" FALSE )

if ( ${CFRAME_UNIT_TEST} )
  cframe_start_internal_tests()
  include( ${CFrameCorePath}/tests/MessagingTests.cmake )
  include( ${CFrameCorePath}/tests/ListUtilsTests.cmake )
  cframe_finish_internal_tests()
endif()

# -----------------------------------------------------------------------------
#
# -----------------------------------------------------------------------------
function( cframe_initialize )

  cframe_message(
      MODE STATUS
      VERBOSITY 5
      TAGS CFrame
      MESSAGE cframe_initialize()
  )

  set( subSystems "" )

  # If no arguments are passed, load all available SubSystems which are subdirs
  # of the subsystems directory
  if ( ${ARGC} EQUAL 0 )
    file( GLOB subDirs RELATIVE ${CFrameSubSystemsPath} ${CFrameSubSystemsPath}/* )
    foreach( subDir ${subDirs} )
      if( IS_DIRECTORY ${CFrameSubSystemsPath}/${subDir} )
        list( APPEND subSystems ${subDir} )
      endif()
    endforeach()
 else()

    # Make a subSystems variable which contains a set (no duplicates) of the
    # function arguments converted to lower case
    foreach( arg ${ARGV} )
      string( TOLOWER ${arg} argLower )
      list( APPEND subSystems ${argLower} )
    endforeach()
    list( REMOVE_DUPLICATES subSystems )
    
  endif()

  #
  # Initialize each of the other Subsystems
  #
  foreach( subSystem ${subSystems} )
    if ( NOT ${subSystem} STREQUAL "messaging" )
      cframe_subsystem_initialize(
          ${subSystem}
          ${CFrameSubSystemsPath}/${subSystem}
      )
    endif()
  endforeach()

endfunction() # cframe_initialize
