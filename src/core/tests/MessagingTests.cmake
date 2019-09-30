# -----------------------------------------------------------------------------
#
# Unit Tests for the Messaging functions
#
# -----------------------------------------------------------------------------

# cframe_message Unit Tests
if ( ${CFRAME_UNIT_TEST} )

  # cframe_message tests
  cframe_message(
      MODE STATUS
      VERBOSITY 1
      TAGS CFrame UnitTest
      MESSAGE "Executing cframe_message() unit tests"
  )

  
endif()