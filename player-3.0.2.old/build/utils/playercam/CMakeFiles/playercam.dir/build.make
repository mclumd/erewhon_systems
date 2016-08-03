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

# Include any dependencies generated for this target.
include utils/playercam/CMakeFiles/playercam.dir/depend.make

# Include the progress variables for this target.
include utils/playercam/CMakeFiles/playercam.dir/progress.make

# Include the compile flags for this target's objects.
include utils/playercam/CMakeFiles/playercam.dir/flags.make

utils/playercam/CMakeFiles/playercam.dir/playercam.o: utils/playercam/CMakeFiles/playercam.dir/flags.make
utils/playercam/CMakeFiles/playercam.dir/playercam.o: ../utils/playercam/playercam.c
	$(CMAKE_COMMAND) -E cmake_progress_report /fs/erewhon/group/systems/player-3.0.2/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object utils/playercam/CMakeFiles/playercam.dir/playercam.o"
	cd /fs/erewhon/group/systems/player-3.0.2/build/utils/playercam && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/playercam.dir/playercam.o   -c /fs/erewhon/group/systems/player-3.0.2/utils/playercam/playercam.c

utils/playercam/CMakeFiles/playercam.dir/playercam.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/playercam.dir/playercam.i"
	cd /fs/erewhon/group/systems/player-3.0.2/build/utils/playercam && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -E /fs/erewhon/group/systems/player-3.0.2/utils/playercam/playercam.c > CMakeFiles/playercam.dir/playercam.i

utils/playercam/CMakeFiles/playercam.dir/playercam.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/playercam.dir/playercam.s"
	cd /fs/erewhon/group/systems/player-3.0.2/build/utils/playercam && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -S /fs/erewhon/group/systems/player-3.0.2/utils/playercam/playercam.c -o CMakeFiles/playercam.dir/playercam.s

utils/playercam/CMakeFiles/playercam.dir/playercam.o.requires:
.PHONY : utils/playercam/CMakeFiles/playercam.dir/playercam.o.requires

utils/playercam/CMakeFiles/playercam.dir/playercam.o.provides: utils/playercam/CMakeFiles/playercam.dir/playercam.o.requires
	$(MAKE) -f utils/playercam/CMakeFiles/playercam.dir/build.make utils/playercam/CMakeFiles/playercam.dir/playercam.o.provides.build
.PHONY : utils/playercam/CMakeFiles/playercam.dir/playercam.o.provides

utils/playercam/CMakeFiles/playercam.dir/playercam.o.provides.build: utils/playercam/CMakeFiles/playercam.dir/playercam.o

# Object files for target playercam
playercam_OBJECTS = \
"CMakeFiles/playercam.dir/playercam.o"

# External object files for target playercam
playercam_EXTERNAL_OBJECTS =

utils/playercam/playercam: utils/playercam/CMakeFiles/playercam.dir/playercam.o
utils/playercam/playercam: client_libs/libplayerc/libplayerc.so.3.0.2
utils/playercam/playercam: libplayerinterface/libplayerinterface.so.3.0.2
utils/playercam/playercam: libplayercommon/libplayercommon.so.3.0.2
utils/playercam/playercam: libplayerwkb/libplayerwkb.so.3.0.2
utils/playercam/playercam: libplayercommon/libplayercommon.so.3.0.2
utils/playercam/playercam: libplayerjpeg/libplayerjpeg.so.3.0.2
utils/playercam/playercam: utils/playercam/CMakeFiles/playercam.dir/build.make
utils/playercam/playercam: utils/playercam/CMakeFiles/playercam.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C executable playercam"
	cd /fs/erewhon/group/systems/player-3.0.2/build/utils/playercam && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/playercam.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
utils/playercam/CMakeFiles/playercam.dir/build: utils/playercam/playercam
.PHONY : utils/playercam/CMakeFiles/playercam.dir/build

utils/playercam/CMakeFiles/playercam.dir/requires: utils/playercam/CMakeFiles/playercam.dir/playercam.o.requires
.PHONY : utils/playercam/CMakeFiles/playercam.dir/requires

utils/playercam/CMakeFiles/playercam.dir/clean:
	cd /fs/erewhon/group/systems/player-3.0.2/build/utils/playercam && $(CMAKE_COMMAND) -P CMakeFiles/playercam.dir/cmake_clean.cmake
.PHONY : utils/playercam/CMakeFiles/playercam.dir/clean

utils/playercam/CMakeFiles/playercam.dir/depend:
	cd /fs/erewhon/group/systems/player-3.0.2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /fs/erewhon/group/systems/player-3.0.2 /fs/erewhon/group/systems/player-3.0.2/utils/playercam /fs/erewhon/group/systems/player-3.0.2/build /fs/erewhon/group/systems/player-3.0.2/build/utils/playercam /fs/erewhon/group/systems/player-3.0.2/build/utils/playercam/CMakeFiles/playercam.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : utils/playercam/CMakeFiles/playercam.dir/depend

