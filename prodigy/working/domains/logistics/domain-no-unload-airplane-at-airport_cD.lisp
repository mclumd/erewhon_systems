#|
--------------------------------------------------------------------------------

LOGISTICS domain.

--------------------------------------------------------------------------------
|#

(create-problem-space 'logistics :current t)

(ptype-of OBJECT :top-type)
(ptype-of CARRIER :top-type)
(ptype-of TRUCK  CARRIER)
(ptype-of AIRPLANE CARRIER)
(ptype-of LOCATION :top-type)
(ptype-of AIRPORT LOCATION)
(ptype-of POST-OFFICE LOCATION)
(ptype-of CITY :top-type)



#|  ------------------------------  OPERATORS ------------------------------ |#



(OPERATOR LOAD-TRUCK
  (params <obj> <truck> <loc>)  ;; params are used for printing purposes only
  (preconds
   ((<obj> OBJECT)
    (<truck> TRUCK)
    (<loc>  (and LOCATION (in-truck-city-p  <truck> <loc>))))
   (and (at-obj <obj> <loc>)
	(at-truck <truck> <loc>)))
  (effects ()
   ((add (inside-truck <obj> <truck>))
    (del (at-obj <obj> <loc>)))))


(OPERATOR LOAD-AIRPLANE
  (params <obj> <airplane> <loc>)
  (preconds 
   ((<obj> OBJECT)
    (<airplane> AIRPLANE)
    (<loc> (and AIRPORT (in-obj-city-p <obj> <loc>))))
   (and (at-obj <obj> <loc>)
	(at-airplane <airplane> <loc>)))
  (effects ()
   ((del (at-obj <obj> <loc>))
    (add (inside-airplane <obj> <airplane>)))))


(OPERATOR UNLOAD-TRUCK
  (params <obj> <truck> <loc>)
  (preconds 
   ((<obj> OBJECT)
    (<truck> TRUCK)
    (<loc> (and LOCATION (in-truck-city-p <truck> <loc>))))
   (and (inside-truck <obj> <truck>)
	(at-truck <truck> <loc>)))
  (effects ()
   ((del (inside-truck <obj> <truck>))
    (add (at-obj <obj> <loc>)))))


(OPERATOR UNLOAD-AIRPLANE
  (params <obj> <airplane> <loc>)
  (preconds 
   ((<obj> OBJECT)
    (<airplane> AIRPLANE)
    (<loc> AIRPORT))
   (and (inside-airplane <obj> <airplane>)
	(at-airplane <airplane> <loc>)))
  (effects ()
   ((del (inside-airplane <obj> <airplane>))
    (add (at-obj <obj> <loc>)))))


(OPERATOR DRIVE-TRUCK
  (params <truck> <loc-from> <loc-to>)
  (preconds
   ((<truck> TRUCK)
    (<loc-from> LOCATION)
    (<loc-to> (and LOCATION (diff <loc-from> <loc-to>))))
   (and
    (same-city <loc-from> <loc-to>)
    (at-truck <truck> <loc-from>)))
  (effects ()
   ((del (at-truck <truck> <loc-from>))
    (add (at-truck <truck> <loc-to>)))))


(OPERATOR FLY-AIRPLANE
  (params <airplane> <loc-from> <loc-to>)
  (preconds
   ((<airplane> AIRPLANE)
    (<loc-from> AIRPORT)
    (<loc-to> (and AIRPORT (diff <loc-from> <loc-to>))))
   (at-airplane <airplane> <loc-from>))
  (effects ()
   ((del (at-airplane <airplane> <loc-from>))
    (add (at-airplane <airplane> <loc-to>)))))


(Inference-Rule  IN-SAME-CITY
   (mode eager)

   (params <loc1> <loc2> <city>)
   (preconds
    ((<loc1> LOCATION)
     (<loc2> (and LOCATION (diff <loc1> <loc2>)))
     (<city> CITY))
    (and (loc-at <loc1> <city>)
	 (loc-at <loc2> <city>)))
   (effects ()
    ((add (same-city <loc1> <loc2>)))))



;;; ***********************************************************
;;; Control rules   - aperez  Feb 92
;;; See new meta-predicates at the end of this file

;;rules to prefer dealing with package locations before moving the
;;carriers 

(control-rule REJECT-MOVING-AIRP1
  (if (and (candidate-goal (at-airplane <airplane> <loc>))
	   (candidate-goal (at-obj <package> <other-loc>))))
  (then reject goal (at-airplane <airplane> <loc>)))

(control-rule REJECT-MOVING-AIRP2
  (if (and (candidate-goal (at-airplane <airplane> <loc>))
	   (candidate-goal (inside-truck <package> <truck>))))
  (then reject goal (at-airplane <airplane> <loc>)))

(control-rule REJECT-MOVING-AIRP3
  (if (and (candidate-goal (at-airplane <airplane1> <loc>))
	   (candidate-goal (inside-airplane <package> <airplane2>))))
  (then reject goal (at-airplane <airplane1> <loc>)))

(control-rule REJECT-MOVING-TRUCK1
  (if (and (candidate-goal (at-truck <truck> <loc>))
	   (candidate-goal (at-obj <package> <other-loc>))))
  (then reject goal (at-truck <truck> <loc>)))

(control-rule REJECT-MOVING-TRUCK2
  (if (and (candidate-goal (at-truck <truck> <loc>))
	   (candidate-goal (inside-airplane <package> <airplane>))))
  (then reject goal (at-truck <truck> <loc>)))

(control-rule REJECT-MOVING-TRUCK3
  (if (and (candidate-goal (at-truck <truck1> <loc>))
	   (candidate-goal (inside-truck <package> <truck2>))))
  (then reject goal (at-truck <truck1> <loc>)))


;; reject moving truck if needed loading

(control-rule REJECT-MOVING-AIRPLANE-IF-NEEDED-LOADING
  (if (and (candidate-goal (at-airplane <airplane> <new-loc>))
	   (known (at-airplane <airplane> <loc>))
	   (expanded-operator 
	    (LOAD-AIRPLANE <obj> <airplane> <loc>))))
  (then reject goal (at-airplane <airplane> <new-loc>)))

(control-rule REJECT-MOVING-TRUCK-IF-NEEDED-LOADING
  (if (and (candidate-goal (at-truck <truck> <new-loc>))
           (known (at-truck <truck> <loc>))
           (expanded-operator
	    (LOAD-TRUCK <obj> <truck> <loc>))))
  (then reject goal (at-truck <truck> <new-loc>)))

;;other goal ordering rules to be able to interleave the plans for
;;moving different packages, and therefore using the same airplane for
;;moving diff packages with same origin and destination

(control-rule LOAD-OTHER-OBJ-FIRST
  (if (and (candidate-goal (inside-truck <obj> <truck>))
	   (candidate-goal (at-obj <other-obj> <loc>))
	   (diff <obj> <other-obj>)
	   (expanded-goal  (inside-truck <other-obj> <truck>))))
  (then prefer goal (inside-truck <obj> <truck>)
	            (at-obj <other-obj> <loc>)))

(control-rule MOVE-OTHER-OBJ-TO-AIRPORT-FIRST
  (if (and (candidate-goal (at-obj <obj> <airport>))
	   (type-of-object <airport> airport)
	   (candidate-goal (inside-airplane <other-obj> <airplane>))
	   (diff <obj> <other-obj>)
	   (expanded-goal (at-obj <other-obj> <airport>))))
  (then reject goal (inside-airplane <other-obj> <airplane>)))


;;use same airplane for moving diff packages with same origin and
;;destination 

(control-rule SAME-AIRPLANE
  (if (and (current-goal (at-obj <object> <airport>))
	   (type-of-object <airport> airport)
	   (current-operator UNLOAD-AIRPLANE)
	   (expanded-goal (at-obj <other-obj> <airport>))
	   (diff <object> <other-obj>)
	   ;;both objects come from the same destination
	   (known (at-obj <object> <loc>))
	   (known (at-obj <other-obj> <other-loc>))
	   (or (same-city <loc> <other-loc>)
	       (equal <loc> <other-loc>))
	   ;;get the airplane chosen for the first object
	   (is-op-for-goal-p
	    (UNLOAD-AIRPLANE <other-obj> <plane> <airport>)
	    (at-obj <other-obj> <airport>))))
  (then select bindings ((<obj> . <object>)(<airplane> . <plane>)
					   (<loc> . <airport>))))

;;; ||||| This should work but does not. :-( [mcox]
(control-rule NO-UNLOAD-AIRPLANE-AT-AIRPORT_CD
  (if (and (current-goal (at-obj <object> airport_cD))
	   (type-of-object airport_cD airport)
	   (current-operator UNLOAD-AIRPLANE)))
  (then reject bindings ((<loc> . airport_cD))))

;;use different airplane if available for moving packages with
;;different destinations


(control-rule DIFF-AIRPLANE
  (if (and (current-goal (at-obj <object> <airport>))
	   (type-of-object <airport> airport)
	   (current-operator UNLOAD-AIRPLANE)
	   (expanded-goal (at-obj <other-obj> <other-airport>))
	   (diff <object> <other-obj>)
	   (diff <airport> <other-airport>)
	   ;;get a different airplane
	   (is-op-for-goal-p
	    (UNLOAD-AIRPLANE <other-obj> <plane> <other-airport>)
	    (at-obj <other-obj> <other-airport>))))
  (then reject bindings ((<obj> . <object>)(<airplane> . <plane>)
					   (<loc> . <airport>))))
 

;;prefer airplane already at that city
(control-rule USE-AIRPLANE-IN-CITY
  (if (and (current-goal (at-obj <object> <airport>))
	   (type-of-object <airport> airport)
	   (current-operator UNLOAD-AIRPLANE)
	   (known (at-airplane <plane> <city>))
	   (known (at-obj <object> <other-loc>))
	   (or (same-city <other-loc> <city>)
	       (equal <other-loc> <city>))))
  (then select bindings ((<obj> . <object>)(<airplane> . <plane>)
					   (<loc> . <airport>))))


;;prefer truck already at that location 

(control-rule USE-TRUCK-IN-LOCATION
  (if (and (current-goal (at-obj <object> <new-loc>))
	   (current-operator UNLOAD-TRUCK)
	   (known (at-truck <trck> <truck-loc>))
	   (same-city <truck-loc> <new-loc>)))
  (then select bindings ((<obj> . <object>)(<truck> . <trck>)
			 (<loc> . <new-loc>))))


;;; *****************************************************************
;;; New meta-predicates 
;;; They are all domain independent. -- aperez Feb. 92


;;This is similar to the original candidate-goal but considering only
;;candidate goals those that do not lead to a goal loop. Should
;;candidate-goal do this?

(defun candidate-goal (goal)
  (declare (special *current-node* *current-problem-space*
		    *candidate-goals*))
  (test-match-goals goal (candidate-goals)))

(defun candidate-goals ()
  (remove-if #'(lambda (x)(p4::goal-loop-p *current-node* x))
	     (if (boundp '*candidate-goals*)
		 *candidate-goals*
	       (p4::a-or-b-node-pending-goals
		(give-me-a-or-b-node *current-node*)))))

(defun is-op-for-goal-p (inst-op-exp goal-exp)
  ;;goal-exp and inst-op-exp have to be bound to lists
  ;;goal-exp has to be completely instantiated (from other meta-preds)
  ;;The car of inst-op-exp, (the op-name) has to be bound, but its 
  ;;arguments don't need to be bound
  ;;(we will use this meta-pred to get bindings for the vars in the op)
  (let ((binding-node
	 (find-inst-op-node *current-node* goal-exp nil)))
    (cond
     ((null binding-node) nil)
     ;;check op name 
     ((not (eq (p4::operator-name
		(p4::instantiated-op-op
		 (p4::binding-node-instantiated-op binding-node)))
	       (car inst-op-exp)))
      nil)
     (t
      (let* (new-bindings
	     (result
	       (every
		#'(lambda (arg-obj arg-name)
		    ;;allow arg-name to be a variable
		    (cond ((p4::strong-is-var-p arg-name)
			   (push (cons arg-name arg-obj) new-bindings))
			  (t (equal arg-obj arg-name))))
		(p4::instantiated-op-values
		 (p4::binding-node-instantiated-op binding-node))
		(cdr inst-op-exp))))
	(if new-bindings (list new-bindings) result))))))

(defun find-inst-op-node (node goal-exp grand-child)
  ;;path is (goal op bindings apply-op*)
  ;;this will break if node does not have enough ancestrors 
  (let ((next-goal-and-bind-nodes
	 (case
	  (type-of node)
	  (p4::goal-node
	   (next-goal (p4::nexus-parent node) node nil))
	  (p4::operator-node
	   (next-goal
	    (p4::nexus-parent (p4::nexus-parent node))
	    (p4::nexus-parent node)
	    node))
	  (p4::binding-node
	   (next-goal
	    (p4::nexus-parent (p4::nexus-parent (p4::nexus-parent node)))
	    (p4::nexus-parent (p4::nexus-parent node))
	    (p4::nexus-parent node)))
	  (p4::applied-op-node
	   (next-goal (p4::nexus-parent node) node nil)))))
    (if next-goal-and-bind-nodes
	(find-inst-op-node-rec (car next-goal-and-bind-nodes)
			       goal-exp
			       (cdr next-goal-and-bind-nodes)))))
      

(defun next-goal (node child grand-child)
  ;;return (goal-node . grand-child)
  (cond
   ((null node) nil)
   ((typep node 'p4::goal-node)
    (cons node grand-child))
   (t (next-goal (p4::nexus-parent node)
		 node child))))

  
(defun find-inst-op-node-rec (node goal-exp grand-child)
  ;;assumes goal-exp is fully instantiated
  (cond
   ((and 
     (typep node 'p4::goal-node)
     (equal (p4::goal-node-goal node)
	    (p4::instantiate-consed-literal goal-exp)))
    grand-child)
   ((null (p4::nexus-parent node)) nil)
   (t (find-inst-op-node-rec (p4::nexus-parent node)
			 goal-exp
			 (p4::nexus-parent grand-child)))))

