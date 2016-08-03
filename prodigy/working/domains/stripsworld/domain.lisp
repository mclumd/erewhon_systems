;;;
;;; Copied from the Prodigy2 domain, 19/7/91
;;;

(create-problem-space 'stripsworld :current t)

(ptype-of OBJECT :top-type)
(ptype-of ROOM   :top-type)
(ptype-of DOOR   :top-type)
(ptype-of LOCX   :top-type)
(ptype-of LOCY   :top-type)
(ptype-of Robot  :top-type)
(ptype-of Status :top-type)

(pinstance-of ROBOT Robot)
(pinstance-of OPEN  Status)
(pinstance-of CLOSED Status)

(Operator
 Goto-Box
 (params <box> <room>)
 (preconds
  ((<box> OBJECT)
   (<room> ROOM))
  (and (in-room <box> <room>)
       (in-room robot <room>)))
 ;; I don't think these conditional effects should be necessary, but
 ;; they're to test them out, and model the Prodigy2 domain.
 (effects
  ((<1> LocX)
   (<2> LocY)
   (<3> Object))
  ((if (at robot <1> <2>) ((del (at robot <1> <2>))))
   (if (next-to robot <3>) ((del (next-to robot <3>))))
   (add (next-to robot <box>)))))

(Operator
 Goto-Door
 (params <door> <roomx> <roomy>)
 (preconds
  ((<door> DOOR)
   (<roomx> ROOM)
   (<roomy> ROOM))
  (and (connects <door> <roomx> <roomy>)
       (in-room robot <roomx>)))
  (effects
   ((<1> LocX)
    (<2> LocY)
    (<3> Object))
   ((if (at robot <1> <2>) ((del (at robot <1> <2>))))
    (if (next-to robot <3>) ((del (next-to robot <3>))))
    (add (next-to robot <door>)))))

(Operator
 Goto-Loc
 (params <x> <y> <roomx>)
 (preconds
  ((<x> LocX)
   (<y> LocX)
   (<roomx> ROOM))
  (and (loc-in-room <x> <y> <roomx>)
       (in-room robot <roomx>)))
 (effects
  ((<1> LocX)
   (<2> LocY)
   (<3> Object))
  ((if (at robot <1> <2>) ((del (at robot <1> <2>))))
   (if (next-to robot <3>) ((del (next-to robot <3>))))
   (add (at robot <x> <y>)))))

(Operator
 Push-Box
 (params <boxx> <boxy> <roomx>)
 (preconds
  ((<boxx> OBJECT)
   (<boxy> OBJECT)
   (<roomx> ROOM))
  (and (pushable <boxx>)
       (in-room <boxx> <roomx>)
       (in-room <boxy> <roomx>)
       (in-room robot <roomx>)
       (next-to robot <boxx>)))
 (effects
  ((<1> LocX)
   (<2> LocY)
   (<3> Object)
   (<4> LocX)
   (<5> LocY)
   (<6> Object)
   (<7> Object))
  ((if (at robot <1> <2>) ((del (at robot <1> <2>))))
   (if (next-to robot <3>) ((del (next-to robot <3>))))
   (if (at <boxx> <4> <5>) ((del (at <boxx> <4> <5>))))
   (if (next-to <boxx> <6>) ((del (next-to <boxx> <6>))))
   (if (next-to <7> <boxx>) ((del (next-to <7> <boxx>))))
   (add (next-to <boxy> <boxx>))
   (add (next-to <boxx> <boxy>))
   (add (next-to robot <boxx>)))))

(Operator
 Push-To-Door
 (params <box> <door> <roomx>)
 (preconds
  ((<box> Object)
   (<door> Door)
   (<roomx> Room)
   (<roomy> Room))
  (and (connects <door> <roomx> <roomy>)
       (pushable <box>)
       (in-room robot <roomx>)
       (in-room <box> <roomx>)
       (next-to robot <box>)))
 (effects
  ((<1> LocX)
   (<2> LocY)
   (<3> Object)
   (<4> LocX)
   (<5> LocY)
   (<6> Object)
   (<7> Object))
  ((if (at robot <1> <2>) ((del (at robot <1> <2>))))
   (if (next-to robot <3>) ((del (next-to robot <3>))))
   (if (at robot <4> <5>) ((del (at robot <4> <5>))))
   (if (next-to <box> <6>) ((del (next-to <box> <6>))))
   (if (next-to <box> <door>) ((del (next-to <box> <door>))))
   (add (next-to <box> <door>))
   (add (next-to robot <box>)))))

(Operator
 Push-to-Loc
 (params <box> <x> <y>)
 (preconds
  ((<box> Object)
   (<x> LocX)
   (<y> LocY)
   (<roomx> Room))
  (and (pushable <box>)
       (loc-in-room <x> <y> <roomx>)
       (in-room robot <roomx>)
       (in-room <box> <roomx>)
       (next-to robot <box>)))
 (effects
  ((<1> LocX)
   (<2> LocY)
   (<3> Object)
   (<4> LocX)
   (<5> LocY)
   (<6> Object)
   (<7> Object))
    ((if (at robot <1> <2>)((del (at robot <1> <2>))))
     (if (next-to robot <3>)((del (next-to robot <3>))))
     (if (at <box> <4> <5>)((del (at <box> <4> <5>))))
     (if (next-to <box> <6>)((del (next-to <box> <6>))))
     (if (next-to <7> <box>)((del (next-to <7> <box>))))
     (add (at <box> <x> <y>))
     (add (next-to robot <box>)))))


(Operator
 GO-THRU-DOOR
 (params <door> <roomy> <roomx>)
 (preconds
  ((<door>  Door)
   (<roomy> Room)
   (<roomx> Room))
  (and (connects <door> <roomx> <roomy>)
       (in-room robot <roomy>)
       (statis <door> open)
       (next-to robot <door>)))
 (effects
  ((<1> LocX)
   (<2> Locy)
   (<whatever> Object))
  ((del (at robot <1> <2>))
   (del (next-to robot <whatever>))
   (del (in-room robot <roomy>))
   (add (in-room robot <roomx>)))))

(Operator
 PUSH-THRU-DOOR
 (params <box> <door> <roomy> <roomx>)
 (preconds
  ((<box> Object)
   (<door> Door)
   (<roomy> Room)
   (<roomx> Room))
  (and (connects <door> <roomy> <roomx>)
       (pushable <box>)			
       (in-room robot <roomy>)		
       (in-room <box> <roomy>)		
       (statis <door> open)		
       (next-to <box> <door>)		
       (next-to robot <box>)))
 (effects
  ((<1> LocX)
   (<2> LocY)
   (<3> Object)
   (<4> LocX)
   (<5> LocY)
   (<6> Object)
   (<7> Object))
  ((if (at robot <1> <2>)((del (at robot <1> <2>))))
   (if (next-to robot <3>)((del (next-to robot <3>))))
   (if (at <box> <4> <5>)((del (at <box> <4> <5>))))
   (if (next-to <box> <6>)((del (next-to <box> <6>))))
   (if (next-to <7> <box>)((del (next-to <7> <box>))))
   (if (in-room robot <roomy>)((del (in-room robot <roomy>))))
   (if (in-room <box> <roomy>)((del (in-room <box> <roomy>))))
   (add (in-room robot <roomx>))
   (add (in-room <box> <roomx>))
   (add (next-to robot <box>)))))

(Operator
 OPEN-DOOR 
 (params <door>)
 (preconds
  ((<door> Door))
  (and (next-to robot <door>)		;[5]
       (statis <door> closed)		;[5]
       ))
 (effects
  ()
  ((del (statis <door> closed))
   (add (statis <door> open)))))

(Operator
 CLOSE-DOOR
 (params <door>)
 (preconds
  ((<door> Door))
  (and (next-to robot <door>)		;[5]
       (statis <door> open)))
 (effects
  ()
  ((del (statis <door> open))
   (add (statis <door> closed)))))

;;; This eager static rule might slow us down a little bit in tests
;;; with Prodigy 2, but it keeps the problem specs a bit smaller.
(Inference-Rule
 Connects-is-reflexive
 (mode eager)
 (params <door> <room1> <room2>)
 (preconds
  ((<door> Door)
   (<room1> Room)
   (<room2> Room))
  (connects <door> <room1> <room2>))
 (effects () ((add (connects <door> <room2> <room1>)))))


;;; This is the one control rule in the prodigy 2.0 stripsworld domain.
(Control-Rule
 Move-robot-only--Ignore-boxes
 (if (and (current-goal (in-room robot <room>))
	  (candidate-operator push-thru-door)))
 (then reject operator push-thru-door))