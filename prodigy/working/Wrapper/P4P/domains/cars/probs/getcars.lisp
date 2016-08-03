;; Chris and Rick are at the garage with the Toyota.
;; They have to drive the Toyota to the auction, pick up the Chrysler, 
;;  and bring both cars back to the garage.

(setf (current-problem)
        (create-problem
        (name get-cars)
        (objects
         (Toyota Chrysler CAR)

         (Garage Auction LOCATION)
         (Rick Chris PERSON))
        (state 
         (and (at Toyota Garage)
              (at Chris Garage)
              (at Rick Garage)
              (at Chrysler Auction)))

        (goal
         (and (at Chris Garage)
              (at Rick Garage)
              (at Toyota Garage)
              (at Chrysler Garage)
         ))))
      





