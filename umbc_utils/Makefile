# these next two might not work under all OSes

MACHINE = $(shell 'hostname --short')
ARCH    = $(shell arch)
SYS     = $(shell uname)

# ifeq ($(SYS),Linux)
#   include make/Make.linux
# else
#   $(error No configuration file for your OS in make/Make.$(SYS))
# endif

-include make/Make.$(SYS)
-include make/Make.$(MACHINE)

IDIRS =  -Isrc/include -Iapi/umbc

obj/test_%.o: test/test_%.cc
	$(CC) $(CFLAGS) $(MACHINE_COMPFLAGS) $(IDIRS) -DSAFE -c $< -o $@

obj/%.o:    src/%.cc
	$(CC) $(CFLAGS) $(MACHINE_COMPFLAGS) $(IDIRS) -DSAFE -c $< -o $@

test_%: obj/test_%.o $(UMBC_LIB_FILENAME)
	$(LD) $(UMBC_LIB_FILENAME) -o $@ $^

UMBC_LIB_ROOTNAME = UMBC
UMBC_LIB_FILENAME = lib$(UMBC_LIB_ROOTNAME).$(LIBEXT)

include make/Make.files

$(UMBC_LIB_FILENAME): $(LIB_OBJ)
	$(LD) $(LINKFLAGS) $(MACHINE_LINKFLAGS) -o $@ $^

objects: $(LIB_OBJ)

all: $(UMBC_LIB_FILENAME)

install: $(UMBC_LIB_FILENAME)
	-$(MDIRP) $(SYS_LIBDIR)
	$(CP) $(UMBC_LIB_FILENAME) $(SYS_LIBDIR)
	-$(MDIRP) $(SYS_INCLUDEDIR)/umbc
	$(CP) api/umbc/*.h $(SYS_INCLUDEDIR)/umbc/

clean:
	-$(MDIRP) obj
	-$(RM) obj/*.o
	-$(RM) src/*~
	-$(RM) test/*~
	-$(RM) src/include/*~
	-$(RM) api/umbc/*~
	-$(RM) *.so
	-$(RM) *~
	-$(RM) test_*

#test: $(UMBC_LIB_FILENAME) mclTest.o 
#	$(LD) -o ta mclTest.o -l$(MCL_CORE_ROOTNAME)

docs:
	doxygen Doxyfile
