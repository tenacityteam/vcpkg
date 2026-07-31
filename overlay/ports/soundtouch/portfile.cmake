# Overlay of the upstream soundtouch port. Codeberg's archive tarballs are not
# byte-stable across Gitea versions, so vcpkg_from_github's hash check breaks
# whenever Codeberg re-generates the archive. We also mirror the git repo to
# GitHub so builds don't depend on Codeberg's anti-abuse throttling.

vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/tenacityteam/soundtouch.git
    REF d994965fbbcf0f6ceeed0e72516968130c2912f0
    FETCH_REF refs/tags/${VERSION}
    HEAD_REF master
    PATCHES
        fix-install-includes.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
    soundstretch SOUNDSTRETCH
    soundtouchdll SOUNDTOUCH_DLL
)

if(SOUNDTOUCH_DLL)
  vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)
endif()

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS ${FEATURE_OPTIONS}
)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/SoundTouch)
vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

if(SOUNDSTRETCH)
  vcpkg_copy_tools(TOOL_NAMES soundstretch AUTO_CLEAN)
endif()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING.TXT")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
