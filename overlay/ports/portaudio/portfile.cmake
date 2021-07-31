vcpkg_fail_port_install(ON_TARGET "uwp")
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Be-ing/portaudio
    REF 62455aa6b4791f714ab8c2f2857af54f93760115
    SHA512 5864e4d36e2532fce1f79bfbbe6fef5304d45cf647e8413761f1b69cc3c7dbe87758c3c4a9a8d34290db92ebe6ca055755460b2db528cb8491cbe22b28304ca0
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
