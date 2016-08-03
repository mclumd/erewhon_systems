(create-problem-space 'carworld :current t)

(ptype-of CAR :top-type)
(ptype-of LOCATION :top-type)
(ptype-of PERSON :top-type)

;; One of the people already in the car is assigned to drive it.
(OPERATOR DRIVE
          (params <p1> <c1> <L1> <L2>)
          (preconds
           ((<p1> PERSON)
            (<c1> CAR)
            (<L1> LOCATION)
            (<L2> LOCATION))
           (and (at <c1> <L1>)
                (in <p1> <c1>)))
          (effects
           ()
           ((del (at <c1> <L1>))
            (add (at <c1> <L2>)))))

;; A person at the same location as a car can get in the car.
;; The person is considered not to be at a location when they 
;;  are in a car to prevent getting in multiple times. 
(OPERATOR GET-IN
          (params <c1> <p1> <L1>)
          (preconds
           ((<c1> CAR)
            (<p1> PERSON)
            (<L1> LOCATION))
           (and (at <c1> <L1>)
                (at <p1> <L1>)))
          (effects
           ()
           ((add (in <p1> <c1>))
            (del (at <p1> <L1>)))))


;; A person can get out of a car when the car is at a location.
;; The person is at the location when they get out.
(OPERATOR GET-OUT
          (params <c1> <p1> <L1>)
          (preconds
           ((<c1> CAR)
            (<p1> PERSON)
            (<L1> LOCATION))
           (and (at <c1> <L1>)
                (in <p1> <c1>)))
          (effects
           ()
           ((del (in <p1> <c1>))
            (add (at <p1> <L1>)))))












