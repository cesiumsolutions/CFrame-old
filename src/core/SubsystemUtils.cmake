

#
#
#
function( cframe_subsystem_initialize name dir )

  cframe_message(
      MODE STATUS
      VERBOSITY 3
      TAGS CFrame
      MESSAGE "Initializing Subsystem: ${name}"
  )


  # Include all files in this directory (excluding directories and this file)
  file(
      GLOB entries
      ${dir}/*
  )
  foreach( entry ${entries} )
    if ( NOT IS_DIRECTORY ${entry} )
      include( ${entry} )
    endif()
  endforeach()

  if ( ${CFRAME_UNIT_TEST} )
    file(
        GLOB tests
        ${dir}/tests/*.cmake
    )
    list( LENGTH tests numTests )
    if ( ${numTests} GREATER 0 )
      cframe_start_internal_tests()
      foreach( test ${tests} )
        include( ${test} )
      endforeach()
      cframe_finish_internal_tests()
    endif()
  endif()

endfunction() # cframe_subsystem_initialize