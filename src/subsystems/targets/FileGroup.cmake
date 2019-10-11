# ------------------------------------------------------------------------------
# @brief Logically groups a list of files together
# @ingroup targets
#
# Single valued arguments:
# @param [in] GROUPNAME:    The name of the group to assign to the files. In some
#                           IDEs (e.g. Visual Studio), the files will be shown in
#                           an organizational folder.
# @param [out] OUTVAR:      The name of the variable to assign the filename list to.
# @param [in] VERBOSITY:    The verbosity level to use for any messages (default: 1)
#
# Multi-valued arguments:
# @param [in] FILES:        The list of files to group together
# @param [in] PROPERTIES:   A list of properties to assign to the files.
# @param [in] INSTALL_DIRS: The directory(ies) to install the files to. If not
#                           specified, the files will not be installed (at least
#                           not using this function).
#
# Example:
# @code
# cframe_file_group(
#     GROUPNAME Data
#     OUTVAR    DATA_FILES
#     FILES
#         widgets.dat
#         gadgets.dat
#         thingamajigs.dat
#         shims.txt
#         shams.csv
#     INSTALL_DIRS
#         projects/data
# )
# @endcode
# ------------------------------------------------------------------------------
function( cframe_file_group )

  set( verbosity 1 )

  set( options )
  set( oneValueArgs
      GROUPNAME
      OUTVAR
      VERBOSITY
  )
  set( multiValueArgs
      FILES
      PROPERTIES
      INSTALL_DIRS
  )

  cmake_parse_arguments(
      cframe_file_group
      "${options}"
      "${oneValueArgs}"
      "${multiValueArgs}"
      ${ARGN}
  )

  if ( DEFINED cframe_file_group_VERBOSITY )
    set( verbosity ${cframe_file_group_VERBOSITY} )
  endif()
 
  list( LENGTH cframe_file_group_FILES numFiles )
  if ( ${numFiles} LESS 0 )
    cframe_message(
        MODE FATAL_ERROR
        TAGS CFrame Targets
        VERBOSITY ${verbosity}
        MESSAGE "cframe_file_group() FILES not specified or empty, aborting"
    )
  endif()

  if ( DEFINED cframe_file_group_GROUPNAME )
    source_group(
        ${cframe_file_group_GROUPNAME}
        FILES ${cframe_file_group_FILES}
    )
  endif()

  if ( DEFINED cframe_file_group_OUTVAR )
    set( ${cframe_file_group_OUTVAR} ${cframe_file_group_FILES} PARENT_SCOPE )
  endif()
 
  if ( DEFINED cframe_file_group_PROPERTIES )
    set_source_files_properties(
        ${cframe_file_group_FILES}
        PROPERTIES
            ${cframe_file_group_PROPERTIES}
    )
  endif()

  if ( DEFINED cframe_file_group_INSTALL_DIRS )
    foreach( installDir ${cframe_file_group_INSTALL_DIRS} )
      install(
          FILES ${cframe_file_group_FILES}
          DESTINATION ${installDir}
      )
    endforeach()
  endif()

endfunction() # cframe_file_group