(setf (current-problem)
      (create-problem
       (name abmic)
       (objects
	(objects-are package1 package2 OBJECT)
	(objects-are pgh-truck bos-truck  TRUCK)
	(object-is airplane1 AIRPLANE)
	(objects-are bos-po1 bos-po2 pgh-po1 pgh-po2 POST-OFFICE)
	(objects-are pgh-airport bos-airport  AIRPORT)
	(objects-are pittsburgh boston CITY))
       (state
	(and (at-obj package1 pgh-po1)
	     (at-obj package2 bos-po1)
	     (at-airplane airplane1 pgh-airport)
	     (at-truck pgh-truck pgh-po2)
	     (at-truck bos-truck bos-po2)
	     (part-of bos-truck boston)
	     (part-of pgh-truck pittsburgh)
	     (loc-at pgh-po1 pittsburgh)
	     (loc-at pgh-po2 pittsburgh)
	     (loc-at pgh-airport pittsburgh)
	     (loc-at bos-po1 boston)
	     (loc-at bos-po2 boston)
	     (loc-at bos-airport boston)
	     (same-city bos-po1 bos-airport)
	     (same-city bos-po2 bos-airport)
	     (same-city pgh-po1 pgh-airport)
	     (same-city pgh-po2 pgh-airport)
	     (same-city pgh-airport pgh-po1)
	     (same-city bos-airport bos-po1)
	     (same-city pgh-airport pgh-po2)
	     (same-city bos-airport bos-po2)
	     ))
       (goal
	(and 
	 (at-obj package1 bos-po2)
	 (at-obj package2 pgh-po2)
	     ))))
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
