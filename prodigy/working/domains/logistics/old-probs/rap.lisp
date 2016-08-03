

(setf (current-problem)
      (create-problem
       (name rap)
       (objects
	(objects-are o1 o2  OBJECT)
	(objects-are t1 t2 TRUCK)
	(objects-are air1 AIRPLANE)
	(objects-are po1 po2 po3 POST-OFFICE)
	(objects-are a1 a2 a3 AIRPORT)
	(objects-are c1 c2 c3 CITY))
       (state
	(and (inside-truck o1 t1)
	     (at-obj o2 po2)
	     (at-airplane air1 a3)
	     (at-truck t1 a1)
	     (at-truck t2 a2)
	     (part-of t1 c1)
	     (part-of t2 c2)
	     (loc-at po1 c1)
	     (loc-at po2 c2)
	     (loc-at po3 c3)
	     (loc-at a3 c3)
	     (loc-at a2 c2)
	     (loc-at a1 c1)))
       (goal
	(and (at-obj o1 a3)
	     (inside-truck o2 t2)))))



#|
(setf (current-problem)
      (create-problem
       (name rap)
       (objects
	(objects-are envelope packet OBJECT)
	(objects-are red-truck blue-truck TRUCK)
	(objects-are airplane AIRPLANE)
	(objects-are po-boston po-pitt po-phila POST-OFFICE)
	(objects-are air-boston air-pitt air-phila AIRPORT)
	(objects-are boston pittsburgh philadelphia CITY))
       (state
	(and (inside-truck envelope red-truck)
	     (at-obj packet po-pitt)
	     (at-airplane airplane air-phila)
	     (at-truck red-truck air-boston)
	     (at-truck blue-truck air-pitt)
	     (part-of red-truck boston)
	     (part-of blue-truck pittsburgh)
	     (loc-at po-boston boston)
	     (loc-at po-pitt pittsburgh)
	     (loc-at po-phila philadelphia)
	     (loc-at air-phila philadelphia)
	     (loc-at air-pitt pittsburgh)
	     (loc-at air-boston boston)))
       (goal
	(and (at-obj envelope air-phila)
	     (inside-truck packet blue-truck)))))
|#


