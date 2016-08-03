;;; This is the "new problem" used in the multiple-case replay discussion in
;;; Veloso (1994), pp. 133-135. See files p133-old1.lisp and p133-old2.lisp.
;;; In the old problem for solving the inside-truck goal, the truck is at the
;;; airport rather than the post office. In the old problem for solving the
;;; inside-airplane goal, the object is at the local airport rather than inside
;;; the truck.
;;;
;;; Need to use either serial or eager-apply merge modes for this problem, not
;;; SABA.
;;;
(setf (current-problem)
      (create-problem
       (name p133-new)
       (objects
	(objects-are ob3 ob8  OBJECT)
	(object-is tr2 TRUCK)
	(object-is p15 AIRPLANE)
	(object-is p4 POST-OFFICE)
	(objects-are a4 a12 AIRPORT)
	(objects-are pittsburgh boston CITY))
       (state
	(and (at-obj ob8 p4)
	     (at-airplane p15 a12)
	     (at-truck tr2 p4)
	     (inside-truck ob3 tr2)
	     (part-of tr2 pittsburgh)
	     (loc-at p4 pittsburgh)
	     (loc-at a4 pittsburgh)
	     (loc-at a12 boston)
	     (same-city p4 a4)
	     (same-city a4 p4)
	     ))
       (igoal
	(and (inside-truck ob8 tr2)
	     (inside-airplane ob3 p15)))))
