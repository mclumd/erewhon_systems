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
CMAKE_SOURCE_DIR = /fs/erewhon/group/systems/Stage-3.2.2-Source

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /fs/erewhon/group/systems/Stage-3.2.2-Source

# Include any dependencies generated for this target.
include examples/ctrl/CMakeFiles/source.dir/depend.make

# Include the progress variables for this target.
include examples/ctrl/CMakeFiles/source.dir/progress.make

# Include the compile flags for this target's objects.
include examples/ctrl/CMakeFiles/source.dir/flags.make

examples/ctrl/CMakeFiles/source.dir/source.o: examples/ctrl/CMakeFiles/source.dir/flags.make
examples/ctrl/CMakeFiles/source.dir/source.o: examples/ctrl/source.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /fs/erewhon/group/systems/Stage-3.2.2-Source/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object examples/ctrl/CMakeFiles/source.dir/source.o"
	cd /fs/erewhon/group/systems/Stage-3.2.2-Source/examples/ctrl && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/source.dir/source.o -c /fs/erewhon/group/systems/Stage-3.2.2-Source/examples/ctrl/source.cc

examples/ctrl/CMakeFiles/source.dir/source.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/source.dir/source.i"
	cd /fs/erewhon/group/systems/Stage-3.2.2-Source/examples/ctrl && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /fs/erewhon/group/systems/Stage-3.2.2-Source/examples/ctrl/source.cc > CMakeFiles/source.dir/source.i

examples/ctrl/CMakeFiles/source.dir/source.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/source.dir/source.s"
	cd /fs/erewhon/group/systems/Stage-3.2.2-Source/examples/ctrl && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /fs/erewhon/group/systems/Stage-3.2.2-Source/examples/ctrl/source.cc -o CMakeFiles/source.dir/source.s

examples/ctrl/CMakeFiles/source.dir/source.o.requires:
.PHONY : examples/ctrl/CMakeFiles/source.dir/source.o.requires

examples/ctrl/CMakeFiles/source.dir/source.o.provides: examples/ctrl/CMakeFiles/source.dir/source.o.requires
	$(MAKE) -f examples/ctrl/CMakeFiles/source.dir/build.make examples/ctrl/CMakeFiles/source.dir/source.o.provides.build
.PHONY : examples/ctrl/CMakeFiles/source.dir/source.o.provides

examples/ctrl/CMakeFiles/source.dir/source.o.provides.build: examples/ctrl/CMakeFiles/source.dir/source.o

# Object files for target source
source_OBJECTS = \
"CMakeFiles/source.dir/source.o"

# External object files for target source
source_EXTERNAL_OBJECTS =

examples/ctrl/source.so: examples/ctrl/CMakeFiles/source.dir/source.o
examples/ctrl/source.so: libstage/libstage.so.3.2.2
examples/ctrl/source.so: /usr/lib/libGLU.so
examples/ctrl/source.so: /usr/lib/libGL.so
examples/ctrl/source.so: /usr/lib/libSM.so
examples/ctrl/source.so: /usr/lib/libICE.so
examples/ctrl/source.so: /usr/lib/libX11.so
examples/ctrl/source.so: /usr/lib/libXext.so
examples/ctrl/source.so: /usr/lib/libltdl.so.3
examples/ctrl/source.so: examples/ctrl/CMakeFiles/source.dir/build.make
examples/ctrl/source.so: examples/ctrl/CMakeFiles/source.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX shared module source.so"
	cd /fs/erewhon/group/systems/Stage-3.2.2-Source/examples/ctrl && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/source.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/ctrl/CMakeFiles/source.dir/build: examples/ctrl/source.so
.PHONY : examples/ctrl/CMakeFiles/source.dir/build

examples/ctrl/CMakeFiles/source.dir/requires: examples/ctrl/CMakeFiles/source.dir/source.o.requires
.PHONY : examples/ctrl/CMakeFiles/source.dir/requires

examples/ctrl/CMakeFiles/source.dir/clean:
	cd /fs/erewhon/group/systems/Stage-3.2.2-Source/examples/ctrl && $(CMAKE_COMMAND) -P CMakeFiles/source.dir/cmake_clean.cmake
.PHONY : examples/ctrl/CMakeFiles/source.dir/clean

examples/ctrl/CMakeFiles/source.dir/depend:
	cd /fs/erewhon/group/systems/Stage-3.2.2-Source && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /fs/erewhon/group/systems/Stage-3.2.2-Source /fs/erewhon/group/systems/Stage-3.2.2-Source/examples/ctrl /fs/erewhon/group/systems/Stage-3.2.2-Source /fs/erewhon/group/systems/Stage-3.2.2-Source/examples/ctrl /fs/erewhon/group/systems/Stage-3.2.2-Source/examples/ctrl/CMakeFiles/source.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/ctrl/CMakeFiles/source.dir/depend

