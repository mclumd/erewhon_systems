FILE(REMOVE_RECURSE
  "CMakeFiles/example_driver.dir/example_xdr.o"
  "CMakeFiles/example_driver.dir/eginterf_driver.o"
  "example_interface.h"
  "example_xdr.h"
  "example_xdr.c"
  "libexample_driver.pdb"
  "libexample_driver.so"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang C CXX)
  INCLUDE(CMakeFiles/example_driver.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
