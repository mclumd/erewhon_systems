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
include examples/libplayerc++/CMakeFiles/goto.dir/depend.make

# Include the progress variables for this target.
include examples/libplayerc++/CMakeFiles/goto.dir/progress.make

# Include the compile flags for this target's objects.
include examples/libplayerc++/CMakeFiles/goto.dir/flags.make

examples/libplayerc++/CMakeFiles/goto.dir/goto.o: examples/libplayerc++/CMakeFiles/goto.dir/flags.make
examples/libplayerc++/CMakeFiles/goto.dir/goto.o: ../examples/libplayerc++/goto.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /fs/erewhon/group/systems/player-3.0.2/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object examples/libplayerc++/CMakeFiles/goto.dir/goto.o"
	cd /fs/erewhon/group/systems/player-3.0.2/build/examples/libplayerc++ && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/goto.dir/goto.o -c /fs/erewhon/group/systems/player-3.0.2/examples/libplayerc++/goto.cc

examples/libplayerc++/CMakeFiles/goto.dir/goto.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/goto.dir/goto.i"
	cd /fs/erewhon/group/systems/player-3.0.2/build/examples/libplayerc++ && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /fs/erewhon/group/systems/player-3.0.2/examples/libplayerc++/goto.cc > CMakeFiles/goto.dir/goto.i

examples/libplayerc++/CMakeFiles/goto.dir/goto.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/goto.dir/goto.s"
	cd /fs/erewhon/group/systems/player-3.0.2/build/examples/libplayerc++ && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /fs/erewhon/group/systems/player-3.0.2/examples/libplayerc++/goto.cc -o CMakeFiles/goto.dir/goto.s

examples/libplayerc++/CMakeFiles/goto.dir/goto.o.requires:
.PHONY : examples/libplayerc++/CMakeFiles/goto.dir/goto.o.requires

examples/libplayerc++/CMakeFiles/goto.dir/goto.o.provides: examples/libplayerc++/CMakeFiles/goto.dir/goto.o.requires
	$(MAKE) -f examples/libplayerc++/CMakeFiles/goto.dir/build.make examples/libplayerc++/CMakeFiles/goto.dir/goto.o.provides.build
.PHONY : examples/libplayerc++/CMakeFiles/goto.dir/goto.o.provides

examples/libplayerc++/CMakeFiles/goto.dir/goto.o.provides.build: examples/libplayerc++/CMakeFiles/goto.dir/goto.o

# Object files for target goto
goto_OBJECTS = \
"CMakeFiles/goto.dir/goto.o"

# External object files for target goto
goto_EXTERNAL_OBJECTS =

examples/libplayerc++/goto: examples/libplayerc++/CMakeFiles/goto.dir/goto.o
examples/libplayerc++/goto: client_libs/libplayerc++/libplayerc++.so.3.0.2
examples/libplayerc++/goto: client_libs/libplayerc/libplayerc.so.3.0.2
examples/libplayerc++/goto: libplayerinterface/libplayerinterface.so.3.0.2
examples/libplayerc++/goto: libplayercommon/libplayercommon.so.3.0.2
examples/libplayerc++/goto: libplayerjpeg/libplayerjpeg.so.3.0.2
examples/libplayerc++/goto: libplayerwkb/libplayerwkb.so.3.0.2
examples/libplayerc++/goto: libplayercommon/libplayercommon.so.3.0.2
examples/libplayerc++/goto: examples/libplayerc++/CMakeFiles/goto.dir/build.make
examples/libplayerc++/goto: examples/libplayerc++/CMakeFiles/goto.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable goto"
	cd /fs/erewhon/group/systems/player-3.0.2/build/examples/libplayerc++ && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/goto.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/libplayerc++/CMakeFiles/goto.dir/build: examples/libplayerc++/goto
.PHONY : examples/libplayerc++/CMakeFiles/goto.dir/build

examples/libplayerc++/CMakeFiles/goto.dir/requires: examples/libplayerc++/CMakeFiles/goto.dir/goto.o.requires
.PHONY : examples/libplayerc++/CMakeFiles/goto.dir/requires

examples/libplayerc++/CMakeFiles/goto.dir/clean:
	cd /fs/erewhon/group/systems/player-3.0.2/build/examples/libplayerc++ && $(CMAKE_COMMAND) -P CMakeFiles/goto.dir/cmake_clean.cmake
.PHONY : examples/libplayerc++/CMakeFiles/goto.dir/clean

examples/libplayerc++/CMakeFiles/goto.dir/depend:
	cd /fs/erewhon/group/systems/player-3.0.2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /fs/erewhon/group/systems/player-3.0.2 /fs/erewhon/group/systems/player-3.0.2/examples/libplayerc++ /fs/erewhon/group/systems/player-3.0.2/build /fs/erewhon/group/systems/player-3.0.2/build/examples/libplayerc++ /fs/erewhon/group/systems/player-3.0.2/build/examples/libplayerc++/CMakeFiles/goto.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/libplayerc++/CMakeFiles/goto.dir/depend

