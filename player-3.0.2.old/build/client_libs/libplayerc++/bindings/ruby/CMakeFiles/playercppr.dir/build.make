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
include client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/depend.make

# Include the progress variables for this target.
include client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/progress.make

# Include the compile flags for this target's objects.
include client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/flags.make

client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o: client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/flags.make
client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o: client_libs/libplayerc++/bindings/ruby/playercppRUBY_wrap.cxx
	$(CMAKE_COMMAND) -E cmake_progress_report /fs/erewhon/group/systems/player-3.0.2/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o"
	cd /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/playercppr.dir/playercppRUBY_wrap.o -c /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby/playercppRUBY_wrap.cxx

client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/playercppr.dir/playercppRUBY_wrap.i"
	cd /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby/playercppRUBY_wrap.cxx > CMakeFiles/playercppr.dir/playercppRUBY_wrap.i

client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/playercppr.dir/playercppRUBY_wrap.s"
	cd /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby/playercppRUBY_wrap.cxx -o CMakeFiles/playercppr.dir/playercppRUBY_wrap.s

client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o.requires:
.PHONY : client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o.requires

client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o.provides: client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o.requires
	$(MAKE) -f client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/build.make client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o.provides.build
.PHONY : client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o.provides

client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o.provides.build: client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o

client_libs/libplayerc++/bindings/ruby/playercppRUBY_wrap.cxx: ../client_libs/libplayerc++/playerc++.h
client_libs/libplayerc++/bindings/ruby/playercppRUBY_wrap.cxx: ../client_libs/libplayerc++/bindings/ruby/playercpp.i
	$(CMAKE_COMMAND) -E cmake_progress_report /fs/erewhon/group/systems/player-3.0.2/build/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Swig source"
	cd /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby && /usr/bin/swig -ruby -w801 -outdir /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby -c++ -I/fs/erewhon/group/systems/player-3.0.2 -I/fs/erewhon/group/systems/player-3.0.2/build -I/fs/erewhon/group/systems/player-3.0.2/build/libplayercore -I/usr/local/ruby-1.8.7-p174/lib/ruby/1.8/i686-linux -I/fs/erewhon/group/systems/player-3.0.2/client_libs -I/fs/erewhon/group/systems/player-3.0.2/build/client_libs -o /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby/playercppRUBY_wrap.cxx /fs/erewhon/group/systems/player-3.0.2/client_libs/libplayerc++/bindings/ruby/playercpp.i

# Object files for target playercppr
playercppr_OBJECTS = \
"CMakeFiles/playercppr.dir/playercppRUBY_wrap.o"

# External object files for target playercppr
playercppr_EXTERNAL_OBJECTS =

client_libs/libplayerc++/bindings/ruby/playercppr.so: client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o
client_libs/libplayerc++/bindings/ruby/playercppr.so: /usr/local/ruby-1.8.7-p174/lib/libruby-static.a
client_libs/libplayerc++/bindings/ruby/playercppr.so: client_libs/libplayerc++/libplayerc++.so.3.0.2
client_libs/libplayerc++/bindings/ruby/playercppr.so: client_libs/libplayerc/libplayerc.so.3.0.2
client_libs/libplayerc++/bindings/ruby/playercppr.so: libplayerwkb/libplayerwkb.so.3.0.2
client_libs/libplayerc++/bindings/ruby/playercppr.so: libplayerinterface/libplayerinterface.so.3.0.2
client_libs/libplayerc++/bindings/ruby/playercppr.so: libplayercommon/libplayercommon.so.3.0.2
client_libs/libplayerc++/bindings/ruby/playercppr.so: libplayerjpeg/libplayerjpeg.so.3.0.2
client_libs/libplayerc++/bindings/ruby/playercppr.so: client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/build.make
client_libs/libplayerc++/bindings/ruby/playercppr.so: client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX shared module playercppr.so"
	cd /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/playercppr.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/build: client_libs/libplayerc++/bindings/ruby/playercppr.so
.PHONY : client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/build

client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/requires: client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/playercppRUBY_wrap.o.requires
.PHONY : client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/requires

client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/clean:
	cd /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby && $(CMAKE_COMMAND) -P CMakeFiles/playercppr.dir/cmake_clean.cmake
.PHONY : client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/clean

client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/depend: client_libs/libplayerc++/bindings/ruby/playercppRUBY_wrap.cxx
	cd /fs/erewhon/group/systems/player-3.0.2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /fs/erewhon/group/systems/player-3.0.2 /fs/erewhon/group/systems/player-3.0.2/client_libs/libplayerc++/bindings/ruby /fs/erewhon/group/systems/player-3.0.2/build /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby /fs/erewhon/group/systems/player-3.0.2/build/client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : client_libs/libplayerc++/bindings/ruby/CMakeFiles/playercppr.dir/depend
