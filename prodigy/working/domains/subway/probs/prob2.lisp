;; This is the second test for the subway domain. In order to get
;; onto the platform at station3, we need that fully instantiated
;; operator you'll see poking its head out in domain.lisp


;; Once I remember the station names, this problem file will allow you to
;; traverse the entire Pittsburgh subway system!!

(setf (current-problem)
      (create-problem
       (name subway2)
       (objects
	(gateway-center station)
	(dan person))
       (state (and (adjacent gateway-center wood-street)
		   (at-p dan gateway-center)
		   (shoe-color dan blue)))
       (igoal (on-platform dan wood-street))
;       (igoal (the-angels-want-to-wear-my-red-shoes))
       ))

