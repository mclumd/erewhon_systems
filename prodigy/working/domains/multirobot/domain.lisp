(create-problem-space 'multirobot :current t)

(ptype-of Object-Or-Robot :Top-type)
(ptype-of Object Object-Or-Robot)
(ptype-of Robot Object-Or-Robot)
(ptype-of Block Object)
(ptype-of Box Object)
(ptype-of Room :Top-type)
(ptype-of Door :Top-type)
(infinite-type Position #'numberp)


(OPERATOR GOTO-LOCATION
    (params <robot> <room> <xs> <ys> <xdest> <ydest>)
    (preconds
     ((<robot> ROBOT)
      (<room> ROOM)
      (<xs> (and POSITION (inside t <xs> <room>)))
      (<ys> (and POSITION 
		 (get-initial-location <robot> <xs> <ys> <room>))))
     (at <robot> <xs> <ys>))
    (effects
     ((<xdest> (and POSITION (inside t <xdest> <room>)))
      (<ydest> (and POSITION (inside nil <ydest> <room>))))
     ((del (at <robot> <xs> <ys>))
      (add (at <robot> <xdest> <ydest>)))))


(OPERATOR PUSH-TO-LOCATION   
   (params <robot> <object> <room> <xs> <ys> <xdest> <ydest>)
   (preconds
    ((<robot>   ROBOT)
     (<object> (or BOX BLOCK))
     (<room> ROOM)
     (<xs> (and POSITION (inside t <xs> <room>)))
     (<ys> (and POSITION 
		(get-initial-location <object> <xs> <ys> <room>))))
    (and (at <object> <xs> <ys>)
	 (pushable  <object>)    
	 (at <robot> <xs> <ys>)))
   (effects
    ((<xdest> (and POSITION (inside t <xdest> <room>)))
     (<ydest> (and POSITION (inside nil <ydest> <room>))))
    ((del (at <robot> <xs> <ys>))
     (del (at <object> <xs> <ys>))
     (add (at <robot> <xdest> <ydest>))
     (add (at <object> <xdest> <ydest>)))))



(OPERATOR T-PUSH-TO-LOCATION
 (params <robot1> <robot2> <object> <room> <xs> <ys> <xdest> <ydest>)	  
 (preconds
  ((<robot1>  ROBOT)
   (<robot2>  (and ROBOT (diff <robot1> <robot2>)))
   (<object> (or BOX BLOCK))
   (<room> ROOM)
   (<xs> (and POSITION (inside t <xs> <room>)))
   (<ys> (and POSITION 
	      (get-initial-location <object> <xs> <ys> <room>))))
  (and (at <object> <xs> <ys>)
       (team-pushable  <object>)    
       (at <robot1> <xs> <ys>)
       (at <robot2> <xs> <ys>)))
 (effects
  ((<xdest> (and POSITION (inside t <xdest> <room>)))
   (<ydest> (and POSITION (inside nil <ydest> <room>))))
  ((del (at <robot1> <xs> <ys>))
   (del (at <robot2> <xs> <ys>))
   (del (at <object> <xs> <ys>))
   (add (at <robot1> <xdest> <ydest>))
   (add (at <robot2> <xdest> <ydest>))
   (add (at <object> <xdest> <ydest>)))))






(OPERATOR GO-THRU-DOOR                     ;take loc out of params
   (params <robot> <door> <room1> <room2> <xroom1> <yroom1> <x2> <y2>)
   (preconds
    ((<robot> ROBOT)
     (<door> DOOR)
     (<room1> ROOM)
     (<xroom1> (and POSITION 
		    (get-door-coord t <door> <room1> <xroom1>)))
     (<yroom1> (and POSITION 
		    (get-door-coord nil <door> <room1> <yroom1>))))
    (and 
     (at <robot> <xroom1> <yroom1>)
     (door-open <door>)))
   (effects
    ((<room2> (and ROOM (diff <room1> <room2>)))
     (<x2> (and POSITION (get-door-coord t <door> <room2> <x2>)))
     (<y2> (and POSITION (get-door-coord nil <door> <room2> <y2>))))
    ((del (at <robot> <xroom1> <yroom1>))
     (add (at <robot> <x2> <y2>)))))






(OPERATOR PUSH-THRU-DOOR                     ;take loc out of params
   (params <robot> <object> <door> <room1> <room2> <xroom1> <yroom1> <x2> <y2>)
   (preconds
    ((<robot> ROBOT)
     (<object> (or BOX BLOCK))
     (<door> DOOR)
     (<room1> ROOM)
     (<xroom1> (and POSITION 
		    (get-door-coord t <door> <room1> <xroom1>)))
     (<yroom1> (and POSITION 
		    (get-door-coord nil <door> <room1> <yroom1>)))
     (<room2> (and ROOM (diff <room1> <room2>)))
     (<x2> (and POSITION (get-door-coord t <door> <room2> <x2>)))
     (<y2> (and POSITION (get-door-coord nil <door> <room2> <y2>))))
    (and
     (pushable <object>)
     (at <robot> <xroom1> <yroom1>)
     (at <object> <xroom1> <yroom1>)
     (door-open <door>)))
   (effects ()
    ((del (at <robot> <xroom1> <yroom1>))
     (del (at <object> <xroom1> <yroom1>))
     (add (at <robot> <x2> <y2>))
     (add (at <object> <x2> <y2>)))))





(OPERATOR T-PUSH-THRU-DOOR                     ;take loc out of params
   (params <robot1> <robot2> <object> <door> <room1> <room2>
	   <xroom1> <yroom1> <x2> <y2>)
   (preconds
    ((<robot1> ROBOT)
     (<robot2> (and ROBOT (diff <robot1> <robot2>)))
     (<object> (or BOX BLOCK))
     (<door> DOOR)
     (<room1> ROOM)
     (<xroom1> (and POSITION 
		    (get-door-coord t <door> <room1> <xroom1>)))
     (<yroom1> (and POSITION 
		    (get-door-coord nil <door> <room1> <yroom1>))))
    (and
     (team-pushable <object>)
     (at <robot1> <xroom1> <yroom1>)
     (at <robot2> <xroom1> <yroom1>)
     (at <object> <xroom1> <yroom1>)
     (door-open <door>)))
   (effects
    ((<room2> (and ROOM (diff <room1> <room2>)))
     (<x2> (and POSITION (get-door-coord t <door> <room2> <x2>)))
     (<y2> (and POSITION (get-door-coord nil <door> <room2> <y2>))))
    ((del (at <robot1> <xroom1> <yroom1>))
     (del (at <robot2> <xroom1> <yroom1>))
     (del (at <object> <xroom1> <yroom1>))
     (add (at <robot1> <x2> <y2>))
     (add (at <robot2> <x2> <y2>))
     (add (at <object> <x2> <y2>)))))




(OPERATOR OPEN-DOOR
  (params <robot> <door>)
  (preconds
   ((<robot> ROBOT)
    (<door> DOOR))
   (and
    (next-to <robot> <door>)
    (door-closed <door>)))
 (effects
  ()
  ((del (door-closed <door>))
   (add (door-open <door>)))))


(OPERATOR CLOSE-DOOR
  (params <robot> <door>)
  (preconds
   ((<robot> ROBOT)
    (<door> DOOR))
   (and
    (next-to <robot> <door>)
    (door-open <door>)))
 (effects
  ()
  ((del (door-open <door>))
   (add (door-closed <door>)))))


(OPERATOR PUT-INTO-BOX                 ;may add (not-full <box>) as precond
    (params <robot> <block> <box> <x> <y>)
    (preconds
     ((<robot> ROBOT)
      (<block> (or BLOCK BOX))
      (<box>   BOX)
      (<x> (and POSITION (get-coord t <box> <x>)))
      (<y> (and POSITION (get-coord nil <box> <y>))))
    (and 
     (pushable <block>)
     (forall ((<other-box> (and BOX (diff <box> <other-box>))))
	     (~ (in <other-box> <block>)))
     (at <box> <x> <y>)
     (next-to <box> <block>)
     (next-to <robot> <box>)))
    (effects
     ()
     ((add (in <box> <block>))
      (del (at <block> <x> <y>)))))


(OPERATOR T-PUT-INTO-BOX                 ;may add (not-full <box>) as precond
    (params <robot1> <robot2> <block> <box> <x> <y>)
    (preconds
     ((<robot1> ROBOT)
      (<robot2> (and ROBOT (diff <robot1> <robot2>)))
      (<block> (or BLOCK BOX))
      (<box>   BOX)
      (<x> (and POSITION (get-coord t <box> <x>)))
      (<y> (and POSITION (get-coord nil <box> <y>))))
     (and 
      (team-pushable <block>)
      (forall ((<other-box> (and BOX (diff <box> <other-box>))))
	      (~ (in <other-box> <block>)))
      (at <box> <x> <y>)
      (next-to <box> <block>)
      (next-to <robot1> <box>)
      (next-to <robot2> <box>)))
    (effects
     ()
     ((add (in <box> <block>))
      (del (at <block> <x> <y>)))))


(OPERATOR TAKE-OUT-OF-BOX  
    (params <robot> <block> <box> <x> <y>)
 (preconds
  ((<robot> ROBOT)
   (<block> (or BLOCK BOX))
   (<box>   BOX))
  (and 
   (pushable <block>)
   (in <box> <block>)
   (next-to <robot> <box>)))
 (effects
  ((<x> (and POSITION (get-coord t <box> <x>)))
   (<y> (and POSITION (get-coord nil <box> <y>))))
  ((del (in <box> <block>))
   (add (at <block> <x> <y>)))))


(OPERATOR T-TAKE-OUT-OF-BOX  
    (params <robot1> <robot2> <block> <box> <x> <y>)
 (preconds
  ((<robot1> ROBOT)
   (<robot2> (and ROBOT (diff <robot1> <robot2>)))
   (<block> (or BLOCK BOX))
   (<box>   BOX))
  (and 
   (team-pushable <block>)
   (in <box> <block>)
   (next-to <robot1> <box>)
   (next-to <robot2> <box>)))
 (effects
  ((<x> (and POSITION (get-coord t <box> <x>)))
   (<y> (and POSITION (get-coord nil <box> <y>))))
  ((del (in <box> <block>))
   (add (at <block> <x> <y>)))))




;inference rules

(INFERENCE-RULE INFER-NEXT-TO-DOOR
    (mode eager)		
    (params <door> <room> <something> <x> <y>)
    (preconds
     ((<door> DOOR)
      (<room> ROOM)
      (<something> OBJECT-OR-ROBOT)
      (<x> (and POSITION (get-door-coord t <door> <room> <x>)))
					;inefficient to call (get-door-coord ) twice
      (<y> (and POSITION (get-door-coord nil <door> <room> <y>))))
     (and
      (at <something> <x> <y>)
      (in-room <something> <room>)))
    (effects
     ()
     ((add (next-to <something> <door>)))))


(INFERENCE-RULE INFER-NEXT-TO-BIDIR
    (mode eager)
    (params <object1> <object2> <x> <y>)
    (preconds
     ((<object1>  OBJECT-OR-ROBOT)
      (<object2> (and OBJECT-OR-ROBOT (diff <object1> <object2>)))
      (<x> (and POSITION (get-coord t <object1> <x>)))
      (<y> (and POSITION (get-coord nil <object1> <y>))))
     (and
      (at <object1> <x> <y>)
      (at <object2> <x> <y>)))
    (effects
     ()
     ((add (next-to <object1> <object2>))
      (add (next-to <object2> <object1>)))))


(INFERENCE-RULE IN-ROOM-OBJECTS ;only works for rectangular rooms 
    (mode eager)
    (params <object> <room> <xo> <yo>)
    (preconds
     ((<object> OBJECT-OR-ROBOT)
      (<room> ROOM)
      (<xo> (and POSITION (inside t <xo> <room>)))
      (<yo> (and POSITION (inside nil <yo> <room>))))
     (at <object> <xo> <yo>))
    (effects
     ()
     ((add (in-room <object> <room>)))))


(INFERENCE-RULE INFER-CONNECTS  ;only fires at load-problem time
    (mode eager)
    (params <door> <room1> <room2> <xroom1> <yroom1> <xroom2> <yroom2>)
    (preconds
     ((<door> DOOR)
      (<room1> ROOM)
      (<room2> (and ROOM (diff <room1> <room2>)))
      (<xroom1> (and POSITION (inside t <xroom1> <room1>)))
      (<yroom1> (and POSITION (inside nil <yroom1> <room1>)))
      (<xroom2> (and POSITION (inside t <xroom2> <room2>)))
      (<yroom2> (and POSITION (inside nil <yroom2> <room2>))))
     (door-loc <door> <xroom1> <yroom1> <xroom2> <yroom2>))
    (effects
     ()
     ((add (connects <door> <room1> <room2>))
      (add (connects <door> <room2> <room1>))
      (add (loc-next-to-door <door> <room1> <xroom1> <yroom1>))
      (add (loc-next-to-door <door> <room2> <xroom2> <yroom2>)))))

(INFERENCE-RULE INFER-UNMOVABLE
    (mode eager)
    (params <obj>)
    (preconds
     ((<obj> OBJECT))
     (and
      (~ (pushable <obj>))
      (~ (team-pushable <obj>))))
    (effects
     ()
     ((add (unmovable <obj>)))))



;;; *********************************
;;; stuff for building parallel plans

(setf *resources* '(robot))
(setf *conflict-list* '(door box))

;;; for replanning.lisp

(defun eval-domain-dependent-stuff nil nil)

(defun initial-situation (instance type)
  (list 'at instance 0 0))

(defun number-of-generic-instances (resource)
  3)

(setf *linear-ps* t)

;;; this fn is used in assign-robots9.lisp

(defun reason-to-join-p (resource-instance branch)
  ;general case
  (member (pa-class-of resource-instance)
	  (branch-resources (car branch) (second branch))
	  :key #'cdr))


;====================
;  operator decision
;====================

(CONTROL-RULE REJECT-GOTO-EFF
    (IF (and (current-goal (at <sth> <x> <y>))
	     (~ (p4::type-of-object <sth> ROBOT))))
    (THEN reject operator 'GOTO-LOCATION))


(CONTROL-RULE REJECT-GO-THRU-DOOR
    (IF (and (candidate-operator 'GOTO-LOCATION)
	     (candidate-operator 'GO-THRU-DOOR)
	     (current-goal (at <robot> <x> <y>))
	     (true-in-state (in-room <robot> <room>))
	     (true-in-state (loc-next-to-door <door> <room> <x> <y>))))
    (THEN reject operators GO-THRU-DOOR))

(CONTROL-RULE REJECT-PUSH-THRU-DOOR
    (IF (and (candidate-operator 'PUSH-THRU-DOOR)
	     (candidate-operator 'PUSH-TO-LOCATION)
	     (current-goal (at <obj> <x> <y>))
	     (true-in-state (in-room <obj> <room>))
	     (~ (true-in-state (loc-next-to-door <door> <room> <x> <y>)))))
    (THEN reject operators push-thru-door))


(CONTROL-RULE REJECT-T-PUSH-THRU-DOOR
    (IF (and (candidate-operator 'T-PUSH-THRU-DOOR)
	     (candidate-operator 'T-PUSH-TO-LOCATION)
	     (current-goal (at <obj> <x> <y>))
	     (true-in-state (in-room <obj> <room>))
	     (true-in-state (loc-next-to-door <door> <room> <x> <y>))))
    (THEN reject operators T-PUSH-THRU-DOOR))

(CONTROL-RULE PREFER-GOTO
    (IF (and (current-goal (at <robot> <x> <y>))
	     (p4::type-of-object <robot> ROBOT)
	     (candidate-operator 'PUSH-TO-LOCATION)
	     (candidate-operator 'GOTO-LOCATION)))
    (THEN prefer operators GOTO-LOCATION PUSH-TO-LOCATION))


#|
(CONTROL-RULE SELECT-GO-THRU-DOOR-IF-NOT-IN-SAME-ROOM
    (IF (and (current-goal (at <obj> <x> <y>))
	     (p4::type-of-object <obj> OBJECT)
	     (true-in-state (in-room <obj> <room1>))
	     (true-in-state (connects <door> <room2>))
	     (diff <room1> <room2>)
	     (true-in-state (loc-next-to-door <door> <room2> <x> <y>))))
    (THEN select operators PUSH-THRU-DOOR T-PUSH-THRU-DOOR))
|#

;; not useful any more, because generate bindings won't care about
;; bindings for <xdest> and <ydest>
#| 
;====================
;  binding decision
;====================

(CONTROL-RULE REJECT-GOTO-SAME-LOC
    (IF (and (current-ops (GOTO-LOCATION))
	     (same-loc <x1> <y1> <x2> <y2>)))
    (THEN reject bindings ((<xs> . <x1>) (<ys> . <y1>) (<xdest> . <x2>)
			   (<ydest> . <y2>))))


(defun same-loc (x1 y1 x2 y2)
  (and (= x1 x2) (= y1 y2)))
|#

;====================
;  goal decision
;====================

(CONTROL-RULE WORK-ON-AT-OBJECT-FIRST
    (IF (and (candidate-goal <goal>)
	     (at-least-one-at-object-goal-p)
	     (at-robot-goal-p <goal>)))
    (THEN reject goals <goal>))

(defun at-least-one-at-object-goal-p ()
  (declare (special *current-node* *current-problem-space*))
  (let* ((a-or-b-node (give-me-a-or-b-node *current-node*))
	 (goals (if (not (eq (p4::a-or-b-node-goals-left a-or-b-node)
			     :not-computed))
		    (p4::a-or-b-node-goals-left a-or-b-node)
		    (or (p4::a-or-b-node-pending-goals a-or-b-node)
			(p4::give-me-all-pending-goals a-or-b-node)))))
;    (format t "~% node: ~S goals:~S" (p4::nexus-name a-or-b-node) goals)
    (cond ((null goals) nil)
	  (t
	   (some #'(lambda (goal)
		     (and (eq (p4::literal-name goal) 'at)
			  (p4::type-of-object 
			   (elt (p4::literal-arguments goal) 0)
			   'OBJECT)
			  (not (p4::goal-loop-p a-or-b-node goal))))
		   goals)))))

(defun at-robot-goal-p (goal)
  (and (eq (p4::literal-name goal) 'at)
       (p4::type-of-object 
	(elt (p4::literal-arguments goal) 0) 'ROBOT)))
