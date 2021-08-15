vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tenacityteam/libid3tag
    REF 0.16.1
    SHA512 621cbdf7a0ea5cdca6a9133c88fb07ff0c519ed73bc26a535de3928f4784b912bb44315b45362600d53cd03083b66f38d674d1880ca30e5f6c342321977a6eb2
    HEAD_REF main
)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/id3tag)
vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
