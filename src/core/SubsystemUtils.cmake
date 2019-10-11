# ------------------------------------------------------------------------------
# @brief Includes the files for a subsystem corresponding to a specific stage.
#
# During CFrame processing, stages are different steps of processing that can
# be called on a subsystem. These stages are typically triggered by a high level
# call from a user. For example, the following stages are typically used:
#
# - Initialize:  Called on initial loading of the CFrame system.
# - Preprocess:  Called when the cframe_preprocess() function is called.
# - Process:     Called when the cframe_process() function is called.
# - Postprocess: Called when the cframe_postprocess() function is called.
# - tests:       Called if CFRAME_UNIT_TEST is ON.
#
# Subsystems can provide "hooks" into each of these stages by adding a file
# called ${stage}.cmake in their corresponding directory, in which case this
# file will be included, or by adding a subdirectory called ${stage} in their
# directory in which case all of the files in that subdirectory will be included.
# ------------------------------------------------------------------------------
function( cframe_subsystem_stage name dir stage )

  cframe_message(
      MODE STATUS
      VERBOSITY 3
      TAGS CFrame
      MESSAGE "Subsystem: ${name} executing stage: ${stage} in dir: ${dir}"
  )

  # If there is a file in the subsystem's directory named ${stage}.cmake, just
  # include that file.
  if ( EXISTS ${dir}/${stage}.cmake )
    include( ${dir}/${stage}.cmake )
    return()
  endif()

  # If there is a subdirectory in the subsystem's directory named ${stage},
  # include all of the files in that subdirectory.
  if ( IS_DIRECTORY ${dir}/${stage} )
    file(
        GLOB entries
        ${dir}/${stage}/*
    )
    foreach( entry ${entries} )
      if ( NOT IS_DIRECTORY ${entry} )
        include( ${entry} )
      endif()
    endforeach()
  endif()

endfunction() # cframe_exec_stage
