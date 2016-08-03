(setf (current-problem)
      (create-problem
       (name test2)
       (objects
	(objects-are o1 o2  OBJECT)
	(objects-are t1 t2 TRUCK)
	(objects-are p1 AIRPLANE)
	(objects-are po1 po2 POST-OFFICE)
	(objects-are airp1 airp2 AIRPORT)
	(objects-are c1 c2 CITY))
       (state
	(and (at-obj o1 po1) (at-obj o2 po1)
	     (at-airplane p1 airp2)
	     (at-truck t1 airp1)
	     (at-truck t2 po2)	     
	     (part-of t1 c1)
	     (part-of t2 c2)
	     (loc-at po1 c1)
	     (loc-at airp1 c1)
	     (loc-at po2 c2)
	     (loc-at airp2 c2)
	     (same-city po1 airp1)
	     (same-city airp1 po1)
	     (same-city po2 airp2)
	     (same-city airp2 po2)))
       (igoal
	(and (at-obj o1 airp2)
	     (at-obj o2 airp2)))))

