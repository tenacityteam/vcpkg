vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PortAudio/portaudio
    REF aa1cfb046f93b18db4d12986ddbff84cbaa952cb
    SHA512 53c8f79878ae1ab2e65ad25a334c9e89a5278a38fe1e2fc434e72cc633cf742ae2a77bc3d38e34314f620d1c99697e2578b33ab54a81c47362d15be46166884c
    HEAD_REF master
)

if ("${VCPKG_LIBRARY_LINKAGE}" STREQUAL "dymamic")
    set(PA_BUILD_SHARED_LIBS ON)
else()
    set(PA_BUILD_SHARED_LIBS OFF)
endif()

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        asio PA_USE_ASIO
)

# NOTE: the ASIO backend will be built automatically if the ASIO-SDK is provided
# in a sibling folder of the portaudio source in vcpkg/buildtrees/portaudio/src
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DPA_USE_DS=ON
        -DPA_USE_WASAPI=ON
        -DPA_USE_WDMKS=ON
        -DPA_USE_WMME=ON
        -DPA_BUILD_SHARED_LIBS=${PA_BUILD_SHARED_LIBS}
        -DPA_DLL_LINK_WITH_STATIC_RUNTIME=OFF
        -DPA_USE_ASIO=${PA_USE_ASIO}
    OPTIONS_DEBUG
        -DPA_ENABLE_DEBUG_OUTPUT:BOOL=ON
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

vcpkg_fixup_pkgconfig()
