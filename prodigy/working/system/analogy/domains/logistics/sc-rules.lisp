#| ------------------------------  CONTROL RULES ------------------------------ |#

;====================
;  goal decision
;====================

(CONTROL-RULE REJECT-MOVING-CARRIER
    (IF (and (at-least-one-non-carrier-goal-p)
	     (candidate-goal <goal>)
	     (carrier-goal-p <goal>)))
    (THEN reject goal  <goal>))		      


(CONTROL-RULE REJECT-MOVING-AIRPLANE-IF-NEEDED-LOADING
    (IF (and (true-in-state (at-airplane <airplane> <loc>))
	     (candidate-goal (at-airplane <airplane> <loc2>))
	     (open-load-airplane-p <airplane> <loc>)))
    (THEN reject goal (at-airplane <airplane> <loc2>)))

;don't move the truck if it is waiting to be loaded (at-obj <obj>
;<loc>) is a precond of an open op LOAD-TRUCK)

(CONTROL-RULE REJECT-MOVING-TRUCK-IF-NEEDED-LOADING
    (IF (and (true-in-state (at-truck <truck> <loc>))
	     (candidate-goal (at-truck <truck> <loc1>))
	     (open-load-truck-p <truck> <loc>)))
    (THEN reject goal (at-truck <truck> <loc1>)))


			     
;====================
;  binding decision
;====================

#|
(CONTROL-RULE Drive-Directly
    (IF (and (current-goal (at-truck <truck> <loc1>))
	     (expanded-goal (at-obj <obj> <loc1>))
	     (current-ops (DRIVE-TRUCK))
	     (true-in-state (same-city <loc1> <loc2>))
	     (or (true-in-state (at-obj <obj> <loc2>))
		 (and (true-in-state (at-truck <truck> <loc2>))
		      (true-in-state (inside-truck <obj> <truck>))))))
    (THEN select bindings ((<loc-from> . <loc2>))))


;; Reject loading a truck at a location where the object is to be
(CONTROL-RULE EARLY-AVOID-GOAL-LOOP-LOAD-TRUCK
    (IF (and  (current-goal (inside-truck <obj> <truck>))
	      (current-ops (LOAD-TRUCK))
	      (expanded-goal (at-obj <obj> <some-loc>))))
    (THEN reject bindings ( (<loc> . <some-loc>))))

|#
#|
(Control-Rule Select-Binding-In-Obj-City
    (IF (and (current-ops (LOAD-AIRPLANE))
	     (in-obj-city-p <x> <y>)))
    (THEN select bindings ((<obj> . <x>) (<loc> . <y>))))
|#

#|
(Control-Rule Select-Airplane-available
    (IF (and (current-ops (UNLOAD-AIRPLANE))
	     (current-goal (at-obj <x> <y>))
	     (true-in-state (at-obj <x> <z>))
	     (true-in-state (at-airplane <u> <v>))
	     (in-obj-city-p <x> <v>)))
    (THEN select bindings ((<obj> . <x>) (<airplane> . <u>))))

(Control-Rule Select-Binding-In-Truck-City-Load-Truck
    (IF (and (current-ops (LOAD-TRUCK))
	     (in-truck-city-p <x> <y>)))
    (THEN select bindings ((<truck> . <x>) (<loc> . <y>))))

(Control-Rule Select-Binding-In-Truck-City-Unload-Truck
    (IF (and (current-ops (UNLOAD-TRUCK))
	     (in-truck-city-p <x> <y>)))
    (THEN select bindings ((<truck> . <x>) (<loc> . <y>))))
|#

(Control-Rule Fly-Direct
    (IF (and (current-ops (FLY-AIRPLANE))
	     (current-goal (at-airplane <x> <y>))
	     (true-in-state (at-airplane <x> <z>))))
    (THEN select bindings ((<airplane> . <x>) (<loc-from> . <z>)
			   (<loc-to> . <y>))))

;====================
;  operator decision
;====================

#|
(Control-Rule Unload-Airplane-At-Airport-if-From-Diff-City
    (IF (and (current-goal (at-obj <x> <y>))
	     (p4::type-of-object <y> AIRPORT)
	     (~ (in-obj-city-p <x> <y>))))
    (THEN select operator UNLOAD-AIRPLANE))



	      (IF (and (true-in-state (at-truck <truck> <loc>))
	     (true-in-state (at-obj <obj> <loc>))
	     (candidate-goal <goal>)
	     (truck-at-goal-p <goal>)
	     (expanded-goal-p (inside-truck <obj> <truck>))))
    (THEN reject goal <goal>))
|#


#|
(Control-Rule Do-Not-Move-Truck-Unnecessarily
    (IF (and (only-one-applicable-operator)
	     (applicable-operator (drive-truck <truck> <from> <to>))
	     (empty-truck-p <truck>)
	     (not (open-load-truck-p <truck> <loc>))
	     (top-level-goal-p
    (THEN sub-goal))
|#



#|
(CONTROL-RULE REJECT-MOVING-TRUCKS
    (IF (and (candidate-goal (at-truck <truck> <loc>))
	     (at-least-one-non-carrier-goal-p)))
    (THEN reject goal (at-truck <truck> <loc>)))


(CONTROL-RULE REJECT-MOVING-AIRPLANES 
     (IF (and (candidate-goal (at-airplane <airplane> <loc>))
	      (at-least-one-non-carrier-goal-p)))
     (THEN reject goal (at-airplane <airplane> <loc>)))
|#





#| ------------------------------  META PREDICATES  -------------------------|#
(defun only-one-applicable-operator ()
  (declare (special *current-node*))
  (eq (length (p4::a-or-b-node-applicable-ops-left *current-node*)) 1))



(defun open-load-truck-p (truck loc)
  (declare (special *current-problem-space*))
  (let ((goals (p4::problem-space-expanded-goals *current-problem-space*)))
;;    (format t "~% expanded-goals goals")

    (some #'(lambda (x)
	      (when (and (eq (p4::literal-name x) 'at-obj)
		       (eq (elt (p4::literal-arguments x) 1) loc))
;;		(format t "~% at-obj ~S" x)
		(let ((insts (p4::literal-goal-p x)))
;;		  (format t "~% inst ~S" insts)
		  (some #'(lambda (inst-op)
			    (and
			     (eq (p4::operator-name
				  (p4::instantiated-op-op inst-op))
				 'load-truck)
			     (eq (second (p4::instantiated-op-values inst-op))
				 truck)))
			insts))))
	  goals)))

#|
  (let ((goals (p4::problem-space-expanded-goals *current-problem-space*)))
    (some #'(lambda (x)
	      (and (eq (p4::literal-name x) 'inside-truck)
		   (eq truck (elt (p4::literal-arguments x) 1))
		   (eq loc
		       (get-loc-of-obj (elt (p4::literal-arguments x) 0)))))
	  goals)))
|#


(defun open-load-airplane-p (airplane loc)
  (declare (special *current-node* *current-problem-space*))
  (let ((goals (p4::problem-space-expanded-goals *current-problem-space*)))
;;    (format t "~% expanded-goals goals")

    (some #'(lambda (x)
	      (when (and (eq (p4::literal-name x) 'at-obj)
		       (eq (elt (p4::literal-arguments x) 1) loc))
;;		(format t "~% at-obj ~S" x)
		(let ((insts (p4::literal-goal-p x)))
;;		  (format t "~% inst ~S" insts)
		  (some #'(lambda (inst-op)
			    (and
			     (eq (p4::operator-name
				  (p4::instantiated-op-op inst-op))
				 'load-airplane)
			     (eq (second (p4::instantiated-op-values inst-op))
				 airplane)))
			insts))))
	  goals)))


(defun empty-truck-p (truck)
  (declare (special *current-problem-space*))
  (let ((inside-truck-hash (gethash 'inside-truck
				    (p4::problem-space-assertion-hash
				     *current-problem-space*)))
	(result t))
    (if inside-truck-hash
	(maphash #'(lambda (key val)
		     (declare (ignore key))
		     (if result
			 (if (p4::literal-state-p val)
			     (if (eq (elt (p4::literal-arguments val) 1)
				     truck)
				 (setf result nil)))))
		 inside-truck-hash))
    result))
  

(defun at-least-one-non-carrier-goal-p ()
  (declare (special *current-node* *current-problem-space*))
  (let* ((a-or-b-node (give-me-a-or-b-node *current-node*))
	 (goals (if (not (eq (p4::a-or-b-node-goals-left a-or-b-node)
			     :not-computed))
		    (p4::a-or-b-node-goals-left a-or-b-node)
		    (or (p4::a-or-b-node-pending-goals a-or-b-node)
			(p4::give-me-all-pending-goals a-or-b-node)))))
    (cond ((null goals) nil)
	  (t
	   (let ((non-carrier-goals
		  (remove-if
		   #'(lambda (goal)
		       (and (or (eq (p4::literal-name goal) 'at-truck)
				(eq (p4::literal-name goal) 'at-airplane))))
		   goals)))
	     (notevery
	      #'(lambda (x)
		(p4::goal-loop-p *current-node* x)) non-carrier-goals))))))

    
(defun will-load-obj-p (truck obj loc)
  (declare (special *current-node* *current-problem-space*))
  (let* ((goals (p4::problem-space-expanded-goals *current-problem-space*)))
;;    (format t "~% expanded-goals goals")
    (some #'(lambda (x)
	      (and (eq (p4::literal-name x) 'inside-truck)
		   (eq (elt (p4::literal-arguments x) 1) truck)
		   
		   (eq loc (get-city-of-airplane airplane))))
	  goals)))
  


;;; returns T if the goal is (at-airplane ...)
(defun airplane-at-goal-p (goal)
  (eq (p4::literal-name goal) 'at-airplane))

;;; returns T if the goal is (at-truck ...)
(defun truck-at-goal-p (goal)
  (eq (p4::literal-name goal) 'at-truck))
  
    
(defun carrier-goal-p (goal)
  (or (truck-at-goal-p goal)
      (airplane-at-goal-p goal)))


(defun expanded-goal-p (goal)
  (declare (special *current-node* *current-problem-space*
		    *candidate-goals*))

  (let ((goals (p4::problem-space-expanded-goals *current-problem-space*)))
    (cond ((p4::has-unbound-vars goal)
	   (match-candidate-goal goal goals))
	  ((member (p4::instantiate-consed-literal goal) goals) t)
	  (t nil))))
