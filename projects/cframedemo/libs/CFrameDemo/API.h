#pragma once

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @file API.h
 * @brief Linkage definitions for CFrame Demo libraries API
 */

/* Definitions for exporting or importing the CFrame Demo Libraries API */
#if defined(_MSC_VER) || defined(__CYGWIN__) || defined(__MINGW32__) || defined( __BCPLUSPLUS__)  || defined( __MWERKS__)
#  if defined cframedemo_STATIC
#    define CFRAMEDEMO_API
#  elif defined cframedemo_EXPORTS
#    define CFRAMEDEMO_API __declspec( dllexport )
#  else
#    define CFRAMEDEMO_API __declspec( dllimport )
#  endif
#else
#  define CFRAMEDEMO_API
#endif

#ifdef __cplusplus
} /* extern "C" */
#endif
