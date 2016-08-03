;;; sokoban domain - Manuela
;;; dagstuhl, 11/96

(create-problem-space 'sokoban :current t)

(ptype-of BALL :top-type)
(infinite-type LOCATION #'numberp)
(defvar *limit* 2)

(OPERATOR PUSH-N
  (params <ball> <locx> <locy>)
  (preconds 
   ((<ball> BALL)
    (<locx> LOCATION)
    (<locy> LOCATION)
    (<locy-1> (and LOCATION (decrease1 <locy>)))
    (<locy-2> (and LOCATION (decrease1 <locy-1>))))
   (and (~ (blocked <locx> <locy>))
	(~ (blocked <locx> <locy-1>))
	(~ (blocked <locx> <locy-2>))
	(at <ball> <locx> <locy-1>)
	(at-robot <locx> <locy-2>)))
  (effects 
   () 
   ((del (at <ball> <locx> <locy-1>))
    (del (at-robot <locx> <locy-2>))
    (add (at <ball> <locx> <locy>))
    (add (at-robot <locx> <locy-1>)))))

(OPERATOR PUSH-S
  (params <ball> <locx> <locy>)
  (preconds 
   ((<ball> BALL)
    (<locx> LOCATION)
    (<locy> LOCATION)
    (<locy+1> (and LOCATION (increase1 <locy>)))
    (<locy+2> (and LOCATION (increase1 <locy+1>))))
   (and (~ (blocked <locx> <locy>))
	(~ (blocked <locx> <locy+1>))
	(~ (blocked <locx> <locy+2>))
	(at <ball> <locx> <locy+1>)
	(at-robot <locx> <locy+2>)))
  (effects 
   () 
   ((del (at <ball> <locx> <locy+1>))
    (del (at-robot <locx> <locy+2>))
    (add (at <ball> <locx> <locy>))
    (add (at-robot <locx> <locy+1>)))))


(OPERATOR PUSH-W
  (params <ball> <locx> <locy>)
  (preconds 
   ((<ball> BALL)
    (<locx> LOCATION)
    (<locy> LOCATION)
    (<locx+1> (and LOCATION (increase1 <locx>)))
    (<locx+2> (and LOCATION (increase1 <locx+1>))))
   (and (~ (blocked <locx> <locy>))
	(~ (blocked <locx+1> <locy>))
	(~ (blocked <locx+2> <locy>))	
	(at <ball> <locx+1> <locy>)
	(at-robot <locx+2> <locy>)))
  (effects 
   () 
   ((del (at <ball> <locx+1> <locy>))
    (del (at-robot <locx+2> <locy>))
    (add (at <ball> <locx> <locy>))
    (add (at-robot <locx+1> <locy>)))))

(OPERATOR PUSH-E
  (params <ball> <locx> <locy>)
  (preconds 
   ((<ball> BALL)
    (<locx> LOCATION)
    (<locy> LOCATION)
    (<locx-1> (and LOCATION (decrease1 <locx>)))
    (<locx-2> (and LOCATION (decrease1 <locx-1>))))
   (and (~ (blocked <locx> <locy>))
	(~ (blocked <locx-1> <locy>))
	(~ (blocked <locx-2> <locy>))
	(at <ball> <locx-1> <locy>)
	(at-robot <locx-2> <locy>)))
  (effects 
   () 
   ((del (at <ball> <locx-1> <locy>))
    (del (at-robot <locx-2> <locy>))
    (add (at <ball> <locx> <locy>))
    (add (at-robot <locx-1> <locy>)))))


(OPERATOR MOVE-W
  (params <locx> <locy>)
  (preconds 
   ((<locx> LOCATION)
    (<locy> (and LOCATION (no-ball-p <locx> <locy>)))
    (<locx+1> (and LOCATION (increase1 <locx>))))
   (and (~ (blocked <locx> <locy>))
	(at-robot <locx+1> <locy>)))
  (effects 
   () 
   ((del (at-robot <locx+1> <locy>))
    (add (at-robot <locx> <locy>)))))

(OPERATOR MOVE-E
  (params <locx> <locy>)
  (preconds 
   ((<locx> LOCATION)
    (<locy> (and LOCATION (no-ball-p <locx> <locy>)))
    (<locx-1> (and LOCATION (decrease1 <locx>))))
   (and (~ (blocked <locx> <locy>))
	(at-robot <locx-1> <locy>)))
  (effects 
   () 
   ((del (at-robot <locx-1> <locy>))
    (add (at-robot <locx> <locy>)))))

(OPERATOR MOVE-N
  (params <locx> <locy>)
  (preconds 
   ((<locx> LOCATION)
    (<locy> (and LOCATION (no-ball-p <locx> <locy>)))
    (<locy-1> (and LOCATION (decrease1 <locy>))))
   (and (~ (blocked <locx> <locy>))
	(at-robot <locx> <locy-1>)))
  (effects 
   () 
   ((del (at-robot <locx> <locy-1>))
    (add (at-robot <locx> <locy>)))))

(OPERATOR MOVE-S
  (params <locx> <locy>)
  (preconds 
   ((<locx> LOCATION)
    (<locy> (and LOCATION (no-ball-p <locx> <locy>)))
    (<locy+1> (and LOCATION (increase1 <locy>))))
   (and (~ (blocked <locx> <locy>))
	(at-robot <locx> <locy+1>)))
  (effects 
   () 
   ((del (at-robot <locx> <locy+1>))
    (add (at-robot <locx> <locy>)))))

;;;**************************************************************
(pset :linear t)
(pset :depth-bound 5000)
;;;**************************************************************












