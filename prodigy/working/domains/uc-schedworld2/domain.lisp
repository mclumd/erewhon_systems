;;Created: Alicia Perez.          Date: nov 16 1992

;;To keep the similarity with UCPOP I use only one type (Gentype) for 
;;everything.

;;The UCPOP sched-world-domain2 does not have times, although the
;;function sched-world-init generates later predicates (but they are
;;not used anywhere) I believe they tried a version with times (op
;;Immersion-paint has a ?t variable that is not used).

(create-problem-space 'uc-schedworld2 :current t)

;(ptype-of Object :Top-type)
(ptype-of Gentype :Top-type)

(infinite-type number #'numberp)

(pinstance-of cold hot polished smooth rough null cylindrical 
	      gentype)

(operator POLISH
  (params <x>)
  (preconds
   ((<x> Gentype))
   (temperature <x> cold))
  (effects
   ((<oldsurf> (and gentype (diff <oldsurf> polished))))
   ((add (surface-condition <x> polished))
    (del (surface-condition <x> <oldsurf>)))))

#|
(effects
 ((<oldsurf> gentype))
 ((del (surface-condition ?x ?oldsurf))
  (add (surface-condition ?x polished))))
|#

(operator ROLL
  (params <x>)
  (preconds
   ((<x> Gentype))
   (nothing))
  (effects
   ((<oldsurf> (and Gentype (diff <oldsurf> smooth)))
    (<oldpaint> (and Gentype (diff <oldpaint> null)))
    (<oldshape> (and Gentype (diff <oldshape> Cylindrical)))
    (<oldtemp> (and Gentype (diff <oldtemp> hot)))
    (<old-orient> Gentype)
    (<oldwidth>
     (and number (gen-from-pred (has-hole <x> <oldwidth> <old-orient>)))))
   ((add (temperature <x> hot))
    (add (shape <x> Cylindrical))
    (add (painted <x> null))
    (add (surface-condition <x> smooth))
    (del (surface-condition <x> <oldsurf>))
    (del (painted <x> <oldpaint>))
    (del (shape <x> <oldshape>))
    (del (temperature <x> <oldtemp>))
    (del (has-hole <x> <oldwidth> <old-orient>)))))

(operator LATHE
  (params <x>)
  (preconds
   ((<x> Gentype))
   (nothing))
  (effects
   ((<oldsurf> (and Gentype (diff <oldsurf> rough)))
    (<oldpaint> (and Gentype (diff <oldpaint> null)))
    (<oldshape> (and Gentype (diff <oldshape> Cylindrical))))
   ((add (surface-condition <x> rough))
    (add (shape <x> Cylindrical))
    (add (painted <x> null))
    (del (surface-condition <x> <oldsurf>))
    (del (painted <x> <oldpaint>))
    (del (shape <x> <oldshape>)))))

(operator GRIND
  (params <x>)
  (preconds
   ((<x> Gentype))
   (nothing))
  (effects
   ((<oldsurf> (and Gentype (diff <oldsurf> smooth)))
    (<oldpaint> (and Gentype (diff <oldpaint> null))))
   ((add (surface-condition <x> smooth))
    (add (painted <x> null))
    (del (surface-condition <x> <oldsurf>))
    (del (painted <x> <oldpaint>)))))


(operator PUNCH
  (params <x> <width> <orient>)
  (preconds
   ((<x> Gentype))
   (temperature <x> cold))
  (effects
   ((<oldsurf> (and Gentype (diff <oldsurf> rough)))
    (<width> number)
    (<orient> Gentype))
   ((add (has-hole <x> <width> <orient>))
    (add (surface-condition <x> rough))
    (del (surface-condition <x> <oldsurf>)))))

(operator DRILL-PRESS
  (params <x> <width> <orient>)
  (preconds
   ((<x> Gentype)
    (<width> number))
   (and (temperature <x> cold)
	(have-bit <width>)))
  (effects
   ((<orient> Gentype))
   ((add (has-hole <x> <width> <orient>)))))

(operator SPRAY-PAINT
  (params <x> <paint>)
  (preconds
   ((<x> Gentype)
    (<paint> Gentype))
   (and (temperature <x> cold)
	(sprayable <paint>)))
  (effects
   ()
   ((add (painted <x> <paint>)))))

(operator IMMERSION-PAINT
  (params <x> <paint>)
  (preconds
   ((<x> Gentype)
    (<paint> Gentype))
   (have-paint-for-immersion <paint>))
  (effects
   ()
   ((add (painted <x> <paint>)))))

(pset :use-abs-level nil)
(setf (getf (p4::problem-space-plist *current-problem-space*)
	    :depth-bound) 100)