;;; Elan Smith 
;;; Gary Schmaltz
;;; James Bryce Howell
;;; CS 409   (Undergraduate!!!)
;;; 
;;; domain.lisp
;;; 
;;; Interpretation:
;;; 
;;; A person (in our problems, a farmer) has to move some animals from one
;;; location to another. Specifically, the farmer has to move the animals
;;; (a dog, cat, and mouse) from one side of the river to another. We
;;; originally to planned to implement the food-chain among the animals
;;; (i.e. the dog attacking the cat, and the cat killing the mouse) but
;;; time considerations did not permit this. Animals left to themselves
;;; would eat their respective prey, and disappear from the system.
;;; This action was implemented in the MOVE-PERSON operator and the "eats"
;;; predicate which indicated which animals could eat which other animals.

;;; In our problems, the "eats" predicate is not populated. 
;;; 
;;; 

;;; The predicates used are listed as follows:
;;;
;;; is-at CREATURE LOCATION 
;;;   This predicate indicates where a creature is currently located.
;;;   If an ANIMAL is being carried, it will not be found in this
;;;   predicate. Instead, it will occur in the is-carrying predicate.
;;;
;;; is-carrying HUMAN ANIMAL
;;;   This predicate indicates if an ANIMAL is being carried by a HUMAN.
;;;   A HUMAN was not allowed to pick up more ANIMALs if he/she was 
;;;   already carrying at least one in our domain. 
;;;
;;; eats ANIMAL ANIMAL
;;;   This predicate indicates if an animal will eat another animal
;;;   when no HUMANs are around. This is partially implemented.
;;;   Our problems did not make use of this predicate, however.


(create-problem-space 'river :current t)

;;; All the objects in our domain are of type CREATURE or LOCATION. 
;;; CREATUREs include ANIMALs and HUMANs. The interpretations of these
;;; classes should be obvious. 

(ptype-of CREATURE :top-type)
(ptype-of ANIMAL CREATURE)
(ptype-of HUMAN CREATURE)
(ptype-of LOCATION :top-type)


;;; The operator LOAD-PERSON represents the action of a human picking up
;;; an animal. 
;;; 
;;; Pre-conditions:
;;;  The HUMAN <person> and the ANIMAL <critter> should be at the same
;;;  LOCATION <loc>. <person> should not be carrying any other animals
;;;  already.
;;;
;;; Effects:
;;;  <critter> will no longer be at LOCATION <loc>.
;;;  <critter> will be carried by the HUMAN <person>.

(OPERATOR LOAD-PERSON 
 (params <person> <critter> <loc>)
 (preconds 
  ((<person> HUMAN)
   (<critter> ANIMAL)
   (<loc> LOCATION ))

   (and (~ (exists ((<x> ANIMAL)) (is-carrying <person> <x>) ))
     (and (is-at <person> <loc>) (is-at <critter> <loc>) ) ))  

 (effects ()
          ( (del (is-at <critter> <loc>) )
            (add (is-carrying <person> <critter>)))))

;;; The operator UNLOAD-PERSON represents the action of a person
;;; dropping an animal.
;;; 
;;; Preconditions:
;;; 
;;; The HUMAN <person> must be carrying the ANIMAL <critter>.
;;; The HUMAN <person> should be at the LOCATION <loc>.
;;;
;;; Effects:
;;;
;;; <person> will no longer be carrying <critter>
;;; <critter> will no longer be at the LOCATION <loc>
 
(OPERATOR UNLOAD-PERSON
  (params <person> <critter> <loc>) 
  (preconds 
   ( (<person> HUMAN )
     (<critter> ANIMAL )
     (<loc> LOCATION ) )
   (and (is-carrying <person> <critter>) (is-at <person> <loc>)))
  (effects ()   
            ((del (is-carrying <person> <critter>))
             (add (is-at <critter> <loc>)) )))


;;; The operator MOVE-PERSON represents the action of a HUMAN moving
;;; from one LOCATION to another. 
;;;
;;; Preconditions:
;;; 
;;; The HUMAN <person> must be at the LOCATION <from>.
;;;
;;; Effects:
;;;  
;;; The HUMAN <person> will be at the LOCATION <to>.
;;; 
;;; I am not entirely sure (because I don't know if the effects are
;;; applied to all possible combinations of effects parameters), but
;;; all the animals whose predators are present when <person> moves 
;;; out of a location should cease to exist. That is, they should be
;;; eaten!!!!!!!!!!! :)  An ANIMAL <critter2> should only disappear if
;;; ANIMAL <critter1> is present and (eats <critter1> <critter2>) is true.
;;; This lets us specify in our problems whether any predation is going to
;;; occur out of the sight of HUMANs.


(OPERATOR MOVE-PERSON
          (params <person> <from> <to>)
          (preconds 
           ( (<person> HUMAN)
             (<to> LOCATION)
             (<from> LOCATION) )
           (is-at <person> <from>))
          
          (effects ((<critter1> ANIMAL) 
                    (<critter2> ANIMAL))
                  
                   ((del (is-at <person> <from>))
                    (add (is-at <person> <to>))
                    (if 
                        (and (is-at <critter1> <from>) 
                             (is-at <critter2> <from>)
                             (eats <critter1> <critter2>)) 
                        ((del (is-at <critter2> <from>))))))) 


          


