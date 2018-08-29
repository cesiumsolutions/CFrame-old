# -----------------------------------------------------------------------------
#
# Contains Project-related setup functions.
#
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------
#
# -----------------------------------------------------------------------------
macro( cframe_setup_subdir )

  cframe_message( STATUS 3 "CFrame: FUNCTION: cframe_setup_subdir")

  # -----------------------------------
  # Set up and parse multiple arguments
  # -----------------------------------
  set( options
  )
  set( oneValueArgs
      PREFIX
      SUBDIR
      FOLDER
      HEADERS_INSTALL_DIR
      FILES_INSTALL_DIR
  )
  set( multiValueArgs
      HEADERS_PUBLIC
      HEADERS_PRIVATE
      FILES_PUBLIC
      FILES_PRIVATE
      SOURCES
  )

  cmake_parse_arguments(
      cframe_setup_subdir
      "${options}"
      "${oneValueArgs}"
      "${multiValueArgs}"
      ${ARGN}
  )

  cframe_message( STATUS 4 "Parameters for cframe_setup_subdir:" )
  cframe_message( STATUS 4 "PREFIX:               ${cframe_setup_subdir_PREFIX}" )
  cframe_message( STATUS 4 "SUBDIR:               ${cframe_setup_subdir_SUBDIR}" )
  cframe_message( STATUS 4 "FOLDER:               ${cframe_setup_subdir_FOLDER}" )
  cframe_message( STATUS 4 "HEADERS_INSTALL_DIR:  ${cframe_setup_subdir_HEADERS_INSTALL_DIR}" )
  cframe_message( STATUS 4 "FILES_INSTALL_DIR:    ${cframe_setup_subdir_FILESS_INSTALL_DIR}" )
  cframe_message( STATUS 4 "HEADERS_PUBLIC:       ${cframe_setup_subdir_HEADERS_PUBLIC}" )
  cframe_message( STATUS 4 "HEADERS_PRIVATE:      ${cframe_setup_subdir_HEADERS_PRIVATE}" )
  cframe_message( STATUS 4 "FILES_PUBLIC:         ${cframe_setup_subdir_FILES_PUBLIC}" )
  cframe_message( STATUS 4 "FILES_PRIVATE:        ${cframe_setup_subdir_FILES_PRIVATE}" )
  cframe_message( STATUS 4 "SOURCES:              ${cframe_setup_subdir_SOURCES}" )

  set( PREFIX               ${cframe_setup_subdir_PREFIX} )
  set( SUBDIR               ${cframe_setup_subdir_SUBDIR} )
  set( FOLDER               ${cframe_setup_subdir_FOLDER} )
  set( HEADERS_INSTALL_DIR  ${cframe_setup_subdir_HEADERS_INSTALL_DIR} )
  set( FILES_INSTALL_DIR    ${cframe_setup_subdir_FILESS_INSTALL_DIR} )
  set( HEADERS_PUBLIC       ${cframe_setup_subdir_HEADERS_PUBLIC} )
  set( HEADERS_PRIVATE      ${cframe_setup_subdir_HEADERS_PRIVATE} )
  set( FILES_PUBLIC         ${cframe_setup_subdir_FILES_PUBLIC} )
  set( FILES_PRIVATE        ${cframe_setup_subdir_FILES_PRIVATE} )
  set( SOURCES              ${cframe_setup_subdir_SOURCES} )

  # Allow the case for a SUBDIR which is actually the current directory, in which case
  # SUBDIR should be undefined and the SEP will also remain undefined below
  if ( NOT ${SUBDIR} STREQUAL "" )
    set( SEP "/" )
  endif()

  foreach( FILE ${HEADERS_PUBLIC} )
    list( APPEND ${PREFIX}_HEADERS_PUBLIC ${SUBDIR}${SEP}${FILE} )
  endforeach()
  set( ${PREFIX}_HEADERS_PUBLIC ${${PREFIX}_HEADERS_PUBLIC} PARENT_SCOPE )
  cframe_message( STATUS 4 "CFrame: ${PREFIX}_HEADERS_PUBLIC: ${${PREFIX}_HEADERS_PUBLIC}" )

  foreach( FILE ${HEADERS_PRIVATE} )
    list( APPEND ${PREFIX}_HEADERS_PRIVATE ${SUBDIR}${SEP}${FILE} )
  endforeach()
  set( ${PREFIX}_HEADERS_PRIVATE ${${PREFIX}_HEADERS_PRIVATE} PARENT_SCOPE )
  cframe_message( STATUS 4 "CFrame: ${PREFIX}_HEADERS_PRIVATE: ${${PREFIX}_HEADERS_PRIVATE}" )

  foreach( FILE ${FILES_PUBLIC} )
    list( APPEND ${PREFIX}_FILES_PUBLIC ${SUBDIR}${SEP}${FILE} )
  endforeach()
  set( ${PREFIX}_FILES_PUBLIC ${${PREFIX}_FILES_PUBLIC} PARENT_SCOPE )
  cframe_message( STATUS 4 "CFrame: ${PREFIX}_FILES_PUBLIC: ${${PREFIX}_FILES_PUBLIC}" )

  foreach( FILE ${FILES_PRIVATE} )
    list( APPEND ${PREFIX}_FILES_PRIVATE ${SUBDIR}${SEP}${FILE} )
  endforeach()
  set( ${PREFIX}_FILES_PRIVATE ${${PREFIX}_FILES_PRIVATE} PARENT_SCOPE )
  cframe_message( STATUS 4 "CFrame: ${PREFIX}_FILES_PRIVATE: ${${PREFIX}_FILES_PRIVATE}" )

  foreach( FILE ${SOURCES} )
    list( APPEND ${PREFIX}_SOURCES ${SUBDIR}${SEP}${FILE} )
  endforeach()
  set( ${PREFIX}_SOURCES ${${PREFIX}_FILES_SOURCES} PARENT_SCOPE )
  cframe_message( STATUS 4 "CFrame: ${PREFIX}_SOURCES: ${${PREFIX}_SOURCES}" )

  source_group(
      \\${FOLDER} FILES
      ${${PREFIX}_HEADERS_PUBLIC}
      ${${PREFIX}_HEADERS_PRIVATE}
      ${${PREFIX}_FILES_PUBLIC}
      ${${PREFIX}_FILES_PRIVATE}
      ${${PREFIX}_SOURCES}
  )

  if ( DEFINED cframe_setup_subdir_HEADERS_INSTALL_DIR )
    install(
        FILES
            ${${PREFIX}_HEADERS_PUBLIC}
        DESTINATION
            ${cframe_setup_subdir_HEADERS_INSTALL_DIR}
    )
  endif()

  if (DEFINED cframe_setup_subdir_FILES_INSTALL_DIR )
    install(
        FILES
            ${${PREFIX}_FILES_PUBLIC}
        DESTINATION
            ${cframe_setup_subdir_FILES_INSTALL_DIR}
    )
  endif()

endmacro() # cframe_setup_subdir