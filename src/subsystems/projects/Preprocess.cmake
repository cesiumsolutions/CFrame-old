# ------------------------------------------------------------------------------
# @file src/subsystems/projects/Preprocess.cmake
# @brief Performs tasks during the preprocessing stage for the Projects subsystem.
# ------------------------------------------------------------------------------

# Process the directories specified by the CFRAME_PROJECTS variable and add all
# all found project directories.
foreach( project ${CFRAME_PROJECTS} )

  # We want to allow specifying subdirectories of the CURRENT_SOURCE_DIR as well
  # as directories outside of the source tree. But for processing, it is easier
  # to be consistent and assume all paths are absolute.
  # So prepend the CURRENT_SOURCE_DIR if project is  a subdirectory, otherwise
  # use as is.
  if ( EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${project} )
    set( rootDir ${CMAKE_CURRENT_SOURCE_DIR}/${project} )
  else()
    set( rootDir ${project} )
  endif()

  # Find all of the subdirs that contain a CMakeLists.txt file.
  cframe_search_subdirs(
      ROOTDIRS "${rootDir}"
      FILENAME CMakeLists.txt
      OUTVAR   projectDirs
      RECURSIVE STOPWHENFOUND
  )
  
  # Check if projectDirs is empty and give a message if so
  if ( projectDirs )
    list( LENGTH projectDirs numProjectDirs )
  else()
    set( numProjectDirs 0 )
  endif()
  if ( ${numProjectDirs} EQUAL 0 )
    cframe_message(
        MODE WARNING
        VERBOSITY 2
        TAGS CFrame Projects
        MESSAGE
            "No projects found in project directory: ${rootDir}"
            " or directory is invalid"
    )
  endif()

  foreach( projectDir ${projectDirs} )

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

    cframe_message(
        MODE STATUS
        VERBOSITY 3
        TAGS CFrame Projects
        MESSAGE
            "Adding project dir: ${projectDir} using binary dir: ${relPath}"
    )
    add_subdirectory( ${projectDir} ${relPath} )

  endforeach() # projectDirs

endforeach() # CFRAME_PROJECTS
