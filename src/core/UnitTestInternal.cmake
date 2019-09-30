# -----------------------------------------------------------------------------
#
# Contains functions for unit testing (internal) CMake functions.
#
# -----------------------------------------------------------------------------

# Initialize internal test statistics
set( CFRAME_TESTS_NUM_SUCCEEDED 0 CACHE INTERNAL "" )
set( CFRAME_TESTS_NUM_FAILED 0 CACHE INTERNAL "" )
set( CFRAME_TESTS_NUM_EXECUTED 0 CACHE INTERNAL "" )

#
#
#
function( cframe_start_internal_tests )

  set( CFRAME_TESTS_NUM_SUCCEEDED 0 CACHE INTERNAL "" )
  set( CFRAME_TESTS_NUM_FAILED 0 CACHE INTERNAL "" )
  set( CFRAME_TESTS_NUM_EXECUTED 0 CACHE INTERNAL "" )

endfunction() # cframe_start_tests

#
#
#
function( cframe_finish_internal_tests )

  if ( ${CFRAME_TESTS_NUM_FAILED} GREATER 0 )
    cframe_message(
        MODE NOTICE
        VERBOSITY 2
        TAGS CFrame UnitTest
        MESSAGE
            "Internal Unit Tests Summary:\n"
            "  Total Executed:  ${CFRAME_TESTS_NUM_EXECUTED}\n"
            "  Total Succeeded: ${CFRAME_TESTS_NUM_SUCCEEDED}\n"
            "  Total Failed:    ${CFRAME_TESTS_NUM_FAILED}\n"
    )
  else()
    cframe_message(
        MODE STATUS
        VERBOSITY 2
        TAGS CFrame UnitTest
        MESSAGE
            "Internal Unit Tests Summary:\n"
            "  Total Executed:  ${CFRAME_TESTS_NUM_EXECUTED}\n"
            "  Total Succeeded: ${CFRAME_TESTS_NUM_SUCCEEDED}\n"
            "  Total Failed:    ${CFRAME_TESTS_NUM_FAILED}\n"
    )
  endif()

endfunction() # cframe_finish_tests

#
#
#
function( cframe_check value comp expected msg )

  ##message( STATUS "cframe_check ${value} ${comp} ${expected} ${msg}" )

  math( EXPR numExecuted "${CFRAME_TESTS_NUM_EXECUTED} + 1" )
  set( CFRAME_TESTS_NUM_EXECUTED ${numExecuted} CACHE INTERNAL "" )

  if ( ${value} ${comp} ${expected} )
    math( EXPR numSucceeded "${CFRAME_TESTS_NUM_SUCCEEDED} + 1" )
    set( CFRAME_TESTS_NUM_SUCCEEDED ${numSucceeded} CACHE INTERNAL "" )
    cframe_message(
        MODE STATUS
        VERBOSITY 3
        TAGS CFrame UnitTest
        MESSAGE "SUCCEEDED: ${msg}"
    )
  else()
    math( EXPR numFailed "${CFRAME_TESTS_NUM_FAILED} + 1" )
    set( CFRAME_TESTS_NUM_FAILED ${numFailed} CACHE INTERNAL "" )
    cframe_message(
        MODE NOTICE
        VERBOSITY 2
        TAGS CFrame UnitTest
        MESSAGE "FAILED: ${msg}"
    )
  endif()

endfunction()
