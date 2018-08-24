set( CATCH_HEADER
    ${CMAKE_CURRENT_SOURCE_DIR}/catch.hpp
    CACHE INTERNAL "Location of catch header."
)

set( CATCH_MAIN_SOURCE
    ${CMAKE_CURRENT_SOURCE_DIR}/catchmain.cpp
    CACHE INTERNAL "Location of catch main source."
)

cframe_message( STATUS 3 "CFrame: CATCH_HEADER      = ${CATCH_HEADER}" )
cframe_message( STATUS 3 "CFrame: CATCH_MAIN_SOURCE = ${CATCH_MAIN_SOURCE}" )
