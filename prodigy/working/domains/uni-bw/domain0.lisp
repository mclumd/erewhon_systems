(create-problem-space 'uni-bw :current t)

(ptype-of Object :top-type)
(ptype-of Location :top-type)

(pinstance-of B Object)

(OPERATOR MOV-B
  (params <m> <l>)
  (preconds
   ((<m> Location)
    (<l> (and Location
	      (diff <m> <l>))))
   (at B <m>))
  (effects
   ((<z> (and Object
	      (diff <z> B))))
   ((add (at B <l>))
    (del (at B <m>))
    (if (in <z>)
	((add (at <z> <l>))
	 (del (at <z> <m>)))))))

(OPERATOR PUT-IN
  (params <x> <l>)
  (preconds
   ((<x> Object)
    (<l> Location))
   (and (at <x> <l>)
	(at B <l>)))
  (effects
   ()
   ((add (in <x>)))))

;;; Interesting KR problem
;;; This operator as it is does not help
;;; in Prodigy -- This is not goal-driven
;;; So Prodigy does not consider applying this
;;; operator to avoid a state loop.
;;; Run this domain with problem p4.lisp
;;; and you will see the problem

(OPERATOR TAKE-OUT
  (params <x>)
  (preconds
   ()
   (nothing))
  (effects
   ((<x> (and Object
	      (diff <x> B))))
   ((del (in <x>)))))


(CONTROL-RULE apply-not-subgoal
	      (if (applicable-operator <op>))
	      (then apply))


	  
	  
