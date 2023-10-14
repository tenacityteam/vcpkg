vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO claytonotey/libsbsms
    REF e6c9c3b5460f6886305c659de6b25b763f54738b
    SHA512 473f17a8c0bcf67f7d3273de553bbd428ba24994975ee26b378aab0ae53ae82fcc89ed740fcd5aa31bcf3d1b227723f1f122817b1515922281b64287010f039a
    HEAD_REF main
)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/sbsms" PACKAGE_NAME sbsms)
vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
