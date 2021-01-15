vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libsndfile/libsamplerate
    REF 27efea7d0eebb6aacb87719030f1072ba2a3f0bf
    SHA512 0e00d9366c18bb2c642064e80617e45f36df9cd438ae7cf453086bbab9aa7449dd692febdf2aae7b1970e118cf997a1ee87aaaa9f135971be3b42fb14ec9c4d4
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)
vcpkg_install_cmake()

if(WIN32 AND (NOT MINGW) AND (NOT CYGWIN))
  set(CMAKE_INSTALL_PACKAGEDIR cmake) 
else()
  set(CMAKE_INSTALL_PACKAGEDIR lib/cmake/SampleRate)
endif()

vcpkg_fixup_cmake_targets(CONFIG_PATH ${CMAKE_INSTALL_PACKAGEDIR})

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/libsamplerate RENAME copyright)

vcpkg_copy_pdbs()
