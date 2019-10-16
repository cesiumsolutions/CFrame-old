# -----------------------------------------------------------------------------
#
# Unit Tests for the Directory Utility functions
#
# -----------------------------------------------------------------------------

# Directory Utils Unit Tests
if ( ${CFRAME_UNIT_TEST} )

  # ---------------------------
  # cframe_search_subdirs tests
  # ---------------------------
  cframe_message(
      MODE STATUS
      VERBOSITY 1
      TAGS CFrame UnitTest
      MESSAGE "Executing cframe_search_subdirs() unit tests"
  )

  set( rootDirs
      ${CMAKE_CURRENT_LIST_DIR}/DirectoryUtilsTests.dir/projectA
      ${CMAKE_CURRENT_LIST_DIR}/DirectoryUtilsTests.dir/projectB
      ${CMAKE_CURRENT_LIST_DIR}/DirectoryUtilsTests.dir/projectC
  )

  # Test recursive=true and stop-when-found=true
  cframe_search_subdirs(
      ROOTDIRS "${rootDirs}"
      FILENAME CMakeLists.txt
      OUTVAR results
      RECURSIVE STOPWHENFOUND
  )
  cframe_files_relative_paths(
      relPaths
      ${CMAKE_CURRENT_LIST_DIR}/DirectoryUtilsTests.dir
      "${results}"
  )
  set( expected projectA projectB/subdirB1 projectB/subdirB2/subdirB22 )
  cframe_list_equal( relPaths expected equal )
  cframe_check(
      "${equal}" STREQUAL TRUE
      "Recurse=true, StopWhenFound=true"
  )

  # Test recursive=true and stop-when-found=false
  set( results "" )
  set( relPaths "" )
  cframe_search_subdirs(
      ROOTDIRS "${rootDirs}"
      FILENAME CMakeLists.txt
      OUTVAR results
      RECURSIVE
  )
  cframe_files_relative_paths(
      relPaths
      ${CMAKE_CURRENT_LIST_DIR}/DirectoryUtilsTests.dir
      "${results}"
  )
  set( expected projectA projectA/subdirA1 projectA/subdirA2 projectB/subdirB1 projectB/subdirB2/subdirB22 )
  cframe_list_equal( relPaths expected equal )
  cframe_check(
      "${equal}" STREQUAL TRUE
      "Recurse=true, StopWhenFound=false"
  )

  # Test recursive=false and stop-when-found=true
  set( results "" )
  set( relPaths "" )
  cframe_search_subdirs(
      ROOTDIRS "${rootDirs}"
      FILENAME CMakeLists.txt
      OUTVAR results
      STOPWHENFOUND
  )
  cframe_files_relative_paths(
      relPaths
      ${CMAKE_CURRENT_LIST_DIR}/DirectoryUtilsTests.dir
      "${results}"
  )
  set( expected projectA )
  cframe_list_equal( relPaths expected equal )
  cframe_check(
      "${equal}" STREQUAL TRUE
      "Recurse=false, StopWhenFound=true"
  )

  # Test recursive=false and stop-when-found=false
  set( results "" )
  set( relPaths "" )
  cframe_search_subdirs(
      ROOTDIRS "${rootDirs}"
      FILENAME CMakeLists.txt
      OUTVAR results
  )
  cframe_files_relative_paths(
      relPaths
      ${CMAKE_CURRENT_LIST_DIR}/DirectoryUtilsTests.dir
      "${results}"
  )
  set( expected projectA )
  cframe_list_equal( relPaths expected equal )
  cframe_check(
      "${equal}" STREQUAL TRUE
      "Recurse=false, StopWhenFound=false"
  )

endif() # CFRAME_UNIT_TEST