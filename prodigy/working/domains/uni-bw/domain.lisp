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

(OPERATOR TAKE-OUT
  (params <x>)
  (preconds
   ((<x> (and Object
	      (diff <x> 'B))))
   (in <x>))
  (effects
   ((<l> Location))
   ((del (in <x>))
    (if (at B <l>)
	((add (at <x> <l>)))))))


	  
	  
