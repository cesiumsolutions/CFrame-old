cmake_minimum_required(VERSION 3.0)
project(cframe)

set( CMAKE_MODULE_PATH
    ${${PROJECT_NAME}_SOURCE_DIR}/share/${PROJECT_NAME}/cmake
)

include( CFrameInitialize )
add_subdirectory( testtools )

cframe_main()

add_subdirectory( docs )
add_subdirectory( share )
