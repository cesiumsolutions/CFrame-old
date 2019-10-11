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
include( ${CFrameCorePath}/DirectoryUtils.cmake )
include( ${CFrameCorePath}/SubsystemUtils.cmake )

#include core implementation unit test files
option( CFRAME_UNIT_TEST "Toggle unit testing of CFrame functions" FALSE )

if ( ${CFRAME_UNIT_TEST} )
  cframe_start_internal_tests()
  include( ${CFrameCorePath}/tests/MessagingTests.cmake )
  include( ${CFrameCorePath}/tests/ListUtilsTests.cmake )
  include( ${CFrameCorePath}/tests/DirectoryUtilsTests.cmake )
  cframe_finish_internal_tests()
endif()

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
function( cframe_initialize )

  cframe_message(
      MODE STATUS
      VERBOSITY 5
      TAGS CFrame
      MESSAGE cframe_initialize()
  )

  set( subSystems ${CFrameSubsystems} )

  # If no arguments are passed, load all available Subsystems which are subdirs
  # of the subsystems directory
  if ( ${ARGC} EQUAL 0 )
    file( GLOB subDirs RELATIVE ${CFrameSubSystemsPath} ${CFrameSubSystemsPath}/* )
    foreach( subDir ${subDirs} )
      if( IS_DIRECTORY ${CFrameSubSystemsPath}/${subDir} )
        list( APPEND subSystems ${subDir} )
      endif()
    endforeach()
 else()

    # Make a CFramSubSystems variable which contains a set (no duplicates) of the
    # function arguments converted to lower case
    foreach( arg ${ARGV} )
      string( TOLOWER ${arg} argLower )
      list( APPEND subSystems ${argLower} )
    endforeach()
    
  endif()

  list( REMOVE_DUPLICATES subSystems )
  # Maintain a list of all explicitly specified or automatically discovered
  # subsystems
  set( CFrameSubsystems "${subSystems}"
      CACHE INTERNAL "CFrame's subsystems"
  )

  #
  # Initialize each of the other Subsystems
  #
  foreach( subSystem ${CFrameSubsystems} )
    cframe_subsystem_stage(
        ${subSystem}
        ${CFrameSubSystemsPath}/${subSystem}
        "Initialize"
    )
  endforeach()

  #
  # Call the test phase if testing is enabled
  #
  if ( ${CFRAME_UNIT_TEST} )
    foreach( subSystem ${CFrameSubsystems} )
      cframe_subsystem_stage(
          ${subSystem}
          ${CFrameSubSystemsPath}/${subSystem}
          "tests"
      )
    endforeach()
  endif()

endfunction() # cframe_initialize

# ------------------------------------------------------------------------------
# @brief Executes the Preprocess stage of each of the registered Subsystems.
# ------------------------------------------------------------------------------
function( cframe_preprocess )

  cframe_message(
      MODE STATUS
      VERBOSITY 5
      TAGS CFrame
      MESSAGE cframe_preprocess()
  )

  foreach( subSystem ${CFrameSubsystems} )
    cframe_subsystem_stage(
        ${subSystem}
        ${CFrameSubSystemsPath}/${subSystem}
        "Preprocess"
    )
  endforeach()

endfunction() # cframe_preprocess

# ------------------------------------------------------------------------------
# @brief Executes the Process stage of each of the registered Subsystems.
# ------------------------------------------------------------------------------
function( cframe_process )

  cframe_message(
      MODE STATUS
      VERBOSITY 5
      TAGS CFrame
      MESSAGE cframe_process()
  )

  foreach( subSystem ${CFrameSubsystems} )
    cframe_subsystem_stage(
        ${subSystem}
        ${CFrameSubSystemsPath}/${subSystem}
        "Process"
    )
  endforeach()

endfunction() # cframe_process

# ------------------------------------------------------------------------------
# @brief Executes the Postprocess stage of each of the registered Subsystems.
# ------------------------------------------------------------------------------
function( cframe_postprocess )

  cframe_message(
      MODE STATUS
      VERBOSITY 5
      TAGS CFrame
      MESSAGE cframe_postprocess()
  )

  foreach( subSystem ${CFrameSubsystems} )
    cframe_subsystem_stage(
        ${subSystem}
        ${CFrameSubSystemsPath}/${subSystem}
        "Postprocess"
    )
  endforeach()

endfunction() # cframe_postprocess