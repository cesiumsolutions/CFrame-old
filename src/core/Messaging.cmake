# -----------------------------------------------------------------------------
#
# Enhanced message functions and variables
#
# -----------------------------------------------------------------------------

set( CFRAME_MESSAGE_MODE_FILTER ""
    CACHE STRING
    "List of Modes to allow to be displayed. If empty, all Message Modes are displayed"
)
set( CFRAME_MESSAGE_DEFAULT_MODE NOTICE
    CACHE STRING
    "Default Mode of cframe_messages if no MODE parameter is specified"
)

# The Verbosity level used by cframe_message to compare with an incoming message's
# verbosity level to determine if it is displayed.
# Verbosity Levels:
# - 0: No messages
# - 1: Essential messages
# - 2: More informational messages
# - 3: Debug messages
# - 4: Low level debug messages
set( CFRAME_MESSAGE_VERBOSITY_LEVEL 2
    CACHE STRING
    "Verbosity level for CFrame messages: 0=off, 1=essential, higher=more"
)
set( CFRAME_MESSAGE_DEFAULT_VERBOSITY 2
    CACHE STRING
    "Default Verbosity level for cframe_messages where VERBOSITY parameter is not specified"
)

set( CFRAME_MESSAGE_TAGS_FILTER ""
    CACHE STRING
    "A list of free-form labels to associate with the messages"
)
set( CFRAME_MESSAGE_DEFAULT_TAGS ""
    CACHE STRING
    "Default tags associated with cframe_messages where TAGS parameter is not specified"
)

# -----------------------------------------------------------------------------
# Determines if a message would display or not given the parameters and filters.
# @param MODE The message Mode, @see CMake message
# @param VERBOSITY The verbosity associated with the messages
# @param TAGS A list of freeform text associated with the message, used for filtering.
# @param The message
# -----------------------------------------------------------------------------
function( cframe_would_message mode verbosity tags outVar )

  ##message( STATUS
  ##    "cframe_would_message()\n"
  ##    "  mode: ${mode}\n"
  ##    "  verbosity: ${verbosity}\n"
  ##    "  tags: ${tags}\n"
  ##)

  set( ${outVar} TRUE PARENT_SCOPE )

  # Filter on the Verbosity (first, as this is the fastest)
  if ( ${verbosity} GREATER ${CFRAME_MESSAGE_VERBOSITY_LEVEL} )
    set( ${outVar} FALSE PARENT_SCOPE )
    return()
  endif()

  # Filter on the Mode
  cframe_filter( mode CFRAME_MESSAGE_MODE_FILTER TRUE modeFilter )
  if ( ${modeFilter} STREQUAL FALSE )
    set( ${outVar} FALSE PARENT_SCOPE )
    return()
  endif()

  # Filter on the Tags list
  cframe_filter( tags CFRAME_MESSAGE_TAGS_FILTER TRUE tagFilter )
  ##message( DEBUG "tagFilter = ${tagFilter}" )
  set( ${outVar} ${tagFilter} PARENT_SCOPE )

endfunction() # cframe_would_message

# -----------------------------------------------------------------------------
# Message wrapper which checks verbosity level, modes, and labels to enable
# more control over filtering of messages to display.
# @param MODE The message Mode, @see CMake message
# @param VERBOSITY The verbosity associated with the messages
# @param TAGS A list of freeform text associated with the message, used for filtering.
# @param MESSAGE The message
# -----------------------------------------------------------------------------
function( cframe_message )
  
  # Assign default values to parameters
  set( mode      ${CFRAME_MESSAGE_DEFAULT_MODE} )
  set( verbosity ${CFRAME_MESSAGE_DEFAULT_VERBOSITY} )
  set( tags      ${CFRAME_MESSAGE_DEFAULT_TAGS} )

  # Set up and parse multiple arguments
  set( options
  )
  set( oneValueArgs
      MODE
      VERBOSITY
  )
  set( multiValueArgs
      TAGS
      MESSAGE
  )

  cmake_parse_arguments(
      cframe_message
      "${options}"
      "${oneValueArgs}"
      "${multiValueArgs}"
      ${ARGN}
  )
  
  if ( DEFINED cframe_message_MODE )
    set( mode ${cframe_message_MODE} )
  else ()
    set( mode ${CFRAME_MESSAGE_DEFAULT_MODE} )
  endif()
  if ( DEFINED cframe_message_VERBOSITY )
    set( verbosity ${cframe_message_VERBOSITY} )
  else ()
    set( verbosity ${CFRAME_MESSAGE_DEFAULT_VERBOSITY} )
  endif()
  if ( DEFINED cframe_message_TAGS )
    set( tags ${cframe_message_TAGS} )
  else ()
    set( tags ${CFRAME_MESSAGE_DEFAULT_TAGS} )
  endif()
  
  # NOTICE is only supported from CMake version 3.15
  set( displayMode ${mode} )
  if ( ${CMAKE_VERSION} VERSION_LESS "3.15.0" AND
       ${mode} STREQUAL NOTICE )
    set( mode "" )
  endif()

  ##message( STATUS "Mode: ${mode}" )
  ##message( STATUS "Verbosity: ${verbosity}" )
  ##message( STATUS "Tags: ${tags}" )
  ##message( STATUS "Message: ${cframe_message_MESSAGE}" )

  # Check filter
  cframe_would_message( "${mode}" "${verbosity}" "${tags}" wouldMessage )
  if ( ${wouldMessage} STREQUAL FALSE )
    return()
  endif()

  # Prepend message with Tag(s)
  string( REPLACE ";" "/" prefix "${tags}" )
  string( REPLACE ";" "" msg "${cframe_message_MESSAGE}" )
  
  # Display message
  message( ${mode} "${prefix}[${displayMode},${verbosity}]: ${msg}" )

endfunction() # cframe_message