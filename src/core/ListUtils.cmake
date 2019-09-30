# -----------------------------------------------------------------------------
#
# Contains functions for operating on lists
#
# -----------------------------------------------------------------------------

#
#
#
function( cframe_list_equal list1 list2 outVar )

  list( LENGTH ${list1} list1Length )
  list( LENGTH ${list2} list2Length )

  ##message( "cframe_list_equal()" )
  ##message( "  list1: ${${list1}}" )
  ##message( "  list2: ${${list2}}" )
  ##message( "  lengths: ${list1Length} ${list2Length}" )

  # If lengths aren't equal, lists can't be equal
  if ( NOT ${list1Length} EQUAL ${list2Length} )
    set( ${outVar} FALSE PARENT_SCOPE )
    return()
  endif()

  # If lists are both empty, then they are equal
  if ( ${list1Length} EQUAL 0 )
    set( ${outVar} TRUE PARENT_SCOPE )
    return()
  endif()

  # Compare items in each list
  set( ${outVar} TRUE PARENT_SCOPE )
  math( EXPR endIndex "${list1Length} - 1" )
  foreach( index RANGE ${endIndex} )
    list( GET ${list1} ${index} item1 )
    list( GET ${list2} ${index} item2 )
    ##message( "  ${index}: ${item1} ${item2}" )

    if ( NOT "${item1}" STREQUAL "${item2}" )
      set( ${outVar} FALSE PARENT_SCOPE )
      return()
    endif()
  endforeach()

endfunction() # cframe_list_equal

#
#
#
function( cframe_list_intersect list1 list2 outVar )

  ##message( "cframe_list_intersect()" )
  ##message("  list1: [${${list1}}]" )
  ##message("  list2: [${${list2}}]" )

  foreach( item ${${list1}} )
    list( FIND ${list2} ${item} found )
    if ( NOT ${found} EQUAL -1 )
      list( APPEND intersection ${item} )
    endif()
  endforeach()

  set( ${outVar} ${intersection} PARENT_SCOPE )
  ##message( "  ==> outVar: ${${outVar}}" )

endfunction() # cframe_list_intersect

# @brief Checks that any of the values in the items list is in the filter list.
# Will return TRUE in outVar if any of the values in the items list are found in
# the filter list. If either of the lists are empty, the value of emptyReturnVal
# will be used.
#
# @param [in] items A list of items to check if in filter list
# @param [in] filter A list of strings used for filtering
# @param [in] emptyReturnVal The value to return if either the items or filter
#        lists are empty
# @param [out] outVar The variable to place the result in.
function( cframe_filter items filter emptyReturnVal outVar )

  ##message( STATUS "cframe_filter" )
  ##message( STATUS "  Items: ${${items}}" )
  ##message( STATUS "  Filter: ${${filter}}" )
  ##message( STATUS "  EmptyReturnVal: ${emptyReturnVal}" )

  list( LENGTH ${items} itemsLength )
  list( LENGTH ${filter} filterLength )
  ##message( STATUS "  Items Length: ${itemsLength}" )
  ##message( STATUS "  Filter Length: ${filterLength}" )
  if ( ${itemsLength} EQUAL 0 OR
       ${filterLength} EQUAL 0 )
    set( ${outVar} ${emptyReturnVal} PARENT_SCOPE )
    return()
  endif()
  
  set( ${outVar} FALSE PARENT_SCOPE )
  foreach( item ${${items}} )
    ##message( STATUS "    Checking: ${item}" )
    list( FIND ${filter} ${item} found )
    ##message( STATUS "      Found: ${found}" )
    if ( NOT ${found} EQUAL -1 )
      set( ${outVar} TRUE PARENT_SCOPE )
      ##message( STATUS "  OutVar: ${${outVar}}" )
      return()
    endif()
  
  endforeach()

endfunction() # cframe_filter