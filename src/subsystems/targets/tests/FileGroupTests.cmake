# -----------------------------------------------------------------------------
#
# Unit Tests for the FileGroup functions
#
# -----------------------------------------------------------------------------

# List Utils Unit Tests
if ( ${CFRAME_UNIT_TEST} )

  # cframe_file_group tests
  cframe_message(
      MODE STATUS
      VERBOSITY 2
      TAGS CFrame UnitTest Targets
      MESSAGE "Executing cframe_file_group() unit tests"
  )

  cframe_file_group(
      GROUPNAME Data
      OUTVAR    DATAFILES
      FILES
          widgets.dat
          gadgets.dat
          thingamajigs.dat
      PROPERTIES
          LABELS DataFile
      INSTALL_DIR projects/data
  )
  
  set( expectedFileList widgets.dat gadgets.dat thingamajigs.dat )
  cframe_list_equal( ${DATAFILES} ${expectedFileList} equal )
  cframe_check(
      "${equal}" STREQUAL TRUE
      "List of file_group files"
  )
  get_property(
      propVal
      SOURCE widgets.dat
      PROPERTY LABELS
  )
  cframe_check(
      ${propVal} STREQUAL DataFile
      "DataFile label"
  )

endif()