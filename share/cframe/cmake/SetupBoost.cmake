# -----------------------------------------------------------------------------
#
# Boost specialized setup
#
# -----------------------------------------------------------------------------

find_package( Boost REQUIRED
    ${SACCADES_EXTERNAL_Boost_COMPONENTS}
)
add_definitions( -DBOOST_ALL_DYN_LINK )
include_directories( ${Boost_INCLUDE_DIR} )
link_directories( ${Boost_LIBRARY_DIRS} )
