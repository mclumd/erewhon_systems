
(create-problem-space 'schedworld :current t)

(ptype-of Object :Top-Type)
(ptype-of Shape  :Top-Type)
(ptype-of Temperature :Top-Type)
(ptype-of Machine :Top-Type)
(ptype-of Paint   :Top-Type)
(ptype-of Surface-Condition :Top-Type)
(ptype-of Orientation :Top-Type)

(pinstance-of polisher roller lathe grinder punch drill-press bolting-machine
	      welder spray-painter immersion-painter Machine)
(pinstance-of rectangular cylindrical undetermined Shape)
(pinstance-of polished rough smooth Surface-Condition)
(pinstance-of hot cold Temperature)
(pinstance-of regular-red regular-white water-res-red water-res-white paint)
(pinstance-of orientation-1 orientation-2 orientation-3 orientation-4
	      orientation)

(infinite-type Time #'numberp)
(infinite-type Width #'numberp)

(OPERATOR
 Polish
 (params <obj-p> <time-p> <prev-time-p>)
 (preconds
  ((<obj-p> Object)
   (<prev-time-p> (and Time (gen-from-pred
			     (last-scheduled <obj-p> <prev-time-p>))))
   (<time-p> (and Time (later <time-p> <prev-time-p>))))
  (and (or (clampable <obj-p> POLISHER)
	   (shape <obj-p> RECTANGULAR))
       (idle POLISHER <time-p>)))
 (effects
  ((<surface> Surface-Condition))
  ((del (surface-condition <obj-p> <surface>))
   (add (surface-condition <obj-p> POLISHED))
   (del (last-scheduled <obj-p> <prev-time-p>))
   (add (last-scheduled <obj-p> <time-p>))
   (add (scheduled <obj-p> POLISHER <time-p>)))))

(OPERATOR
 Roll
 (params <obj-r> <time-r> <prev-time-r>)
 (preconds
  ((<obj-r> Object)
   (<prev-time-r> (and Time (gen-from-pred
			     (last-scheduled <obj-r> <prev-time-r>))))
   (<time-r> (and Time (later <time-r> <prev-time-r>))))
  (and 
       (idle ROLLER <time-r>)))
 (effects
  ((<old-shape-r> Shape)
   (<old-temp-r> Temperature)
   (<*1-r> Surface-Condition)
   (<*2-r> Paint)
   (<*4-r> Orientation)
   (<*3-r> (and Width (gen-from-pred
		       (has-hole <obj-r> <*3-r> <*4-r>)))))
  ((del (shape <obj-r> <old-shape-r>))
   (del (temperature <obj-r> <old-temp-r>))
   (del (last-scheduled <obj-r> <prev-time-r>))
   (del (surface-condition <obj-r> <*1-r>))
   (del (painted <obj-r> <*2-r>))
   (del (has-hole <obj-r> <*3-r> <*4-r>))
   (add (temperature <obj-r> HOT))
   (add (shape <obj-r> CYLINDRICAL))
   (add (last-scheduled <obj-r> <time-r>))
   (add (scheduled <obj-r> ROLLER <time-r>)))))

(OPERATOR
 Lathe
 (params <obj-l> <time-l> <shape-l> <prev-time-l>)
 (preconds
  ((<obj-l> Object)
   (<prev-time-l> (and Time (gen-from-pred
			     (last-scheduled <obj-l> <prev-time-l>))))
   (<time-l> (and Time (later <time-l> <prev-time-l>)))
   (<shape-l> Shape))
  (and 
       (idle LATHE <time-l>)
       (shape <obj-l> <shape-l>)))
 (effects
  ((<*3-l> Surface-Condition)
   (<*4-l> Paint))
  ((del (shape <obj-l> <shape-l>))
   (del (surface-condition <obj-l> <*3-l>))
   (add (surface-condition <obj-l> ROUGH))
   (del (painted <obj-l> <*4-l>))
   (del (last-scheduled <obj-l> <prev-time-l>))
   (add (shape <obj-l> CYLINDRICAL))
   (add (last-scheduled <obj-l> <time-l>))
   (add (scheduled <obj-l> LATHE <time-l>)))))

(OPERATOR
 Grind
 (params <obj-g> <time-g> <prev-time-g>)
 (preconds
  ((<obj-g> Object)
   (<prev-time-g> (and Time (gen-from-pred
			     (last-scheduled <obj-g> <prev-time-g>))))
   (<time-g> (and Time (later <time-g> <prev-time-g>))))
  (and 
       (idle GRINDER <time-g>)))
 (effects
  ((<whatever-1> Surface-Condition)
   (<whatever-2> Paint))
  ((del (surface-condition <obj-g> <whatever-1>))
   (add (surface-condition <obj-g> SMOOTH))
   (del (painted <obj-g> <whatever-2>))
   (del (last-scheduled <obj-g> <prev-time-g>))
   (add (last-scheduled <obj-g> <time-g>))
   (add (scheduled <obj-g> GRINDER <time-g>)))))

(OPERATOR
 Punch
 (params <obj-u> <time-u> <hole-width-u> <orientation-u> <prev-time-u>)
 (preconds
  ((<obj-u> Object)
   (<prev-time-u> (and Time (gen-from-pred
			     (last-scheduled <obj-u> <prev-time-u>))))
   (<time-u> (and Time (later <time-u> <prev-time-u>)))
   (<orientation-u> Orientation)
   (<hole-width-u>
    (and Width (gen-from-pred
		(is-punchable <obj-u> <hole-width-u> <orientation-u>)))))
  (and (clampable <obj-u> PUNCH)
       (idle PUNCH <time-u>)))
 (effects
  ((<whatever-condition> Surface-Condition))
  ((add (has-hole <obj-u> <hole-width-u> <orientation-u>))
   (del (surface-condition <obj-u> <whatever-condition>))
   (add (surface-condition <obj-u> <prev-time-u>))
   (del (last-scheduled <obj-u> <prev-time-u>))
   (add (last-scheduled <obj-u> <time-u>))
   (add (scheduled <obj-u> PUNCH <time-u>)))))

(OPERATOR
 Drill-Press
 (params <obj-d> <time-d> <hole-width-d> <orientation-d> <prev-time-d>)
 (preconds
  ((<obj-d> Object)
   (<prev-time-d> (and Time
		       (gen-from-pred (last-scheduled <obj-d> <prev-time-d>))))
   (<time-d> (and Time (later <time-d> <prev-time-d>)))
   (<hole-width-d> (and Width (gen-from-pred (have-bit <hole-width-d>))))
   (<orientation-d> Orientation))
  (and (is-drillable <obj-d> <orientation-d>)
       (~ (surface-condition <obj-d> POLISHED))
       (idle DRILL-PRESS <time-d>)))
 (effects
  ()
  ((add (has-hole <obj-d> <hole-width-d> <orientation-d>))
   (del (last-scheduled <obj-d> <prev-time-d>))
   (add (last-scheduled <obj-d> <time-d>))
   (add (scheduled <obj-d> DRILL-PRESS <time-d>)))))

#|

This operator deletes two objects and creates a new one, at least, if
we interpret the "is-object" predicate as a type, it does. There are
ways round this, but because I'm not sure what is the best thing to
do, I've left this operator out for now. Jim.

(OPERATOR
 Bolt
  (params <obj1-b> <obj2-b> <time-b> <new-obj-b> <prev-time1-b> <prev-time2-b>
	  <orientation-b> <width-b> <bolt-b>)
  (preconds
   ((<obj1-b> Object)
    (<obj2-b> Object)
    (<time-b> Time)
      (and
	(can-be-bolted <obj1-b> <obj2-b> <orientation-b>)
	(is-bolt <bolt-b>)
        (is-width <width-b> <bolt-b>)
	(has-hole <obj1-b> <width-b> <orientation-b>)
	(has-hole <obj2-b> <width-b> <orientation-b>)
        (last-scheduled <obj1-b> <prev-time1-b>)
	(last-scheduled <obj2-b> <prev-time2-b>)
        (later <time-b> <prev-time1-b>)
	(later <time-b> <prev-time2-b>)
        (idle BOLTING-MACHINE <time-b>)
        (composite-object <new-obj-b> <orientation-b> <obj1-b> <obj2-b>)))
;	(shape <obj1-w> <shape1-w>)
;	(shape <obj2-w> <shape1-w>)
;        (composite-shape <new-shape-b> <orientation-b> <obj1-b> <obj2-b>)
  (effects (
     (del (last-scheduled <obj1-b> <prev-time1-b>))
     (del (last-scheduled <obj2-b> <prev-time2-b>))
     (add (last-scheduled <new-obj-b> <time-b>))
;     (del (shape <new-obj-b> <old-shape-*>))
;     (add (shape <new-obj-b> <new-shape-b>))
     (add (is-object <new-obj-b>))
     (del (is-object <obj1-b>))
     (del (is-object <obj2-b>))
     (add (joined <obj1-b> <obj2-b> <orientation-b>))
     (add (scheduled <new-obj-b> BOLTING-MACHINE <time-b>)))))

  )

Weld is in the same boat.

(WELD
  (params (<obj1-w> <obj2-w> <time-w> <new-obj-w> <prev-time1-w> <prev-time2-w> <orientation-w>))
  (preconds 
      (and
        (is-object <obj1-w>)
	(is-object <obj2-w>)
	(can-be-welded <obj1-w> <obj2-w> <orientation-w>)
        (last-scheduled <obj1-w> <prev-time1-w>)
	(last-scheduled <obj2-w> <prev-time2-w>)
        (later <time-w> <prev-time1-w>)
	(later <time-w> <prev-time2-w>)
        (idle WELDER <time-w>)
        (composite-object <new-obj-w> <orientation-w> <obj1-w> <obj2-w>)))
;	(shape <obj1-w> <shape1-w>)
;	(shape <obj2-w> <shape2-w>)
;        (composite-shape <new-shape-w> <orientation-w> <obj1-w> <obj2-w>)
  (effects (
     (del (last-scheduled <obj1-w> <prev-time1-w>))
     (del (last-scheduled <obj2-w> <prev-time2-w>))
     (add (last-scheduled <new-obj-w> <time-w>))
;     (del (shape <new-obj-w> <old-shape*3-w>))
;     (add (shape <new-obj-w> <new-shape-w>))
     (del (temperature <new-obj-w> <old-temp*>))
     (add (temperature <new-obj-w> HOT))
     (add (is-object <new-obj-w>))
     (del (is-object <obj1-w>))
     (del (is-object <obj2-w>))
     (add (joined <obj1-w> <obj2-w> <orientation-w>))
     (add (scheduled <new-obj-w> WELDER <time-w>)))))
|#

(OPERATOR
 Spray-Paint
 (params <obj-s> <time-s> <paint-s> <prev-time-s>)
 (preconds
  ((<obj-s> Object)
   (<paint-s> Paint)
   (<prev-time-s>
    (and Time (gen-from-pred (last-scheduled <obj-s> <prev-time-s>))))
   (<time-s> (and Time (later <time-s> <prev-time-s>)))
   (<s-s> Shape))
  (and
   (sprayable <paint-s>)
   (shape <obj-s> <s-s>)
   (regular-shape <s-s>)
;      (primed <obj-s> <paint-s>)
   (clampable <obj-s> SPRAY-PAINTER)
   (idle SPRAY-PAINTER <time-s>)))
 (effects
  ((<paint-s> Paint)
   (<*2-s> Surface-Condition))
  ((add (painted <obj-s> <paint-s>))
   (del (surface-condition <obj-s> <*2-s>))
   (del (last-scheduled <obj-s> <prev-time-s>))
   (add (last-scheduled <obj-s> <time-s>))
   (add (scheduled <obj-s> SPRAY-PAINTER <time-s>)))))

(OPERATOR
 Immersion-Paint
 (params <obj-i> <time-i> <paint-i> <prev-time-i>)
 (preconds
  ((<obj-i> Object)
   (<paint-i> Paint)
   (<prev-time-i>
    (and Time (gen-from-pred (last-scheduled <obj-i> <prev-time-i>))))
   (<time-i> (and Time (later <time-i> <prev-time-i>))))
  (and
;      (primed <obj-i> <paint-i>)
   (have-paint-for-immersion <paint-i>)
   (idle IMMERSION-PAINTER <time-i>)))
 (effects
  ()
  ((add (painted <obj-i> <paint-i>))
   (del (last-scheduled <obj-i> <prev-time-i>))
   (add (last-scheduled <obj-i> <time-i>))
   (add (scheduled <obj-i> IMMERSION-PAINTER <time-i>)))))


(INFERENCE-RULE
 Is-Clampable
 (params <obj1> <machine>)
 (preconds
  ((<obj1> Object)
   (<machine> Machine))
  (and 
   (has-clamp <machine>)
   (temperature <obj1> COLD)))
 (effects () ((add (clampable <obj1> <machine>)))))


;;; Both the forall and the exists work equally well.
(INFERENCE-RULE
 Infer-Idle
 (params <mach>  <time-t>)
 (preconds
  ((<mach> Machine)
   (<time-t> (and Time (reasonable-time <time-t>))))
  (~ (exists ((<obj2> Object)) (scheduled <obj2> <mach> <time-t>)))
  #|
   (forall ((<obj2> Object))
	   (~ (scheduled <obj2> <mach> <time-t>)))|#
  )
 (effects ()
	  ((add (idle <mach> <time-t>)))))




