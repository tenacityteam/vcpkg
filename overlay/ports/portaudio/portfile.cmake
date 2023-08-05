vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PortAudio/portaudio
    REF 95a5c4ba645e01b32f70458f8ddcd92edd62f982
    SHA512 8ed8042e38e1c9a2ff8f9e4b72bcc760ffb80b53b29542c40f47be242955bcff897f93272847931332585c3660d9ab3ddce4cb86a9fccc21183d3312bd2d660f
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
