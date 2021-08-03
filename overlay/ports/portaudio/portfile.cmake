vcpkg_fail_port_install(ON_TARGET "uwp")
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Be-ing/portaudio
    REF d3edb9f52a9fe87bff06fd6c94f61496e0554718
    SHA512 3a696dd30e8ce65f89ef896ddfde8989771cc70be5ea82bd2dd088d86b4a91e9d7db8ef454e922ed4b2af2db54871928b833395eaa83c5c4db42120caf32cf65
    HEAD_REF cmake_rewrite
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS FEATURES
    asio ASIO
    jack JACK
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS ${FEATURE_OPTIONS}
    # The ASIO variable is only used on Windows.
    MAYBE_UNUSED_VARIABLES ASIO
    OPTIONS_DEBUG -DDEBUG_OUTPUT:BOOL=ON
)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})
vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
