# CFrame: User's Manual
-----------------------
This document describes the process for integrating disparate/separate software
projects that use the CMake build system.

## Administrative Stuff

### Revision Log
| Version | Date | Description |
| :---: |:---:| --- |
| 0.1 | 2018/08/18 | Initial release. |

### License Summary

### Prerequisites
This document assumes the reader knows how to develop their own software and how to
setup CMake to build their software. The framework tries to be as minimally intrusive
as possible and strives to use standard CMake conventions.

### Resources
CMake can be downloaded from [here](http://www.cmake.org/download).

Saccades information can be found [here](http://www.cesiumsolutions.com/saccades).

Cesium Solutions general information can be found [here](http://www.cesiumsolutions.com).

## Motivation

## General Process

## End User Instructions

## Software Module Instructions

## Framework Internals

## Appendices

### License

### Roadmap/TODOs

* Handling of project subdirectories
    * Define ```CFRAME_SETUP_PROJECT_SUBDIR``` or something like that
    * For the top level:
        * ```CFRAME_SET_PROJECT_SUBDIRS``` which includes each SUBDIR/SUBDIR.cmake
    * Defines:
        * ```CFRAME_SUBDIRS_HEADERS_PUBLIC```
        * ```CFRAME_SUBDIRS_HEADERS_PRIVATE```
        * ```CFRAME_SUBDIRS_SOURCES```

* Automate and standardize (unit) testing configuration
    * Catch
    * GoogleTest
    * Boost.unit_test

* Handling of external packages
    * Define a ```CFRAME_EXTERNALS_POLICY``` which can take one of the following:
        * Manual: all externals must be specified explicitly, maybe using
          a ```CFRAME_EXTERNALS_DIR``` as the base
        * Conan: Use the conan package manager

* Standard way for handling platform/compiler dependencies
    * Define canonical form for platform identification so can be used for
      example as directory names

      For example: win64-vc14, ubuntu16.04-64, or something like that. This could
      be used to automatically specify externals directory for Manual
      ```CFRAME_EXTERNALS_POLICY``` and for build directory specification.

* Add Platform specific variables, for example:
    * ```CFRAME_OS_LIBRARIES```
    * ```CFRAME_LOADER_LIBRARIES```

* Add support for automatic versioning
    * Specify ```CFRAME_VERSION_TECHNIQUE```
    * Provide a standard CFrame implementation of versioning (similar to OpenIGS's Version)
    * cframe_build_target function accepts VERSION specification

* Handle projects scattered in file system, not just as children of one directory
    * Read project names and locations from a file specified by
      ```CFRAME_PROJECTS_FILE```

* Use source file filter
