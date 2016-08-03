(setf (current-problem)
      (create-problem
       (name pgh2)
       (objects
	(objects-are package1 package2 OBJECT)
	(objects-are pgh-truck bos-truck la-truck TRUCK)
	(objects-are airplane1 airplane2  AIRPLANE)
	(objects-are bos-po la-po pgh-po POST-OFFICE)
	(objects-are bos-airport la-airport pgh-airport AIRPORT)
	(objects-are pittsburgh boston los-angeles CITY))
       (state
	(and (at-obj package1 pgh-po)
	     (at-obj package2 pgh-po)
	     (at-airplane airplane1 pgh-airport)
	     (at-airplane airplane2 pgh-airport)
	     (at-truck pgh-truck pgh-po)
	     (at-truck bos-truck bos-po)
	     (part-of bos-truck boston)
	     (part-of pgh-truck pittsburgh)
	     (part-of la-truck los-angeles)
	     (loc-at la-po los-angeles)
	     (loc-at la-airport los-angeles)
	     (loc-at pgh-po pittsburgh)
	     (loc-at pgh-airport pittsburgh)
	     (loc-at bos-po boston)
	     (loc-at bos-airport boston)))
       (igoal
	(and (at-obj package1 bos-po) (at-obj package2 bos-po)))))


