cmake_minimum_required(VERSION 3.8)
project(jack VERSION 1.9.19 LANGUAGES C)

include_directories(common)

add_library(jack STATIC common/JackWeakAPI.c)

install(TARGETS jack
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

set(PREFIX "${CMAKE_INSTALL_PREFIX}")
set(LIBDIR "\${prefix}/lib")
set(INCLUDEDIR "\${prefix}/include")
set(JACK_VERSION "${CMAKE_PROJECT_VERSION}")
# JackWeak dynamically loads the real JACK library which requires linking dl
set(CLIENTLIB "jack -ldl")
# NOTE: the server_libs variable will be broken but this port does not build the server anyway
configure_file(jack.pc.in "${CMAKE_CURRENT_BINARY_DIR}/jack.pc" @ONLY)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/jack.pc" DESTINATION "lib/pkgconfig")

install(DIRECTORY common/jack DESTINATION include)
