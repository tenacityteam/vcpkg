set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)

# Mixxx loads fdk-aac dynamically at runtime. This allows the user to replace 
# the version of fdk-aac we ship which has the patent-encumbered HE-AAC 
#removed with another build that supports HE-AAC.
if(${PORT} MATCHES "fdk-aac")
    set(VCPKG_LIBRARY_LINKAGE dynamic)
else()
    set(VCPKG_LIBRARY_LINKAGE static)
endif()

set(VCPKG_CMAKE_SYSTEM_NAME Darwin)
set(VCPKG_OSX_ARCHITECTURES x86_64)

set(VCPKG_OSX_DEPLOYMENT_TARGET 10.12)
set(VCPKG_C_FLAGS -mmacosx-version-min=10.12)
set(VCPKG_CXX_FLAGS -mmacosx-version-min=10.12)
  
