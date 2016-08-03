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
     (at-robot <robot> <xs> <ys>))
    (effects
     ((<xdest> (and POSITION (inside t <xdest> <room>)))
      (<ydest> (and POSITION (inside nil <ydest> <room>))))
     ((del (at-robot <robot> <xs> <ys>))
      (add (at-robot <robot> <xdest> <ydest>)))))


(OPERATOR PUSH-TO-LOCATION   
   (params <robot> <object> <room> <xs> <ys> <xdest> <ydest>)
   (preconds
    ((<robot>   ROBOT)
     (<object> (or BOX BLOCK))
     (<room> ROOM)
     (<xs> (and POSITION (inside t <xs> <room>)))
     (<ys> (and POSITION 
		(get-initial-location <object> <xs> <ys> <room>))))
    (and (at-object <object> <xs> <ys>)
	 (pushable  <object>)    
	 (at-object <robot> <xs> <ys>)))
   (effects
    ((<xdest> (and POSITION (inside t <xdest> <room>)))
     (<ydest> (and POSITION (inside nil <ydest> <room>))))
    ((del (at-robot <robot> <xs> <ys>))
     (del (at-object <object> <xs> <ys>))
     (add (at-robot <robot> <xdest> <ydest>))
     (add (at-object <object> <xdest> <ydest>)))))



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
  (and (at-object <object> <xs> <ys>)
       (team-pushable  <object>)    
       (at-robot <robot1> <xs> <ys>)
       (at-robot <robot2> <xs> <ys>)))
 (effects
  ((<xdest> (and POSITION (inside t <xdest> <room>)))
   (<ydest> (and POSITION (inside nil <ydest> <room>))))
  ((del (at-robot <robot1> <xs> <ys>))
   (del (at-robot <robot2> <xs> <ys>))
   (del (at-object <object> <xs> <ys>))
   (add (at-robot <robot1> <xdest> <ydest>))
   (add (at-robot <robot2> <xdest> <ydest>))
   (add (at-object <object> <xdest> <ydest>)))))






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
     (at-robot <robot> <xroom1> <yroom1>)
     (door-open <door>)))
   (effects
    ((<room2> (and ROOM (diff <room1> <room2>)))
     (<x2> (and POSITION (get-door-coord t <door> <room2> <x2>)))
     (<y2> (and POSITION (get-door-coord nil <door> <room2> <y2>))))
    ((del (at-robot <robot> <xroom1> <yroom1>))
     (add (at-robot <robot> <x2> <y2>)))))






(OPERATOR PUSH-THRU-DOOR                     ;take loc out of params
   (params <robot> <door> <room1> <room2> <xroom1> <yroom1> <x2> <y2>)
   (preconds
    ((<robot> ROBOT)
     (<object> (or BOX BLOCK))
     (<door> DOOR)
     (<room1> ROOM)
     (<xroom1> (and POSITION 
		    (get-door-coord t <door> <room1> <xroom1>)))
     (<yroom1> (and POSITION 
		    (get-door-coord nil <door> <room1> <yroom1>))))
    (and
     (pushable <object>)
     (at-robot <robot> <xroom1> <yroom1>)
     (at-object <object> <xroom1> <yroom1>)
     (door-open <door>)))
   (effects 
    ((<room2> (and ROOM (diff <room1> <room2>)))
     (<x2> (and POSITION (get-door-coord t <door> <room2> <x2>)))
     (<y2> (and POSITION (get-door-coord nil <door> <room2> <y2>))))
    ((del (at-robot <robot> <xroom1> <yroom1>))
     (del (at-object <object> <xroom1> <yroom1>))
     (add (at <robot> <x2> <y2>))
     (add (at-object <object> <x2> <y2>)))))





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
     (at-object <object> <xroom1> <yroom1>)
     (door-open <door>)))
   (effects
    ((<room2> (and ROOM (diff <room1> <room2>)))
     (<x2> (and POSITION (get-door-coord t <door> <room2> <x2>)))
     (<y2> (and POSITION (get-door-coord nil <door> <room2> <y2>))))
    ((del (at <robot1> <xroom1> <yroom1>))
     (del (at <robot2> <xroom1> <yroom1>))
     (del (at-object <object> <xroom1> <yroom1>))
     (add (at <robot1> <x2> <y2>))
     (add (at <robot2> <x2> <y2>))
     (add (at-object <object> <x2> <y2>)))))




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
     (at-object <box> <x> <y>)
     (next-to <box> <block>)
     (next-to <robot> <box>)))
    (effects
     ()
     ((add (in <box> <block>))
      (del (at-object <block> <x> <y>)))))


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
      (at-object <box> <x> <y>)
      (next-to <box> <block>)
      (next-to <robot1> <box>)
      (next-to <robot2> <box>)))
    (effects
     ()
     ((add (in <box> <block>))
      (del (at-object <block> <x> <y>)))))


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
   (add (at-object <block> <x> <y>)))))


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
   (add (at-object <block> <x> <y>)))))




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
