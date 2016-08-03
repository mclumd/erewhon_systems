;;; Name: Elan Smith, James Bryce Howell, Gary Schmaltz 
;;; File name: prob1.lisp

;;; Interpretation:

;;; The HUMAN object is a farmer
;;; The ANIMAL objects are cat, dog, and mouse
;;; The LOCATION objects are north and south

;;; The initial state of HUMAN and ANIMALS are in south side location
;;; The goal is to get all of them to move to location of the north side
  
(setf (current-problem)
   (create-problem
      (name moving)
      (objects
         (farmer HUMAN)

         (cat dog mouse ANIMAL)
         (north south LOCATION))
      (state
        (and
          (is-at farmer south)
          (is-at mouse south)
          (is-at cat south)
          (is-at dog south) ) )
      (igoal 
        (and 
          (is-at farmer north)
          (is-at mouse north)
          (is-at cat north)
          (is-at dog north) ) ) ) )

