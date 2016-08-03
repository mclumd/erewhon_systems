FILE(REMOVE_RECURSE
  "CMakeFiles/functiontable_gen"
  "functiontable_gen.h"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/functiontable_gen.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
