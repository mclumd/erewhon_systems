;;;
;;; Adapted from the Prodigy2 domain, 25/1/92 aperez
;;;

;;; Notes about this version:
;;; -no locations (i.e. no "at" predicate, no numbers)
;;; -if something is pickud up by the robot, it is not next-to
;;; anything (i.e. (holding x) --> (~(next-to x y))  PICKUP-OBJ
;;; -the robot cannot be holding two things at a time (PICKUP-OBJ)
;;; -next-to not transitive: see PUTDOWN
;;; -next-to symmetric: see PUTDOWN-NEXT-TO, PUSH-BOX

;;; 10/2/92 aperez
;;; Removed conditional effects lhs's.
;;; Added boxes to get a deeper type hierarchy. Only boxes are
;;; pushable. 

(create-problem-space 'sim-robot :current t)

(ptype-of OBJECT :top-type)
(ptype-of BOX    OBJECT)
(ptype-of KEY    OBJECT)
(ptype-of ROOM   :top-type)
(ptype-of DOOR   :top-type)
; (ptype-of LOCX   :top-type)
; (ptype-of LOCY   :top-type)
(ptype-of ROBOT  :top-type)
(ptype-of STATUS :top-type)

(pinstance-of ROBOT ROBOT)
(pinstance-of OPEN CLOSED STATUS)
    
;;; ********************************************************
;;; Going to objects and pushing them

(operator GOTO-OBJECT
 (params <o> <room>)
 (preconds
  ((<o>  OBJECT)
   (<room> ROOM))
  (and (in-room <o> <room>)
       (in-room robot <room>)))
 (effects
  ((<other>  (or OBJECT DOOR)))
  ((del (next-to robot <other>))
   (add (next-to robot <o>)))))

(operator PUSH-BOX
 (params <box> <to> <room>)
 (preconds
  ((<box> BOX)
   (<to> (and OBJECT (diff <to> <box>)))
   (<room> ROOM))
  (and (in-room <to> <room>)
       (in-room <box> <room>)
       (pushable <box>)
       (next-to robot <box>)))
 (effects
  ((<other>  (and (or OBJECT DOOR) (diff <other> <box>)))
   (<other2> (or OBJECT DOOR))
   (<other3> (or OBJECT DOOR)))
  ((del (next-to robot <other>))
   (del (next-to <box> <other2>))
   (del (next-to <other3> <box>))
   (add (next-to robot <to>))
   (add (next-to <box> <to>))
   (add (next-to <to> <box>)))))

;;; *****************************************************
;;; Picking up and putting down objects

(operator PICK-UP
 (params <o>)
 (preconds
  ((<o> OBJECT))
  (and (arm-empty)
       (next-to robot <o>)
       (carriable <o>)))
 (effects
  ((<other> (or OBJECT DOOR))
   (<other2> (or OBJECT DOOR)))
  ((del (arm-empty))
   (del (next-to <o> <other>))
   (del (next-to <other2> <o>))
   (add (holding <o>)))))

(operator PUT-DOWN
 (params <o>)
 (preconds
  ((<o> OBJECT))
  (holding <o>))
 (effects ()
	  ((del (holding <o>))
	   (add (next-to robot <o>))
	   (add (arm-empty)))))

(operator PUT-DOWN-NEXT-TO
 (params <o> <other-ob> <room>)
 (preconds
  ((<o> OBJECT)
   (<other-ob> (and OBJECT (diff <other-ob> <o>)))
   (<room> ROOM))
  (and (holding <o>)
       (in-room <other-ob> <room>)
       (in-room <o> <room>)
       (next-to robot <other-ob>)))
 (effects
  ()
  ((del (holding <o>))
   (add (next-to <o> <other-ob>))
   (add (next-to robot <o>)) 
   (add (next-to <other-ob> <o>))
   (add (arm-empty)))))

;;; ********************************************************
;;; Moving to doors (pushing or just going) and through doors
;;; (the robot by itself, pushing something, or carrying something)

(operator GOTO-DOOR
 (params <door> <room>)
 (preconds
  ((<door> DOOR)
   (<room> ROOM))
  (and (door-to-room <door> <room>)
       (in-room robot <room>)))
 (effects
  ((<other> (or OBJECT DOOR)))
  ((del (next-to robot <other>))
   (add (next-to robot <door>)))))

(operator PUSH-TO-DOOR
 (params <box> <door> <room>)
 (preconds
  ((<door> DOOR)
   (<room> ROOM)
   (<box> BOX))
  (and (door-to-room <door> <room>)
       (in-room <box> <room>)
       (next-to robot <box>)
       (pushable <box>)))
 (effects
  ((<other>  (and (or OBJECT DOOR) (diff <other> <box>)))
   (<other2> (or OBJECT DOOR))
   (<other3> (and (or OBJECT DOOR) (diff <other3> robot))))
;;I can remove the conditions if the adds are done after the deletes;
;;otherwise the state after the op won't have (next-to <box> <door>)
  ((del (next-to robot <other>))
   (del (next-to <box> <other2>))
   (del (next-to <other3> <box>))
   (add (next-to <box> <door>))
   (add (next-to robot <door>)))))

(operator GO-THROUGH-DOOR
 (params <door> <room1> <room2>)
 (preconds
  ((<door> DOOR)
   (<room1> ROOM)
   (<room2> ROOM))
  (and (arm-empty)
       (door-to-room <door> <room1>)
       (door-open <door>)
       (next-to robot <door>)
       (connects <door> <room1> <room2>)
       (in-room robot <room1>)))
 (effects
  ((<other> OBJECT))
  (
   (del (next-to robot <other>))
   (del (in-room robot <room1>))
   (add (in-room robot <room2>)))))

(operator PUSH-THROUGH-DOOR
 (params <box> <door> <room1> <room2>)
 (preconds
  ((<box> BOX)
   (<door> DOOR)
   (<room1> ROOM)
   (<room2> ROOM))
  (and (door-to-room <door> <room1>)
       (door-open <door>)
       (next-to <box> <door>)
       (next-to robot <box>)
       (pushable <box>)
       (connects <door> <room1> <room2>)
       (in-room <box> <room1>)))
 (effects
  ((<other>  (and (or OBJECT DOOR) (diff <other> <box>)))
   (<other2> (or OBJECT DOOR))
   (<other3> (and (or OBJECT DOOR)))
   (<other4> OBJECT))
  ((del (next-to robot <other>))
   (del (next-to <box> <other2>))
   (del (next-to <other3> <box>))
   (if (holding <other4>)
       ((del (in-room <other4> <room1>))
	(add (in-room <other4> <room2>))))
   (del (in-room robot <room1>))
   (del (in-room <box> <room1>))
   (add (in-room robot <room2>))
   (add (in-room <box> <room2>)))))

(operator CARRY-THROUGH-DOOR
 (params <o> <door> <room1> <room2>)
 (preconds
  ((<o> OBJECT)
   (<door> DOOR)
   (<room1> ROOM)
   (<room2> ROOM))
  (and (door-to-room <door> <room1>)
       (door-open <door>)
       (holding <o>)
       (connects <door> <room1> <room2>)
       (in-room <o> <room2>)
       (in-room robot <room2>)
       (next-to robot <door>)))
 (effects
  ((<other> (and (or OBJECT DOOR)
		 (diff <other> <o>)
		 (diff <other> <door>)))
   (<other2> (or OBJECT DOOR))
   (<other3> (or OBJECT DOOR)))
  ((del (next-to robot <other>))
   (del (in-room robot <room2>))
   (del (in-room <o> <room2>))
   (add (in-room robot <room1>))
   (add (in-room <o> <room1>)))))

;;;****************************************************
;;; actions with doors

(Operator OPEN-DOOR 
 (params <door>)
 (preconds
  ((<door> Door))
  (and (next-to robot <door>)
       (unlocked <door>)
       (door-closed <door>)))
 (effects
  ()
  ((del (door-closed <door>))
   (add (door-open <door>)))))


(operator CLOSE-DOOR
 (params <door1>)
 (preconds
  ((<door1> DOOR))
  (and (next-to robot <door1>)
       (door-open <door1>)))
 (effects
  ()
  ((del (door-open <door1>))
   (add (door-closed <door1>)))))

; should probably kill carriable scr rule

(operator LOCK
 (params <door> <key> <room>)
 (preconds
  ((<door> DOOR)
   (<key> KEY)
   (<room> ROOM))
  (and (is-key <door> <key>)
       (holding <key>)
       (door-to-room <door> <room>)
       (in-room <key> <room>)
       (next-to robot <door>)
       (door-closed <door>)
       (unlocked <door>)))
 (effects
  ()
  ((del (unlocked <door>))
   (add (locked <door>)))))

(operator UNLOCK
 (params <door> <key> <room>)
 (preconds
  ((<door> DOOR)
   (<key> KEY)
   (<room> ROOM))
  (and (is-key <door> <key>)
       (holding <key>)
       (door-to-room <door> <room>)
       (in-room <key> <room>)
       (in-room robot <room>)
       (next-to robot <door>)
       (locked <door>)))
 (effects
  ()
  ((del (locked <door>))
   (add (unlocked <door>)))))


;;; This eager static rule might slow us down a little bit in tests
;;; with Prodigy 2, but it keeps the problem specs a bit smaller.
(Inference-Rule
 Connects-is-symmetric
 (mode eager)
 (params <door> <room1> <room2>)
 (preconds
  ((<door> Door)
   (<room1> Room)
   (<room2> Room))
  (connects <door> <room1> <room2>))
 (effects () ((add (connects <door> <room2> <room1>)))))


;;; Warning! You will need to change this pointer if you are not at CMU!
; (load "/afs/cs/project/prodigy/version4.0/domains/extended-strips/sc-rules.lisp")

(pset :depth-bound 1000)
(pset :print-alts t)
