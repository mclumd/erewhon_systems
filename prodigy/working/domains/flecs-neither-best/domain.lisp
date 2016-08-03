;;; Peter Stone  7/18/94

(create-problem-space 'paint :current t)

(ptype-of OBJECT :top-type)
(ptype-of COLOR :top-type)
(ptype-of ROLLER :top-type)

(pset :depth-bound 80)
(pset :chronological-backtracking t)

(OPERATOR prepare-wall
  (params <roller> <wall> <color>)
  (preconds
   ((<roller> ROLLER)
    (<wall> OBJECT)
    (<color> COLOR))
   (and (needs-painting <wall>)
	(clean <roller>)))
  (effects
   ()
   ((add (prepared <wall> <roller> <color>))
    (add (chosen <roller> <color>)))))

(OPERATOR fill-roller
   (params <roller> <color>)
   (preconds
    ((<roller> ROLLER)
     (<color> COLOR))
    (and (clean <roller>)
	 (chosen <roller> <color>)))
   (effects
    ()
    ((add (filled-with-paint <roller> <color>))
     (del (clean <roller>)))))

(OPERATOR paint-wall
  (params <roller> <wall> <color>)
  (preconds
   ((<roller> ROLLER)
    (<wall> OBJECT)
    (<color> COLOR))
   (and (prepared <wall> <roller> <color>)
	(filled-with-paint <roller> <color>)))
   (effects
    ()
    ((add (painted <wall> <color>))
     (del (needs-painting <wall>))
     (del (prepared <wall> <roller> <color>)))))





