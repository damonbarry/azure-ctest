#Copyright (c) Microsoft. All rights reserved.
#Licensed under the MIT license. See LICENSE file in the project root for full license information.

cmake_minimum_required(VERSION 2.8.11 FATAL_ERROR)

# Use @rpath in a target’s install name
if(POLICY CMP0042)
  cmake_policy(SET CMP0042 NEW)
endif()

# Specify a VERSION in the project() command
if(POLICY CMP0048)
  cmake_policy(SET CMP0048 NEW)
endif()

option(ENABLE_UNIT_TESTS "Build unit tests" OFF)
option(BUILD_SHARED_LIBS "Build shared libraries rather than static" ON)

project(ctest VERSION 1.1.19)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Use solution folders in Visual Studio
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Build

set(c_files
    src/ctest.c)

set(h_files
    inc/ctest.h
    inc/ctest_macros.h)

include_directories(inc)

include(CheckIncludeFiles)
check_include_files("stdint.h;stdbool.h" HAS_C99_TYPES)
if(NOT HAS_C99_TYPES)
    list(APPEND h_files
        aux_inc/cstdbool
        aux_inc/cstdint
        aux_inc/inttypes.h
        aux_inc/stdbool.h
        aux_inc/stdint.h)
    include_directories(inc/aux_inc)
endif()

include(CompilerFlags)

add_library(ctest ${c_files})

set_target_properties(ctest PROPERTIES FOLDER "test_tools")

# Test

if(ENABLE_UNIT_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

# Install

include(GNUInstallDirs) # Set CMAKE_INSTALL_<dir>

if(NOT DEFINED CMAKE_INSTALL_LIBDIR)
    set(CMAKE_INSTALL_LIBDIR "lib")
endif()

configure_file("configs/${PROJECT_NAME}Config.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}Config.cmake"
    COPYONLY)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion)

install(TARGETS ctest EXPORT ctestTargets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/static
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(FILES ${h_files}
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(EXPORT ctestTargets
    FILE "${PROJECT_NAME}Targets.cmake"
    DESTINATION cmake)
install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}Config.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}ConfigVersion.cmake"
    DESTINATION cmake)
