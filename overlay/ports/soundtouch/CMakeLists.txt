cmake_minimum_required(VERSION 3.5)
project(soundtouch CXX)

if(MSVC AND CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(ARCH_SUFFIX _x64)
else()
    set(ARCH_SUFFIX)
endif()

if(MSVC AND BUILD_SHARED_LIBS)
    set(TYPE_SUFFIX Dll)
else()
    if($<Config:Debug>)
        set(TYPE_SUFFIX D)
    endif()
endif()

configure_file("${CMAKE_CURRENT_LIST_DIR}/include/soundtouch_config.h.in" ${CMAKE_CURRENT_BINARY_DIR}/include/soundtouch_config.h)

file(GLOB SOUNDTOUCH_SOURCES "${CMAKE_CURRENT_LIST_DIR}/source/SoundTouch/*.cpp")
add_library(libsoundtouch ${SOUNDTOUCH_SOURCES})
target_include_directories(libsoundtouch PUBLIC "${CMAKE_CURRENT_LIST_DIR}/include")
target_include_directories(libsoundtouch PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/include")
set_target_properties(libsoundtouch PROPERTIES OUTPUT_NAME SoundTouch${TYPE_SUFFIX}${ARCH_SUFFIX})
if(WIN32 AND BUILD_SHARED_LIBS)
    target_compile_definitions(libsoundtouch PRIVATE -DDLL_EXPORTS)
    target_sources(libsoundtouch PRIVATE
        "${CMAKE_CURRENT_LIST_DIR}/source/SoundTouchDLL/SoundTouchDLL.cpp"
        "${CMAKE_CURRENT_LIST_DIR}/source/SoundTouchDLL/SoundTouchDLL.rc"
    )
endif()

include(GNUInstallDirs)

install(TARGETS libsoundtouch
  ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
  LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
  RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
  INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

install(
    FILES
        include/BPMDetect.h
        include/FIFOSampleBuffer.h
        include/FIFOSamplePipe.h
        include/STTypes.h
        include/SoundTouch.h
        "${CMAKE_CURRENT_BINARY_DIR}/include/soundtouch_config.h"
    DESTINATION
        "${CMAKE_INSTALL_INCLUDEDIR}/soundtouch"
)

if(WIN32)
    install(FILES source/SoundTouchDLL/SoundTouchDLL.h DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/soundtouch")
endif()
