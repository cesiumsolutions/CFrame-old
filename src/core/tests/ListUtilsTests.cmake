# -----------------------------------------------------------------------------
#
# Unit Tests for the Filter Utility functions
#
# -----------------------------------------------------------------------------

# List Utils Unit Tests
if ( ${CFRAME_UNIT_TEST} )

  # cframe_list_equal tests
  cframe_message(
      MODE STATUS
      VERBOSITY 1
      TAGS CFrame UnitTest
      MESSAGE "Executing cframe_list_equal() unit tests"
  )

  set( list0 )
  set( list123 One Two Three )
  set( list1234 One Two Three Four )
  set( list234 Two Three Four )
  set( list456 Four Five Six )

  cframe_list_equal( list0 list0 equal )
  cframe_check( ${equal} STREQUAL TRUE
                "two empty lists" )

  cframe_list_equal( list0 list123 equal )
  cframe_check( ${equal} STREQUAL FALSE
                "empty and non empty lists" )

  cframe_list_equal( list123 list0 equal )
  cframe_check( ${equal} STREQUAL FALSE
                "non-empty and empty lists" )

  cframe_list_equal( list123 list123 equal )
  cframe_check( ${equal} STREQUAL TRUE
                "non-empty same list" )

  cframe_list_equal( list123 list234 equal )
  cframe_check( ${equal} STREQUAL FALSE
                "two non-empty overlapping lists" )

  cframe_list_equal( list123 list1234 equal )
  cframe_check( ${equal} STREQUAL FALSE
                "two non-empty inequal length lists" )

  # cframe_list_intersect tests
  cframe_message(
      MODE STATUS
      VERBOSITY 1
      TAGS CFrame UnitTest
      MESSAGE "Executing cframe_list_intersect() unit tests"
  )

  cframe_list_intersect( list123 list234 intersection )
  list( LENGTH intersection numIntersections )
  cframe_check( ${numIntersections} EQUAL 2
                "two overlapping lists length check" )
  set( list23 Two Three )
  cframe_list_equal( intersection list23 equal )
  cframe_check( "${equal}" STREQUAL TRUE
                "two overlapping lists contents check" )

  # cframe_filter tests
  cframe_message(
      MODE STATUS
      VERBOSITY 1
      TAGS CFrame UnitTest
      MESSAGE "Executing cframe_filter() unit tests"
  )

  set( testItems Red Green Blue )
  set( testFilter1 Green Orange )
  set( testFilter2 Orange Purple )

  # Empty Items
  cframe_filter( noItems testFilter1 TRUE testResult )
  cframe_check( ${testResult} STREQUAL TRUE
                "nullItem TRUE check failed" )

  cframe_filter( noItems testFilter1 FALSE testResult )
  cframe_check( ${testResult} STREQUAL FALSE
                "nullItem FALSE check failed" )

  # Empty Filter
  cframe_filter( testItems noFilter TRUE testResult )
  cframe_check( ${testResult} STREQUAL TRUE
                "nullFilter TRUE check failed" )
  cframe_filter( testItems noFilter FALSE testResult )
  cframe_check( ${testResult} STREQUAL FALSE
                "nullFilter FALSE check failed" )

  # Empty Items and Filter
  cframe_filter( noItems noFilter TRUE testResult )
  cframe_check( ${testResult} STREQUAL TRUE
                "nullItems + nullFilter TRUE check failed" )
  cframe_filter( noItems noFilter FALSE testResult )
  cframe_check( ${testResult} STREQUAL FALSE
                "nullItems + nullFilter FALSE check failed" )

  # Non-empty Items and Filter with successful filter
  cframe_filter( testItems testFilter1 TRUE testResult )
  cframe_check( ${testResult} STREQUAL TRUE
                "valid items + filter TRUE check failed" )

  # Non-empty Items and Filter with unsuccessful filter
  cframe_filter( testItems testFilter2 TRUE testResult )
  cframe_check( ${testResult} STREQUAL FALSE
                "valid items + filter FALSE check failed" )

endif()