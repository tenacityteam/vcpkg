vcpkg_fail_port_install(ON_TARGET "uwp")
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Be-ing/portaudio
    REF 0bbd49c1fc1861ad8a4b072b261b1856dd9d7c00
    SHA512 cc568e15b7f1c5380670ca8dfa81532608530e678e93069251cc9fd76b5d4568e5a3fbc2c558f560053bae28a978374c5bf39ad9882d7c24a707272e70209eb6
    HEAD_REF cmake_rewrite
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS_DEBUG
        -DDEBUG_OUTPUT:BOOL=ON
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT})
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
