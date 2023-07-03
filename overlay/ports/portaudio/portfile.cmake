vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PortAudio/portaudio
    REF cb8d3dcbc6fa74c67f3e236be89b12d5630da141
    SHA512 cec25a200e4edaa81a3a1d3142823f6297ea46950df2f850e06f6cee5c1a892509eacb80d01016c57746ea96fac1d60ee963cabb5982bb8436b930eb7a475415
    HEAD_REF master
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
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

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/${PORT}")
vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME "copyright")
