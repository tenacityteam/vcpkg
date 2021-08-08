vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Be-ing/libsbsms
    REF 626382565f2794afc782058f42b0bf250a8b2e56
    SHA512 0ed4457a93d389cd72e283ff60938d6ae8f952c9c2b1fc1769f06e10bdd7947f3eeb6deefd655237ac3620cb5a411acc6ca4924c8b2bc293706aff9bfd30a72f
    HEAD_REF main
)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/sbsms" PACKAGE_NAME sbsms)
vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
