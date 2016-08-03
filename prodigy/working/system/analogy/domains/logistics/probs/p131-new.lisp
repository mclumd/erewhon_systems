;;; This is (isomorphic to) the "new problem" used in the replay discussion in
;;; Veloso's thesis (Veloso, 1994), pp. 131-133. See file p131-old.lisp
;;;
;;; The solution will be:
;;;
;;; <drive-truck pgh-truck pgh-airport pgh-po>      
;;; <load-truck package1 pgh-truck pgh-po>          
;;; <drive-truck pgh-truck pgh-po pgh-airport>      
;;; <unload-truck package1 pgh-truck pgh-airport>   
;;; <load-airplane package1 airplane1 pgh-airport>  
;;; <fly-airplane airplane1 pgh-airport bos-airport>
;;; <unload-airplane package1 airplane1 bos-airport>
;;;
;;; Note that during the replay of p131p-old the first step (i.e., drive-truck,
;;; is an extra step. 

(setf (current-problem)
      (create-problem
       (name p131-new)
       (objects
	(object-is package1  OBJECT)
	(objects-are pgh-truck TRUCK)
	(objects-are airplane1 AIRPLANE)
	(objects-are pgh-po POST-OFFICE)
	(objects-are pgh-airport bos-airport  AIRPORT)
	(objects-are pittsburgh boston CITY))
       (state
	(and (at-obj package1 pgh-po)
	     (at-airplane airplane1 pgh-airport)
	     (at-truck pgh-truck pgh-airport)
	     (part-of pgh-truck pittsburgh)
	     (loc-at pgh-po pittsburgh)
	     (loc-at pgh-airport pittsburgh)
	     (loc-at bos-airport boston)
	     (same-city pgh-po pgh-airport)
	     (same-city pgh-airport pgh-po)
	     ))
       (igoal
	(and (at-obj package1 bos-airport)))))
