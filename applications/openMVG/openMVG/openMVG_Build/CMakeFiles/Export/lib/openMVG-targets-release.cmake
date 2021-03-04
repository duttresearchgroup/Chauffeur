#----------------------------------------------------------------
# Generated CMake target import file for configuration "RELEASE".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "lib_CoinUtils" for configuration "RELEASE"
set_property(TARGET lib_CoinUtils APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(lib_CoinUtils PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/liblib_CoinUtils.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS lib_CoinUtils )
list(APPEND _IMPORT_CHECK_FILES_FOR_lib_CoinUtils "${_IMPORT_PREFIX}/lib/liblib_CoinUtils.a" )

# Import target "lib_Osi" for configuration "RELEASE"
set_property(TARGET lib_Osi APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(lib_Osi PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/liblib_Osi.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS lib_Osi )
list(APPEND _IMPORT_CHECK_FILES_FOR_lib_Osi "${_IMPORT_PREFIX}/lib/liblib_Osi.a" )

# Import target "lib_clp" for configuration "RELEASE"
set_property(TARGET lib_clp APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(lib_clp PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/liblib_clp.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS lib_clp )
list(APPEND _IMPORT_CHECK_FILES_FOR_lib_clp "${_IMPORT_PREFIX}/lib/liblib_clp.a" )

# Import target "lib_OsiClpSolver" for configuration "RELEASE"
set_property(TARGET lib_OsiClpSolver APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(lib_OsiClpSolver PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/liblib_OsiClpSolver.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS lib_OsiClpSolver )
list(APPEND _IMPORT_CHECK_FILES_FOR_lib_OsiClpSolver "${_IMPORT_PREFIX}/lib/liblib_OsiClpSolver.a" )

# Import target "openMVG_stlplus" for configuration "RELEASE"
set_property(TARGET openMVG_stlplus APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_stlplus PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_stlplus.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_stlplus )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_stlplus "${_IMPORT_PREFIX}/lib/libopenMVG_stlplus.a" )

# Import target "openMVG_lemon" for configuration "RELEASE"
set_property(TARGET openMVG_lemon APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_lemon PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_lemon.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_lemon )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_lemon "${_IMPORT_PREFIX}/lib/libopenMVG_lemon.a" )

# Import target "openMVG_cxsparse" for configuration "RELEASE"
set_property(TARGET openMVG_cxsparse APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_cxsparse PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_cxsparse.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_cxsparse )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_cxsparse "${_IMPORT_PREFIX}/lib/libopenMVG_cxsparse.a" )

# Import target "openMVG_ceres" for configuration "RELEASE"
set_property(TARGET openMVG_ceres APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_ceres PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "openMVG_cxsparse;/usr/lib/aarch64-linux-gnu/liblapack.so;/usr/lib/aarch64-linux-gnu/libf77blas.so;/usr/lib/aarch64-linux-gnu/libatlas.so;/usr/lib/aarch64-linux-gnu/libf77blas.so;/usr/lib/aarch64-linux-gnu/libatlas.so;gomp;-pthread"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_ceres.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_ceres )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_ceres "${_IMPORT_PREFIX}/lib/libopenMVG_ceres.a" )

# Import target "openMVG_easyexif" for configuration "RELEASE"
set_property(TARGET openMVG_easyexif APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_easyexif PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_easyexif.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_easyexif )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_easyexif "${_IMPORT_PREFIX}/lib/libopenMVG_easyexif.a" )

# Import target "openMVG_fast" for configuration "RELEASE"
set_property(TARGET openMVG_fast APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_fast PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_fast.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_fast )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_fast "${_IMPORT_PREFIX}/lib/libopenMVG_fast.a" )

# Import target "openMVG_exif" for configuration "RELEASE"
set_property(TARGET openMVG_exif APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_exif PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_exif.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_exif )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_exif "${_IMPORT_PREFIX}/lib/libopenMVG_exif.a" )

# Import target "openMVG_features" for configuration "RELEASE"
set_property(TARGET openMVG_features APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_features PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_features.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_features )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_features "${_IMPORT_PREFIX}/lib/libopenMVG_features.a" )

# Import target "openMVG_image" for configuration "RELEASE"
set_property(TARGET openMVG_image APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_image PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_image.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_image )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_image "${_IMPORT_PREFIX}/lib/libopenMVG_image.a" )

# Import target "openMVG_linearProgramming" for configuration "RELEASE"
set_property(TARGET openMVG_linearProgramming APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_linearProgramming PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_linearProgramming.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_linearProgramming )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_linearProgramming "${_IMPORT_PREFIX}/lib/libopenMVG_linearProgramming.a" )

# Import target "openMVG_lInftyComputerVision" for configuration "RELEASE"
set_property(TARGET openMVG_lInftyComputerVision APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_lInftyComputerVision PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_lInftyComputerVision.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_lInftyComputerVision )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_lInftyComputerVision "${_IMPORT_PREFIX}/lib/libopenMVG_lInftyComputerVision.a" )

# Import target "openMVG_geometry" for configuration "RELEASE"
set_property(TARGET openMVG_geometry APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_geometry PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_geometry.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_geometry )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_geometry "${_IMPORT_PREFIX}/lib/libopenMVG_geometry.a" )

# Import target "openMVG_matching" for configuration "RELEASE"
set_property(TARGET openMVG_matching APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_matching PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_matching.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_matching )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_matching "${_IMPORT_PREFIX}/lib/libopenMVG_matching.a" )

# Import target "openMVG_kvld" for configuration "RELEASE"
set_property(TARGET openMVG_kvld APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_kvld PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_kvld.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_kvld )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_kvld "${_IMPORT_PREFIX}/lib/libopenMVG_kvld.a" )

# Import target "openMVG_matching_image_collection" for configuration "RELEASE"
set_property(TARGET openMVG_matching_image_collection APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_matching_image_collection PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_matching_image_collection.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_matching_image_collection )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_matching_image_collection "${_IMPORT_PREFIX}/lib/libopenMVG_matching_image_collection.a" )

# Import target "openMVG_multiview" for configuration "RELEASE"
set_property(TARGET openMVG_multiview APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_multiview PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_multiview.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_multiview )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_multiview "${_IMPORT_PREFIX}/lib/libopenMVG_multiview.a" )

# Import target "openMVG_numeric" for configuration "RELEASE"
set_property(TARGET openMVG_numeric APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_numeric PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_numeric.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_numeric )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_numeric "${_IMPORT_PREFIX}/lib/libopenMVG_numeric.a" )

# Import target "openMVG_robust_estimation" for configuration "RELEASE"
set_property(TARGET openMVG_robust_estimation APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_robust_estimation PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_robust_estimation.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_robust_estimation )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_robust_estimation "${_IMPORT_PREFIX}/lib/libopenMVG_robust_estimation.a" )

# Import target "openMVG_system" for configuration "RELEASE"
set_property(TARGET openMVG_system APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_system PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_system.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_system )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_system "${_IMPORT_PREFIX}/lib/libopenMVG_system.a" )

# Import target "openMVG_sfm" for configuration "RELEASE"
set_property(TARGET openMVG_sfm APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(openMVG_sfm PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_sfm.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openMVG_sfm )
list(APPEND _IMPORT_CHECK_FILES_FOR_openMVG_sfm "${_IMPORT_PREFIX}/lib/libopenMVG_sfm.a" )

# Import target "vlsift" for configuration "RELEASE"
set_property(TARGET vlsift APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(vlsift PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libvlsift.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS vlsift )
list(APPEND _IMPORT_CHECK_FILES_FOR_vlsift "${_IMPORT_PREFIX}/lib/libvlsift.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
