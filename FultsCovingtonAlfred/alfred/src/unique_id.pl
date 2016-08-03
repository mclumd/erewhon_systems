/*Scott Fults 8/24/09
  creates a list of unique numbers, using a number stored
  in a file (currentMaxID.pl) as the start number,
  increasing that number by 1 for every ID needed, and
  then storing the final number in the file.*/
/*Doesn't work.  Not useful anyway...calls must occur
  in the consequent of rules, not antecedent.*/


/*Get current ID from file, and go on to loop.*/
unique_id(IDList) :-
   af(test1),
   open('/fs/qubit/scott/linAlfred/src/currentMaxID', read, Stream),
   af(test2),
   read(Stream, curMaxID),
   af(test3),
   close(Stream),
   af(tst4),
   createUniqueIDs(curMaxID, IDList).     /*go to loop with num and id list*/

/*stop condition: when id list is empty, make current id equal to num*/
createUniqueIDs(Num,[]):-
   open('/fs/qubit/scott/linAlfred/src/currentMaxID', write, Stream),
   write(Stream, Num),
   close(Stream).

/*loop*/
createUniqueIDs(Num, [ID|IDList]) :-
    NewNum is Num + 1,                  /*increase num by 1*/
    number_chars(Num, NumList),         /*make num a list of ascii chars*/
    atom_chars(ID, NumList),            /*make ID atoms from ascii char list*/
    createUniqueIDs(NewNum, IDList).    /*send rest of list with newNum*/

