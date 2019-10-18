# ------------------------------------------------------------------------------
# @file src/subsystems/projects/Initialize.cmake
# @brief Initializes projects subsystem by loading source files and initializing
#        project subsystem variables
# ------------------------------------------------------------------------------

message( "${CMAKE_CURRENT_LIST_DIR}/Initialize.cmake" )

# Variable: CFRAME_PROJECTS
# Is a list of directories to search for projects (CMakeLists.txt) files.
# Multiple directories can be listed (separated by a ';'.
# Subdirectories of the current source directory (CMAKE_CURRENT_SOURCE_DIR) as
# well as outof source directories are supported.
#
# @note As CMake expects a binary directory be specified for any out of source
# source directories, the relative path will be calculated, any leading ../'s
# will be stripped, and what remains will be used as the binary directory. So
# this remaining part must be unique.
#
# For example, with the following directories, with the project source contained
# in the 'project' directory and out of source source in the 'other' directory:
#
# /dev
#     /project  (Directory where the main project's CMakeLists.txt file is)
#         /other
#             /experiment
#     /other
#         /experiment - Contains a CMakeLists.txt file
# /other/experiment   - Contains another CMakeLists.txt different than the previous
#
# Specifying CFRAME_PROJECTS=/dev/other;/other will result in relative paths as:
# ../other/experiment and ../../other/experiment, resultinig in the same binary
# build directory when the ../'s are stripped.
set( CFRAME_PROJECTS ""
    CACHE STRING
    "List of paths to directories to look for projects."
)
