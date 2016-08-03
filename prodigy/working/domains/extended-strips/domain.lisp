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

(create-problem-space 'extended-strips :current t)

(ptype-of OBJECT :top-type)
(ptype-of BOX    OBJECT)
(ptype-of KEY    OBJECT)
(ptype-of ROOM   :top-type)
(ptype-of DOOR   :top-type)
(ptype-of LOCX   :top-type)
(ptype-of LOCY   :top-type)
(ptype-of Robot  :top-type)
(ptype-of Status :top-type)

(pinstance-of ROBOT Robot)
(pinstance-of OPEN  Status)
(pinstance-of CLOSED Status)
    
;;; *****************************************************
;;; Picking up and putting down objects

(operator PICKUP-OBJ
 (params <o1>)
 (preconds
  ((<o1> OBJECT))
  (and (arm-empty)
       (next-to robot <o1>)
       (carriable <o1>)))
 (effects
  ((<other> (or OBJECT DOOR))
   (<other2> (or OBJECT DOOR)))
  ((del (arm-empty))
   (del (next-to <o1> <other>))
   (del (next-to <other2> <o1>))
   (add (holding <o1>)))))


(operator PUTDOWN
 (params <o2>)
 (preconds
  ((<o2> OBJECT))
  (holding <o2>))
 (effects ()
	  ((del (holding <o2>))
	   (add (next-to robot <o2>))
	   (add (arm-empty)))))

(operator PUTDOWN-NEXT-TO
 (params <o3> <other-ob> <o3-rm>)
 (preconds
  ((<o3> OBJECT)
   (<other-ob> OBJECT)
   (<o3-rm> ROOM))
  (and (holding <o3>)
       (inroom <other-ob> <o3-rm>)
       (inroom <o3> <o3-rm>)
       (next-to robot <other-ob>)))
 (effects
  ()
  ((del (holding <o3>))
   (add (next-to <o3> <other-ob>))
   (add (next-to robot <o3>)) 
   (add (next-to <other-ob> <o3>))
   (add (arm-empty)))))

;;; ********************************************************
;;; Moving to doors (pushing or just going) and through doors
;;; (the robot by itself, pushing something, or carrying something)

(operator PUSH-TO-DR
 (params <b1> <d1> <r1>)
 (preconds
  ((<d1> DOOR)
   (<r1> ROOM)
   (<b1> BOX))
  (and (dr-to-rm <d1> <r1>)
       (inroom <b1> <r1>)
       (next-to robot <b1>)
       (pushable <b1>)))
 (effects
  ((<other>  (and (or OBJECT DOOR) (diff <other> <b1>)))
   (<other2> (or OBJECT DOOR))
   (<other3> (and (or OBJECT DOOR) (diff <other3> robot))))
;;I can remove the conditions if the adds are done after the deletes;
;;otherwise the state after the op won't have (next-to <b1> <d1>)
  ((del (next-to robot <other>))
   (del (next-to <b1> <other2>))
   (del (next-to <other3> <b1>))
   (add (next-to <b1> <d1>))
   (add (next-to robot <d1>)))))

(operator PUSH-THRU-DR
 (params <b-x> <d-x> <r-x> <r-y>)
 (preconds
  ((<b-x> BOX)
   (<d-x> DOOR)
   (<r-x> ROOM)
   (<r-y> ROOM))
  (and (dr-to-rm <d-x> <r-x>)
       (dr-open <d-x>)
       (next-to <b-x> <d-x>)
       (next-to robot <b-x>)
       (pushable <b-x>)
       (connects <d-x> <r-x> <r-y>)
       (inroom <b-x> <r-x>)))
 (effects
  ((<other>  (and (or OBJECT DOOR) (diff <other> <b-x>)))
   (<other2> (or OBJECT DOOR))
   (<other3> (and (or OBJECT DOOR) (diff <other3> robot)))
   (<other4> OBJECT))
  ((del (next-to robot <other>))
   (del (next-to <b-x> <other2>))
   (del (next-to <other3> <b-x>))
   (if (holding <other4>)
       ((del (inroom <other4> <r-x>))
	(add (inroom <other4> <r-y>))))
   (del (inroom robot <r-x>))
   (del (inroom <b-x> <r-x>))
   (add (inroom robot <r-y>))
   (add (inroom <b-x> <r-y>)))))

(operator GO-THRU-DR
 (params <ddx> <rrx> <rry>)
 (preconds
  ((<ddx> DOOR)
   (<rrx> ROOM)
   (<rry> ROOM))
  (and (arm-empty)
       (dr-to-rm <ddx> <rrx>)
       (dr-open <ddx>)
       (next-to robot <ddx>)
       (connects <ddx> <rrx> <rry>)
       (inroom robot <rrx>)))
 (effects
  ((<other> OBJECT)
   (<other1> OBJECT))
  (
  ;; this should not be here.  GO-THRU-DR should not allow the robot
  ;; holding anything.
   (if (holding <other1>)
       ((del (inroom <other1> <rrx>))
	(add (inroom <other1> <rry>))))
   (del (next-to robot <other>))
   (del (inroom robot <rrx>))
   (add (inroom robot <rry>)))))

(operator CARRY-THRU-DR
 (params <b-zz> <d-zz> <r-zz> <r-ww>)
 (preconds
  ((<b-zz> OBJECT)
   (<d-zz> DOOR)
   (<r-zz> ROOM)
   (<r-ww> ROOM))
  (and (dr-to-rm <d-zz> <r-zz>)
       (dr-open <d-zz>)
       (holding <b-zz>)
       (connects <d-zz> <r-zz> <r-ww>)
       (inroom <b-zz> <r-ww>)
       (inroom robot <r-ww>)
       (next-to robot <d-zz>)))
 (effects
  ((<other> (and (or OBJECT DOOR)
		 (diff <other> <b-zz>)
		 (diff <other> <d-zz>)))
   (<other2> (or OBJECT DOOR))
   (<other3> (or OBJECT DOOR)))
  ((del (next-to robot <other>))
   (del (inroom robot <r-ww>))
   (del (inroom <b-zz> <r-ww>))
   (add (inroom robot <r-zz>))
   (add (inroom <b-zz> <r-zz>)))))


(operator GOTO-DR
 (params <dx> <rx>)
 (preconds
  ((<dx> DOOR)
   (<rx> ROOM))
  (and (dr-to-rm <dx> <rx>)
       (inroom robot <rx>)))
 (effects
  ((<other> (or OBJECT DOOR)))
  ((del (next-to robot <other>))
   (add (next-to robot <dx>)))))

;;; ********************************************************
;;; Going to objects and pushing them

(operator PUSH-BOX
 (params <ba> <bb> <ra>)
 (preconds
  ((<ba> BOX)
   (<bb> OBJECT)
   (<ra> ROOM))
  (and (inroom <bb> <ra>)
       (inroom <ba> <ra>)
       (pushable <ba>)
       (next-to robot <ba>)))
 (effects
  ((<other>  (and (or OBJECT DOOR) (diff <other> <ba>)))
   (<other2> (or OBJECT DOOR))
   (<other3> (and (or OBJECT DOOR) (diff <other3> robot))))
  ((del (next-to robot <other>))
   (del (next-to <ba> <other2>))
   (del (next-to <other3> <ba>))
   (add (next-to robot <bb>))
   (add (next-to <ba> <bb>))
   (add (next-to <bb> <ba>)))))


(operator GOTO-OBJ
 (params <b> <rm>) 
 (preconds
  ((<b>  OBJECT)
   (<rm> ROOM))
  (and (inroom <b> <rm>)
       (inroom robot <rm>)))
 (effects
  ((<other>  (or OBJECT DOOR)))
  ((del (next-to robot <other>))
   (add (next-to robot <b>)))))

;;;****************************************************
;;; actions with doors

(Operator OPEN-DOOR 
 (params <door>)
 (preconds
  ((<door> Door))
  (and (next-to robot <door>)
       (unlocked <door>)
       (dr-closed <door>)))
 (effects
  ()
  ((del (dr-closed <door>))
   (add (dr-open <door>)))))


(operator CLOSE-DOOR
 (params <door1>)
 (preconds
  ((<door1> DOOR))
  (and (next-to robot <door1>)
       (dr-open <door1>)))
 (effects
  ()
  ((del (dr-open <door1>))
   (add (dr-closed <door1>)))))

; should probably kill carriable scr rule

(operator LOCK
 (params <door2> <k1> <rm-b>)
 (preconds
  ((<door2> DOOR)
   (<k1> KEY)
   (<rm-b> ROOM))
  (and (is-key <door2> <k1>)
       (holding <k1>)
       (dr-to-rm <door2> <rm-b>)
       (inroom <k1> <rm-b>)
       (next-to robot <door2>)
       (dr-closed <door2>)
       (unlocked <door2>)))
 (effects
  ()
  ((del (unlocked <door2>))
   (add (locked <door2>)))))


(operator UNLOCK
 (params <door3> <k2> <rm-a>)
 (preconds
  ((<door3> DOOR)
   (<k2> KEY)
   (<rm-a> ROOM))
  (and (is-key <door3> <k2>)
       (holding <k2>)
       (dr-to-rm <door3> <rm-a>)
       (inroom <k2> <rm-a>)
       (inroom robot <rm-a>)
       (next-to robot <door3>)
       (locked <door3>)))
 (effects
  ()
  ((del (locked <door3>))
   (add (unlocked <door3>)))))


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
(load (concatenate 'string
	*world-path* "extended-strips/sc-rules.lisp"))
;(load "/afs/cs/project/prodigy/version4.0/domains/extended-strips/sc-rules.lisp")

