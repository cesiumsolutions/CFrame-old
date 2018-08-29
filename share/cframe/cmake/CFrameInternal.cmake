# -----------------------------------------------------------------------------
#
# Internal macros used for setting up CFrame
#
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Macro: cframe_prepare_products
#
# Do a first pass through all product directories
# and include their CFrameLists.txt file (if it exists).
#
# The Product's CFrameLists.txt should do the following:
# - specify include_directoriem s for the appropriate product subdirectories
# - specify the name of external package dependencies, and when possible
#   the components of those packages. This can be done using the function:
#
#      cframe_use_external_package( PACKAGE <name> VERSION <version> COMPONENTS <components...> ).
#
#   For example, for Boost:
#
#       cframe_use_external_package(
#           PACKAGE Boost
#           VERSION version
#           COMPONENTS
#               signals
#               system
#               unit_test_framework
#       )
#
#   Each of the lists will be reduced to make sure there are no duplicate entries.
#
# - Each Project should also publish their interfaces in a standard way so that
#   other dependent Projects can refer to then in a standard way. This done by
#   using the function:
#
#       cframe_publish_product( PRODUCT_NAME
#           VERSION      <parts of version identifier: major minor patch build, number of elements is optional>
#           DEFINITIONS  <list of definitions>
#           INCLUDE_DIRS <list of directories to include>
#           LIBRARY_DIRS <list of directories to search for libraries>
#           LIBRARIES    <list of libraries generated>
#       )
#
# Global parameters used:
#     CFRAME_PRODUCTS_DIR
#
# -----------------------------------------------------------------------------
macro( cframe_prepare_products )

  cframe_message( STATUS 3 "CFrame: MACRO: cframe_prepare_products" )

  # Assume all directories under the products directory are products. Make a BUILD option
  # for each of them.
  file( GLOB PRODUCT_DIRS
      LIST_DIRECTORIES TRUE
      RELATIVE ${CFRAME_PRODUCTS_DIR}
      ${CFRAME_PRODUCTS_DIR}/*
  )
  cframe_message( STATUS 4 "CFrame: Product directories: ${PRODUCT_DIRS}")
  foreach( PRODUCT ${PRODUCT_DIRS} )
    if ( (IS_DIRECTORY ${CFRAME_PRODUCTS_DIR}/${PRODUCT}) AND
         (EXISTS ${CFRAME_PRODUCTS_DIR}/${PRODUCT}/CMakeLists.txt) )

      list( APPEND CFRAME_BUILD_PRODUCTS ${PRODUCT} )

      if ( EXISTS ${CFRAME_PRODUCTS_DIR}/${PRODUCT}/CFrameLists.txt )
        option( BUILD_PRODUCT_${PRODUCT} "Build Product ${PRODUCT}" ON )
        set( CFRAME_CURRENT_PRODUCT_DIR ${CFRAME_PRODUCTS_DIR}/${PRODUCT} )
        set( CFRAME_CURRENT_PRODUCT_NAME ${PRODUCT} )
        include( ${CFRAME_PRODUCTS_DIR}/${PRODUCT}/CFrameLists.txt )

        cframe_message( STATUS 4
            "CFrame: ${PRODUCT} version:      ${${PRODUCT}_VERSION}"
        )
        cframe_message( STATUS 4
            "CFrame: ${PRODUCT} definitions:  ${${PRODUCT}_DEFINITIONS}"
        )
        cframe_message( STATUS 4
            "CFrame: ${PRODUCT} include dirs: ${${PRODUCT}_INCLUDE_DIRS}"
        )
        cframe_message( STATUS 4
            "CFrame: ${PRODUCT} library dirs: ${${PRODUCT}_LIBRARY_DIRS}"
        )
        cframe_message( STATUS 4
            "CFrame: ${PRODUCT} libraries:    ${${PRODUCT}_LIBRARIES}"
        )

      else()
        option( BUILD_PRODUCT_${PRODUCT} "Build Package ${PRODUCT}" OFF )
        cframe_message( WARNING 2
            "CFrame: Package: ${PRODUCT} does not contain a CFrameLists.txt."
            "It will be ignored for further processing."
            "See CFrame CMake Modular Framework documentation for further information."
        )
      endif()

      if ( BUILD_PRODUCT_${PRODUCT} MATCHES ON )
        if ( DEFINED ${PRODUCT}_INCLUDE_DIRS )
          cframe_message( STATUS 4 "CFrame: ${PRODUCT}_INCLUDE_DIRS: ${${PRODUCT}_INCLUDE_DIRS}")
          include_directories( ${${PRODUCT}_INCLUDE_DIRS} )
        endif()
      endif()

    else()

      cframe_message( STATUS 2
          "CFrame: Project ${PRODUCT} is not a directory or does not contain a CMakeLists.txt, skipping"
      )

    endif() # is directory and CMakeLists.txt exists
  endforeach() # product subdirectory loop

endmacro() # cframe_prepare_products

# -----------------------------------------------------------------------------
# Macro: cframe_setup_external_packages
#
# Go through each of the external dependencies listed by the packages
# and either call the Setup${EXT_DEP}.cmake or do a standard setup.
#
# -----------------------------------------------------------------------------
macro( cframe_setup_external_packages )

  cframe_message( STATUS 3 "CFrame: MACRO: cframe_external_package_setup" )

  foreach( XPACKAGE ${CFRAME_EXTERNAL_PACKAGES} )
    cframe_message( STATUS 2
        "CFrame: Setting up external package: ${XPACKAGE} with components: ${CFRAME_EXTERNAL_${XPACKAGE}_COMPONENTS}"
    )

    if ( EXISTS ${${PROJECT_NAME}_SOURCE_DIR}/share/${PROJECT_NAME}/cmake/Setup${XPACKAGE}.cmake )
      cframe_message( STATUS 3 "CFrame: Using share/${PROJECT_NAME}/cmake/Setup${XPACKAGE}.cmake" )
      include( ${${PROJECT_NAME}_SOURCE_DIR}/share/${PROJECT_NAME}/cmake/Setup${XPACKAGE}.cmake )
    else()
      cframe_message( STATUS 3 "CFrame: Using standard external setup for package: ${XPACKAGE}" )
      cframe_setup_external_package( ${XPACKAGE} "${CFRAME_EXTERNAL_${XPACKAGE}_COMPONENTS}" )
    endif()
  endforeach()

endmacro() # cframe_setup_external_packages

# -----------------------------------------------------------------------------
# Macro: cframe_build_products
#
# Now go through each of the product directories again and add their
# subdirectories. The CFRAME_BUILD variable will be set to true so that each
# product can either build using CFrame conventions or their own conventions.
#
# For example, in the root CMakeLists.txt of the product, the following check
# can be made:
#
#   if ( ${CFRAME_BUILD} )
#     include( CFrameBuild.cmake )
#   else()
#     .. do standard internal build
#   endif()
#
# -----------------------------------------------------------------------------
macro( cframe_build_products )

  cframe_message( STATUS 3 "CFrame: MACRO: cframe_build_products" )
  cframe_message( STATUS 4 "CFrame: Products: ${CFRAME_BUILD_PRODUCTS}")

  set( CFRAME_BUILD TRUE )
  foreach( PRODUCT ${CFRAME_BUILD_PRODUCTS} )
    if ( BUILD_PRODUCT_${PRODUCT} MATCHES ON )
      # @todo Find a better way to determine if CMAKE_PRODUCTS_DIR is outside
      # of CFrame's source directory
      if ( IS_ABSOLUTE ${CFRAME_PRODUCTS_DIR} )
        add_subdirectory( ${CFRAME_PRODUCTS_DIR}/${PRODUCT} ${PRODUCT} )
      else()
        add_subdirectory( ${CFRAME_PRODUCTS_DIR}/${PRODUCT} )
      endif()
    endif()
  endforeach()
  set( CFRAME_BUILD FALSE )

endmacro() # cframe_build_products

# -----------------------------------------------------------------------------
# Macro: cframe_main
#
# Main body of CFrame root CMakeLists.txt
# -----------------------------------------------------------------------------
macro( cframe_main )

  cframe_message( STATUS 3 "CFrame: MACRO: cframe_main" )

  cframe_prepare_products()

  cframe_setup_external_packages()

  cframe_build_products()

endmacro() # cframe_prepare