% carne-wrapper.pl -- M. Covington 2010

% For starting Carne using Quintus in interactive mode instead of compiled code.

:- write('Compiling Carne...'), nl.
:- compile('carne.pl').
:- runtime_entry(start).   % this would be done automatically when loading compiled code.



