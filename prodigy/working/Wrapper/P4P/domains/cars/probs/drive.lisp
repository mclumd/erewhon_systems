;; Chris is in Springfield with the car.
;; Rick is in Dayon with no car.
;; Chris has to get to Dayton and Rick has to get to Springfield.
(setf (current-problem)
        (create-problem
        (name drive)
        (objects
         (Chevy CAR)
         (Dayton Springfield LOCATION)
         (Chris Rick PERSON))
        (state 
         (and (at Chevy Springfield)
              (at Chris Springfield)
              (at Rick Dayton)))
        (goal
         (and (at Rick Springfield)
              (at Chris Dayton)  ))))

      




