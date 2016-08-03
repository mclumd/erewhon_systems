;;; Pednault's briefcase world, to demonstrate that we're doing conditional
;;; effects right.

(create-problem-space 'briefcase :current t)

(setf *xmargin* 30)
(setf *width* 130)

(ptype-of location :top-type)
(ptype-of object :top-type)
(ptype-of container object)

(pinstance-of briefcase container)
(pinstance-of dictionary object)
(pinstance-of paycheck object)
(pinstance-of home location)
(pinstance-of office location)

;;; As in Pednault's description, I'm supressing the briefcase.

(operator PutIn
	  (params <x> <l>)
	  (preconds ((<x> (and Object
			       (diff <x>
				     (p4::object-name-to-object
				      'briefcase *current-problem-space*))))
		     (<l> Location))
		    (and (at briefcase <l>)
			 (at <x> <l>)))
	  (effects () ((add (in <x> briefcase)))))

(operator TakeOut
	  (params <x>)
	  (preconds ((<x> Object)) (and))
	  (effects () ((del (in <x> briefcase)))))

(operator Move-briefcase
	  (params <l>)
	  (preconds ((<l> Location)) (and))
	  (effects ((<o> Location))
		   ((del (at briefcase <o>))
		    (add (at briefcase <l>))
		    (forall ((<x> Object))
			    (in <x> briefcase)
			    ((del (at <x> <o>))
			     (add (at <x> <l>)))))))

(defun diff (x y) (not (eq x y)))


#|
I tried to use this to have protection by default, to solve the
problem optimally. But it doesn't work, because the code to figure out
what is protectable is hard-wired to look for applied-op nodes already
existing. I'm going to take that out, because the bias to do this last
is already in the function expand-binding-or-applied-op.

(control-rule protect-first
	      (if (protectable-goals))
	      (then protect))
|#


(defun protectable-goals ()
  (p4::generate-protection-nodes *current-node*))


;;; Some control rules to make it easier to get to the good bits while
;;; I debug the whole approach.

(control-rule move-stuff-not-briefcases
 (if (and (candidate-goal (at briefcase <loc1>))
	  (candidate-goal (at <x> <loc2>))
	  (not-briefcase <x>)))
 (then reject goal (at briefcase <loc1>)))

     
(defun not-briefcase (object)
  (not (eq (p4::prodigy-object-name object) 'briefcase)))

(setf p4::*use-protection* t)
