# -----------------------------------------------------------------------------
#
# Internal macros used for setting up CFrame
#
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Macro: cframe_prepare_projects
#
# Do a first pass through all project directories
# and include their CFrameLists.txt file (if it exists).
#
# The Package's CFrameLists.txt should do the following:
# - specify include_directoriem s for the appropriate project subdirectories
# - specify the name of external package dependencies, and when possible
#   the components of those packages. This can be done using the function:
#
#      cframe_use_external_package( PACKAGE <name> VERSION <version> COMPONENTS <components...> ).
#
#   For example, for Boost:
#
#       cframe_use_external_package(
#           PACKAGE Boost
#           VERSION version
#           COMPONENTS
#               signals
#               system
#               unit_test_framework
#       )
#
#   Each of the lists will be reduced to make sure there are no duplicate entries.
#
# - Each Project should also publish their interfaces in a standard way so that
#   other dependent Projects can refer to then in a standard way. This done by
#   using the function:
#
#       cframe_publish_project( PROJECT_NAME
#           VERSION      <parts of version identifier: major minor patch build, number of elements is optional>
#           DEFINITIONS  <list of definitions>
#           INCLUDE_DIRS <list of directories to include>
#           LIBRARY_DIRS <list of directories to search for libraries>
#           LIBRARIES    <list of libraries generated>
#       )
#
# Global parameters used:
#     CFRAME_PROJECTS_DIR
# -----------------------------------------------------------------------------
macro( cframe_prepare_projects )

  cframe_message( STATUS 3 "CFrame: MACRO: cframe_internal_project_prepare" )

  # Assume all directories under the projects directory are projects. Make a BUILD option
  # for each of them.
  file( GLOB PROJECT_DIRS
      LIST_DIRECTORIES TRUE
      RELATIVE ${CFRAME_PROJECTS_DIR}
      ${CFRAME_PROJECTS_DIR}/*
  )
  foreach( PROJECT ${PROJECT_DIRS} )
    if ( (IS_DIRECTORY ${CFRAME_PROJECTS_DIR}/${PROJECT}) AND
         (EXISTS ${CFRAME_PROJECTS_DIR}/${PROJECT}/CMakeLists.txt) )

      list( APPEND CFRAME_BUILD_PROJECTS ${PROJECT} )

      if ( EXISTS ${CFRAME_PROJECTS_DIR}/${PROJECT}/CFrameLists.txt )
        option( BUILD_PROJECT_${PROJECT} "Build Package ${PROJECT}" ON )
        set( CFRAME_CURRENT_PROJECT_DIR ${CFRAME_PROJECTS_DIR}/${PROJECT} )
        set( CFRAME_CURRENT_PROJECT_NAME ${PROJECT} )
        include( ${CFRAME_PROJECTS_DIR}/${PROJECT}/CFrameLists.txt )

        cframe_message( STATUS 4
            "CFrame: ${PROJECT} version:      ${${PROJECT}_VERSION}"
        )
        cframe_message( STATUS 4
            "CFrame: ${PROJECT} definitions:  ${${PROJECT}_DEFINITIONS}"
        )
        cframe_message( STATUS 4
            "CFrame: ${PROJECT} include dirs: ${${PROJECT}_INCLUDE_DIRS}"
        )
        cframe_message( STATUS 4
            "CFrame: ${PROJECT} library dirs: ${${PROJECT}_LIBRARY_DIRS}"
        )
        cframe_message( STATUS 4
            "CFrame: ${PROJECT} libraries:    ${${PROJECT}_LIBRARIES}"
        )

      else()
        option( BUILD_PROJECT_${PROJECT} "Build Package ${PROJECT}" OFF )
        cframe_message( WARNING 2
            "CFrame: Package: ${PROJECT} does not contain a CFrameLists.txt."
            "It will be ignored for further processing."
            "See CFrame CMake Modular Framework documentation for further information."
        )
      endif()

      if ( BUILD_PROJECT_${PROJECT} )
        if ( DEFINED ${PROJECT}_INCLUDE_DIRS )
          cframe_message( STATUS 4 "CFrame: ${PROJECT}_INCLUDE_DIRS: ${${PROJECT}_INCLUDE_DIRS}")
          include_directories( ${${PROJECT}_INCLUDE_DIRS} )
        endif()
      endif()

    else()

      cframe_message( STATUS 2
          "CFrame: Project ${PROJECT} is not a directory or does not contain a CMakeLists.txt, skipping"
      )

    endif() # is directory and CMakeLists.txt exists
  endforeach() # project subdirectory loop

endmacro() # cframe_prepare_projects

# -----------------------------------------------------------------------------
# Macro: cframe_setup_external_packages
#
# Go through each of the external dependencies listed by the packages
# and either call the Setup${EXT_DEP}.cmake or do a standard setup.
#
# -----------------------------------------------------------------------------
macro( cframe_setup_external_packages )

  cframe_message( STATUS 3 "CFrame: MACRO: cframe_external_package_setup" )

  foreach( XPACKAGE ${CFRAME_EXTERNAL_PACKAGES} )
    cframe_message( STATUS 2
        "CFrame: Setting up external package: ${XPACKAGE} with components: ${CFRAME_EXTERNAL_${XPACKAGE}_COMPONENTS}"
    )

    if ( EXISTS ${${PROJECT_NAME}_SOURCE_DIR}/share/${PROJECT_NAME}/cmake/Setup${XPACKAGE}.cmake )
      cframe_message( STATUS 3 "CFrame: Using share/${PROJECT_NAME}/cmake/Setup${XPACKAGE}.cmake" )
      include( ${${PROJECT_NAME}_SOURCE_DIR}/share/${PROJECT_NAME}/cmake/Setup${XPACKAGE}.cmake )
    else()
      cframe_message( STATUS 3 "CFrame: Using standard external setup for package: ${XPACKAGE}" )
      cframe_setup_external_package( ${XPACKAGE} "${CFRAME_EXTERNAL_${XPACKAGE}_COMPONENTS}" )
    endif()
  endforeach()

endmacro() # cframe_setup_external_packages

# -----------------------------------------------------------------------------
# Macro: cframe_build_projects
#
# Now go through each of the project directories again and add their
# subdirectories. The CFRAME_BUILD variable will be set to true so that each
# project can either build using CFrame conventions or their own conventions.
#
# For example, in the root CMakeLists.txt of the project, the following check
# can be made:
#
#   if ( ${CFRAME_BUILD} )
#     include( CFrameBuild.cmake )
#   else()
#     .. do standard internal build
#   endif()
#
# -----------------------------------------------------------------------------
macro( cframe_build_projects )

  cframe_message( STATUS 3 "CFrame: MACRO: cframe_internal_project_build" )

  set( CFRAME_BUILD TRUE )
  foreach( PROJECT ${CFRAME_BUILD_PROJECTS} )
    if ( ${BUILD_PROJECT_${PROJECT}} )
      # @todo Find a better way to determine if CMAKE_PROJECTS_DIR is outside
      # of CFrame's source directory
      if ( IS_ABSOLUTE ${CFRAME_PROJECTS_DIR} )
        add_subdirectory( ${CFRAME_PROJECTS_DIR}/${PROJECT} ${PROJECT} )
      else()
        add_subdirectory( ${CFRAME_PROJECTS_DIR}/${PROJECT} )
      endif()
    endif()
  endforeach()

endmacro() # cframe_build_projects

# -----------------------------------------------------------------------------
# Macro: cframe_main
#
# Main body of CFrame root CMakeLists.txt
# -----------------------------------------------------------------------------
macro( cframe_main )

  cframe_message( STATUS 3 "CFrame: MACRO: cframe_main" )

  cframe_prepare_projects()

  cframe_setup_external_packages()

  cframe_build_projects()

endmacro() # cframe_prepare