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
include examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/depend.make

# Include the progress variables for this target.
include examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/progress.make

# Include the compile flags for this target's objects.
include examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/flags.make

examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o: examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/flags.make
examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o: ../examples/plugins/opaquedriver/opaque.c
	$(CMAKE_COMMAND) -E cmake_progress_report /fs/erewhon/group/systems/player-3.0.2/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o"
	cd /fs/erewhon/group/systems/player-3.0.2/build/examples/plugins/opaquedriver && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/opaque_client.dir/opaque.o   -c /fs/erewhon/group/systems/player-3.0.2/examples/plugins/opaquedriver/opaque.c

examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/opaque_client.dir/opaque.i"
	cd /fs/erewhon/group/systems/player-3.0.2/build/examples/plugins/opaquedriver && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -E /fs/erewhon/group/systems/player-3.0.2/examples/plugins/opaquedriver/opaque.c > CMakeFiles/opaque_client.dir/opaque.i

examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/opaque_client.dir/opaque.s"
	cd /fs/erewhon/group/systems/player-3.0.2/build/examples/plugins/opaquedriver && /usr/bin/gcc  $(C_DEFINES) $(C_FLAGS) -S /fs/erewhon/group/systems/player-3.0.2/examples/plugins/opaquedriver/opaque.c -o CMakeFiles/opaque_client.dir/opaque.s

examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o.requires:
.PHONY : examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o.requires

examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o.provides: examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o.requires
	$(MAKE) -f examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/build.make examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o.provides.build
.PHONY : examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o.provides

examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o.provides.build: examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o

# Object files for target opaque_client
opaque_client_OBJECTS = \
"CMakeFiles/opaque_client.dir/opaque.o"

# External object files for target opaque_client
opaque_client_EXTERNAL_OBJECTS =

examples/plugins/opaquedriver/opaque_client: examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o
examples/plugins/opaquedriver/opaque_client: client_libs/libplayerc/libplayerc.so.3.0.2
examples/plugins/opaquedriver/opaque_client: libplayerinterface/libplayerinterface.so.3.0.2
examples/plugins/opaquedriver/opaque_client: libplayercommon/libplayercommon.so.3.0.2
examples/plugins/opaquedriver/opaque_client: libplayerwkb/libplayerwkb.so.3.0.2
examples/plugins/opaquedriver/opaque_client: libplayercommon/libplayercommon.so.3.0.2
examples/plugins/opaquedriver/opaque_client: libplayerjpeg/libplayerjpeg.so.3.0.2
examples/plugins/opaquedriver/opaque_client: examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/build.make
examples/plugins/opaquedriver/opaque_client: examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C executable opaque_client"
	cd /fs/erewhon/group/systems/player-3.0.2/build/examples/plugins/opaquedriver && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/opaque_client.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/build: examples/plugins/opaquedriver/opaque_client
.PHONY : examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/build

examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/requires: examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/opaque.o.requires
.PHONY : examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/requires

examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/clean:
	cd /fs/erewhon/group/systems/player-3.0.2/build/examples/plugins/opaquedriver && $(CMAKE_COMMAND) -P CMakeFiles/opaque_client.dir/cmake_clean.cmake
.PHONY : examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/clean

examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/depend:
	cd /fs/erewhon/group/systems/player-3.0.2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /fs/erewhon/group/systems/player-3.0.2 /fs/erewhon/group/systems/player-3.0.2/examples/plugins/opaquedriver /fs/erewhon/group/systems/player-3.0.2/build /fs/erewhon/group/systems/player-3.0.2/build/examples/plugins/opaquedriver /fs/erewhon/group/systems/player-3.0.2/build/examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/plugins/opaquedriver/CMakeFiles/opaque_client.dir/depend

