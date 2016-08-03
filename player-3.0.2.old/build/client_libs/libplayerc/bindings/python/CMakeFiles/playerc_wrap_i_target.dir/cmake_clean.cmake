FILE(REMOVE_RECURSE
  "playercPYTHON_wrap.c"
  "playerc.py"
  "CMakeFiles/playerc_wrap_i_target"
  "playerc_wrap.i"
  "playerc_wrap.h"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/playerc_wrap_i_target.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
