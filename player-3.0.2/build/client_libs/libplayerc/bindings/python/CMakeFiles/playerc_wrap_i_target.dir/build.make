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

# Utility rule file for playerc_wrap_i_target.

client_libs/libplayerc/bindings/python/CMakeFiles/playerc_wrap_i_target: client_libs/libplayerc/bindings/python/playerc_wrap.i
client_libs/libplayerc/bindings/python/CMakeFiles/playerc_wrap_i_target: client_libs/libplayerc/bindings/python/playerc_wrap.h

client_libs/libplayerc/bindings/python/playerc_wrap.i:
	$(CMAKE_COMMAND) -E cmake_progress_report /fs/erewhon/group/systems/player-3.0.2/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating playerc_wrap.i"
	cd /fs/erewhon/group/systems/player-3.0.2/client_libs/libplayerc/bindings/python && /usr/local/bin/python2.6 /fs/erewhon/group/systems/player-3.0.2/client_libs/libplayerc/bindings/python/playerc_swig_parse.py /fs/erewhon/group/systems/player-3.0.2/client_libs/libplayerc/playerc.h /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc/bindings/python/playerc_wrap

client_libs/libplayerc/bindings/python/playerc_wrap.h: client_libs/libplayerc/bindings/python/playerc_wrap.i
	$(CMAKE_COMMAND) -E cmake_progress_report /fs/erewhon/group/systems/player-3.0.2/build/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating playerc_wrap.h"

playerc_wrap_i_target: client_libs/libplayerc/bindings/python/CMakeFiles/playerc_wrap_i_target
playerc_wrap_i_target: client_libs/libplayerc/bindings/python/playerc_wrap.i
playerc_wrap_i_target: client_libs/libplayerc/bindings/python/playerc_wrap.h
playerc_wrap_i_target: client_libs/libplayerc/bindings/python/CMakeFiles/playerc_wrap_i_target.dir/build.make
.PHONY : playerc_wrap_i_target

# Rule to build all files generated by this target.
client_libs/libplayerc/bindings/python/CMakeFiles/playerc_wrap_i_target.dir/build: playerc_wrap_i_target
.PHONY : client_libs/libplayerc/bindings/python/CMakeFiles/playerc_wrap_i_target.dir/build

client_libs/libplayerc/bindings/python/CMakeFiles/playerc_wrap_i_target.dir/clean:
	cd /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc/bindings/python && $(CMAKE_COMMAND) -P CMakeFiles/playerc_wrap_i_target.dir/cmake_clean.cmake
.PHONY : client_libs/libplayerc/bindings/python/CMakeFiles/playerc_wrap_i_target.dir/clean

client_libs/libplayerc/bindings/python/CMakeFiles/playerc_wrap_i_target.dir/depend:
	cd /fs/erewhon/group/systems/player-3.0.2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /fs/erewhon/group/systems/player-3.0.2 /fs/erewhon/group/systems/player-3.0.2/client_libs/libplayerc/bindings/python /fs/erewhon/group/systems/player-3.0.2/build /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc/bindings/python /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc/bindings/python/CMakeFiles/playerc_wrap_i_target.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : client_libs/libplayerc/bindings/python/CMakeFiles/playerc_wrap_i_target.dir/depend
