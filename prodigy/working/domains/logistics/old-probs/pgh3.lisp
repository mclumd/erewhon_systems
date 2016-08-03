(setf (current-problem)
      (create-problem
       (name pgh3)
       (objects
	(objects-are package1 package2 package3 OBJECT)
	(objects-are pgh-truck bos-truck la-truck TRUCK)
	(objects-are airplane1 airplane2 AIRPLANE)
	(objects-are bos-po la-po pgh-po POST-OFFICE)
	(objects-are bos-airport la-airport pgh-airport AIRPORT)
	(objects-are pittsburgh boston los-angeles CITY))
       (state
	(and 
	 (at-obj package1 pgh-po)
	 (at-obj package2 pgh-po)
	 (at-obj package3 pgh-po)
	 (at-airplane airplane1 pgh-airport)
	 (at-airplane airplane2 pgh-airport)
	 (at-truck bos-truck bos-po)
	 (at-truck pgh-truck pgh-po)
	 (at-truck la-truck la-po)
	 (loc-at pgh-po pittsburgh)
	 (loc-at pgh-airport pittsburgh)
	 (loc-at bos-po boston)
	 (loc-at bos-airport boston)
	 (loc-at la-po los-angeles)
	 (loc-at la-airport los-angeles)
	 (part-of bos-truck boston)
	 (part-of pgh-truck pittsburgh)
	 (part-of la-truck los-angeles)))
      (igoal
       (and (at-obj package1 bos-po)
	    (at-obj package2 la-po)
	    (at-obj package3 bos-po)))))

	
