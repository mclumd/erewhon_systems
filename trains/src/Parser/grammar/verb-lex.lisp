(in-package parser)

;;   VERB lexicon
;;
;;   Key features
;;   SUBJ - a constituent for the subject
;;   DOBJ - the direct object
;;   COMP3 - a complement other than direct object


(init-verb-exception-table
 '((bring :past brought)
   (come :past came :pastpart come)
   (cost :past cost :pastpart cost)
   (Do :3s does :past did :pastpart done)
   (find :past found)
   (fit :ing fitting :past fit)
   (forget :ing forgetting :past forgot
           :pastpart forgotten)
   (give :past gave)
   (go :3s goes :past went :pastpart gone)
   (get :ing getting :past got :pastpart gotten)
   (grab :ing grabbing :past grabbed)
   (guess :3s guesses)
   (hang :past hung :pastpart hung)
   (have :3s has :past had)
   (keep :ing keeping :past kept)
   (know :past knew :pastpart known)
   (leave :past left)
   (let :past let :ing letting)
   (make :past made)
   (mean :ing meaning :past meant)
   (misunderstand :past misunderstood)
   (pardon :ing pardoning :past pardoned)
   (put :past put :ing putting :pastpart put)
   (redraw :past redrew)
   (run :ing running :past ran :pastpart run)
   (say :past said)
   (see :ing seeing :past saw :pastpart seen)
   (send  :past sent)
   (take :past took :pastpart taken)
   (tell :past told)
   (think :past thought)
   (undo :3s undoes :past undid)
   (quit :past quit :ing quitting)
 ))


(mapcar 
 #'make-lex
 (expand 
  'V
  '(:node				; main verbs
     ((morph (-vb))                           ;;  default values
      (subj (% np (sem any-sem)))
      (iobj (% -))
      (dobj (% -))
      (comp3 (% -))
      (part (% -))
      (sem ACTION))
     
     ((:node 
       ((sem STOP))
       ((:leaf stop )
        (:leaf cancel)
        (:leaf quit)
        (:leaf forget)
        ))
      (:node				
       ((lf RESTART))
       ((:leaf restart)
        (:node 
         ((part (% word (lex (? w over again)))))
         ((:leaf start)))
        ))
      (:node
       ((subj (% np (sem (? x action plan movable-obj)))))
       ((:leaf start)
        ))
      
      ;; INTRANSITIVE ACTIONS
      
      (:leaf try (subj (% np (sem (? sem person trans-agent))))) ;; rare intransitive use, as in "let's try again"
      (:leaf arrive (subj (% np (sem (? sem movable-obj)))))
      
        
	;; COST MONEYS
      (:node
	 ((dobj (% np (sem money)))
	  (lf COST)
	  (SEM STATE))
	 ((:leaf cost)
	   (:leaf cost (comp3 (% s (stype to))))
	  ))
      
      ;; Operations on Routes
      
      (:node
       ((dobj (% np (sem route))))
       ((:node 
	 ((sem GO) (LF GO-BY-PATH))
	 ((:leaf take)
	  (:leaf follow)
	  ))
	))
	       

      
      (:node				; movement verbs
       ((subj (% np (var ?subjvar) (sem movable-obj)))
        (lf GO-BY-PATH) (SEM GO))
       (
        
        ;; plain old intransitive movement verbs   - many deleted for now to avoid spurious interpretations from speech recongition errors
	;;(:leaf go)
	;;(:leaf come)
	;;(:leaf continue)
	;;(:leaf proceed)			; proceed2
	;;(:leaf return)
	;;(:leaf move)
	(:leaf depart)
	;;(:leaf move (part (% word (lex around))))
	(:node 
	   ((LF GO-BACK))
	   ((:leaf go (part (% word (lex back))))
	    (:leaf back (part (% word (lex up))))
	    ))
	
	(:leaf undo (LF cancel))
		
	;; MEET verbs
	(:node 
	 ((SEM STOP) 
	  (LF MEET))
	 ((:leaf meet)
	  (:leaf connect)
	  ;; Meet something
	  (:node
	   ((dobj (% np (sem movable-obj))))
	   ((:leaf meet)
	    ))
	  ;; Meet/connect with something
	  (:node
	   ((dobj (% pp (ptype with) (sem movable-obj))))
	   ((:leaf meet)
	    (:leaf connect)
	    ))
	  ))
	    
	    
        
        ;; intrans movement verbs with path.  Exact same list of words
        ;; as without path, above.  If such things turn out to be
        ;; common, I'll introduce notation for optionality.
        (:node
         ((comp3 (% path (var ?pathvar)))
          (LF GO-BY-PATH) (SEM GO))
         
         ((:leaf go)
          (:leaf come)
          (:leaf continue)
          (:leaf proceed)
          (:leaf move)
          (:leaf travel)
          (:leaf return)
          (:leaf try) ;;  let's try via avon
	  (:leaf head)
	  (:node 
	   ((LF GO-BACK))
	   ((:leaf go (part (% word (lex back))))
	    (:leaf back (part (% word (lex up))))
	    ))
          (:node
           ((part (% advbl (sem TRAVEL-MODE))) ;;  current travel mode is ignored. ;;WON'T WORK-FIX
            (LF GO-BY-PATH) )
           ((:leaf go)
            (:leaf come)
            (:leaf continue)
            (:leaf proceed)
            (:leaf move)
            (:leaf travel)
            (:leaf return)
            (:leaf try) ;;  let's try via avon
            (:leaf get) ;get to avon
            (:leaf head)
            ))
          ))
	
	(:leaf try (comp3 (% vp (vform ing))))
        
	;;  GET as ARRIVE the train got to Bath at 3
	(:node
	 ((dobj (% pp (ptype TO))) ;; should add TO + when that works - also would be nice to transform this into an AT-LOC constraint
	  (LF ARRIVE-AT))
	 ((:leaf get)
	 ))
		
        ;; assorted other movement verbs that don't have an object
        ;; being moved: "head/leave for Avon". NOTE: for leave, the
        ;; dobj and the comp3 are independently optional.
        (:node
         ((comp3 (% pp (ptype for) (sem (? sem location city)) (var ?lfcomp3)))
          (LF GO-TO))
         ((:leaf head)
          (:leaf leave)
          
          ;; "leave Elmira for Avon"
          (:node
           ((dobj (% np (sem (? sem location city)) (var ?lfdobj))))
           ((:leaf leave)
            (:leaf depart)
            ))
          ))
        
        ;;  leave elmira
        (:node
         ((LF DEPART)
          (dobj (% np (sem (? sem location city)) (var ?lfdobj))))
         ((:leaf leave)
          ))
        
        ))  ;; end movement verbs
      
      
      ;; ACTIONS BY PERSONS
    
      (:node
       ((subj (% np (sem (? subjsem person trans-agent))))
	(dobj (% np (sem movable-obj) (var ?lfdobj))))
       (
	;; transitive movement verbs with particle
	 (:node ;; DROP OFFF
	  ((part (% word (lex off))) (LF unload))
	  ((:leaf drop)
          ))
	        
        (:node ;; KEEP/LEAVE
         ((LF MAINTAIN-PROPERTY)
          (dobj (% np (sem ANY-SEM) (var ?dobj-var)))
          (comp3 (% pred (sem location) (arg ?dobj-var))))
         ((:leaf keep)
          (:leaf leave)
          ))
        
        ;; from here down, these verbs can also take an instrument pp
        ;; (e.g "in/with the boxcar/engine").  I'm not encoding that
        ;; yet.  Do we need a comp4?
        (:node ;; MOVE
         ((LF MOVE) (SEM GO))
         ((:leaf bring)
          (:leaf carry)
	  ;;(:leaf get)
          (:leaf move)
	  (:leaf move (part (% word (lex around))))
          (:leaf pull)
          (:leaf send)
          (:leaf ship)
          (:leaf take)
          (:leaf transport)
          
          ;; transitive movement verbs with path.  see note above on
          ;; optionality.
          (:node
           ((comp3 (% path)))
           ((:leaf bring)
            (:leaf carry)
	    ;;(:leaf get)
            (:leaf move)
            (:leaf continue)
            (:leaf pull)
            (:leaf run)
            (:leaf route)
            (:leaf reroute)
            (:leaf send)
            (:leaf ship)
            (:leaf take)
            (:leaf transport)
            
	    ))
          ))	; end SEND verbs
        
        ;; DELIVER VERBS
        ;; NOTE: the location is optional, so all these verbs also
        ;; appear under transitive movement verbs w/o location.
        (:node
         ((LF DELIVER-PUT)
          (subj (% np (sem (? x person trans-agent))))
          (dobj (% np (sem commodity))))
         ((:leaf deliver)
          (:node
           ((comp3 (% pred (sem location))))
           ((:leaf deliver)
            (:leaf put)
            ))
          
          (:node
           ((comp3 (% pred (sem location)))
            (part (% word (lex off) )))
           ((:leaf drop)
            ))
          
          ))				; end DELIVER verbs
        
        (:leaf hang) ;; needed for "hang out" collocation
	
	;; TAKE TIME
	(:node
	 ((subj (% np (sem (? x eventuality trans-agent route))))
	  (dobj (% np (sem time-duration)))
	  (lf TAKE-TIME))
	 ((:leaf take)
	  (:leaf take (comp3 (% s (stype to))))
	  ))
	        
        ))			; end TRANSITIVE ACTIONS
      
      ;; Verbs describing mental or communicative states and actions.
      
      (:node
       ((subj (% np (var ?subjvar) (sem person)))
        (sem ACTION))
       (
	;;  DISPLAY actions
	(:node 
	 ((dobj (% np (var ?dobjvar) (sem (? x)))))
	 ((:node
	   ((LF DISPLAY))
	   ( ;;(:leaf show) unnecessary with IOBJ delete rule
	    (:leaf display)
	    (:leaf highlight)
	    (:leaf show (iobj (% np (var ?lfiobj) (sem person))))
	    ))
	  (:leaf erase)
	  ))
	
	
	;;(:node 
	;;((dobj (% np (var ?dobjvar) (sort wh-desc))))
	;; ((:node
	;;  ((LF DISPLAY))
	;; ( ;;(:leaf show)
	;;   (:leaf display)
	;;   (:leaf highlight)
	;;  (:leaf show (iobj (% np (var ?lfiobj) (sem person))))
	;;   ))
	;; ))
	
	;; ditransitive verbs from one person to another
	;; note IOBJ-delete riule makes IOBJ optional
        (:node ;; ditrans verbs
         ((iobj (% np (var ?lfiobj) (sem person))))
         ((:node
           ((dobj (% np (var ?dobjvar) (sem (? x plan fact amount information)))))
           ((:leaf tell)
            (:leaf give (lf TELL))
	    ))
	  (:node
	   ((dobj (% np (var ?dobjvar) (sem (? x question information)))))
	   ((:leaf ask)
	    ))
	  ))
        
	;; other verbs involving communication
	
	(:node
	 ((dobj (% np (var ?dobjvar) (sem (? sem LINGUISTIC-OBJECT)))))
	 ((:leaf repeat)
	  (:leaf say)
	  (:leaf say (lf REPEAT) (part (% word (lex (? lex over again)))))
	  ))
        
        ;; verbs that take that-clauses but not whq or if
        (:node
         ((dobj (% s (stype s-that) (vform fin))))
         ((:node 
           ((lf BELIEVE) (sem STATE))
           ((:leaf believe)
            (:leaf think)
            (:leaf mean)	; mean1
            ))
          
          (:node
           ((LF COME-TO-KNOW))
           ((:leaf assume)
            (:leaf suppose)
            ))
          
          (:leaf suggest)
          
          (:node
           ((LF CONFIRM))
           ((:leaf confirm)
            ;;(:leaf (make sure))
            ))
          
          ))				; end that-clauses
        
        ;; verbs that take that or if clauses
        (:node
         ((dobj (% s (stype (? x s-if s-that)) (vform fin))))
         ((:node
           ((LF COME-TO-KNOW))
           ((:leaf discover)
            (:leaf guess)
            (:leaf see)
            (:leaf calculate)
            (:leaf remember)
            (:leaf guess)
	    ))
	  
	  (:leaf say (LF UTTER))
	  (:leaf hear (LF HEAR))
                   
          (:node
           ((sem STATE) (lf BELIEVE))
           ((:leaf know)
            ))
          
          ;; that-clauses and particles
          (:node
           ((part (% word (lex out) )))
           ((:leaf find)
            (:leaf figure)
            ))
          
          (:node 
           ((lf FORGET))
           ((:leaf forget)
	    (:leaf forget (dobj (% np (sem ANY-SEM))))
            ))
	  
	  (:leaf tell)
	  
	  (:leaf ask (dobj (% s (stype (stype s-if)) (arg (% np (sem ?sem))) (Reduced -))))
	  
	  
          ))	; end that or if clauses
        
	;; knowing/finding out WH-DESC - what he said, how long the route is, how to get to avon, ...
	
	(:node
         ((dobj (% np (sort wh-desc))))
         ((:node
           ((LF COME-TO-KNOW))
           ((:leaf discover)
            (:leaf guess)
            (:leaf see)
            (:leaf calculate)
            (:leaf remember)
            (:leaf guess)
	    ))
	  
	  (:leaf say (LF UTTER))
	  (:leaf hear (LF HEAR))
                   
          (:node
           ((sem STATE))
           ((:leaf know)
            ))
          
	  (:node
           ((part (% word (lex out) )))
           ((:leaf find)
            (:leaf figure)
            ))
	  
	   (:node 
           ((lf FORGET))
           ((:leaf forget)
	    (:leaf forget (dobj (% np (sem ANY-SEM))))
            ))
	  
	   ;;   (:leaf tell)
	   ;; (:leaf ask)
          ))
	
	
	;; knowing/finding out the time/cost/weight/....
	(:node
         ((dobj (% np (mass -) (sem (? d DOMAIN)))))
         ((:node
           ((LF COME-TO-KNOW))
           ((:leaf discover)
            (:leaf guess)
            (:leaf see)
            (:leaf calculate)
            (:leaf remember)
            (:leaf guess)
	    ))
	  
	  (:leaf say (LF UTTER))
	  (:leaf hear (LF HEAR))
                   
          (:node
           ((sem STATE))
           ((:leaf know)
            ))
          
	  (:node
           ((part (% word (lex out) )))
           ((:leaf find)
            (:leaf figure)
            ))
          ))
	
        ;; phys-obj direct objects
        (:node
         ((dobj (% np  (var ?dobjvar) (sem phys-obj))))
         ((:node
           ((LF FIND))
           ((:leaf discover)
            (:leaf find)
            ))
          (:leaf avoid (subj (% np (sem agent))))
          (:leaf see)
          (:leaf suggest)
          ))
        
        ;; amount/path/plan direct objects
        (:node
         ((dobj (% np  (var ?dobjvar) (sem (? x amount path plan)))))
         ((:leaf calculate)
          (:leaf remember)
          ;; with particle
          (:node
           ((part (% word (lex out) )))
           ((:leaf figure)))))
        
        ;; "think/worry about something"
        (:node
         ((comp3 (% pp  (var ?compvar) (sem any-sem) (ptype about))))
         ((:leaf worry)
          (:leaf think)
          ))
        
        ;; "think of something"
        (:node
         ((comp3 (% pp (var ?compvar) (sem any-sem) (ptype of))))
         ((:leaf think)
          ))
        
        ;; things people do to plans
        (:node
         ((dobj (% np (sem (? ss OBJECTIVE PLAN))))) ;;   too restrictive. Problem with no 
         ; no SEM constraint is with utts like "Keep the train at avon"
         ((:node
           ((lf CANCEL) 
	    (dobj (% np (sem (? sem OBJECTIVE ROUTE ACTION CITY)))))
           ((:leaf bag)
            (:leaf cancel)
            (:leaf undo)
	    (:leaf scratch)
	    (:leaf delete)
	    (:leaf remove)
	    (:leaf kill)
	    ;;(:leaf forget (dobj (% np (sem ANY-SEM))))
            ))
          
          (:node
           ((lf REVISE))
           ((:leaf change)
            (:leaf check)
            (:leaf modify)
            (:leaf redraw)
            (:leaf reformulate)
            (:leaf shift)
            ))
          
          (:node 
           ((lf ACCEPT))
           ((:leaf keep)
            ))
          
          (:node
           ((lf SUMMARIZE))
           ((:leaf summarize)))
          ;; (:leaf optimize) more general entry below
          
          ;; with particle
          (:node
           ((part (% word (lex up)))
            (lf CONFUSE))
           ((:leaf mix)
            ))
          
          (:node
           ((part (% word (lex through)))
            (lf SOLVE))
           ((:leaf think)
            (:leaf work)))
          
          (:node
           ((dobj (% pp (ptype on)))
            (lf SOLVE))
           ((:leaf work)))
          ; work1
          
          ))				; end things done to plans
        
        ;; things people do to other people
        
        (:node 
         ((dobj (% np (sem person)))
          (SEM SPEECH-ACT))
         ((:leaf excuse)
          (:leaf pardon)
          (:leaf thank)
          (:leaf answer)
          ))
        
        ;; "tell/allow someone to do something".  NOTE The "to do something"
        ;; is optional.  Also note that by this analysis, these verbs
        ;; can have an indirect object without having a direct object.
        ;; Is that wierd?
        (:node
         ((iobj (% np (sem person))))
         ( ;;(:leaf tell)
	  ;;(:leaf allow)
          (:node
           ((dobj (% s (stype to) (subj (% np (var ?lfvar) (sem PERSON))))))
           ((:leaf tell)
            (:node
             ((lf LET))
             ((:leaf allow)
              ))
            ))
          ))
        
        ;; verbs that apply to both actions and plans.
        (:node
         ((dobj (% np (var ?dobjvar)  (sem (? x action plan)))))
         ((:leaf do)
          (:leaf consider)
          (:node 
           ((lf START))
           ((:leaf start)
            (:leaf restart)
            ))
          
          
          ))
        ))				; end mental/communicative verbs
      
      
      ;; these verbs kind of go with the things done to plans, but the
      ;; subject can be an action or a (sub)plan as well as a person.
      (:node
       ((dobj (% np (var ?dobjvar)  (sem plan))))
       ((:leaf optimize)
        (:leaf add)
        (:node
         ((comp3 (% pp (ptype to) (var ?compvar)  (sem (? y amount plan)))))
         ((:leaf add)))
        ))
      
      ;; verbs for which I have yet to find a good grouping
      
      ;; some more senses of start (other senses fit into groups above)
      (:node
       ((subj (% np (var ?subjvar) (sem person))))
       ((:node
         ((dobj (% pp (ptype with) (var ?compvar) (sem (? x objective phys-obj)))))
         ((:leaf start)
          (:leaf restart)))
        ;; NOTE there's also "start by vp:ing", but I'm not sure how to
        ;; represent that.
        ))				; end senses of start
      
      
      ;; conflict: pp is optional if subject is plural (the two plans
      ;; conflict) but not if it's singular.
      (:node
       ((subj (% np (sem (? x objective plan person trans-agent))
                 (agr (? y 1p 2p 3p))))
        (sem STATE))
       ((:leaf conflict)
        (:leaf interfere)
        (:node
         ((subj (% np (sem (? x objective plan))))
          (comp3 (% pp (ptype with) (var ?compvar) (sem (? y objective plan person trans-agent)))))
         ((:leaf conflict)
          (:leaf interfere)
          ))
        ))
      
      
      ;;  MORE ACTIONS
      
      (:node ;; more actions with sem person
       ((subj (% np (var ?subjvar) (sem person))))
       ((:node    ;; "switch around"
         ((dobj (% np (var ?dobjvar) (sem (? x plan machine-component))))
          (part (% word (lex around) )))
         ((:leaf switch)
          ))
        
        ;; create, make1 (make oj)
        (:node
         ((dobj (% np (var ?dobjvar) (sem commodity)))
          (lf CREATE))
         ((:leaf create)
          (:leaf make)
          ))
        
        ;; need, want
        (:node
         ((dobj (% np (var ?dobjvar) (sem any-sem)))
          (LF WANT-OBJECT) (sem STATE))
         ((:leaf need)
          (:leaf want)
          ))
        
        ;;   deal with
        (:node
         ((comp3 (% pp (ptype with) (sem ?sem)))
          (lf FOCUS-ON))
         ((:leaf deal)
          ))
        
        (:node
         ((comp3 (% pp (ptype on) (sem ?sem)))
          (lf FOCUS-ON))
         ((:leaf focus)
          ))
        
        ;;  take care of
        (:node
         ((comp3 (% pp (ptype of) (var ?compvar) (sem any-sem)))
          (part (% word (lex care))))
         ((:leaf take)
          ))
        
        ;; PICK-UP, including collect, grab
        (:node
         ((dobj (% np (var ?dobjvar)  (sem movable-obj))))
         ((:leaf collect)
          (:leaf grab)
          (:node
           ((part (% np (word (lex up)))))
           ((:leaf pick)
            ))
          ))
        
        ;; fix, repair
        (:node
         ((dobj (% np (var ?dobjvar)  (sem (? x building machine-component))))
          (lf REPAIR))
         ((:leaf fix)
          (:leaf repair)))
        
        ;; unload
        (:node
         ((dobj (% np (var ?dobjvar)  (sem (? x container commodity)))))
         ((:leaf unload)
          ))
        
        ;; load/fill, load/fill up NOTE particle and pp both optional
        (:node
         ((dobj (% np (var ?dobjvar)  (sem container)))
          (LF LOAD-WITH))
         ((:leaf fill)
          (:leaf load)
          (:node
           ((part (% word (lex up) )))
           ((:leaf fill)
            (:leaf load)
            (:node
             ((comp3 (% pp (ptype with) (var ?compvar)  (sem commodity))))
             ((:leaf fill)
              (:leaf load)))))
          (:node
           ((comp3 (% pp (ptype with) (var ?compvar) (sem commodity))))
           ((:leaf fill)
            (:leaf load)
            ))
          ))
        
        ;; load: load the oranges into the boxcar, load the boxcar with
        ;; oranges
        (:node
         ((dobj (% np (var ?dobjvar) (sem commodity)))
          (lf LOAD-INTO))
         ((:leaf load)
	  (:leaf load (part (% word (lex up))))
          (:node
           ((comp3 (% pp (ptype into) (var ?compvar) (sem container)))
            (lf LOAD-INTO))
           ((:leaf load)
            ))
          ))
        
        ;; decide, need, plan, want, try (to do something)
        ;;  subject control verbs: subj lf inserted in dobj VP
        (:node
	 ((comp3 (% s (stype to) (var ?dobjvar)
                   (subj (% np (var ?subjvar) (sem movable-obj))))))
         ((:node
           ((sem STATE) 
	    (lf WANT-NEED)
	    (subj (% np (var ?subjvar) (sem movable-obj))))
           ((:leaf need)
            (:leaf want)
            (:leaf like)
	    (:leaf have)
	    ))
	  (:leaf try)
	  (:leaf dare)
          (:leaf decide)
          (:leaf plan)
	  (:leaf get (LF CAN))
	  ))
        
        ;;  need/want/like X to do Y
        (:node
         ((dobj (% np (var ?lfdobj) (sem phys-obj)))
          (comp3 (% s (stype to) (subj (% np (var ?lfdobj))) (lf ?lfcomp3)))
          (lf WANT-NEED) (sem STATE))
         ((:leaf need)
          (:leaf want)
          (:leaf like)
	  ))
	
	;;  special rule for "I want go to boston" - a common error
	(:node
         ((comp3 (% vp (vform base) (sem ?sem) (lf ?lfcomp3)))
          (lf WANT-NEED) (sem STATE))
         ((:leaf need)
          (:leaf want)
	  ))
	
        
	;; finish, finish doing something NOTE optional vp
        (:node
         ((lf COMPLETE))
         ((:node
           ((dobj (% np (sem (? s plan action objective)))))
           ((:leaf complete)
            (:leaf finish)
            ))
          (:node
           ((dobj (% vp  (sem (? e EVENT ACTIVITY)) (vform ing))))
           ((:leaf complete)
            (:leaf finish)
            ))
          ))
        
        
        ;; fit NOTE optional pp
        (:node
         ((sem STATE)
          (lf HAVE-SPACE-FOR))
         ((:leaf fit)
          (:node
           ((comp3 (% pp (ptype in) (var ?cvar) (sem location))))
           ((:leaf fit)
           ))
          ))
         
         ;; follow
         (:node
          ((dobj (% np (var ?dovar) (sem AGENT))))
          ((:leaf follow)
           ))
         
         ;; gain
         (:node
          ((dobj (% np (var ?dovar) (sem amount))))
          ((:leaf gain)
           ))
	
	
	;;  GET/HAVE = MAKE-IT-SO/START MAKING IT SO,  - with PERSON subject, MOVABLE object
         (:node
          ((dobj (% np (var ?dobj) (sem (? ss plan action person trans-agent)))))
	  ;;  We should get the train going
          ((:node
	    ((lf START)
	     (comp3 (% vp (sem ?sem) (vform (? vform ing)))))
	    ((:leaf get)
	     ))
	   ;; We should get/have the train unloaded.
           (:node
	    ((lf MAKE-IT-SO)
	     (comp3 (% vp (vform passive) (sem ?sem) (subjvar ?dobj))))
	    ((:leaf get)
	     (:leaf have)
	     ))
	   ;; Get the train to go to Bath.
	   (:node
	    ((lf MAKE-IT-SO)
	     (comp3 (% s (stype to) (subjvar ?dobj))))
	    ((:leaf get)
	     ))
	   
	   ;; Get the train to bath
	    (:node
	     ((lf MAKE-IT-SO)
	      (comp3 (% path)))
	     ((:leaf get)
	      ))
	    
	   ;; Have/make the train go to Bath
	   (:node
	    ((lf MAKE-IT-SO)
	     (comp3 (% vp (vform base) (sem EVENTUALITY) (subjvar ?dobj))))
	    ((:leaf have)
	     (:leaf make)
	     ))
           ))
         
         ;; have1: "we have oranges in Corning" NOTE optional pp
         (:node
          ((sem STATE) (lf (BE (MEDIUM AVAILABILITY)))
           (dobj (% np (sem (? x amount phys-obj)))))
          ((:leaf have)
           (:node
            ((comp3 (% advbl (sem location))))
            ((:leaf have)))
           ))
         
         ;; have2: "we have to get that to Avon" ("hafta")
         (:node
          ((dobj (% s (stype to) (subj (% np (var ?subjvar) (sem PERSON)))))
           (sem STATE) (lf WANT-NEED))
          ((:leaf have)
           ))
	
	;;  we have Got to go to avon
	(:node
          ((dobj (% vp (CLASS GET-TO) (vform past) (subj (% np (var ?subjvar) (sem movable-obj)))))
           (sem STATE) (lf WANT-NEED))
          ((:leaf have)
           ))
         
         ;; attach, connect, couple, hitch, link, hitch along, hook on,
         ;; hook up
         (:node
          ((dobj (% np (sem movable-obj)))
           (LF ATTACH))
          ((:node
            ((part (% word (lex along) )))
            ((:leaf hitch)
             ))
           (:node
            ((part (% word (lex on) )))
            ((:leaf hook)))
           (:node
            ((part (% word (lex up) )))
            ((:leaf hook)))
           (:node
            ((comp3 (% pp (ptype to) (sem movable-obj))))
            ((:leaf attach)
             (:leaf connect)
             (:leaf couple)
             (:leaf hitch)
             (:leaf link)
             (:node
              ((part (% word (lex up) )))
              ((:leaf hook)))))
           ))
         
         ;; basic transitive verbs with no semantic restriction
         (:node
          ((dobj (% np (sem any-sem))))
          ((:leaf ignore)
           ))
         
         ))  ;; end SUBJ SEM PERSON
       
       ;; leave2 ("leave enough time"), save.  NOTE optional iobj
       (:node
        ((subj (% np (sem plan)))
         (dobj (% np (sem TIME-DURATION)))
         (lf LEAVE-TIME)
	 (iobj (% np (sem person))))
        ((:leaf leave)
         (:leaf save)
	 ))
      
      ;; having/involving problems
      (:node
       ((subj (% np (sem plan)))
	(dobj (% np (sem problem)))
	(lf HAS-PROBLEM))
       ((:leaf involve)
	(:leaf have)
	))
       
       ;; happen
       (:node
        ((subj (% np (sem event))))
        ((:leaf happen)
         ))
       
       ;;   stative verbs regarding routes and maps
       (:node ;;  e.g.,  that route connects rochester to avon.
        ((subj (% np (sem track)))
	 (dobj (% np (sem city)))
	 (comp3 (% pp (ptype to) (sem city)))
	 (lf CONNECTS))
        ((:leaf connect)
	 (:leaf link)
	 ))
       
       (:node ;; e.g.,  Rochester connects to avon
        ((subj (% np (sem city)))
	 (comp3 (% pp (ptype to) (sem city)))
	 (lf CONNECTED-TO))
        ((:leaf connect)
	 ))
       
       ;; look, seem, sound
       (:node
        ((subj (% np (sem ?sem)))
         (sem STATE) (lf APPEARS-TO-BE))
        ((:node
          ((dobj (% adj)))
          ((:leaf look)
	   (:leaf seem)
           (:leaf sound)))
         (:node ;;  don't understand these entries yet
          ((dobj (% s (ptype to) (sem BE))))
	  ((:leaf look)
           (:leaf seem)
	   ))
         ))
       
       
       ;; make for (that makes for a reasonable plan)
       (:node
        ((subj (% np (sem plan)))
         (comp3 (% pp (ptype for) (sem plan))))
        ((:leaf make)
         ))
       
       ;; NOTE "make {a, any} difference" should be lexicalized as a three-word
       ;; idiomatic verb.
       
       ;; make2, process (make/process oranges into oj),
       (:node
        ((subj (% np (sem person)))
         (lf CHANGE))
        ((:node
          ((dobj (% np (sem commodity)))
	   (comp3 (% pp (ptype into) (sem commodity))))
          ((:leaf make)
	   (:leaf process)
	   ))
         
         ;; make5 (we could make that)
         (:node
	  ((dobj (% np (sem event))))
	  ((:leaf make)
	   ))
         ))
       ;; mean3 (that means we have to...)
       (:node
        ((subj (% np (var ?subjvar) (sem fact)))
         (dobj (% s (stype s-that) (vform any-vform)))
         (sem STATE))
        ((:leaf mean)
         ))
       
       ;; mean2 (you mean ...)
       (:node
        ((subj (% np (sem person)))
         (dobj (% (? cat np pred)))
         (sem STATE))
        ((:leaf mean)
         ))
       
       ;; make4 (make this work)
       (:node
        ((subj (% np (var ?subjvar) (sem person)))
         (dobj ?x)
         (comp3 (% vp (subj ?x) (sem EVENTUALITY) (vform base))))
	((:leaf make)
         ))
       
       ;; misunderstand NOTE optional dobj
       (:node
        ((subj (% np (var ?subjvar) (sem person)))
         (SEM HAPPENING))
        ((:leaf misunderstand)
         (:node
	  ((dobj (% np (sem (? x person plan)))))
	  ((:leaf misunderstand)
           ))
         ))
       
       ;; pose a problem
       ;; NOTE this should be entered as a 3-word idiomatic verb.
       
       ;; proceed1 (proceed with the plan)
       (:node
        ((subj (% np (var ?subjvar) (sem person)))
         (comp3 (% pp (sem plan) (ptype with))))
      ((:leaf proceed)))
     
       
	;; run2 (we're running two hours late)
     (:node
      ((subj (% np (var ?subjvar) (sem AGENT)))
       (dobj (% advbl)))
      ((:leaf run)
       ))
        
     ;; schedule, slate NOTE optional vp:inf (to be executed, etc.)
     (:node
      ((subj (% np (var ?subjvar) (sem person)))
       (dobj (% np (sem (? x plan event trans-agent)))))
      ((:leaf schedule)
       (:leaf slate)
       (:node
	((comp3 (% s (stype to) (subj (% np (var ?subjvar) (sem person))))))
	((:leaf schedule)
	 (:leaf slate)))
       ))
     
     ;; solve
     (:node
      ((subj (% np (var ?subj) (sem (? x person plan))))
       (dobj (% np (sem objective) (var ?obj)))
       (lf TRY))
      ((:leaf solve)
       (:leaf try)))
     
     ;; let/allow
     (:node
      ((subj (% np (var ?subjvar) (sem (? x person))))
       (dobj (% np (sem (? dobjsem phys-obj)) (var ?dobjvar)))
       (comp3 (% vp (vform base) (sem (? e EVENT ACTIVITY)) (subj (% np (sem ?dobjsem) (var ?dobjvar)))))
       (lf LET) (SEM LET)) ;; LET indicates special interp of "let us/me" sentences - see rules -command1> and -command2>
      ((:leaf let)
       (:leaf allow)))
     
          
     ;; use NOTE optional comp3
     (:node
      ((subj (% np (var ?subjvar) (sem AGENT)))
       (dobj (% np (var ?lfdobj) (sem (? y phys-obj path))))
       (lf USE))
      ((:leaf use)
       (:leaf try)
       (:node
	((comp3 (% s (stype to) (subj (% np (var ?subjvar) (sem AGENT))))))
	((:leaf use)))
       (:node
	((comp3 (% pp (ptype for) (sem movable-obj))))
	((:leaf use)))
       ))
      
      ;;  movable-objects passing by things
      
      (:node
       ((subj (% np (sem movable-obj)))
	(LF PASS-BY))
       ((:leaf pass)                    ;; passes
	(:node
	 ((part (% word (lex by))))                  ;; passes/goes by
	 ((:leaf pass)            
	  (:leaf go)))
	(:node
	 ((comp3 (% pp (ptype by))) (sem phys-obj))
	 ((:leaf pass)
	  (:leaf go)))
	(:node
	 ((comp3 (% np (sem phys-obj))))
	 ((:leaf pass)
	  ))
	))
	
	     
      ;;  e.g., wait for the engine to arrive
      ;;     NB: modifiers like "at avon", "for three hours", "until the train arrives"
      ;;        are handled by general adverbial rules
     (:node
      ((subj (% np (var ?subjvar) (sem movable-obj)))
       (lf STAY-UNTIL))
      ((:leaf wait)
       ;;(:leaf stay)
       ;; (:node)
       ;;((dobj (% pp (ptype for) (lf ?lf) (sem (? y event movable-obj)))))
       ;;((:leaf wait))

       (:node ((dobj (% np (sem city)))
		(part (% word (lex (? w at in)))))
	      ((:leaf stay)
	       (:leaf wait)
	 ))
	       
       ))

      
	
     ;; work2, work out NOTE optional particle
     (:node
      ((subj (% np (var ?subjvar) (sem plan))))
      ((:leaf work)
       (:node
	((part (% word (lex out) )))
	((:leaf work)
         ))
       ))

    ))			; end verbs
   ))



(mapcar #'make-lex
 (expand 
  'aux
  
  ;; auxiliary "have."  The other auxiliary verbs
  ;; are included at the end of this file, because they are too
  ;; irregular to be handled by the normal verb lexicon functions.
  
  '(:node				; aux have
    ((compform pastpart)
     (perf +)
     (mobl +)
     (sem STATE))
    ((:leaf have)
     ))
  ))



;;;; IRREGULAR VERBS

;;;; Here are the modal verbs, infinitive "to", and "be."  These verbs
;;;; all have too many forms ("be" has was/were distinction) or too
;;;; few forms ("to" comes only in the infinitive, and the modals only
;;;; in tensed forms) to be handled by the verb lex functions, so I do
;;;; them by hand. 


;;; modals

;;; add-modal is just a little shorthand for up to three calls to
;;; augment-lexicon.  npres is negation of present, etc.

(defun add-modal (pres 3s past sem)
  (let ((agr (if (eq pres 3s)
		 '?agr
	       '(? x 1s 2s 1p 2p 3p))))
    (augment-lexicon `((,pres (aux
			       (mobl +)
			       (lf ,pres)
			       (sem ,sem)
			       (vform (? v base pres))
			       (agr ,agr)
			       (compform base)))))
  (if (not (eq pres 3s))
      (augment-lexicon `((,3s (aux
			       (mobl +)
			       (lf ,pres)
			       (sem ,sem)
			       (vform pres)
			       (agr 3s)
			       (compform base))))))
  (if past
      (augment-lexicon `((,past (aux
				 (mobl +)
				 (lf ,pres)
				 (sem ,sem)
				 (vform past)
				 (agr ?agr)
				 (compform base))))))))
				
 

(add-modal 'do 'does 'did 'ACTION)
(add-modal 'can 'can 'could 'STATE)
(add-modal 'may 'may 'might 'STATE)
(add-modal 'shall 'shall 'should 'STATE)
(add-modal 'will 'will 'would 'STATE)
(add-modal 'must 'must nil 'STATE)


;;; auxiliary "to."  It has only one form, the infinitive, so it can't
;;; be handled by the verb lex functions (they would give it other
;;; forms).

(augment-lexicon
 '((to (TO))))

	  
;;; "Be."  This verb has more forms than any other verbs: the past
;;; tense is different in first person than in second person.
;;; Rather than make the verb lexicon functions handle it, I just do
;;; it separately.

;; add-be-form is shorthand for adding several verbs at once:
;; progressive aux  be and  main-verb be.
(defun add-be-form (form vform agr lex)
  (mapcar #'make-lex
	  (append
	   (expand 'AUX
	   `(:node
	     ((MOBL +) (LEX ,lex) (VFORM ,vform) (AGR ,agr))
	     ((:leaf ,form
		     (lf PROG)
		     (subj (% np (sem ?sem) (var ?subjlf)))
		     (compform ing))
	      (:leaf ,form
		     (LF PASSIVE)
		     (subj (% np (sem ?sem) (var ?subjlf)))
		     (compform passive)))))
	   (expand 'V
		   `(:node
		     ((MOBL +) (LEX ,lex) (VFORM ,vform) (AGR ,agr)
			       (iobj (% -)) (part (% -)))
		     ((:leaf ,form	; he is happy
			     (sem BE)
			     (subj (% np (sem ?sem) (var ?subjlf)))
			     (dobj (% -))
			     (comp3 (% pred (arg ?subjlf))))
		      
		     (:leaf ,form	; he is the man
			    (sem BE)
			    (LF EQUAL)
			    (subj (% np (sem ?sem) (var ?subjlf)))
			    (dobj (% np))
			    (comp3 (% -))
			    )))))
	  )
  )
   
(add-be-form 'be 'base '- 'BE)
(add-be-form 'am 'pres '1s 'BE)
(add-be-form '^m 'pres '1s 'BE)
(add-be-form 'are 'pres '(? x 2s 1p 2p 3p) 'BE)
(add-be-form '^re 'pres '(? x 2s 1p 2p 3p) 'BE)
(add-be-form 'is 'pres '3s 'BE)
(add-be-form '^s 'pres '3s 'BE)
(add-be-form 'being 'ing '- 'BE)
(add-be-form 'was 'past '(? x 1s 3s) 'BE)
(add-be-form 'were 'past '(? x 2s 1p 2p 3p) 'BE)
(add-be-form 'been 'pastpart '- 'BE)
   



t
