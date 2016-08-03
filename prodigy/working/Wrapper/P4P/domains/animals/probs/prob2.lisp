;;; Elan Smith
;;; Gary Schmaltz
;;; James Bryce Howell
;;; CS-409 

;;; File name: prob2.lisp

;;; Interpretation:
 
;;; The HUMAN object is farmer
;;; The ANIMAL objects are cat, dog, and mouse 
;;; The LOCATION objects are north and south

;;; The start state locates the farmer, mouse and dog on the south side of the
;;; river with the cat on the north side.  The goal is for the farmer to move the
;;; mouse and dog to the north side and the cat to the south side. The farmer
;;; should also end up at the south side at the goal.


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
          (is-at cat north)
          (is-at dog south) ) )
      (igoal 
        (and 
          (is-at farmer south)

          (is-at mouse north)
          (is-at cat south)
          (is-at dog north) ) ) ) )

