(setf (current-problem)
      (create-problem
       (name pgh1)
       (objects
	(object-is package1  OBJECT)
	(objects-are pgh-truck bos-truck  TRUCK)
	(object-is airplane1 AIRPLANE)
	(objects-are bos-po pgh-po POST-OFFICE)
	(objects-are pgh-airport bos-airport  AIRPORT)
	(objects-are pittsburgh boston CITY))
       (state
	(and (at-obj package1 pgh-airport)
	     (at-airplane airplane1 pgh-airport)
;	     (at-airplane airplane2 pgh-airport)
	     (at-truck pgh-truck pgh-po)
	     (at-truck bos-truck bos-po)
	     (part-of bos-truck boston)
	     (part-of pgh-truck pittsburgh)
	     (loc-at pgh-po pittsburgh)
	     (loc-at pgh-airport pittsburgh)
	     (loc-at bos-po boston)
	     (loc-at bos-airport boston)
	     (same-city bos-po bos-airport)
	     (same-city pgh-po pgh-airport)
	     (same-city pgh-airport pgh-po)
	     (same-city bos-airport bos-po)))
       (igoal
	(and (at-obj package1 bos-airport)))))
#|
	     (~ (at-airplane airplane2 pgh-airport))))))
	( package1 OBJECT)

(run :depth-bound 43)

((:ACHIEVE
  . #<APP-OP-NODE name 47 op #<UNLOAD-TRUCK [<OBJ> PACKAGE1] [<TRUCK> BOS-TRUCK] [<LOC> BOS-PO]>>)
 #<IN-SAME-CITY [<LOC1> BOS-PO] [<LOC2> BOS-AIRPORT] [<CITY> BOSTON]>
 #<IN-SAME-CITY [<LOC1> PGH-PO] [<LOC2> PGH-AIRPORT] [<CITY> PITTSBURGH]>
 #<IN-SAME-CITY [<LOC1> PGH-AIRPORT] [<LOC2> PGH-PO] [<CITY> PITTSBURGH]>
 #<IN-SAME-CITY [<LOC1> BOS-AIRPORT] [<LOC2> BOS-PO] [<CITY> BOSTON]>
 #<LOAD-TRUCK [<OBJ> PACKAGE1] [<TRUCK> PGH-TRUCK] [<LOC> PGH-PO]>
 #<DRIVE-TRUCK [<TRUCK> PGH-TRUCK] [<LOC-FROM> PGH-PO] [<LOC-TO> PGH-AIRPORT]>
 #<DRIVE-TRUCK [<TRUCK> BOS-TRUCK] [<LOC-FROM> BOS-PO] [<LOC-TO> BOS-AIRPORT]>
 #<UNLOAD-TRUCK [<OBJ> PACKAGE1] [<TRUCK> PGH-TRUCK] [<LOC> PGH-AIRPORT]>
 #<LOAD-AIRPLANE [<OBJ> PACKAGE1] [<AIRPLANE> AIRPLANE2] [<LOC> PGH-AIRPORT]>
 #<FLY-AIRPLANE [<AIRPLANE> AIRPLANE2] [<LOC-FROM> PGH-AIRPORT] [<LOC-TO> BOS-AIRPORT]>
 #<UNLOAD-AIRPLANE [<OBJ> PACKAGE1] [<AIRPLANE> AIRPLANE2] [<LOC> BOS-AIRPORT]>
 #<LOAD-TRUCK [<OBJ> PACKAGE1] [<TRUCK> BOS-TRUCK] [<LOC> BOS-AIRPORT]>
 #<DRIVE-TRUCK [<TRUCK> BOS-TRUCK] [<LOC-FROM> BOS-AIRPORT] [<LOC-TO> BOS-PO]>
 #<UNLOAD-TRUCK [<OBJ> PACKAGE1] [<TRUCK> BOS-TRUCK] [<LOC> BOS-PO]>)
p|#
