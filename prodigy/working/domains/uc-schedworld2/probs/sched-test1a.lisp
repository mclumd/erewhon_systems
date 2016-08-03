(setf (current-problem)
      (create-problem
       (name sched-test1a)
       (objects
	(objects-are black red
		     immersion-painter spray-painter drill-press punch
		     grinder lathe roller polisher
		     obj-a obj-b
		     oblong
		     none  GENTYPE))
       (state (and
	       (nothing)
	       (LATER 4 3) (LATER 4 2) (LATER 4 1) (LATER 4 0) (LATER 3 2)
	       (LATER 3 1) (LATER 3 0) (LATER 2 1) (LATER 2 0) 
	       (LATER 1 0) (SPRAYABLE BLACK) (HAVE-PAINT-FOR-IMMERSION BLACK) (SPRAYABLE RED)
	       (HAVE-PAINT-FOR-IMMERSION RED) (HAS-BIT 0.3) (HAS-BIT 0.2) (HAS-BIT 0.1)
	       (IDLE IMMERSION-PAINTER 4)
	       (IDLE SPRAY-PAINTER 4) (IDLE DRILL-PRESS 4) (IDLE PUNCH 4) (IDLE GRINDER 4) (IDLE LATHE 4)
	       (IDLE ROLLER 4)
	       (IDLE POLISHER 4) (IDLE IMMERSION-PAINTER 3) (IDLE SPRAY-PAINTER 3) (IDLE DRILL-PRESS 3)
	       (IDLE PUNCH 3)
	       (IDLE GRINDER 3) (IDLE LATHE 3) (IDLE ROLLER 3) (IDLE POLISHER 3) (IDLE IMMERSION-PAINTER 2)
	       (IDLE SPRAY-PAINTER 2) (IDLE DRILL-PRESS 2) (IDLE PUNCH 2) (IDLE GRINDER 2) (IDLE LATHE 2)
	       (IDLE ROLLER 2)
	       (IDLE POLISHER 2) (IDLE IMMERSION-PAINTER 1) (IDLE SPRAY-PAINTER 1) (IDLE DRILL-PRESS 1)
	       (IDLE PUNCH 1)
	       (IDLE GRINDER 1) (IDLE LATHE 1) (IDLE ROLLER 1) (IDLE POLISHER 1) (IDLE IMMERSION-PAINTER 0)
	       (IDLE SPRAY-PAINTER 0) (IDLE DRILL-PRESS 0) (IDLE PUNCH 0) (IDLE GRINDER 0) (IDLE LATHE 0)
	       (IDLE ROLLER 0)
	       (IDLE POLISHER 0) (SHAPE OBJ-A OBLONG) (TEMPERATURE OBJ-A COLD)
	       (SURFACE-CONDITION OBJ-A ROUGH)
	       (PAINTED OBJ-A NONE) (HAS-HOLE OBJ-A 0 null) (LAST-SCHEDULED OBJ-A 0)
	       (SHAPE OBJ-B CYLINDRICAL)
	       (TEMPERATURE OBJ-B COLD) (SURFACE-CONDITION OBJ-B SMOOTH) (PAINTED OBJ-B RED)
	       (HAS-HOLE OBJ-B 0 null)
	       (LAST-SCHEDULED OBJ-B 0)))
       (goal (and (shape Obj-A cylindrical)
		  (surface-condition Obj-B polished)))))



#|
(defun sched-world-init (time i-state &aux (ret nil))
  (setf ret i-state)
  (dotimes (i time)
    (dolist (machine '(polisher roller lathe grinder punch drill-press
                       spray-painter immersion-painter))
      (push `(idle ,machine ,i) ret)))
  (dolist (size '(.1 .2 .3))
    (push `(has-bit ,size) ret))
  (dolist (color '(red black))
    (push `(have-paint-for-immersion ,color) ret)
    (push `(sprayable ,color) ret))
  (dotimes (i time)
    (dotimes (j i)
      (push `(later ,i ,j) ret)))
  ret)

|#


;;;
;;;Solution:
;;;        <roll obj-a>
;;;        <polish obj-b>
;;;
;;;
;;;(((:STOP . :ACHIEVE) . #<APPLIED-OP-NODE 12 #<POLISH [<X> OBJ-B] [<OLDSURF> ()]>>)




;;;Initial  : ((LATER 4 3) (LATER 4 2) (LATER 4 1) (LATER 4 0) (LATER 3 2) (LATER 3 1) (LATER 3 0) (LATER 2 1)
;;;            (LATER 2 0) (LATER 1 0) (SPRAYABLE BLACK) (HAVE-PAINT-FOR-IMMERSION BLACK) (SPRAYABLE RED)
;;;            (HAVE-PAINT-FOR-IMMERSION RED) (HAS-BIT 0.3) (HAS-BIT 0.2) (HAS-BIT 0.1)
;;;            (IDLE IMMERSION-PAINTER 4) (IDLE SPRAY-PAINTER 4) (IDLE DRILL-PRESS 4) (IDLE PUNCH 4)
;;;            (IDLE GRINDER 4) (IDLE LATHE 4) (IDLE ROLLER 4) (IDLE POLISHER 4) (IDLE IMMERSION-PAINTER 3)
;;;            (IDLE SPRAY-PAINTER 3) (IDLE DRILL-PRESS 3) (IDLE PUNCH 3) (IDLE GRINDER 3) (IDLE LATHE 3)
;;;            (IDLE ROLLER 3) (IDLE POLISHER 3) (IDLE IMMERSION-PAINTER 2) (IDLE SPRAY-PAINTER 2)
;;;            (IDLE DRILL-PRESS 2) (IDLE PUNCH 2) (IDLE GRINDER 2) (IDLE LATHE 2) (IDLE ROLLER 2)
;;;            (IDLE POLISHER 2) (IDLE IMMERSION-PAINTER 1) (IDLE SPRAY-PAINTER 1) (IDLE DRILL-PRESS 1)
;;;            (IDLE PUNCH 1) (IDLE GRINDER 1) (IDLE LATHE 1) (IDLE ROLLER 1) (IDLE POLISHER 1)
;;;            (IDLE IMMERSION-PAINTER 0) (IDLE SPRAY-PAINTER 0) (IDLE DRILL-PRESS 0) (IDLE PUNCH 0)
;;;            (IDLE GRINDER 0) (IDLE LATHE 0) (IDLE ROLLER 0) (IDLE POLISHER 0) (SHAPE OBJ-A OBLONG)
;;;            (TEMPERATURE OBJ-A COLD) (SURFACE-CONDITION OBJ-A ROUGH) (PAINTED OBJ-A NONE)
;;;            (HAS-HOLE OBJ-A 0 NIL) (LAST-SCHEDULED OBJ-A 0) (SHAPE OBJ-B CYLINDRICAL)
;;;            (TEMPERATURE OBJ-B COLD) (SURFACE-CONDITION OBJ-B SMOOTH) (PAINTED OBJ-B RED)
;;;            (HAS-HOLE OBJ-B 0 NIL) (LAST-SCHEDULED OBJ-B 0))
;;;
;;;Step 1  : (LATHE OBJ-A)          Created 2 
;;;Step 2  : (POLISH OBJ-B)         Created 1 
;;;           0  -> (TEMPERATURE OBJ-B COLD)
;;;
;;;Goal    : (AND (SHAPE OBJ-A CYLINDRICAL) (SURFACE-CONDITION OBJ-B POLISHED))
;;;           2  -> (SHAPE OBJ-A CYLINDRICAL)
;;;           1  -> (SURFACE-CONDITION OBJ-B POLISHED)
;;;Complete! 
;;;
;;;
;;;UCPOP Stats: Initial terms = 69;   Goals = 3 ;  Success (2 steps)
;;;      Created 5 plans, but explored only 3
;;;      CPU time:    4.8500 sec
;;;      Branching factor:  1.333
;;;      Working Unifies: 31  
;;;      Bindings Added: 3    
