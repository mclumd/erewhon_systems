# Install script for directory: /fs/erewhon/group/systems/player-3.0.2/config

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

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "samplecfg")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/player/config" TYPE FILE FILES
    "/fs/erewhon/group/systems/player-3.0.2/config/afsm.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/afsm.eps"
    "/fs/erewhon/group/systems/player-3.0.2/config/amigobot.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/amigobot_tcp.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/amtecM5.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/b21r_rflex_lms200.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/cvcam.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/dummy.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/erratic.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/hokuyo_aist.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/iwspy.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/joystick.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/lms400.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/magellan.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/mapfile.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/mbicp.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/nomad.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/obot.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/passthrough.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/phidgetIFK.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/phidgetRFID.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/pioneer.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/pioneer_rs4euze.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/pointcloud3d.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/readlog.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/rfid.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/roomba.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/searchpattern.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/searchpattern_symbols.ps"
    "/fs/erewhon/group/systems/player-3.0.2/config/segwayrmp.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/service_adv.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/simple.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/sphere.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/umass_ATRVJr.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/umass_ATRVMini.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/umass_reb.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/urglaser.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/vfh.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/wavefront.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/wbr914.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/writelog.cfg"
    "/fs/erewhon/group/systems/player-3.0.2/config/wsn.cfg"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "samplecfg")

