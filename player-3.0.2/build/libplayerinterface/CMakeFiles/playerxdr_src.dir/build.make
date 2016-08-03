# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canoncical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /fs/erewhon/group/systems/utils/bin/cmake

# The command to remove a file.
RM = /fs/erewhon/group/systems/utils/bin/cmake -E remove -f

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /fs/erewhon/group/systems/utils/bin/ccmake

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /fs/erewhon/group/systems/player-3.0.2

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /fs/erewhon/group/systems/player-3.0.2/build

# Utility rule file for playerxdr_src.

libplayerinterface/CMakeFiles/playerxdr_src: libplayerinterface/playerxdr.h
libplayerinterface/CMakeFiles/playerxdr_src: libplayerinterface/playerxdr.c
	$(CMAKE_COMMAND) -E cmake_progress_report /fs/erewhon/group/systems/player-3.0.2/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating playerxdr.?"

libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/001_player.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/002_power.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/003_gripper.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/004_position2d.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/005_sonar.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/006_laser.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/007_blobfinder.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/008_ptz.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/009_audio.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/010_fiducial.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/012_speech.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/013_gps.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/014_bumper.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/020_dio.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/021_aio.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/022_ir.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/023_wifi.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/025_localize.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/030_position3d.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/031_simulation.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/033_blinkenlight.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/040_camera.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/042_map.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/044_planner.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/045_log.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/049_joystick.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/050_speech_recognition.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/051_opaque.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/052_position1d.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/053_actarray.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/054_limb.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/055_graphics2d.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/056_rfid.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/057_wsn.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/058_graphics3d.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/059_health.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/060_imu.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/061_pointcloud3d.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/062_ranger.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/063_vectormap.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/064_blackboard.def
libplayerinterface/playerxdr.h: ../libplayerinterface/interfaces/065_stereo.def
libplayerinterface/playerxdr.h: libplayerinterface/player_interfaces.h
	$(CMAKE_COMMAND) -E cmake_progress_report /fs/erewhon/group/systems/player-3.0.2/build/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating playerxdr.h, playerxdr.c"
	cd /fs/erewhon/group/systems/player-3.0.2/libplayerinterface && /usr/local/bin/python2.6 /fs/erewhon/group/systems/player-3.0.2/libplayerinterface/playerxdrgen.py -distro /fs/erewhon/group/systems/player-3.0.2/libplayerinterface/player.h /fs/erewhon/group/systems/player-3.0.2/build/libplayerinterface/playerxdr.c /fs/erewhon/group/systems/player-3.0.2/build/libplayerinterface/playerxdr.h /fs/erewhon/group/systems/player-3.0.2/build/libplayerinterface/player_interfaces.h

libplayerinterface/playerxdr.c: libplayerinterface/playerxdr.h

libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/001_player.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/002_power.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/003_gripper.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/004_position2d.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/005_sonar.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/006_laser.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/007_blobfinder.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/008_ptz.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/009_audio.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/010_fiducial.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/012_speech.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/013_gps.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/014_bumper.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/020_dio.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/021_aio.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/022_ir.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/023_wifi.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/025_localize.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/030_position3d.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/031_simulation.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/033_blinkenlight.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/040_camera.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/042_map.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/044_planner.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/045_log.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/049_joystick.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/050_speech_recognition.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/051_opaque.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/052_position1d.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/053_actarray.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/054_limb.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/055_graphics2d.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/056_rfid.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/057_wsn.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/058_graphics3d.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/059_health.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/060_imu.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/061_pointcloud3d.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/062_ranger.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/063_vectormap.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/064_blackboard.def
libplayerinterface/player_interfaces.h: ../libplayerinterface/interfaces/065_stereo.def
	$(CMAKE_COMMAND) -E cmake_progress_report /fs/erewhon/group/systems/player-3.0.2/build/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating player_interfaces.h"
	cd /fs/erewhon/group/systems/player-3.0.2/libplayerinterface && /usr/local/bin/python2.6 /fs/erewhon/group/systems/player-3.0.2/libplayerinterface/playerinterfacegen.py /fs/erewhon/group/systems/player-3.0.2/libplayerinterface/interfaces > /fs/erewhon/group/systems/player-3.0.2/build/libplayerinterface/player_interfaces.h

playerxdr_src: libplayerinterface/CMakeFiles/playerxdr_src
playerxdr_src: libplayerinterface/playerxdr.h
playerxdr_src: libplayerinterface/playerxdr.c
playerxdr_src: libplayerinterface/player_interfaces.h
playerxdr_src: libplayerinterface/CMakeFiles/playerxdr_src.dir/build.make
.PHONY : playerxdr_src

# Rule to build all files generated by this target.
libplayerinterface/CMakeFiles/playerxdr_src.dir/build: playerxdr_src
.PHONY : libplayerinterface/CMakeFiles/playerxdr_src.dir/build

libplayerinterface/CMakeFiles/playerxdr_src.dir/clean:
	cd /fs/erewhon/group/systems/player-3.0.2/build/libplayerinterface && $(CMAKE_COMMAND) -P CMakeFiles/playerxdr_src.dir/cmake_clean.cmake
.PHONY : libplayerinterface/CMakeFiles/playerxdr_src.dir/clean

libplayerinterface/CMakeFiles/playerxdr_src.dir/depend:
	cd /fs/erewhon/group/systems/player-3.0.2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /fs/erewhon/group/systems/player-3.0.2 /fs/erewhon/group/systems/player-3.0.2/libplayerinterface /fs/erewhon/group/systems/player-3.0.2/build /fs/erewhon/group/systems/player-3.0.2/build/libplayerinterface /fs/erewhon/group/systems/player-3.0.2/build/libplayerinterface/CMakeFiles/playerxdr_src.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : libplayerinterface/CMakeFiles/playerxdr_src.dir/depend

