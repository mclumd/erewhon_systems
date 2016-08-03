;;; A translation of the UCPOP robot domain into prodigy 4.0
;;; syntax, for comparison. 
;;; Jim Blythe, 4/4/93

(create-problem-space 'uc-init-flat-tire :current t)

;;; Might be slightly different, because this definition doesn't allow
;;; containers within containers. If I see his happening, I'll change it.
(ptype-of Object :top-type)
(ptype-of Container :top-type)

(ptype-of Nut   Object)
(ptype-of Hub   Object)
(ptype-of Wheel Object)

(pinstance-of wrench Object)
(pinstance-of jack Object)
(pinstance-of pump Object)

(OPERATOR 
 cuss
 (params)
 (preconds
  ()
  (and))
 (effects
  ()
  ((del (annoyed)))))

(operator
 open
 (params <x>)
 (preconds
  ((<x> Container))
  (and (~ (locked <x>))
       (~ (open <x>))))
 (effects () ((add (open <x>)))))

;;; I added this to the domain so "fixit" would be solvable - Jim
(operator
 close
 (params <container>)
 (preconds ((<container> Container)) (open <container>))
 (effects
  ()
  ((del (open <container>)))))

(operator
 fetch
 (params <x> <y>)
 (preconds
  ((<x> Object)
   (<y> Container))
  (and (in <x> <y>) (open <y>)))
 (effects
  ()
  ((add (have <x>))
   (del (in <x> <y>)))))

(operator
 put-away
 (params <x> <y>)
 (preconds
  ((<x> Object)
   (<y> Container))
  (and (have <x>) (open <y>)))
 (effects
  ()
  ((add (in <x> <y>))
   (del (have <x>)))))

(operator
 loosen
 (params <x> <y>)
 (preconds
  ((<x> Nut)
   (<y> Hub))
  (and (have wrench) (tight <x> <y>) (on-ground <y>)))
 (effects
  ()
  ((add (loose <x> <y>))
   (del (tight <x> <y>)))))

(operator
 tighten
 (params <x> <y>)
 (preconds
  ((<x> Nut)
   (<y> Hub))
  (and (have wrench) (loose <x> <y>) (on-ground <y>)))
 (effects
  ()
  ((add (tight <x> <y>))
   (del (loose <x> <y>)))))

(operator
 jack-up
 (params <y>)
 (preconds ((<y> Hub)) (and (on-ground <y>) (have jack)))
 (effects ()
	  ((del (on-ground <y>))
	   (del (have jack)))))

(operator
 jack-down
 (params <x>)
 (preconds ((<x> Hub)) (~ (on-ground <x>)))
 (effects () ((add (on-ground <x>)) (add (have jack)))))

(operator
 undo
 (params <x> <y>)
 (preconds
  ((<x> Nut) (<y> Hub))
  (and (~ (on-ground <y>)) (~ (unfastened <y>))
       (have wrench) (loose <x> <y>)))
 (effects
  ()
  ((add (have <x>))
   (add (unfastened <y>))
   (del (on <x> <y>))
   (del (loose <x> <y>)))))

(operator
 do-up
 (params <x> <y>)
 (preconds
  ((<x> Nut) (<y> Hub))
  (and (have wrench) (unfastened <y>)
       (~ (on-ground <y>)) (have <x>)))
 (effects
  ()
  ((add (loose <x> <y>))
   (del (unfastened <y>))
   (del (have <x>)))))

(operator
 remove-wheel
 (params <x> <y>)
 (preconds ((<x> Wheel) (<y> Hub))
	   (and (~ (on-ground <y>)) (on <x> <y>) (unfastened <y>)))
 (effects
  ()
  ((add (have <x>))
   (add (free <y>))
   (del (on <x> <y>)))))

(operator
 put-on-wheel
 (params <x> <y>)
 (preconds ((<x> Wheel) (<y> Hub))
	   (and (have <x>) (free <Y>) (unfastened <y>)
		(~ (on-ground <y>))))
 (effects
  ()
  ((add (on <x> <y>))
   (del (have <x>))
   (del (free <y>)))))

(operator
 inflate
 (params <x>)
 (preconds ((<x> Wheel))
	   (and (have pump) (~ (inflated <x>)) (intact <x>)))
 (effects () ((add (inflated <x>)))))



;;; Control rules.
;;;
;;; Ucpop does not support control rules in the released version as of
;;; 4/93, so these are not compatible with the original. However, the
;;; problems fix1 - fix5 supplied with the domain appear to be a
;;; stepping-stone break-down of the "fixit" problem, which is a way
;;; to add control information. I haven't followed the same method
;;; here, though, but instead I've written some local control rules,
;;; more in the style of Prodigy. - Jim

(control-rule close-the-boot-last
	      (if (and (candidate-goal (~ (open boot)))
		       (candidate-goal <something-else>)
		       (not-close-boot <something-else>)))
	      (then select goal <something-else>))

(control-rule put-away-last
	      (if (and (candidate-goal (in <tool> <container>))
		       (candidate-goal <x>)
		       (~ (in-goal <X>))))
	      (then select goal <X>))

(defun in-goal (lit)
  (eq (p4::literal-name lit) 'in))

;;; True iff either the goal is not (open boot) or (open boot) is false
;;; in the state (so the goal must be positive).
(defun not-close-boot (lit)
  (or (not (eq (p4::literal-name lit) 'open))
      (not (eq (p4::prodigy-object-name
		(elt (p4::literal-arguments lit) 0))
	       'boot))
      (not (p4::literal-state-p lit))))

