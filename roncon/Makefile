# these next two might not work under all OSes

SYS     = $(shell uname)
MACHINE = $(shell hostname)
PROC    = $(shell uname -m)
USER	= $(shell whoami)

# the following must be resolved in Make.* :
# .... in the $(SYS) file, usually:
#  PLAYERFLAGS PLAYERLIBS
#  LIBEXT STATIC_LIBEXT
#  CFLAGS LINKFLAGS
#  CC LD CP RM LS CAT

include make/Make.$(SYS)
include make/Make.$(MACHINE)
#include a user-specific makefile if it exists
-include make/Make.$(USER)
include make/Make.files

BUILDDIR = obj/$(SYS)-$(PROC)
PROJECT_OBJ_FILES = $(patsubst %.o,$(BUILDDIR)/%.o,$(RONCON_OBJ_FILES))

IDIRS    = -Isrc/include $(OS_INCFLAGS) $(MACHINE_INCFLAGS)

# REQ_LIBS = MCL2core UMBC
REQ_LIBS = UMBC pthread
LINKLIBS = $(patsubst %,-l%,$(REQ_LIBS)) $(PLAYERLIBS)

LIBFLAGS = $(OS_LINKFLAGS) $(MACHINE_LINKFLAGS)

$(BUILDDIR)/%.o:    src/%.cc
	$(CC) $(CFLAGS) $(IDIRS) -c $< -o $@

$(BUILDDIR)/Raccoon%.o: main.cc
	$(CC) $(CFLAGS) $(IDIRS) -c $< -o $@

test/%.o: test/%.cc
	$(CC) $(CFLAGS) $(IDIRS) -c $< -o $@

Raccoon-$(SYS)-$(PROC): $(PROJECT_OBJ_FILES) $(BUILDDIR)/Raccoon-$(SYS).o
	$(LD) $(LINKFLAGS) -o $@ $^ $(LIBFLAGS) $(LINKLIBS)

all: Raccoon-$(SYS)-$(PROC)

objects: $(PROJECT_OBJ_FILES)

show:
	echo $(BUILDDIR)
	echo $(RONCON_OBJ_FILES)

clean:
	-$(RM) *~
	-$(RM) obj/*/*.o
	-$(RM) rexe-*
	-$(RM) src/*~
	-$(RM) src/include/*~

tst_msgs: $(PROJECT_OBJ_FILES) test/test_msgs.o
	$(LD) $(LINKFLAGS) -o test/$@ $^ $(LIBFLAGS) $(LINKLIBS)

tst_args: $(PROJECT_OBJ_FILES) test/test_args.o
	$(LD) $(LINKFLAGS) -o test/$@ $^ $(LIBFLAGS) $(LINKLIBS)

tst_pbreak: test/pipebreaker.o
	$(LD) -o test/$@ $^ 

#mclconfig: $(MCL_CORE_FILENAME) obj/writeDefaultConfig.o
#	$(LD) -o mclconfig obj/writeDefaultConfig.o -l$(MCL_CORE_ROOTNAME) 

docs:
	doxygen Doxyfile

alldocs:
	doxygen Doxy-all
