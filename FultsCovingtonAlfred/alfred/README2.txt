Changes to Alfred made by The University of Georgia, January 2011:

- Minor modifications to alfred/src/lexeme_speller.pl

  (does not require compiling)


- Major modifications to Alma/dbman/index.pl
                         Alma/res/resolve.pl
                         Alma/res/process_tasks.pl

                         cd alfred/Alma
                         make all              (to compile the 3 altered files)

- Debug level in alfred/bin/rac set to 0 instead of 3 for speed

- Other users will need to set ALFRED_BASE appropriately in alfred/bin/rac, rc, rui

