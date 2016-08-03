# Install script for directory: /fs/erewhon/group/systems/player-3.0.2

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/fs/erewhon/group/systems/utils")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "0")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "headers")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/player-3.0" TYPE FILE FILES "/fs/erewhon/group/systems/player-3.0.2/build/playerconfig.h")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "headers")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/libplayercommon/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/libplayerinterface/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/client_libs/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/libplayercore/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/config/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/libplayerwkb/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/libplayerjpeg/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/libplayertcp/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/libplayersd/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/rtk2/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/server/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/examples/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/utils/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/doc/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/cmake/cmake_install.cmake")
  INCLUDE("/fs/erewhon/group/systems/player-3.0.2/build/replace/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

IF(CMAKE_INSTALL_COMPONENT)
  SET(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
ELSE(CMAKE_INSTALL_COMPONENT)
  SET(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
ENDIF(CMAKE_INSTALL_COMPONENT)

FILE(WRITE "/fs/erewhon/group/systems/player-3.0.2/build/${CMAKE_INSTALL_MANIFEST}" "")
FOREACH(file ${CMAKE_INSTALL_MANIFEST_FILES})
  FILE(APPEND "/fs/erewhon/group/systems/player-3.0.2/build/${CMAKE_INSTALL_MANIFEST}" "${file}\n")
ENDFOREACH(file)
