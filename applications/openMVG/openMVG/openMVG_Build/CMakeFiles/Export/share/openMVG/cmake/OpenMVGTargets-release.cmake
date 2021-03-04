#----------------------------------------------------------------
# Generated CMake target import file for configuration "RELEASE".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "OpenMVG::lib_CoinUtils" for configuration "RELEASE"
set_property(TARGET OpenMVG::lib_CoinUtils APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::lib_CoinUtils PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/liblib_CoinUtils.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::lib_CoinUtils )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::lib_CoinUtils "${_IMPORT_PREFIX}/lib/liblib_CoinUtils.a" )

# Import target "OpenMVG::lib_Osi" for configuration "RELEASE"
set_property(TARGET OpenMVG::lib_Osi APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::lib_Osi PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/liblib_Osi.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::lib_Osi )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::lib_Osi "${_IMPORT_PREFIX}/lib/liblib_Osi.a" )

# Import target "OpenMVG::lib_clp" for configuration "RELEASE"
set_property(TARGET OpenMVG::lib_clp APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::lib_clp PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/liblib_clp.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::lib_clp )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::lib_clp "${_IMPORT_PREFIX}/lib/liblib_clp.a" )

# Import target "OpenMVG::lib_OsiClpSolver" for configuration "RELEASE"
set_property(TARGET OpenMVG::lib_OsiClpSolver APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::lib_OsiClpSolver PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/liblib_OsiClpSolver.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::lib_OsiClpSolver )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::lib_OsiClpSolver "${_IMPORT_PREFIX}/lib/liblib_OsiClpSolver.a" )

# Import target "OpenMVG::openMVG_stlplus" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_stlplus APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_stlplus PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_stlplus.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_stlplus )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_stlplus "${_IMPORT_PREFIX}/lib/libopenMVG_stlplus.a" )

# Import target "OpenMVG::openMVG_lemon" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_lemon APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_lemon PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_lemon.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_lemon )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_lemon "${_IMPORT_PREFIX}/lib/libopenMVG_lemon.a" )

# Import target "OpenMVG::openMVG_cxsparse" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_cxsparse APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_cxsparse PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_cxsparse.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_cxsparse )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_cxsparse "${_IMPORT_PREFIX}/lib/libopenMVG_cxsparse.a" )

# Import target "OpenMVG::openMVG_ceres" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_ceres APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_ceres PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "OpenMVG::openMVG_cxsparse;/usr/lib/aarch64-linux-gnu/liblapack.so;/usr/lib/aarch64-linux-gnu/libf77blas.so;/usr/lib/aarch64-linux-gnu/libatlas.so;/usr/lib/aarch64-linux-gnu/libf77blas.so;/usr/lib/aarch64-linux-gnu/libatlas.so;gomp;-pthread"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_ceres.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_ceres )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_ceres "${_IMPORT_PREFIX}/lib/libopenMVG_ceres.a" )

# Import target "OpenMVG::openMVG_easyexif" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_easyexif APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_easyexif PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_easyexif.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_easyexif )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_easyexif "${_IMPORT_PREFIX}/lib/libopenMVG_easyexif.a" )

# Import target "OpenMVG::openMVG_fast" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_fast APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_fast PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_fast.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_fast )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_fast "${_IMPORT_PREFIX}/lib/libopenMVG_fast.a" )

# Import target "OpenMVG::openMVG_exif" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_exif APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_exif PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_exif.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_exif )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_exif "${_IMPORT_PREFIX}/lib/libopenMVG_exif.a" )

# Import target "OpenMVG::openMVG_features" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_features APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_features PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_features.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_features )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_features "${_IMPORT_PREFIX}/lib/libopenMVG_features.a" )

# Import target "OpenMVG::openMVG_image" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_image APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_image PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_image.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_image )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_image "${_IMPORT_PREFIX}/lib/libopenMVG_image.a" )

# Import target "OpenMVG::openMVG_linearProgramming" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_linearProgramming APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_linearProgramming PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_linearProgramming.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_linearProgramming )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_linearProgramming "${_IMPORT_PREFIX}/lib/libopenMVG_linearProgramming.a" )

# Import target "OpenMVG::openMVG_lInftyComputerVision" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_lInftyComputerVision APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_lInftyComputerVision PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_lInftyComputerVision.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_lInftyComputerVision )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_lInftyComputerVision "${_IMPORT_PREFIX}/lib/libopenMVG_lInftyComputerVision.a" )

# Import target "OpenMVG::openMVG_geometry" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_geometry APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_geometry PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_geometry.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_geometry )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_geometry "${_IMPORT_PREFIX}/lib/libopenMVG_geometry.a" )

# Import target "OpenMVG::openMVG_matching" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_matching APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_matching PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_matching.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_matching )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_matching "${_IMPORT_PREFIX}/lib/libopenMVG_matching.a" )

# Import target "OpenMVG::openMVG_kvld" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_kvld APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_kvld PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_kvld.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_kvld )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_kvld "${_IMPORT_PREFIX}/lib/libopenMVG_kvld.a" )

# Import target "OpenMVG::openMVG_matching_image_collection" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_matching_image_collection APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_matching_image_collection PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_matching_image_collection.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_matching_image_collection )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_matching_image_collection "${_IMPORT_PREFIX}/lib/libopenMVG_matching_image_collection.a" )

# Import target "OpenMVG::openMVG_multiview" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_multiview APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_multiview PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_multiview.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_multiview )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_multiview "${_IMPORT_PREFIX}/lib/libopenMVG_multiview.a" )

# Import target "OpenMVG::openMVG_numeric" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_numeric APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_numeric PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_numeric.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_numeric )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_numeric "${_IMPORT_PREFIX}/lib/libopenMVG_numeric.a" )

# Import target "OpenMVG::openMVG_robust_estimation" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_robust_estimation APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_robust_estimation PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_robust_estimation.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_robust_estimation )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_robust_estimation "${_IMPORT_PREFIX}/lib/libopenMVG_robust_estimation.a" )

# Import target "OpenMVG::openMVG_system" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_system APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_system PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_system.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_system )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_system "${_IMPORT_PREFIX}/lib/libopenMVG_system.a" )

# Import target "OpenMVG::openMVG_sfm" for configuration "RELEASE"
set_property(TARGET OpenMVG::openMVG_sfm APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::openMVG_sfm PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libopenMVG_sfm.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::openMVG_sfm )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::openMVG_sfm "${_IMPORT_PREFIX}/lib/libopenMVG_sfm.a" )

# Import target "OpenMVG::vlsift" for configuration "RELEASE"
set_property(TARGET OpenMVG::vlsift APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenMVG::vlsift PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libvlsift.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenMVG::vlsift )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenMVG::vlsift "${_IMPORT_PREFIX}/lib/libvlsift.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
