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
include libplayercommon/CMakeFiles/playercommon.dir/depend.make

# Include the progress variables for this target.
include libplayercommon/CMakeFiles/playercommon.dir/progress.make

# Include the compile flags for this target's objects.
include libplayercommon/CMakeFiles/playercommon.dir/flags.make

libplayercommon/CMakeFiles/playercommon.dir/error.o: libplayercommon/CMakeFiles/playercommon.dir/flags.make
libplayercommon/CMakeFiles/playercommon.dir/error.o: ../libplayercommon/error.c
	$(CMAKE_COMMAND) -E cmake_progress_report /fs/erewhon/group/systems/player-3.0.2/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object libplayercommon/CMakeFiles/playercommon.dir/error.o"
	cd /fs/erewhon/group/systems/player-3.0.2/build/libplayercommon && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/playercommon.dir/error.o   -c /fs/erewhon/group/systems/player-3.0.2/libplayercommon/error.c

libplayercommon/CMakeFiles/playercommon.dir/error.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/playercommon.dir/error.i"
	cd /fs/erewhon/group/systems/player-3.0.2/build/libplayercommon && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -E /fs/erewhon/group/systems/player-3.0.2/libplayercommon/error.c > CMakeFiles/playercommon.dir/error.i

libplayercommon/CMakeFiles/playercommon.dir/error.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/playercommon.dir/error.s"
	cd /fs/erewhon/group/systems/player-3.0.2/build/libplayercommon && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -S /fs/erewhon/group/systems/player-3.0.2/libplayercommon/error.c -o CMakeFiles/playercommon.dir/error.s

libplayercommon/CMakeFiles/playercommon.dir/error.o.requires:
.PHONY : libplayercommon/CMakeFiles/playercommon.dir/error.o.requires

libplayercommon/CMakeFiles/playercommon.dir/error.o.provides: libplayercommon/CMakeFiles/playercommon.dir/error.o.requires
	$(MAKE) -f libplayercommon/CMakeFiles/playercommon.dir/build.make libplayercommon/CMakeFiles/playercommon.dir/error.o.provides.build
.PHONY : libplayercommon/CMakeFiles/playercommon.dir/error.o.provides

libplayercommon/CMakeFiles/playercommon.dir/error.o.provides.build: libplayercommon/CMakeFiles/playercommon.dir/error.o

# Object files for target playercommon
playercommon_OBJECTS = \
"CMakeFiles/playercommon.dir/error.o"

# External object files for target playercommon
playercommon_EXTERNAL_OBJECTS =

libplayercommon/libplayercommon.so.3.0.2: libplayercommon/CMakeFiles/playercommon.dir/error.o
libplayercommon/libplayercommon.so.3.0.2: libplayercommon/CMakeFiles/playercommon.dir/build.make
libplayercommon/libplayercommon.so.3.0.2: libplayercommon/CMakeFiles/playercommon.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C shared library libplayercommon.so"
	cd /fs/erewhon/group/systems/player-3.0.2/build/libplayercommon && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/playercommon.dir/link.txt --verbose=$(VERBOSE)
	cd /fs/erewhon/group/systems/player-3.0.2/build/libplayercommon && $(CMAKE_COMMAND) -E cmake_symlink_library libplayercommon.so.3.0.2 libplayercommon.so.3.0 libplayercommon.so

libplayercommon/libplayercommon.so.3.0: libplayercommon/libplayercommon.so.3.0.2

libplayercommon/libplayercommon.so: libplayercommon/libplayercommon.so.3.0.2

# Rule to build all files generated by this target.
libplayercommon/CMakeFiles/playercommon.dir/build: libplayercommon/libplayercommon.so
.PHONY : libplayercommon/CMakeFiles/playercommon.dir/build

libplayercommon/CMakeFiles/playercommon.dir/requires: libplayercommon/CMakeFiles/playercommon.dir/error.o.requires
.PHONY : libplayercommon/CMakeFiles/playercommon.dir/requires

libplayercommon/CMakeFiles/playercommon.dir/clean:
	cd /fs/erewhon/group/systems/player-3.0.2/build/libplayercommon && $(CMAKE_COMMAND) -P CMakeFiles/playercommon.dir/cmake_clean.cmake
.PHONY : libplayercommon/CMakeFiles/playercommon.dir/clean

libplayercommon/CMakeFiles/playercommon.dir/depend:
	cd /fs/erewhon/group/systems/player-3.0.2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /fs/erewhon/group/systems/player-3.0.2 /fs/erewhon/group/systems/player-3.0.2/libplayercommon /fs/erewhon/group/systems/player-3.0.2/build /fs/erewhon/group/systems/player-3.0.2/build/libplayercommon /fs/erewhon/group/systems/player-3.0.2/build/libplayercommon/CMakeFiles/playercommon.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : libplayercommon/CMakeFiles/playercommon.dir/depend

