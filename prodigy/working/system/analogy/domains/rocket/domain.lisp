;;; This is the rocket problem, using identical operators to nolimit's
;;; in order to make comparison easy.

(create-problem-space 'nolimit-rocket :current t)

(ptype-of OBJECT    :top-type)
(ptype-of LOCATION  :top-type)
(ptype-of ROCKET    :top-type)

(pinstance-of LocA LocB LOCATION)

(Operator
 Load-Rocket
 (params <object> <rocket> <place>)
 (preconds
  ((<object> OBJECT)
   (<place> LOCATION)
   (<rocket> ROCKET))
  (and (at <rocket> <place>)
       (at <object> <place>)))
 (effects
  ()
  ((del (at <object> <place>))
   (add (inside <object> <rocket>)))))

(Operator
 Unload-Rocket
 (params <object> <place> <rocket>)
 (preconds
  ((<object> OBJECT)
   (<place>  LOCATION)
   (<rocket> ROCKET))
  (and (inside <object> <rocket>)
       (at <rocket> <place>)))
 (effects
  ()
  ((del (inside <object> <rocket>))
   (add (at <object> <place>)))))

(Operator
 Move-Rocket
 (params <rocket>)
 (preconds
  ((<rocket> ROCKET))
  (at <rocket> LocA))
 (effects
  ()
  ((del (at <rocket> LocA))
   (add (at <rocket> LocB)))))

(setf *class-short-names*
      '((OBJECT . o)
	(LOCATION . l)
	(ROCKET . r))) 

(defun diff (x y)
  (not (eq x y)))

(set-running-mode 'saba) ;; nothing to do with analogy

(when *analogical-replay*
  (load 
   (concatenate
    'string
    *system-directory*
    "analogy/replay-crs"))
  (set-running-mode 'savta))

;(pset :compute-abstractions t)
