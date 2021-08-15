vcpkg_fail_port_install(ON_TARGET "UWP")

vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com/
    REPO soundtouch/soundtouch
    REF 2.2
    SHA512 a84b652867a4549cedc304956bd8e3ff2272992adbbcb42405d8da3aefd1a352cb651aecce3abff783c816793ea72ddb7c51164db4d0c4cd64637f8e885b9f7d
    OUT_SOURCE_PATH SOURCE_PATH
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL ${SOURCE_PATH}/COPYING.TXT DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
