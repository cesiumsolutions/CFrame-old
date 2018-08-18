# -----------------------------------------------------------------------------
#
# Contains Project-related setup functions.
#
# -----------------------------------------------------------------------------

function( cframe_publish_project )

  cframe_message( STATUS 3 "CFrame: FUNCTION: cframe_publish_project")

  # -----------------------------------
  # Set up and parse multiple arguments
  # -----------------------------------
  set( options
  )
  set( oneValueArgs
      PROJECT
  )
  set( multiValueArgs
      VERSION
      DEFINITIONS
      INCLUDE_DIRS
      LIBRARY_DIRS
      LIBRARIES
  )

  cmake_parse_arguments(
      cframe_publish_project
      "${options}"
      "${oneValueArgs}"
      "${multiValueArgs}"
      ${ARGN}
  )

  cframe_message( STATUS 4 "Parameters for cframe_publish_project:" )
  cframe_message( STATUS 4 "PROJECT:       ${cframe_publish_project_PROJECT}" )
  cframe_message( STATUS 4 "VERSION:       ${cframe_publish_project_VERSION}" )
  cframe_message( STATUS 4 "DEFINITIONS:   ${cframe_publish_project_DEFINITIONS}" )
  cframe_message( STATUS 4 "INCLUDE_DIRS:  ${cframe_publish_project_INCLUDE_DIRS}" )
  cframe_message( STATUS 4 "LIBRARY_DIRS:  ${cframe_publish_project_LIBRARY_DIRS}" )
  cframe_message( STATUS 4 "LIBRARIES:     ${cframe_publish_project_LIBRARIES}" )

  # Check that minimal values are defined and valid
  if ( NOT DEFINED cframe_publish_project_PROJECT )
    cframe_message( WARNING 1 "CFrame: cframe_publish_project no PROJECT parameter specified" )
    return()
  endif()

  string( TOUPPER ${cframe_publish_project_PROJECT} UPROJECT )

  cframe_message( STATUS 3 "CFrame: ${cframe_publish_project_PROJECT} publishing the following variables." )

  set( ${UPROJECT}_FOUND TRUE
      CACHE INTERNAL "$(cframe_publish_project_PROJECT} project was found."
  )
  cframe_message( STATUS 3
      "${UPROJECT}_FOUND        = ${${UPROJECT}_FOUND}"
  )

  if ( DEFINED cframe_publish_project_VERSION )
    set( ${UPROJECT}_VERSION ${cframe_publish_project_VERSION}
        CACHE STRING "$(cframe_publish_project_PROJECT} project version."
    )
    cframe_message( STATUS 3
        "${UPROJECT}_VERSION      = ${${UPROJECT}_VERSION}"
    )
  endif()

  if ( DEFINED cframe_publish_project_DEFINITIONS )
    set( ${UPROJECT}_DEFINITIONS ${cframe_publish_project_DEFINITIONS}
        CACHE STRING "${cframe_publish_project_PROJECT} project list of definitions."
    )
    cframe_message( STATUS 3
        "${UPROJECT}_DEFINITIONS  = ${${UPROJECT}_DEFINITIONS}"
    )
  endif()

  if ( DEFINED cframe_publish_project_INCLUDE_DIRS )
    set( ${UPROJECT}_INCLUDE_DIRS ${cframe_publish_project_INCLUDE_DIRS}
        CACHE STRING "${cframe_publish_project_PROJECT} project list of include directories."
    )
    cframe_message( STATUS 3
        "${UPROJECT}_INCLUDE_DIRS = ${${UPROJECT}_INCLUDE_DIRS}"
    )
  endif()

  if ( DEFINED cframe_publish_project_LIBRARY_DIRS )
    set( ${UPROJECT}_LIBRARY_DIRS ${cframe_publish_project_LIBRARY_DIRS}
        CACHE STRING "${cframe_publish_project_PROJECT} project list of library directories."
    )
    cframe_message( STATUS 3
        "${UPROJECT}_LIBRARY_DIRS = ${${UPROJECT}_LIBRARY_DIRS}"
    )
  endif()

  if ( DEFINED cframe_publish_project_LIBRARIES )
    set( ${UPROJECT}_LIBRARIES ${cframe_publish_project_LIBRARIES}
        CACHE STRING "${cframe_publish_project_PROJECT} project list of libraries."
    )
    cframe_message( STATUS 3
        "${UPROJECT}_LIBRARIES    = ${${UPROJECT}_LIBRARIES}"
    )
  endif()

endfunction() # cframe_publish_project