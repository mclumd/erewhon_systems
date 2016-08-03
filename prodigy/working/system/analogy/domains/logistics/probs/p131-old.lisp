;;; This is (isomorphic to) the "past case" used in the replay discussion in
;;; Veloso (1994), pp. 131-133. See file p131-new.lisp
;;;
;;; The solution will be:
;;;
;;; <load-truck package1 pgh-truck pgh-po>          
;;; <drive-truck pgh-truck pgh-po pgh-airport>      
;;; <unload-truck package1 pgh-truck pgh-airport>   
;;; <fly-airplane airplane1 bos-airport pgh-airport>
;;; <load-airplane package1 airplane1 pgh-airport>  
;;; <fly-airplane airplane1 pgh-airport bos-airport>
;;; <unload-airplane package1 airplane1 bos-airport>
;;;
;;; Note that during replay the first fly-airplane step will be skipped when
;;; solving p131p-new. 


(setf (current-problem)
      (create-problem
       (name p131-old)
       (objects
	(object-is package1  OBJECT)
	(objects-are pgh-truck TRUCK)
	(objects-are airplane1 AIRPLANE)
	(objects-are pgh-po POST-OFFICE)
	(objects-are pgh-airport bos-airport  AIRPORT)
	(objects-are pittsburgh boston CITY))
       (state
	(and (at-obj package1 pgh-po)
	     (at-airplane airplane1 bos-airport)
	     (at-truck pgh-truck pgh-po)
	     (part-of pgh-truck pittsburgh)
	     (loc-at pgh-po pittsburgh)
	     (loc-at pgh-airport pittsburgh)
	     (loc-at bos-airport boston)
	     (same-city pgh-po pgh-airport)
	     (same-city pgh-airport pgh-po)
	     ))
       (igoal
	(and (at-obj package1 bos-airport)))))
