cmake_minimum_required(VERSION 3.0)
project(cframetestproject)

# CFrame setup and initialization
set( CFRAME_DIR "" CACHE PATH "Directory containing CFrame distribution" )
set( CMAKE_MODULE_PATH ${CFRAME_DIR} )
include( CFrame )
cframe_initialize()
cframe_preprocess()

add_subdirectory( docs )
add_subdirectory( share )

cframe_process()
cframe_postprocess()
