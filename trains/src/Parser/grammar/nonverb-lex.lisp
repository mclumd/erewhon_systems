(in-package parser)
 ;; about 500 hash entries as of 8/11/94

;;  TO ADD:
;; condition, corner. correction, dammit, display, 
;;  else, far, hey, hope, hops, interpreting, matter, meantime, um, mm, hm, 
;;  mutter, ones, order, past, positions, potential, predictable, rather, read,
;;   show, sorry, stupid, sudden, than, travel, units, utterances, wake


;;  IMPORTANT N features
;;      RELN for relational nouns:  
;;       with values OF - the DRIVER of the engine
;;                   POSS - the engine's DRIVER
;;                   BARE - the DRIVER
;;       ARGSEM indicates a selectional restriction of reln nouns
;;       RELNTYPE indicates the relation involved

(setq *lexicon-N*
  (expand 'N 
    ;;   regular noun with -s plural
    '(:node
      nil
      ((:node
        ((AGR 3s) (MORPH (-S-3p)) (SORT PRED))
        ((:node 
          ((SEM (? sem ANY-SEM)))
          ((:leaf thing)
           (:leaf thingy)
	   ))
         
         (:node 
          ((SEM PHYS-OBJ))
          ((:leaf guy)
           (:leaf wheel)
           ))
         
         (:node 
          ((SEM PERSON))
          ((:leaf worker)
           (:leaf system)
           (:leaf manager)
	   (:leaf crew) ;; note - singular N involving many people, currently treat as standard singular noun
           ))
	 
	 (:leaf commodity)
	 
         (:node 
          ((SEM SOLID-COMMODITY))
          ((:leaf orange)
           (:leaf banana)
           ))
         
         (:node
          ((SEM CONTAINER) (ARGSEM COMMODITY) (PRED WEIGHT) (MORPH (-S-3P -load)))
	  ((:leaf truck)
           (:leaf plane)
           (:leaf boxcar)
           (:leaf car)
           (:leaf tanker)
           (:leaf tank)
           (:leaf ship)
           (:leaf boat)
           ))
         
         (:node 
          ((SEM (? x TRANS-AGENT MACHINE-COMPONENT CONTAINER)))
          ((:leaf train)
           (:leaf engine)
           (:leaf plane)
           (:leaf truck)
           (:leaf boat)
           (:leaf ship)
           ))
	 
	 (:node
          ((SEM STORAGE-FACILITY))
          ((:leaf warehouse)
           (:leaf building)
           (:leaf house)
           ))
         
         (:node 
          ((SEM FACTORY))
          ((:leaf factory)
           ))
         
         (:node
          ((SEM CITY))
          ((:leaf city)
           (:leaf town)
           ))
         
	 (:node 
	  ((SEM GEO))
	  ((:leaf state (LF GEO-STATE))
	   (:leaf lake)
	   (:leaf river)
	   (:leaf island)
	   (:leaf country)
	   ))
	
         (:node 
          ((SEM KIND))
          ((:leaf kind)
           ))
         
         (:node
          ((SORT INTERVAL) (SEM TIME-OF-DAY))
	  ((:leaf afternoon (LF (Interval (% Time-of-day (Hour 12)) (% Time-of-day (Hour 18)))))
	   (:leaf morning (LF (interval (% Time-of-day (Hour 0)) (% Time-of-day (Hour 11) (Minute 59) (second 59)))))
	   (:leaf evening (LF (interval (% Time-of-day (Hour 18)) (% Time-of-day (Hour 23) (Minute 59) (Second 59)))))
	   (:leaf am (LF (interval (% Time-of-day (Hour 0)) (% Time-of-day (Hour 11) (Minute 59) (second 59)))))
	   (:leaf pm  (LF (interval (% Time-of-day (Hour 12)) (% Time-of-day (Hour 23) (Minute 59) (second 59)))))
	   ))

	 (:node
	  ((SORT VALUE) (SEM TIME-LOC) (TIME-OF-DAY +))
	  ((:leaf noon (lf (% time-of-day (hour 12))))
	   (:leaf midnight (lf (% time-of-day (hour 0))))
	   ))
			       
	 (:node
          ((SORT PRED) (SEM TIME-LOC))
          ((:leaf deadline)
           (:leaf point)
	   ))
	 
	 (:leaf timeframe (SORT INTERVAL) (SEM TIME-OF-DAY))
	 (:leaf interval (SORT INTERVAL) (SEM ANY-SEM))
                
         (:node
          ((SORT UNIT) (SEM TIME-DURATION) (ARGSEM TIME-DURATION))
          ((:leaf minute)
           (:leaf hour)
           (:leaf second)
           (:leaf sec (LF second))
           (:leaf day)
           (:leaf month)
           (:leaf moment)
           ))
         
	 ;;  OTHER UNITS 
	 
         (:node
          ((SORT UNIT) (ARGSEM PHYS-OBJ))   
          ((:node
	    ((SEM WEIGHT))
	    ((:leaf ton)
	     (:leaf pound)
	     (:leaf ounce)
	     ))
	   (:node 
	    ((SEM VOLUME))
	    ((:leaf gallon)
	     ;; (:leaf (cubic feet))
	     ))
	   (:node 
	    ((SEM DISTANCE) (ARGSEM -))
	    ((:leaf mile)
	     (:leaf kilometer)
	     ))
	   
	   (:node
	    ((SEM COST) (ARGSEM -))
	    ((:leaf dollar)
	     ))
	   
	   ))
	 
	 ;;   RATES
	 
	 (:node 
	  ((SORT RATE) (SEM distance) (AGR (? a 3s 3p)))
	  ((:leaf mph (LF (Per mile hour)))
	   (:leaf kph (LF (Per kilometer hour)))
	   ))
	    
	 (:node
	  ((SORT PRED) (SEM COMMODITY))
	  ((:leaf shipment)
           (:leaf load)
	   ))
	 
	  (:node
	  ((SORT PRED) (SEM COMMODITY) (LF COMMODITY) (AGR 3p) (MORPH nil))
	  ((:leaf supplies)
           (:leaf goods)
	   ))
         
	 ;;  domain specifiers
	 (:node 
	  ((SORT FUNC) (ARGSEM PHYS-OBJ) (RELN (? reln OF POSS BARE)))
	  ((:leaf weight (SEM WEIGHT))
	   (:leaf volume (SEM VOLUME))
	   (:leaf size (SEM SIZE))))
	  
         (:node
          ((SORT FUNC) (RELN (? reln  OF BARE)))
          ((:leaf part (ARGSEM (? x PHYS-OBJ INFORMATION)) 
		  (SEM ?x) (LF PART-OF))
           (:leaf total (ARGSEM SET) (SEM NUMBER) (LF CARDINALITY))
	   (:leaf set (ARGSEM SET) (SEM SET))
           (:leaf amount (ARGSEM COMMODITY) (SEM AMOUNT) (LF AMOUNT))
           (:leaf number (ARGSEM SET) (SEM NUMBER) (LF CARDINALITY))
	   (:leaf length (ARGSEM ROUTE) (SEM DISTANCE))
           ))
	         
         (:node 
          ((SORT PRED)(SEM MAP))
          ((:leaf map)
           ))
         
         (:node 
          ((SORT PRED) (SEM LOCATION) (LF LOCATION))
          ((:leaf place)
	   (:leaf location)
           (:leaf lot)
           (:leaf district)
           (:leaf direction)
           ))
         
         (:node
          ((SORT FUNC) (SEM LOCATION) (RELN (? reln  OF POSS BARE)))
          ((:node
            ((ARGSEM MAP))  ;; these all allow "of NP" complements
            ((:leaf top)
             (:leaf bottom)
             (:leaf side)
             ))
           (:node
            ((ARGSEM (? x ROUTE TRANS-AGENT)))
            ((:leaf destination)
             (:leaf origin)
             (:leaf start (LF origin))
             (:leaf end (LF destination))
             (:leaf beginning (LF origin))
             ))
	    (:node 
	     ((ARGSEM (? x PLAN AGENT)))
	     ((:leaf goal)
	      ))
           ))
       (:node 
	((SORT PRED))  
         ((:node 
          ((SEM PATH) (LF ROUTE))
          ((:leaf route)
	   (:leaf trip)
           (:leaf way)
           (:leaf path)
           ))
         
         (:node 
          ((SEM TRACK))
          ((:leaf rail)
           (:leaf track)
           ))
         
         (:node
          ((SEM PLAN))
          ((:leaf idea)
           (:leaf plan)
           (:leaf line)
           (:leaf choice)
           (:leaf part)
           (:leaf suggestion)
           (:leaf mistake)
           (:leaf option)
	   (:leaf version)
           ))
         
         (:node 
          ((SEM OBJECTIVE))
          ((:leaf requirement)
           (:leaf restriction)
           (:leaf issue)
           (:leaf constraint)
           (:leaf task)
	   (:leaf problem)
           (:leaf game)
           (:leaf conflict)
           (:leaf objective)
           (:leaf job)
	   ;;  (:leaf goal)
           ))
         
         (:node 
          ((SEM SITUATION))
          ((:leaf state)
           (:leaf situation)
	   (:leaf case)
           (:leaf position)
           (:leaf play) ;; ??? was only 3s
           (:leaf equation) ;; ?? also only 3s
           ))
	 
	 (:leaf question (SEM QUESTION))
         
         (:node 
          ((SEM PROBLEM) (MASS +))
          ((:leaf traffic (LF CONGESTION))
           (:leaf congestion)
	   ))
	 
	 (:node 
	  ((SEM PROBLEM))
	  ((:leaf delay)
	   (:leaf problem)
	   ))
	 
	 (:node 
	  ((SEM WEATHER-EVENT) (LF BAD-WEATHER))
	  ((:leaf snowstorm)
	   (:leaf storm)
	   (:leaf flooding)

	   ))
	 
         
         (:node
          ((SEM FACT) (LF FACT))
          ((:leaf fact)
           (:leaf reason)
           ))
         
         (:node
          ((SEM ACTION))
          ((:leaf use)
           (:leaf jaunt)
	   (:leaf alert)
           (:leaf consideration)
           (:leaf alternative)
           (:leaf delivery)
           (:leaf connection)
           ))
         
         (:node
          ((SEM EVENT))
          ((:leaf stop)
           (:leaf exception)
           (:leaf event)
           (:leaf hop)
           ))
         
         (:node 
          ((SEM LINGUISTIC-OBJECT))
          ((:leaf sentence)
           (:leaf word)
           (:leaf sound)
           (:leaf letter)
           ))
         ))

	 (:node
	  ((SORT FUNC) (RELN (? reln OF POSS BARE)))
	  
	  ((:node
	    ((SEM SET) (ARGSEM ANYSEM))
	    ((:leaf set)
	     (:leaf group)
	     ))
         
	   (:node
	    ((SEM NUMBER) (RELN (ARGSEM SET)))
	    ((:leaf maximum)
	     (:leaf minimum)
	     (:leaf average)
	     ))
	  
	   
	   (:leaf speed (SEM SPEED) (ARGSEM MOVABLE-OBJ))
	   (:leaf distance (SEM DISTANCE) (ARGSEM PATH))
	   (:leaf cost (SEM COST) (ARGSEM (? c PHYS-OBJ PLAN ACTION ROUTE)))
	   (:leaf time (SEM TIME-OF-DAY) (ARGSEM (? c EVENT ROUTE)))
	 
	   ))
         ))  ;; end regular 3s/3p nouns
       
       ;; nouns that have no plural form
       (:node 
        ((AGR 3s))
        ((:node
          ((SORT PRED) (SEM AMOUNT)) 
          ((:leaf plenty)
           ))
         ))
       
       ;; nouns that only have plural
       (:node
        ((AGR 3p))
        ((:node ((SORT PRED) (SEM PLAN))
                ((:leaf directions )
                 (:leaf instructions)
                 ))
         ))
       
       ;;   MASS NOUNS
       
       (:node 
        ((MASS +) (AGR 3s) (SORT PRED))
        ((:node
          ((SEM COMMODITY))
          ((:leaf cargo)
           (:leaf material)
           (:leaf stuff)
	   ))
         
         (:node
          ((SEM LIQUID-COMMODITY))
          ((:leaf juice (SEM JUICE))
           (:leaf OJ)
           ))
         
	 (:leaf time (LF TIME-DURATION) (SEM TIME-DURATION))
	 (:leaf timing (SEM TIME-DURATION))
	                
         (:node 
          ((SEM PLAN))
          ((:leaf direction)  ;; can you give me some direction
           (:leaf choice)
           ))
	 
         (:Node 
	  ((SEM INFORMATION))
	  ((:leaf information)
	   (:leaf answer)
	   ))
	 
	 (:node
	  ((SEM MONEY) (LF MONEY))
	  ((:leaf money)
	   (:leaf cash)
	   ))
	 
         (:leaf use (SEM ACTION))  ;;??
         
         (:node
          ((SEM ACTION))
          ((:leaf maintenance)
           ))
         
         (:node
          ((SEM CAPACITY))
          ((:leaf room)
           (:leaf space)
           ))
         
         
         ))  ;; end +MASS
       
       ))  ;; main node
    
    ))  ;; END NOUNS

   
 ;;************************************************************************
 ;;  PROPER NAMES 
 ;;************************************************************************
        
     
(setq *lexicon-NAME*
      (expand 'NAME 
        '(:node
          ((AGR 3s) (NAME +) (CLASS PERSON))
          ((:node 
            ((SEM PERSON))
            ((:leaf System)
             (:leaf Manager)))
           ))
        ))
            
    
    ;;************************************************************************
    ;;  PRONOUNS
    ;;************************************************************************

(setq *lexicon-PRO*
   (expand 'PRO 
      '(:node
        ((PRO +))
        ((:leaf it (sem DUMMY) (AGR 3s)) ;; None referential it: e.g.,  it is faster to go through avon
	 (:node
          ((SEM (? sem PERSON)))
          ((:node 
            ((CASE SUB))
            ((:leaf I (agr 1s))
             (:leaf he (Agr 3s))
             (:leaf she (agr 3s))
             (:leaf we (agr 1p))
              ))
           (:node
            ((CASE OBJ))
            ((:leaf me (agr 1s))
             (:leaf him (Agr 3s))
             (:leaf her (Agr 3s))
             (:leaf us (agr 1p))
             ))

	   (:node
            ((CASE (? case SUB OBJ)) (AGR (? a 2s 2p)))
            ((:leaf you)
             (:leaf Y^ (LF you))
             ))

           (:node
            ((REFL +) (CASE OBJ))
            ((:leaf myself (AGR 1s) (STEM me))
             (:leaf yourself (AGR 2s) (STEM you))
             (:leaf ourselves (AGR 1p) (STEM we))
             (:leaf yourselves (AGR 2p) (STEM you))
             ))

           (:node
            ((POSS +) (AGR (? a 3s 3p)))
            ((:leaf my (STEM me))
             (:leaf your (STEM you))
             (:leaf our (STEM we))
             (:leaf their (STEM they))
             (:leaf his (STEM he))
             (:leaf her (STEM she))
             (:leaf its (STEM it))
             (:leaf whose (STEM who) (WH (? w Q R)))
             ))            
           ))
         
         (:node
          ((SEM (? sem )))
          ((:leaf it (CASE (? case SUB OBJ)) (AGR 3s))
           (:leaf they (CASE SUB) (AGR 3p))
           (:node
            ((CASE OBJ) (AGR 3p))
            ((:leaf them)
             (:leaf ^em (lf them))
             ))
           ))
         
         (:node
          ((CASE (? case SUB OBJ)) (SEM (? sem PHYS-OBJ EVENTUALITY ROUTE)) (AGR 3s))
          ((:leaf that (WH (? wh R -))) ;; that can be a personal pronoun or a relative pronoun
           (:leaf this)
           (:leaf one)
	   (:leaf here (SEM LOCATION))
	   ))
         
         
         (:node 
          ((SEM (? sem PHYS-OBJ)) (REFL +) (CASE OBJ))
          ((:leaf itself (AGR 3s))
           (:leaf themselves (AGR 3p))
           ))
           
         (:node
          ((AGR (? a 3s 3p)) (CASE (? case SUB OBJ)))
          ((:node
            ((WH (? w Q R)) (SEM (? sem PERSON)))
	    ((:leaf who (CASE (? case SUB OBJ)))
	     (:leaf whom (CASE OBJ) (LF WHO))
	     ))
	   
	   (:node
	    ((WH R))
	    ((:leaf when
		    (ARGSEM EVENTUALITY) (SEM TIME-LOC) (PRED AT-TIME))
	     (:leaf where
		    (SEM (? s LOCATION PATH)) (SORT SETTING) (PRED AT-LOC))
	     ))
	   
           (:node 
            ((WH Q) (SEM (? sem ANY-SEM)) (AGR 3s))
            ((:leaf what (AGR (? agr 3s 3p))) ;; need 3p: e.g., what are the routes
             (:leaf whatever (lf what))
             ))

           (:leaf which (WH (? w Q R)) (CASE ?c) (SEM (? sem ANY-SEM)))
           ))
         
	 ;;  the rest of these need some work, i believe
         (:node
          ((SEM ANY-SEM))
          ((:node 
            ((AGR 3s))
            ((:leaf none)
             (:leaf something)
             (:leaf anything)
             (:leaf everything)
             ))
           (:node 
            ((AGR 3p))
            ((:leaf somethings)
             (:leaf others)
             ))
           ))

         (:leaf anybody (agr 3s) (SEM PERSON))
         ))
      ))

(setq *lexicon-NP*
   (expand 'PP-WORD 
                
    ;;************************************************************************
		;;  PP_WORDS - noun phrases that act as adverbials 
		;;  see rules -pp-word1> and -pp-word2>
    ;;************************************************************************
   '(:node
     ((AGR 3s) (ARGSEM ?argsem) (SORT SETTING))
     ((:node
       ((SEM LOCATION) (PRED AT-LOC))
       ((:leaf somewhere)
        (:leaf there)
        (:leaf here)
        (:leaf anywhere)
        (:leaf someplace)
        ))
      
      (:leaf there (SEM LOCATION) (PRED TO) (SORT PATH))
      
      (:node
       ((SEM TIME-LOC) (PRED AT-TIME) (ATYPE (? at PRE POSTVP)))
       ((:leaf tomorrow)
	(:leaf yesterday)
	(:leaf today)
	(:leaf soon)
	))
    
      ;;  FOR WH CONSTRUCTS
      ;;  
      (:node
       ((WH Q) (CASE ?case)) ;; CASE specified for funny examples where these terms head NPs (e.g., tell me how to get to avon")
       ((:leaf why (SORT MANNER) (SEM REASON) (PRED REASON-FOR))
	(:leaf how (SORT MANNER) (SEM METHOD) (PRED METHOD-ACHIEVED))
	(:leaf how (SORT QUALITY) (SEM QUALITY) (PRED HOW-QUALITY))
	(:leaf when
	       (ARGSEM EVENTUALITY) (SEM TIME-LOC) (PRED AT-TIME))
	(:leaf where
	       (SEM LOCATION) (SORT  SETTING) (PRED AT-LOC))
	(:leaf where
	       (SEM PATH) (SORT PATH) (PRED EQ))
	 ))
      ))
   ))


;;************************************************************************
    ;;  ADVERBS
    ;;************************************************************************
    ;;

(setq *Lexicon-ADV*
      (expand 
       'ADV 
       '(:node
	 ((SEM CONSTRAINT) (ARG -)  (ARGSEM ?argsem) (ARGSORT ?argsort)
	  (SUBCAT -) (SUBCATSEM ?subcatsem) (SUBCATSORT ?subcatsort))
		
         ;;  these modify path descriptions and serve as particles, and are ignored
         ;;   OVER to avon, 
         ((:node 
	   ((SUBCAT ADVBL) (SORT PATH))
           ((:node
	     ((ATYPE PRE) (SUBCATSEM PATH) (IGNORE +))
	     ((:leaf over)
	      (:leaf eventually)
	      (:leaf down)
	      (:leaf right)
	      (:leaf ahead)
	      (:leaf up)
	      (:leaf on)
	      (:leaf off)
	      (:leaf around)
	      (:leaf through)
	      (:leaf away)
	      (:leaf out)
	      (:leaf along)
	      ))
 
	    ;;these modify paths as well, but are not ignored
	    (:node 
	     ((ATYPE PRE) (SUBCAT ADVBL) (SUBCATSEM PATH))
	     ( ;; (:leaf back)   deleted for now to allow particle interpretation only
	      ;;(:leaf straight (LF DIRECT))
	      (:leaf then)
	      (:leaf just (LF ONLY))
	      (:leaf not (NEG +))
	      ))

	    ;; these modify paths PRE and POST
	    ;;  DIRECTLY to Bath, to Bath DIRECTLY
	    ;;  no (ATYPE PRE) as this is handled by a special rule in newRules.lisp
	    (:node
	     ((ATYPE POST) (SUBCAT ADVBL) (SUBCATSEM PATH))
	     ((:node
	       ((LF DIRECT))
	       ((:leaf directly)
		(:leaf immediately)
		))
	      (:leaf again)
	      (:leaf only)
	      (:leaf next (LF THEN))
	      (:node
	       ((LF ULTIMATE))
	       ((:leaf finally)
		(:leaf ultimately)
		))
	      ))

            
            )) ;;  PATH adverbials

          ;; MANNER ADVERBIALS
          
          ;; these modify actions/events before or after VP
          ;;  e.g., we can COMPLETELY solve this problem
          ;;        we can solve this problem COMPLETELY
          (:node 
           ((ATYPE (? a PREVP POSTVP)) (SORT MANNER))
           ((:leaf completely (LF  complete))
            (:leaf freely (LF free))
	    (:leaf somehow (LF  somehow))
	    
	    (:node
	     ((SEM TIME-DURATION) (COMP-OP LESS) (LF (LESS TIME-DURATION)))
	     ((:leaf quick (MORPH (-ly)))
	      (:leaf fast)
	      ))
	    
            (:node
             ((LF  simultaneous))
             ((:leaf simultaneously)
              (:leaf concurrently)
              ))
            (:leaf independently (LF independent))
              ;;  others I just don't know what to do with right now
            (:node
             ((IGNORE +) (LF unknown))
             ((:leaf even)
              (:leaf basically)
              (:leaf continually)
              (:leaf together)
              (:leaf timewise)
  
                  
              ))
            ))

          ;;  OTHER VP MANNER ADVERBIALS

          ;;  these modify actions in post-VP position only
          ;;  e.g.,  we can solve this problem differently
          (:node
           ((ATYPE POSTVP) (SORT MANNER))
           ((:leaf differently (LF  different))
	    ;; (:leaf well (LF  WELL))   unlikely interp in trains domain
            ))

          ;;  NON-MANNER VP ADVERBIALS - CURRENTLY SET AS MANNER UNTIL I KNOW WHAT TO DO WITH THEM

          (:node 
           ((ATYPE (? a PRE PREVP POSTVP)) (SORT MANNER))
           (
	      ;;  these temporal expressions are relative to current time,
	    
	    
	    (:leaf already)
            (:leaf equally)
            ;; ones I don't know what to do with  
            (:node
             ((IGNORE +))
             ((:leaf much)
              (:leaf anymore)
              (:leaf still)
              (:leaf also)
              ))
            ))

          ;;   these modify actions in pre-VP position only
          ;;   e.g.,  we NEVER solved the problem
          (:node
           ((ATYPE PREVP))
           ((:leaf never)
	    (:leaf just)
	    (:leaf only)
            ))

          ;;  these modify actions in postVP position
          ;;   e.g., we solved this problem INSTEAD
          (:node
           ((ATYPE POSTVP) (ARGSEM ACTION))
           ((:leaf separately)
	    (:leaf again)
            ))

          ;;  TEMPORAL ADVERBS

          ;;   SEQUENCE ADVERBIALS
          (:node
            ((ATYPE (? a PRE POST)) (SORT DISC) (DISC-FUNCTION IN-SEQUENCE))
             ((:leaf originally)
	      (:leaf ultimately)
	      (:leaf earlier)
	      (:leaf previously)
	      (:leaf afterward)
	      (:leaf afterwards)
	      (:leaf later)
	      ))
              

            ;;  SEQUENCE ADVERBIALS in POST POSITION
            ;;   e.g., we solved this problem BEFORE
            (:node
             ((ATYPE POST) (SORT SEQUENCE))
             ((:leaf before (LF (IN-SEQUENCE BEFORE)))
                ))

            
            ;;  More temporal adverbials in post position
            (:node
             ((ATYPE (? x POST)) (SORT SETTING) (ARGSEM (? sem EVENTUALITY BE)) ;; may be able to delete BE here is it becomes a substype of EVENTUALITY
	      (SEM TIME-CONSTRAINT))
          
	     ((:node 
               ((LF NOW))
               ((:leaf now)
                (:leaf currently)
                (:leaf presently)
                (:leaf yet)
                (:leaf immediately)
                ))
	      (:leaf forever)
	     
              ))
            
           
	  ;;    (:leaf oclock (ATYPE oclock))   oclock is two words now: o^ clock.

	  ;;  frequency adverbials
	  (:NODE
	   ((SORT FREQUENCY))
	   ((:leaf once (FREQUENCY 1))
            (:leaf twice (FREQUENCY 2))
            (:leaf always (FREQUENCY always))
	    ))
            
            ;;  certainty adverbials, commenting on the truth of the assertion
            
            (:node
             ((ATYPE (? a PRE PREVP POST)) (SORT DISC) (SEM DEGREE-OF-BELIEF))
             ((:node
               ((LF (LESS DEGREE-OF-BELIEF))
		(DISC-FUNCTION UNCERTAIN))
               ((:leaf apparently)
                (:leaf probably)
                (:leaf maybe)
                ))
              (:node 
               ((LF (MORE DEGREE-OF-BELIEF)))
               ((:leaf certainly)
                (:leaf obviously)
                (:leaf absolutely)
                (:leaf defintely)
                ))
              ))


          ;;  DISCOURSE ADVERBIALS
          ;;======================================

          (:node
           ((SORT DISC) (ATYPE PRE) (ARGSEM -) (SUBCAT -) (SA-ID ?sa))
           ;;  those that are ignored for now in LF
           ;;   but may be picked up by specific speech act rules
           ((:node 
             ((DISC-FUNCTION POP) (ATYPE PRE))
             ((:leaf now)
              (:leaf anyway)
              (:leaf anyways)
              (:leaf meanwhile)
	      (:leaf meantime (LF MEANWHILE))
              ))

            (:node
             ((DISC-FUNCTION ITEMIZE) (ATYPE (? x PRE POST)))
             ((:leaf first)
	      (:leaf firstly (LF first))
              (:leaf second)
	      (:leaf secondly (LF second))
              (:leaf third)
              (:leaf forth)
              (:leaf fourth)
	      (:leaf last)
	      (:leaf lastly (LF last))
              ))

	    (:leaf then (DISC-FUNCTION (? df ITEMIZE SUMMARIZE)))
	    
            (:node
             ((DISC-FUNCTION SUMMARIZE))
             ((:leaf so)
              (:leaf clearly)
              (:leaf essentially)
              ))
	    
	    (:leaf please (ATYPE (? at PRE POST)) (DISC-FUNCTION POLITE))

            (:NODE
             ((DISC-FUNCTION QUALIFY))
             ((:leaf well)
              (:leaf oh)
              (:leaf hmm)
              (:leaf actually)
              (:leaf though)
            ))
            
            (:node
             ((DISC-FUNCTION  CONJUNCT))
             ((:leaf and)
              (:leaf or)
              (:leaf but)
              (:leaf also)
              ))
	    (:node 
	     ((DISC-FUNCTION SA-ID) (ATYPE (? at PRE POST)))
	     ((:leaf instead (SA-ID reject) (SUBCAT -))
	      (:leaf instead (SA-ID reject) (SUBCAT (% pp (ptype of) (var ?v))))
	     
	      ))
            ))

          ;;  QUANTITY ADVERBIALS
          ;;  e.g., exactly five boxcars
          
          (:node
           ((SORT QUANT))
           ((:node 
             ((LF EXACT))
             ((:leaf exactly)
              (:leaf precisely)
              ))
            (:node
             ((LF APPROX))
             ((:leaf approximately)
              (:leaf roughly)
              (:leaf about)
              (:leaf ^bout)
              (:leaf bout)
              ))
            ))
          
          ;;  ADVERBIALS MODIFYING ADJECTIVES
          ;;  e.g., VERY happy
          
          (:node
           ((SUBCAT ADJ))
           ((:leaf very)
            (:leaf real)
            (:leaf quite)
            (:leaf really)
            (:leaf slightly)
            (:leaf perfectly)
            (:leaf wholly)
            (:leaf certainly)
            (:leaf too)
            (:leaf how (WH Q) (SORT quality))
            (:node 
             ((NEG +))
             ((:leaf not)
              (:leaf never)
              ))
            ))
	  ;;  comparative adverbs
	  (:node 
	   ((SUBCAT ADJ) (SORT COMPARATIVE))
	   ((:leaf least (LF MIN))
	    (:leaf less (LF LESS))
	    (:leaf more (LF MORE))
	    (:leaf most (LF MAX))
	    ))
	    
          ))
       ))


   ;;************************************************************************
    ;;  CONJUNCTIONS
    ;;************************************************************************
    
(setq *lexicon-CONJ*
      (expand 'CONJ 
                   '(:node
                     nil
                     ((:node 
                       ((SUBCAT (? sub S PP)))
                       ((:leaf though)
                        (:leaf while)
                        (:leaf however)
                        (:leaf since)
                        (:leaf unless)
                        (:leaf whether)
                        (:leaf whenever)
                        (:leaf whereas)
                        (:leaf although)
                        (:leaf unless)
                         ))
                      (:node 
                       ((SUBCAT S))
                       ((:leaf because)
                        (:leaf ^cause)
                        (:leaf cause)
                        (:leaf as)
                        (:leaf so)
                        ))
                      (:node
                       ((SUBCAT (? sub NP S PP)))
                       ((:leaf otherwise)
                        ))
                      (:node
                       ((SUBCAT (? sub S PP VP NP)) (CONJ +))
                       ((:leaf plus)
                        (:leaf but)
                        (:leaf and (SEQ +))
                        (:leaf ^n)
                        (:leaf or (SEQ +) (CONJ -) (DISJ +))
                        (:leaf versus)
                        ))
                      ))
                   ))
                      
    
    ;;************************************************************************
    ;;  CARDINALS
    ;;************************************************************************

(setq *lexicon-NUMBER*
  (cons
   '(one (NUMBER (NTYPE (? n)) (AGR 3s) (LF 1)))
   (define-numbers)))

    ;;************************************************************************
    ;;  ORDINALS
    ;;************************************************************************

(augment-lexicon
 '(
    (initial (ORDINAL (agr ?a) (LF FIRST)))
    (first (ORDINAL (agr ?a) (LF FIRST)))
    (second (ORDINAL (agr ?a) (LF SECOND)))
    (third (ORDINAL (agr ?a) (LF THIRD)))
    (fourth (ORDINAL (agr ?a) (LF FOURTH)))
    (last (ORDINAL (agr ?a) (LF LAST)))
    (next (ORDINAL (agr ?a) (LF NEXT)))
))

  
    ;;************************************************************************
    ;;  ARTICLES
    ;;     EXIST - feature with values EX (existential), or DEF definite
    ;;************************************************************************
 
(setq *lexicon-ART*
      (expand
       'ART 
       '(:node 
         ((MASS ?m))
         ((:node 
           ((SEM INDEFINITE) (MASS -))
           ((:node 
             ((AGR 3s))
             ((:leaf an (LF a))
              (:leaf a)
              (:leaf another)
              ))
            (:node
	     ((MASS ?m) (AGR (? a 3s 3p)))
	     ((:leaf some)
	      (:leaf any)
	      (:leaf no)

	      ))
	    
            ))
          
          ;; definite articles/quantifiers
          (:node
           ((SEM DEFINITE))
           ((:node 
             ((AGR ?a))
             ((:leaf the)
              (:leaf th^ (LF THE))
              ))
            (:node
             ((AGR 3s))
             ((:leaf that (SEM THAT))
              (:leaf this (SEM THIS))
              ))
            
            (:node
             ((AGR 3p) (MASS -))
             ((:leaf these)
              (:leaf those)
              ))
            
            (:node
             ((WH Q) (SEM WH) (AGR ?a))
             ((:leaf what)
              (:leaf which)
              ))
            ))  ;; exists def
          ))   ;; root node
       ))

    ;;************************************************************************
    ;;  QUANTIFIERS
    ;;************************************************************************
 
(setq *lexicon-QUANT*
      (expand
       'QUAN 
       '(:node
         nil
         ;; directly head count NP as in ALL boys, EVERY boy
         ((:node
           ((QTYPE BARE))
           ((:node 
             ((AGR  3s))   ;; e.g., EVERY boy
             ((:leaf every (SEM UNIVERSAL))
              (:leaf each)
              (:leaf either)
	      (:node
               ((MASS +))      ;; e.g., ALL JUICE
               ((:leaf just (LF ONLY))
                (:leaf all (SEM UNIVERSAL))
                (:leaf most)
                (:leaf enough)
                ))
              ))
            (:node
             ((AGR 3p))   ;; e.g.,  ALL boys
             ((:leaf both (QUANT 2))
              (:leaf just (LF ONLY))
              (:leaf all (SEM UNIVERSAL))
              (:leaf most)
              (:node
               ((SEM INDEFINITE))
	       ((:leaf enough)
                (:leaf many )
                (:leaf several)
                 ))
              ))
                      
            ))  ;; end QTYPE BARE

          ;;   taking "of" + DEF or MASS NP complements
           (:node
            ((QTYPE OF))
             ((:node 
               ((AGR 3p))  ;; SOME of the boys
               ((:leaf some)
                (:leaf each)
                (:leaf lots (LF many))
                (:leaf many)
                (:leaf most)
                (:leaf enough)
                (:leaf several)
                (:leaf few)
                (:leaf either)
                (:leaf none (NEG +))
                (:leaf both (QUANT 2))
                ))
              (:node
               ((MASS +) (AGR 3s))   ;; SOME of the juice
               ((:leaf some)
                (:leaf lots (LF much))
                (:leaf much)
                (:leaf most)
                (:leaf enough)
                (:leaf none (NEG +))
                (:leaf any)
                ))
              ))  ;; end of QTYPE OF

            (:node
             ((QTYPE CARDINALITY) (AGR 3p))  ;; the FEW boys
             ((:leaf few)
              (:leaf several)
              (:leaf many)
              ))
            
            (:node
             ((QTYPE NP) (AGR (? a 3s 3p)))   ;;  JUST the boys, ONLY this car, ONLY juice
             ((:leaf just)
              (:leaf only)
              ;; ALL is in a category by itself
              (:leaf all (MASS ?m))  ;; e.g., ALL the juice, ALL the boys
            ))
        ))
       ))
      
      
;;************************************************************************
;;  ADJECTIVES
;;************************************************************************
;;  MORPH features
;;      -ly allows formation of ADVERB from ADJ
;;      -er  allows formation of comparative and superlative
;;      -erDouble double the consonant before the -er forms

(setq *lexicon-ADJ*
  (expand 
   'ADJ 
   '(:node
     ((ARGSEM ?a) (ATYPE PRE) (COMP-OP MORE) (SORT ADJ))
     ((:node 
      ((ARGSEM (? a EVENT movable-obj)) (SEM TIME-LOC))
      ((:node
        ((MORPH ( -er)))
        ( ;;(:leaf quick (morph (-er -ly)) (COMP-OP LESS))
         (:leaf early)
         ))
       
       (:node
        ((MORPH (-er)))
        ((:leaf late)
         ))
       
       (:node
        nil
        ((:leaf instantaneous)
         ))
     
       (:leaf delayed)
       (:leaf scheduled)
              
       ))

      
      ;; These need more thought
     (:node 
      ((ARGSEM OBJECTIVE) (SEM DIFFICULTY))
      (        
       (:node 
        ((LF SOLVED))
        ((:leaf solved)
         (:leaf complete)
        ))
      
      (:node
       ((LF WARMUP))
       ((:leaf warmup)
        (:leaf startup)
        (:leaf practice)
        ))
       ))
      
      ;;    ABSTRACT ORDERED DOMAINS
      ;;    Key features:
      ;;       SEM - the abstract domain/scale
      ;;       COMP-OP - the direction for comparatives: LESS or MORE
      ;;       LF - the value on the scale: LOW, MEDIUM, HI

      (:node ;; ordered domains
       ((SORT ORDERED-DOMAIN))
       (
      (:node
       ((SEM DIFFICULTY) (ARGSEM (? argsem EVENT OBJECTIVE PLAN ROUTE)))
       ((:leaf easy (LF LOW) (COMP-OP LESS) (MORPH (-er -ly)))
	
	(:node 
	 ((COMP-OP LESS) (LF MEDIUM))
	 ((:leaf solvable)
	  (:leaf doable)
	  (:leaf possible)
	  ))
	
	(:node 
	 ((COMP-OP MORE) (LF HI))
	 ((:leaf difficult)
	  (:leaf complicated)
	  (:leaf impossible)
	  (:node 
	   ((MORPH (-er)))
	   ((:leaf tricky)
	    (:leaf hard)
	    ))
	 ))
       ))

	;;  ACCEPTABILITY
	
      (:node
       ((SEM ACCEPTABILITY) (ARGSEM (? argsem EVENT OBJECTIVE PLAN ROUTE PERSON)))
       ((:node 
	 ((COMP-OP LESS) (LF LOW))
	 ((:leaf bad (MORPH (-ly)))
	  (:leaf terrible)
	  (:leaf acceptable)
	  (:leaf screwed)
	  (:leaf ridiculous)
	  (:leaf worse (COMPARATIVE +) (LF (LESS ACCEPTABILITY)))
	  (:leaf worst (LF (MIN ACCEPTABILITY)))
	  ))
	
      	(:node 
	 ((COMP-OP MORE) (LF HI))
	 ((:leaf good)
	  (:leaf perfect)
	  (:leaf effective)
	  (:leaf excellent)
	  (:leaf fantastic)
	  (:leaf terrific)
	  (:leaf beautiful)
	  (:leaf fabulous)
	  (:leaf wonderful)
	  (:leaf better (COMPARATIVE +) (LF (MORE ACCEPTABILITY)))
	  (:leaf best (LF (MAX ACCEPTABILITY)))
	  (:node
	   ((MORPH (-er)))
	   ((:leaf great)
	    (:leaf grand)
	    (:leaf nice)
	    (:leaf cool)
	    ))
	  ))
	
	(:NODE 
	 ((COMP-OP MORE) (LF MEDIUM))
	 ((:leaf coherent)
	  (:leaf ok)
	  (:leaf okay)
	  (:leaf reasonable)
	  (:leaf interesting)
	  (:leaf fine)
	  
	  ))
	))

         
      ;;  These need some thinking over
       (:node 
        ((LF GOOD) (SEM ACCEPTABILITY))
        ((:leaf pretty)
	 (:leaf fun)
	 (:leaf sure (LF SURE))
	 (:leaf alright)
	 (:leaf allright)
	     
       ))

      
      ;; IMPORTANCE
      
      (:node
       ((SEM IMPORTANCE) (ARGSEM (? argsem EVENT OBJECTIVE PLAN ROUTE)))
       ((:node
	 ((LF LOW) (COMP-OP LESS))
	 ((:leaf unimportant)
	  (:leaf insignificant)
	  (:leaf required)
	  ))
	(:node 
	 ((COMP-OP MORE) (LF HI))
	 ((:leaf important)
	  (:leaf significant)
	  ))
	))
      
      ;; AVAILABILITY
      
      (:node
       ((SEM AVAILABILITY) (ARGSEM (? argsem PHYS-OBJ ROUTE)))
       ((:node
	 ((LF LOW) (COMP-OP LESS))
	 ((:leaf unavailable)
	  (:leaf used)
	  ))
	(:node 
	 ((COMP-OP MORE) (LF HI) (ATYPE (? x PRE POST)))
	 ((:leaf open)
	  (:leaf free (MORPH (-er)))
	  (:leaf handy (MORPH (-er)))
	  (:leaf available)
	  (:leaf unused)
	  (:leaf ready)
	  ))
	))

      ;;  COMPLETION
      (:node
       ((SEM COMPLETION) (ARGSEM (? argsem PLAN ROUTE)))
	((:node
	 ((LF LOW))
	 ((:leaf unfinished)
	  (:leaf incomplete)
	  ))
	 (:node 
	  ((COMP-OP MORE) (LF HI))
	  ((:leaf complete)
	   ))
	 (:node 
	  ((LF HI) (ATYPE (? a PRE POST)))
	  ((:leaf done)
	   (:leaf completed)
	   (:leaf finished)
	   ))
	 ))
      
      ;;  COST
      
      (:node
       ((SEM COST) (ARGSEM (? argsem PHYS-OBJ PLAN ROUTE)))
       ((:node
	 ((LF LOW) (COMP-OP LESS))
	 ((:leaf cheap  (MORPH (-er -ly)))
	  (:leaf inexpensive  (MORPH (-ly)))
	  ))
	(:node 
	 ((COMP-OP MORE) (LF HI))
	 ((:leaf expensive (MORPH (-ly)))
	  ))
	))
      
      ;;  IDENTITY
      
      (:node
       ((SEM IDENTITY) (ARGSEM (? argsem PHYS-OBJ PLAN ROUTE)))
       ((:node
	 ((LF LOW) (COMP-OP LESS) (MORPH (-ly)))
	 ((:leaf different)
	  (:leaf distinct)
	  (:leaf separate)
	  ))
	
	(:node
	 ((LF LOW))
	 ((:leaf opposite)
	  ))
	
	(:node 
	 ((COMP-OP MORE) (LF HI) (MORPH (-ly)))
	 ((:leaf identical)
	  ))
	
	(:node 
	 ((COMP-OP MORE) (LF MEDIUM) (MORPH (-ly)))
	 ((:leaf similar)
	  ))

	(:node 
	 ((LF HI))
	 ((:leaf same)
	  ))
	))
	
	
      
      ;;   WEIGHT
      (:node
       ((SEM WEIGHT) (ARGSEM (? argsem PHYS-OBJ)))
	((:node
	  ((LF LOW) (COMP-OP LESS) (MORPH (-er)))
	  ((:leaf light)
	   ))
		
	(:node 
	 ((COMP-OP MORE) (LF HI) (MORPH (-er)))
	 ((:leaf heavy)
	  ))
	 ))
      
      ;;  SIZE
      (:node
       ((SEM SIZE) (ARGSEM (? argsem PHYS-OBJ)))
	((:node
	  ((LF LOW) (COMP-OP LESS) (MORPH (-er)))
	  ((:leaf small)
	   (:leaf little)
	   ))
		
	(:node 
	 ((COMP-OP MORE) (LF HI) (MORPH (-er)))
	 ((:leaf large)
	  (:leaf big)
	  ))
	 ))

	;;   PROPORTION
	;;     scale reflecting amount of a substance, or completion of a task
		
       (:node
	((SEM PROPORTION) (ARGSEM (? argsem PHYS-OBJ PLAN)))
	(		
	(:node 
	 ((LF HI))
	 ((:leaf entire)
	  (:leaf whole)
	  (:leaf complete)
	  ))
	))
	
	;; TIME-DURATION
	
	(:node
	 ((SEM TIME-DURATION) (ARGSEM (? argsem SITUATION EVENTUALITY)))
	 ((:node
	   ((LF LOW) (COMP-OP LESS) (MORPH (-er)))
	   ((:leaf short)
	    ))
	  
	  (:node 
	   ((COMP-OP MORE) (LF HI) (MORPH (-er)))
	   ((:leaf long)
	    ))
	  
	  (:node ;; fast/slow applied to routes maps to time-duration            
	   ((ARGSEM (? argsem ROUTE EVENT ACTIVITY)) (MORPH (-er)))
	   ((:node
	     ((COMP-OP LESS) (LF LOW))
	     ((:leaf fast)
	      (:leaf quick (MORPH (-er -ly)))
	      ))
	    (:node
	     ((COMP-OP MORE) (LF HI))
	     ((:leaf slow)
	      ))
	      
	    ))
	  
	))
	;;  DISTANCE
	
	(:node
	 ((SEM DISTANCE) (ARGSEM (? argsem ROUTE)))
	 ((:node
	   ((LF LOW) (COMP-OP LESS) (MORPH (-er)))
	   ((:leaf short)
	    ))
	  
	  (:node 
	   ((COMP-OP MORE) (LF HI) (MORPH (-er)))
	   ((:leaf long)
	    (:leaf far)
	    ))
	  ))
	

	))
      
      (:node 
       ((ARGSEM ?argsem))
       ((:leaf last (SEM SEQUENCE-DOMAIN) (LF (? lf previous final)))
       (:node
        nil ;; ((MORPH (-ly)))
        ((:leaf necessary)
	 (:leaf current (SEM TIME-OF-DAY))
         (:leaf present (LF current) (SEM TIME-OF-DAY))
	 (:node
	   ((SEM SEQUENCE-DOMAIN))
	   ((:leaf previous)
	    (:leaf final)
	    (:leaf original)
	    (:leaf first (LF original))
	    (:leaf ultimate)
	    (:leaf other)
	    ))
         ))
       
      
       (:leaf careful)
       (:leaf compatible)
	
   
   (:node 
    ((ARGSEM PHYS-OBJ))
    ((:node
	((MORPH (-er)) (SEM SHAPE))
	((:leaf round)
	 (:leaf square)
	 ))
       
       (:node 
	((ARGSEM (? s PHYS-OBJ PATH)))
	
	((:node
	  ((SEM COLOR))
	  ((:leaf red)
	   (:leaf green)
	   (:leaf blue)
	   (:leaf white)
	   (:leaf black)
         (:leaf yellow)
         (:leaf purple)
         (:leaf orange)
         ))
       (:node
	((SEM LOCATION))
	((:leaf upper)
	 (:leaf lower)
	 (:leaf top)
	 (:leaf bottom)
	 (:leaf southern (LF bottom))  ;; dependency of map
	 (:leaf northern (LF top))
	 (:leaf north)
	 (:leaf south)
	 (:leaf east)
	 (:leaf west)
	 (:node
	  ((MORPH (-er)) (LF NEAR) (SEM DISTANCE) (COMPL (% pp (ptype to) (sem phys-obj))) (COMP-OP LESS))
	  ((:leaf near)
	   (:leaf close)
	   (:leaf nearby (ATYPE (? a PRE POST)))
	   (:leaf closeby (ATYPE (? a PRE POST)))
	   ))
	 ))
       
       ))
      ))
         
     (:node
      ((ARGSEM (? argsem CITY ROUTE)))
      ((:leaf congested)
       (:leaf intersecting)
       (:node
        ((MORPH (-er)))
        (	 
	 (:node
	  ((SEM TIME-DURATION) (LF (LESS TIME-DURATION)) (COMP-OP LESS))
	  ((:leaf clear)
	   (:leaf straight)
	   ))
	 ))
       
       (:node 
	((ARGSEM (? argsem ROUTE SOLUTION)) (SEM (? x TIME-DURATION DISTANCE)))
	((:leaf direct (COMP-OP LESS))
	 ))

       ))
     
     (:node 
      ((ARGSEM (? argsem ANY-SEM)))
      ((:leaf unknown (SEM CERTAINTY))
      
       (:node 
	((SEM IMPORTANCE))
	((:leaf routine)
	 (:leaf required (LF necessary))
	 ))
       (:node
	((SEM CARDINALITY))
	((:leaf single)
	 (:leaf only)
	 ))
       
       (:leaf temporary (SEM TIME-URATION))
      
       (:leaf welcome)
       
      
       
       (:node
        ((LF CORRECT) (SEM TRUTH)) ;; (MORPH (-ly))
        ((:leaf correct)
         (:leaf right)
         ))
       
       (:node
        ((LF INCORRECT) (SEM TRUTH)) ;; (MORPH (-ly))
        ((:leaf incorrect)
         (:leaf wrong)
         ))
       
       ;;   MEDIUM and AVERAGE should apply to any scale
       (:node
        ((SEM SIZE))
        ((:leaf medium)
	 (:leaf average (LF medium))
	 ))
              
       (:node
        ((LF REMAINING) (SEM PART-WHOLE) (ATYPE (? a PRE POST)))
        ((:leaf extra)
         (:leaf remaining)
         (:leaf (left over))
         (:leaf additional)
         (:leaf left)
         ))
       
       (:node 
        ((MORPH (-er)))
        ((:node
          ((LF NEW) (COMP-OP LESS) (SEM NOVELTY))
          ((:leaf new)
           (:leaf fresh)
           ))
         
         (:node
          ((LF OLD) (COMP-OP MORE) (SEM NOVELTY))
          ((:leaf old)
           ))
         
	 ;;(:leaf warm)
	 ;;(:leaf cool)
         ))
       
       
       (:node 
        ((LF SPECIFIC))
        ((:leaf specific)
         (:leaf particular)
         ))
       
       ))
     
     
     (:node 
      ((ARGSEM CONTAINER))
      ((:node 
       ((LF FULL))
       ((:leaf full)
        (:leaf loaded)
        (:leaf filled)
        ))
       (:node 
        ((LF EMPTY) (ATYPE PRE))
        ((:leaf empty)
	 (:leaf vacant)
	 (:leaf unloaded)
        ))
       ))
      
      (:node
       ((ARGSEM (? s MOVABLE-OBJ PATH)))
       ((:leaf through)
       ))
     
     (:node 
      ((ARGSEM DOMAIN) (SEM ?sem))
      ((:leaf sufficient (LF ENOUGH))
       (:leaf enough)
       ))
     
     (:node
      ((ARGSEM FACT) (SEM TRUTH))
      ((:leaf true)
       (:leaf false)
       ))
     
     (:node
      ((ARGSEM PERSON)) 
      ((:node
        ((LF MISTAKEN))
        ((:leaf misleading)
         (:leaf mistaken)
         (:leaf confused)
         ))
       (:leaf sorry) 
       ))
     ))
      ))
   ))
   

 ;;***********************************************************************
    ;;  PREPOSITIONS
    ;;************************************************************************

;;  These include all adverbials that take a SUBCAT NP. 
;;  When subcategorized for by a verb, these contribute
;;   no semantic content to the utterance.

(setq *lexicon-PREP*
  (append
   ;;   this is a list of all preps that are subcategoized for by verbs
   
   (mapcar #'(lambda (w)
	       `(,w (PREP)))
	   '(about between for from in into of on to with until))

   ;;  the following define PP forms that act as adverbial modifiers
    
      (expand
       'ADV
       '(:node 
	 ((SUBCAT NP) (SUBCATSEM ?subcatsem) (SUBCATSORT ?subcatsort)
	      (ARGSEM ?argsem) (ARGSORT ?argsort) (ATYPE (? atype PRE POSTVP)))
	 ((:node
	   ((SUBCATSORT VALUE) (AGR ?a))
	   ;;  from 70 degress to 90 degrees, from 5:30 to 7 PM.
	   ((:node
	     ((SORT INTERVAL) (SEM (? m MEASURE-DOMAIN)) (SUBCATSEM ?m))
	     ((:leaf from)
	      (:leaf to)
	      (:leaf between (AGR 3p))
	      ))
	  
	    (:node
	     ((SORT PATH) (SEM ROUTE) 
			  (SUBCATSEM (? x LOCATION FIXED-OBJ))
			  (SUBCATSORT DESCR)
			  (ATYPE -))
	     ((:leaf between (AGR 3p))
	      (:leaf from)
	      (:node
	       ((LF TO))
	       ((:leaf to)
		(:leaf into)
	      (:leaf onto)
	      (:leaf toward)
	      (:leaf until)
	      (:leaf til)
	      (:leaf till)
	      (:leaf then (LF (THEN TO)))
	      ))
	      (:node
	       ((LF VIA))
	       ((:leaf via)
		(:leaf through)
		;;  along takes a path/route instead
		;;   ALONG the bottom route
		;;   ALONG to Dansville
		(:leaf along (ARGSEM (? arg ROUTE PATH)))
		))
	      (:node
	       ((LF BEYOND) (SUBCATSEM (? x CITY)))
	       ((:leaf beyond)
		(:leaf past)
		))
	      )) ;; end SEM PATH

	
	  ;;   SETTING CONSTRAINTS
	  ;;  We have general purpose constraints for domains, then constraints specific to location and time
	  (:node ;; CONSTRAINTS on physical objects
	   ((SORT SETTING) 
	    (SEM (? sem DOMAIN)) (ARGSEM (? argsem PHYS-OBJ)) (ARGSORT ?argsort))
	   ((:node 
	      ((SEM LOCATION) (SUBCATSEM (? subcatsem PHYS-OBJ)) (ARGSEM (? argsem PHYS-OBJ SITUATION EVENTUALITY)))
	      ((:leaf at (lf AT-LOC))
	       (:node
		((LF APPROX-AT-LOC) (SUBCAT (? subcat NP NP-DELETED)))
		((:leaf near)
		 (:leaf nearby)
		 (:leaf about)
		 (:leaf ^bout)
		 (:leaf bout)
		 (:leaf around)
		 ))
	       ))
	    (:node 
	     ((SEM TIME-LOC) (SUBCATSEM (? t TIME-OF-DAY TIME-LOC)) (ARGSEM (? argsem EVENTUALITY)))
	     ((:leaf at (lf AT-TIME))
	      (:node
	       ((LF APPROX-AT-TIME))
	       ((:leaf near)
		(:leaf about)
		(:leaf ^bout)
		(:leaf bout)
		(:leaf around)
		))
	      ))
	   
		     
	       ;;  LOCATION CONSTRAINTS
	    
	    (:node
	     ((SEM LOCATION) (SUBCATSEM (? subcatsem EVENTUALITY PHYS-OBJ)))
	     ((:node
	       ((LF ABOVE))
	       ((:leaf above)
		(:leaf over)
		))
               
	     (:node
	      ((LF UNDER))
	      ((:leaf under)
	       (:leaf underneath)
	       (:leaf below)
	       ))
               
	     (:node
	      ((LF INSIDE) (ARGSEM (? argsem PHYS-OBJ EVENTUALITY)) (SUBCATSEM (? subcatsem CONTAINER)))
	      ((:leaf inside)
	       (:leaf in)
	       (:leaf within)
	       ))

	      (:node
	      ((LF AT-LOC) (ARGSEM (? argsem PHYS-OBJ EVENTUALITY SITUATION)) (SUBCATSEM (? subcatsem CITY)))
	      ((:leaf inside)
	       (:leaf in)
	       (:leaf within)
	       ))
	     (:leaf on)
               
	     )) ;; end SEM LOCATION
	    
	    ;; On routes
	    
	    ;; e.g., (the city/delay) on this route
	    
	    (:leaf on (lf assoc-with) (subcatsem (? scs route)) (argsem (? c PHYS-OBJ PROBLEM)))
	    
	    ;;  e.g., (what did you see) on that route
	    
	    (:leaf on (lf at-loc) (subcatsem (? subcatsem route)) (argsem (? argsem EVENTUALITY)))
	    
	    ;;  Temporal constraints
	    
	    (:node
	     ((SEM TIME-LOC) (ARGSEM EVENTUALITY))
	     ((:node
	       ((SUBCATSEM (? scs TIME-LOC DATE)))
	       ((:leaf before)
	        (:leaf after)
		))
	       
	      (:node
	       ((SUBCATSEM DAY))
	       ((:leaf on (LF TIME-WITHIN))
		))

	      (:node
	       ((SUBCATSEM (? my MONTH YEAR)))
	       ((:leaf in (LF TIME-WITHIN))
		))
	      
	      (:node
	       ((LF END-DEADLINE) (SUBCATSEM TIME-OF-DAY))
	       ((:leaf by)
		(:leaf before)
		))

	      (:node
	       ((LF START-DEADLINE) (SUBCATSEM TIME-OF-DAY))
	       ((:leaf after)
		))
	      )) ;; end SEM TIME-OF-DAY
	    
	    (:node
	     ((SEM TIME-DURATION) (SUBCATSEM TIME-DURATION))
	     ((:node
	       ((LF DURATION-MAX) (SUBCATSEM TIME-DURATION))
	       ((:leaf within)
		(:leaf in)
		))
	      (:leaf for (LF DURATION))
              )) ;; END SEM TIME-DURATION
            )) ;; end constraints
             
	    ;; (:leaf of (SUBCATSEM PERSON) (SEM POSSESSION) (LF OWNED-BY))     need to fix - an ARGSEM or something
	    ;;(:leaf of (SUBCATSEM TRANS-AGENT) (SEM SUBPART) (LF PART-OF))
	   
	    )) ;; end AGR 3s 3p
	          
	  ;;  temporal relations between events
	  (:node
	   ((SORT SETTING) (SEM TIME-CONSTRAINT) (SUBCATSEM event) (SUBCAT (? x VP S)))
	   ((:leaf before)
	    (:leaf after)
	    (:leaf until)
	    (:leaf when)
	    ))
	  
            ;; these can modify almost any VP

            (:node
             ((SORT MANNER) (ARGSEM event))
              ((:node 
                ((SUBCAT NP))
                ((:leaf with (LF (? x ACCOMP-BY INSTRUMENT)) (ARGSEM PHYS-OBJ))
                 (:leaf without (LF (NOT ACCOMP-BY)) (ARGSEM PERSON))
                 (:leaf without (LF (NOT INSTRUMENT)) (ARGSEM PHYS-OBJ))
                 (:leaf for (LF BENEFACTOR) (ARGSEM PERSON))
                 (:leaf except (LF EXCEPTION))
                 (:leaf per (LF ACCORDING-TO) (ARGSEM (? arg PERSON PLAN OBJECTIVE)))
                        
                 ))
	       (:leaf by (LF MODE-OF-TRAVEL) (ARGSEM GO) (SEM TRAVEL-MODE))
	       (:leaf by (ARGSEM ACTION))
	    
               (:node 
                ((SUBCAT VP))
                ((:leaf without (LF CONSTRAINT))
                 ))
               ))  ;; end SEM MANNER
                  
            
             ))  ;; end AGR 3s or 3p
       ))	 ;; end node
  )

;;************************************************************************
    ;;  APOSTROPHE AND TIME REFERENCES
    ;;************************************************************************

(setq *lexicon-misc*
      '(
    (@ (@))
	(^s (^S))
	(^ (^))
	(o^ (o^)) ;; in o'clock
      
    (punc-comma (punc (LF COMMA)))
    (punc-period (punc (LF PERIOD) (punctype decl)))
    (punc-question-mark (punc (LF QUESTION-MARK) (punctype (? x ynq whq))))
    (punc-exclamation-mark (punc (LF EXCLAMATION-MARK) (punctype (? x decl imp))))
	(end-of-utterance (punc (LF end-of-utterance) (punctype decl)))
	(start-of-utterance (punc (LF start-of-utterance)))
    (end-of-mouse (punc (LF end-of-mouse)))
    (punc-colon (punc (LF COLON)))
    (punc-semicolon (punc (LF SEMICOLON)))
     
   
    ;;   FILLED PAUSES, ETC

    (um (fp))
	(ah (fp))
	(uh (fp))
	(hmm (fp))
	(<sil> (fp))
    
	(mind (cv (lex mind))) ;; for never mind
	(clock (cv (lex clock))) ;; for o'clock
	
	(straight (cv))

    (Aurora (cv (LF AURORA)))
    (Mount (cv (LF Mount)))
    (Mt (cv (LF Mount)))
    (Morris (cv (LF Morris)))
    (Penn (cv (LF Penn)))
    (Yan (cv (LF Yan)))
    (Watkins (cv (LF Watkins)))
    (Glen (cv (LF Glen)))
	(York (cv (LF York)))
	(Jersey (cv (LF Jersey)))
		
	;; WORDS THAT ARE DEFINED IN RULES RATHER THAN BY THE LEXICON
	(if (cv)) ;;  If defined here as CV, all rules look explicitly for the lexical item
	(than (cv))
	
    ;;   SINGLE WORD SPEECH ACTS

	(yes (UttWord (LF YES) (SA CONFIRM)))
	(yep (UttWord (LF YES) (SA CONFIRM)))
	(yeah (UttWord (LF YES) (SA CONFIRM)))
	(sure (UttWord (LF SURE) (SA CONFIRM)))
	(no (UttWord (LF NO) (SA REJECT)))
	(nope (UttWord (LF NO) (SA REJECT)))
	(maybe (UttWord (LF UNSURE) (SA RESPONSE)))
	(perhaps (Uttword (LF UNSURE) (SA RESPONSE)))
	(oops (UttWord (LF OOPS) (SA REJECT)))
	(oopps (UttWord (LF OOPS) (SA REJECT)))
	(hello (UttWord (LF HELLO) (SA GREET)))
	(hi (UttWord (LF HI) (SA GREET)))
	(goodbye (UttWord (LF BYE) (SA CLOSE)))
	(bye (UttWord (LF BYE) (SA CLOSE)))
	(thanks (UttWord (LF THANKS) (SA EXPRESSIVE)))
	(phew (UttWord (LF RELIEF) (SA EXPRESSIVE)))
	(whew (Uttword (LF RELIEF) (SA EXPRESSIVE)))
	(hey (Uttword (LF ATTENTION) (SA EXPRESSIVE)))
	(yo (Uttword (LF ATTENTION) (SA EXPRESSIVE)))
	(nevermind (UttWord (LF NEVERMIND) (SA REJECT)))
	(sorry (Uttword (LF SORRY) (SA APOLOGIZE)))
	(huh (Uttword (SA NOLO-COMPRENDEZ)))
	
	;;  abbreviated city names
	(philly (name (NAME +) (SEM CITY) (CLASS CITY) (LF PHILADELPHIA) (AGR 3s)))
	(indy (name (NAME +) (SEM CITY) (CLASS CITY) (LF INDIANAPOLIS) (AGR 3s)))
	(nyc (name (NAME +) (SEM CITY) (CLASS CITY) (LF NEW_YORK_CITY) (AGR 3s)))
	(ny  (name (NAME +) (SEM CITY) (CLASS CITY) (LF NEW_YORK) (AGR 3s)))
	(cinci (name (NAME +) (SEM CITY) (CLASS CITY) (LF CINCINNATI) (AGR 3s)))
	(cincy (name (NAME +) (SEM CITY) (CLASS CITY) (LF CINCINNATI) (AGR 3s)))
     ))

(defun make-city-entry (c)
  `(,c (NAME (NAME +) (SEM CITY) (CLASS CITY) (AGR 3s) (LF ,c))))


(setq *lexicon-CITY*
	  (mapcar #'make-city-entry
		  '(albany atlanta avon baltimore 
		    bath buffalo
		    burlington boston canandaigua
		    charleston corning 
		    charlotte chicago cincinnati
		    cleveland columbus dansville 
		    detroit east_aurora
		    elmira franklinville fulton
		    geneva hornell 
		    indianapolis ithaca jamestown
		    lexington lyons milwaukee
		    montreal mount_morris new_york olean
		    penn_yan philadelphia
		    pittsburgh raleigh richmond 
		    rochester scranton sodus
		    syracuse toledo toronto yorkshire
		    warsaw washington watkins_glen)))

(defun make-state-entry (c)
  `(,c (NAME (NAME +) (SEM GEO-STATE) (CLASS GEO-STATE) (AGR 3s) (LF ,c))))

;;  missing north/south carolina, west virgina, new jersey, new york, new hampshire, rhode island,
;;   long island, manitoulin island

(setq *lexicon-state*
	  (mapcar #'make-state-entry
		  '(alabama carolina connecticut delaware georgia illinois indiana kentucky
		    maine 
		    maryland massachusetts michigan mississippi missouri 
		    ohio ontario pennsylvania quebec 
		    tennessee wisconsin vermont virgina)))

 ;;************************************************************

(defun generate-letters nil
  (mapcar #'(lambda (c)
              `(,c (value (SEM LETTER))))
          '(a b c d e f g h i j k l m n o p q r s t u v w x y z)))

(setq *lexicon-LETTER*
 (generate-letters))

(defun generate-months-and-days nil
  (append
   (let ((month-index 0))
     (mapcar #'(lambda (m)
                 (setq month-index (+ month-index 1))
                 `(,m (value (SEM MONTH) (CLASS MONTH) (AGR 3s) (INDEX ,month-index))))
             '(january february march april may june july august september october november december)
             ))
   (let ((day-index 0))
     (mapcar #'(lambda (d)
                 (setq day-index (+ day-index 1))
                 `(,d (value (SEM DAY) (CLASS DAY) (AGR 3s) (INDEX ,day-index))))
             '(monday tuesday wednesday thursday friday saturday sunday)
             ))
))

(setq *lexicon-MONTH-AND-DAYS*
      (generate-months-and-days))



(augment-lexicon 
 (append *lexicon-N* *lexicon-LETTER* *lexicon-ADJ* *lexicon-ADV*
	 *lexicon-PREP* *lexicon-NAME* *lexicon-PRO*
	 *lexicon-QUANT* *lexicon-ART* *lexicon-NUMBER*
	 *lexicon-CONJ* *lexicon-NP*
	 *lexicon-MONTH-AND-DAYS* *lexicon-CITY* *lexicon-state* *lexicon-misc*))


T

