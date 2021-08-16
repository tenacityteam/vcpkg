vcpkg_fail_port_install(ON_TARGET "UWP")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Be-ing/twolame
    REF 714033cc1548d5022f7fa2bbbc23691bf618481e
    SHA512 7a08a4a7f1c07d060b6c3cfb3f96118cb2b45a2fa1cea796c3516bd474e3fc93c0415003958430a3825a9bb249000281a51450a01272d72c2072f4d63eb09f77
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
    executable EXECUTABLE
)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS ${FEATURE_OPTIONS}
)
vcpkg_cmake_install()

if(EXECUTABLE)
  vcpkg_copy_tools(twolame)
endif()

vcpkg_cmake_config_fixup(PACKAGE_NAME libtwolame CONFIG_PATH lib/cmake/libtwolame)
vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
