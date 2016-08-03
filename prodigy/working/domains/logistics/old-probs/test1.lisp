(setf (current-problem)
      (create-problem
       (name test1)
       (objects
	(objects-are o1 o2  OBJECT)
	(objects-are t1  TRUCK)
	(objects-are p1 AIRPLANE)
	(objects-are po1 POST-OFFICE)
	(objects-are airp1 AIRPORT)
	(objects-are c1 CITY))
       (state
	(and (at-obj o1 po1) (at-obj o2 po1)
	     (at-airplane p1 po1)
	     (at-truck t1 po1)
	     (part-of t1 c1)
	     (loc-at po1 c1)
	     (loc-at airp1 c1)
	     (same-city po1 airp1)
	     (same-city airp1 po1)))
       (igoal
	(and (at-obj o1 airp1)
	     (at-obj o2 airp1)))))
