(in-package parser)

;;;; Uses the functions in hierarchy-functions.lisp to build
;;;; hierarchies for the hierarchical features.

;;;; NOUN HIERARCHY in lisp 
;;;; children of a category are indicated
;;;; by a list following the category
;;;;

(setq *ontology-list*
  '(ROOT

    (-)                   ;;  empty value

    (ANY-SEM              ;; anything that can fill the SEM feature
      (PHYS-OBJ           ;; things that have physical presence in the world
        (FIXED-OBJ         ;;  cannot be moved, also serve as absolute locations
	 (CITY) 
	 (GEO
	  (GEO-STATE)
	  (LAKE)
	  (COUNTRY)
	  (RIVER))
	 (TRACK)
	 (BUILDING 
	  (FACTORY) 
	  (WAREHOUSE)))
       (MOVABLE-OBJ      
         (COMMODITY       ;;   things that can be moved
          (LIQUID-COMMODITY)
          (SOLID-COMMODITY))
	 (MACHINE-COMPONENT)
         (AGENT            ;;    things that can move themselves and act
	   (PERSON) 
           (TRANS-AGENT))
	    
	 
         (CONTAINER)       ;;  things that hold other things, also serve as units
	 )) ;; end PHYS-OBJ
       
      (INFORMATION         ;; things that can be known and shown
       (OBJECTIVE
	(GOAL)
	(PLAN))
       (SITUATION)
       (FACT)
       (MAP)
       (PROPERTY) ;; property of an object, e.g., color
       (VALUE
	(RATE))
       (INTERVAL
	(TIME-INTERVAL
	 (DAY) (MONTH) (YEAR)))
       (LOCATION)
       (SEQUENCE
	(PATH
	 (ROUTE))))
      
     
      (LINGUISTIC-OBJECT
       (WORD) (LETTER))      ;; sentences, words, etc
    

      ;;   verb phrase sems
      (BE)
      (EVENTUALITY
       (STATE
        (MENTAL-PHENOM
         (MEAN) (BELIEVE) (WANT-NEED))
          )
       (ACTIVITY
	(WAIT))
       (EVENT
        (HAPPENING)    ;; non-action events
	(LET) ;; the special verb "let" for "let's do x" sentences      
      ;;   ACTION HIERARCHY
      
	(ACTION
	 (SPEECH-ACT                 ;; illoc acts
	  (TELL 
	   (ELABORATE) 
	   (ID-GOAL) 
	   (WARN))
	  (CONV-ACTS 
	   (CLOSE) 
	   (GREET) 
	   (REJECT) 
	   (CONFIRM)
	   (NOLO-COMPRENDEZ))
	  (REQUEST 
	   (SUGGEST) 
	   (QUESTION 
	    (WH-QUESTION
	     (HOW-QUESTION)
	     (WHY-QUESTION))
	    (YN-QUESTION)))
	  (EXPRESSIVE)
	  (CONDITIONAL)
	  (SIGNAL-WRONG-ACT
	   ;; (STOP)
	   (RESTART)))
	 (PLAN-ACTS       
	  (ACCEPT-PLAN) 
	  (SUMMARIZE-PLAN) 
	  (REVISE-PLAN) 
	  (REJECT-PLAN))
	 (MENTAL-ACTS
	  (FORGET))
	 (PHYS-ACTS
	  (GO)
	  (STOP)
	  (SAY-ACT)))))
      
      
      ;;   THE DIFFERENT DOMAINS OF VALUES, where we have some comparison function
      ;;      between values that determines an ordering
      (DOMAIN
       (MEASURE-DOMAIN
        (TIME-OF-DAY)
        (TIME-DURATION)
        (DISTANCE)
        (WEIGHT)
        (VOLUME)
        (SPEED)
        (COST)
        (DATE)
        (DIFFICULTY)
        (ACCEPTABILITY)
        (CERTAINTY)
        (IMPORTANCE)
        (SHAPE)
        (SIZE)
        (TRUTH)
        (AVAILABILITY)
        (NOVELTY)
        (COMPLETION)
        (PART-WHOLE)
        (IDENTITY)
        (TEMPERATURE))
       (SEQUENCE-DOMAIN)
       (DISCRETE-DOMAIN
        (TRAVEL-MODE)
        (COLOR))
       )

      ;;  THE SORTS (These are subtypes of ANY-SEM as there can be individuals of these types)
      
      (ANY-SORT
       ;;  This first group is relative just to the SEM feature
       (INDIVIDUAL)   ;;  an individual of the specified SEM
       (SET)          ;;  a set of individuals of the specified SEM
       (STUFF)        ;;  an amount of stuff consisting of the specified SEM
       ;;(INTERVAL)     ;;  a interval consisting of the specified SEM (for "ordered" domains)
       (PRED)         ;;  a unary predicates true only of individuals of the specified SEM
       (KIND)         ;;  the kind identified by the SEM
       
       ;;   This group is relative to SEM plus an ARGSEM
       (FUNC)         ;;  a function that maps an ARGSEM to a PRED on SEMs
       (UNIT)         ;;  a function from a NUMBER and a KIND to STUFF 
                      ;;          (.e.g, pounds, minutes,...) 
       ;;(RATE)   duplicate??
       (DESCR)) ;; a complete description denoting an object
    
       (ADV-SORT
	(DISC) ;; discourse adverbials  e.g., now, anyways, ...
	;;(SEQUENCE) duplicate??  sequence adverbials e.g., next, before
	(FREQUENCY)
	(DEGREE-OF-BELIEF)
	(QUANT)
	(PREDSORT ;;  adverbials that can be used as predications (e.g., "He is AT THE STORE")
	 (MANNER)
	 (SETTING))
	)
       
      (CONSTRAINT
       (TIME-CONSTRAINT)
       (OTHER-CONSTRAINT)
       (REASON)
       (METHOD))

       
       
       ;;   INTERVAL and VALUE - should they be here or eslewhere (as they now stand)
       
       
      

      ;;  UNITS, MEASURES and STUFF
      ;;     UNIT is a function from a number to an AMOUNT, e.g., pounds
      ;;        RATE-UNIT is a function from a rate to an AMOUNT
      ;;     AMOUNT is function from STUFF to a OBJECT or SCALE-VALUE,  
      ;;        e.g., five pounds of oranges -> an object consisting of oranges
      ;;        e.g., 
      ;;     AMOUNT-FUNCTION is a function from a OBJECT to an AMOUNT,  e.g., weight
      ;;     CAPACITY is a function from containers and stuff to an AMOUNT

      ;;  These SEM features are augmented by a feature UNIT-TYPE in lexicon
      ;;    and grammar that ranges over TIME, STUFF, DISTANCE, and RATE
       (AMOUNT               ;;  e.g., five hours, ten miles
       (RELATIVE-AMOUNT)  
       (ABSOLUTE-AMOUNT
        ))

      (AMOUNT-FUNCTION)   ;; e.g., duration, weight, distance, speed

      (TIME-LOC-FUNCTION
       (TIME-OF)      ;; function from events to time-loc
       (LOC-OF))     ;; function from events/objects in time to Location
       
      (TIME-LOC)
     
      (CAPACITY)                        ;; capacity

        
      )

    (ANY-VFORM
      (FIN (PRES) (PAST))
     (NONFIN (BASE) (INF) (PASTPART) (ING) (PASSIVE)))
    
    (ANY-STATUS
     (DEFINITE) (INDEFINTE) (QUANTIFIER) (UNIVERSAL))
     
    )
  )

(Declare-hierarchical-features '(SEM ARGSEM SUBCATSEM VFORM SA-ID SORT))
(init-type-hierarchy)
(compile-hierarchy *ontology-list*)

