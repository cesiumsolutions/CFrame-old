# ------------------------------------------------------------------------------
# @file src/subsystems/projects/Preprocess.cmake
# @brief Performs tasks during the preprocessing stage for the Projects subsystem.
# ------------------------------------------------------------------------------

message( ${CMAKE_CURRENT_LIST_DIR}/Preprocess.cmake )
message( "CFRAME_PROJECTS = ${CFRAME_PROJECTS}" )

set( projectDirs "" )
cframe_search_subdirs(
    ROOTDIRS "${CFRAME_PROJECTS}"
    FILENAME CMakeLists.txt
    OUTVAR   projectDirs
    RECURSIVE STOPWHENFOUND
)

message( "CMAKE_CURRENT_SOURCE_DIR: ${CMAKE_CURRENT_SOURCE_DIR}" )
message( "projectDirs = ${projectDirs}" )

foreach( projectDir ${projectDirs} )

  # @todo Should this be checking CMAKE_CURRENT_SOURCE_DIR or PROJECT_DIR?
  if ( EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${projectDir} )

    # If projectDir is not a subDir of current source dir, figure out relative
    # path and use the part of that path that isn't relative (i.e. remove all ../'s)
    # and use that as the binary directory.
    # @note Windows paths starting with a drive letter different than the drive
    #       where the current source dir is located will not be properly stripped.
    #       (I don't know how to recognize this in CMake). So all project source
    #       directories must be on the same drive (on Windows).
    file( RELATIVE_PATH relPathNative ${CMAKE_CURRENT_SOURCE_DIR} ${projectDir}  )
    file( TO_CMAKE_PATH ${relPathNative} relPath )
    string( LENGTH ${relPath} relPathLength )

    string( SUBSTRING ${relPath} 0 3 relPrefix )
    while( ${relPrefix} STREQUAL "../" )
      math( EXPR relPathLength "${relPathLength}-3" )
      string( SUBSTRING ${relPath} 3 ${relPathLength} relPath )
      string( SUBSTRING ${relPath} 0 3 relPrefix )
    endwhile()

    message( "projectDir: ${projectDir}" )
    message( "relPath: ${relPath}" )
    add_subdirectory( ${projectDir} ${relPath} )
  
  else()
  
    cframe_message(
        MODE FATAL_ERROR
        TAGS CFrame Projects
        VERBOSITY 1
        MESSAGE "Process stage: out of source source directories are not
                 supported yet"
    )

  endif()
endforeach()