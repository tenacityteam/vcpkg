vcpkg_fail_port_install(ON_TARGET "UWP")

vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com
    REPO Be_/soundtouch
    REF 3617bd166b7ed3f3a94b30f7412f79c9ad792cf9
    SHA512 c0d8cf9c4d372746ed8709385df48418380e58585caace03f7c8a1a9d11381d3df98b433416427fb48a7b204ee3cde5f1970ad1a165bb64277db7287eed8b1ac
    OUT_SOURCE_PATH SOURCE_PATH
)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/SoundTouch)
vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL ${SOURCE_PATH}/COPYING.TXT DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
