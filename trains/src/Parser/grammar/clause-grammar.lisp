(in-package parser)

(addlexicalcat 'aux)

;;(define-foot-feature 'gap)

(augment-grammar
 '((headfeatures
    (vp vform var agr neg sem iobj dobj comp3 part)
    (s vform var neg sem var subjvar dobjvar)
    (v lex sem lf neg var agr) ;; needed for passive transformation rules
    ;; (pp var)
    ;; (pps var)
    (utt neg qtype sem setting subjvar dobjvar)
    (pred var sem)
    )
   

   ;; TOP-LEVEL UTTERANCE RULES

   ;; e.g., There are oranges at Corning.

   ((Utt (sa TELL) (var ?v) (punctype decl) (lf ?lf)) 
    -utt-s1>
    (head (s (stype decl) (gap -) (wh -) (lf ?lf)))) 
   
   ;;  Single NP utterances - requiring (punc) on both sides is too strict given speech
   ;;   errors. So we have two rules - one for the start and one for the end.
   ;;   Not having punc rules tends to break up uninterpretable speech into too 
   ;;   many speech acts.
   ;; e.g., Three boxcars.

   ((Utt (sa SPEECH-ACT) (var ?v1) (lf ?v) (focus ?v) (punctype decl)) 
    -utt-np1> .5  ;;  this allow single NPs to be utterances. Its a default to allow the question rule to override it
    (head (np (var ?v) (gap -) (poss -)))
    (punc (var ?v1) (lex (? x end-of-utterance punc-period))))
   

   ;;  This rule causes problems
   ;;  by competing with other UTT rules that happen not to
   ;;  consume the START-OF-UTTERANCE marker. Adding a generic
   ;;  UTT -> PUNC UTT would solve this problem but then lead to
   ;;  many spurious UTT interpretations. We need something like
   ;;  optional constituents to do this well.
   ;;  The rule is currently kept in order to
   ;;   handle "The train at avon, send it to bath"
   ;;  fix this in version 2.0
   
    ((Utt (sa SPEECH-ACT) (var ?v1) (lf ?v) (focus ?v) (punctype decl)) 
     -utt-np2> .5  ;;  this allow single NPs to be utterances. Its a default to allow the question rule to override it
    (punc (var ?v1) (lex start-of-utterance))
    (head (np (var ?v) (gap -))))

    ;; e.g., From Avon to Bath.
    ((Utt (sa SPEECH-ACT) (var ?v1) (lf ?v) (focus ?v) (punctype decl)) 
     -utt-path> .5 ;; this allows a single path to be an utterance. Its a default to allow question rule to override it.
     ;;  (punc)
     (head (path (var ?v) (neg -) (gap -))))
   ;; (punc (var ?v1))
   
   ((Utt (sa ?sa) (var ?v1) (lf ?lf) (disc-function ?d) (setting ?set) (punc +) (punctype (? p ynq imp)))
    -utt-punc1>
    (head (utt (sa ?sa) (disc-function ?d) (setting ?set) (lf ?lf) (punctype ?p)))
    (punc (var ?v1) (punctype ?p)))
   
   ((Utt (sa ?sa) (var ?v1) (lf ?lf)  (disc-function ?d) (setting ?set) (punc +) (punctype ?p)) 
    -utt-punc2>
    (head (utt (sa ?sa) (lf ?lf) (disc-function ?d)  (setting ?set) (punctype ?p)))
    (punc (var ?v1) (punctype decl)))
   
   ;;  these consume the START-OF-UTTERANCE marker: note a single UTT -> START UTT rule
   ;;  would produce too many interpretations
  
   ((Utt (sa ?sa) (var ?v1) (lf ?lf) (disc-function ?d) (setting ?set) (punc +) (punctype (? p ynq imp)))
    -utt-punc3>
    (punc (lex start-of-utterance))
    (head (utt (sa ?sa) (disc-function ?d) (setting ?set) (lf ?lf) (punctype ?p)))
    (punc (var ?v1) (punctype ?p)))
   
   ((Utt (sa ?sa) (var ?v1) (lf ?lf)  (disc-function ?d) (setting ?set) (punc +) (punctype ?p)) 
    -utt-punc4>
    (punc (lex start-of-utterance))
    (head (utt (sa ?sa) (lf ?lf) (disc-function ?d)  (setting ?set) (punctype ?p)))
    (punc (var ?v1) (punctype decl))) 

   ;; QUESTIONS
   
   ;; e.g., Is the engine coming from Corning?
   ((Utt (sa YN-QUESTION) (lf ?lf) (var ?v) (punctype ?p)) 
    -utt-ynq1>
    (head (s (stype ynq) (lf ?lf)  (gap -) (wh -))))
   
   ;; Would it be faster to go through avon instead?
    
   ((Utt (sa YN-QUESTION)  (setting ?set) (LF (% prop (var ?v1) (class ?c) (constraint (and ?con ?lf)))))
    -question-alternate>
    (head (s  (setting ?set) (stype ynq)
	   (lf (% prop (var ?v1) (class ?c) (constraint ?con)))))
    (advbl (LF (instead ?v1 ?y)) (LF ?lf) (ARG ?v1)))
    
   
   ;; e.g., The engine is coming from Corning?
   ((Utt (var ?v) (lf ?lf) (punc +) (sa YN-QUESTION)) 
    -utt-ynq2>
    (head (s (stype decl) (lf ?lf)  (gap -) (wh -)))
    (punc (var ?v) (punctype ynq)))
   
   ;; e.g., The boxcar?
   ((Utt (sa YN-QUESTION) (lf ?v) (punc +) (var ?v1) (focus ?v)) 
    -utt-ynq-3>
    (punc)
    (head (np (var ?v) (gap -) (wh -)))
    (punc (var ?v1) (punctype ynq)))
   
   ;; e.g., From Avon to Corning?
   ((Utt (sa YN-QUESTION) (lf ?v) (punc +) (var ?v1) (focus ?v)) 
    -utt-ynq-4>
    (punc)
    (head (path (var ?v) (gap -) (wh -)))
    (punc (var ?v1) (punctype ynq)))
  
   ;;  DUMMY IT sentences
    ;; e.g., It is faster to go via Avon
   ((s (stype decl) (var ?v) (subjvar ?npvar) (focus ?npvar) (gap ?g)
     (LF (% prop (var ?v) (class ?c) (constraint ?con))))
    -s-it-dummy>
    (np (sem DUMMY) (var ?npvar) (agr ?a) (case (? c sub -))
      (pp_word -))
    (head (pred (argsem DUMMY) (lf (% pred (class ?c) (constraint ?con))))))
   
   ;;  SINGLE WORD/SHORT CANNED PHRASE UTTERANCES
   
   ;;  e.g., hello, yes, maybe, no
   ((Utt (sa ?sa) (var ?v) (lf ?lf) (punctype (? x decl imp))) -utt4a>
    (head (uttword (lf ?lf) (sa ?sa))))

   ;;  e.g., hello with punctuation
   ((Utt (sa ?sa) (lf ?lf) (var ?v1) ) -utt4b>
    (head (uttword (lf ?lf) (sa ?sa)))
    (punc (lf comma) (var ?v1)))
   
   ;;  REQUEST and SUGGESTIONS
   
   ;; e.g., How about from Avon to Corning?
   ((Utt (sa SUGGEST) (var ?v1) (lf ?v)  (LEX HOW-ABOUT) (punctype ?p))
    -how-about> 
    (word (LEX (? x how what)) (var ?v1))
    (word (LEX about)) 
    (head ((? cat path np vp) (gap -) (var ?v) (lf ?lf))))
   
   ;; e.g., Why would that route be faster?
   ((Utt (sa WHY-QUESTION) (lf ?lf) (punctype ?p))
    -why-s>
    (head (s (gap -) (QTYPE WHY) (lf ?lf) (FOCUS ?FOC) (stype whq))))
      
   ;; e.g., Why two boxcars of oranges?
   ((Utt  (sa WHY-QUESTION) (lf ?v) (qtype ?type) (focus ?foc) (punctype ?p))
    -why-pp> 
    (word (LEX why)) 
    (head ((? cat path np vp) (var ?v) (gap -))))
   
   ;; e.g., Why not three boxcars of oranges?
   ((Utt (sa WHY-QUESTION) (LF (not ?v)) (punctype ?p))
     -why-not-pp> 
     (word (LEX why)) 
     (word (LEX not)) 
    (head ((? cat np path vp) (gap -) (var ?v))))
    
   ;; e.g., How do we get there by three?
   ((Utt (sa HOW-QUESTION) (focus ?foc) (lf ?lf) (punctype ?p))
    -how-s>
    (head (s (gap -) (QTYPE HOW) (lf ?lf) (FOCUS ?FOC) (stype whq))))
   

   ;; WH Question Utterances
   ;;

   ;; e.g., When will the engine arrive at Dansville?
   
   ((utt (sa WH-QUESTION) (qtype ?type) (lf ?lf) (focus ?foc) (punctype ?p))
    -wh-question1>
    (head (s (stype whq) (focus ?foc) (lf ?lf) (qtype (? type WHEN WHERE Q HOW-X)))))
   
   ;; e.g., When?
   ((utt (sa WH-QUESTION) (qtype ?type) (lf ?v) (focus ?foc) (punctype ?p))
    -wh-question2>
    (head (advbl (WH Q) (focus ?foc) (var ?v) (arg *PRO*) (qtype (? type WHEN WHERE Q HOW-X)))))
   
   ;; SENTENCE RULES
   
   ;; main s rule. We exclude the pp-word subjects because they have special rule
    
   ;; e.g., The boxcar is at Bath.
   ((s (stype decl) (var ?v) (subjvar ?npvar) (focus ?npvar) (gap ?g)
     (LF (% prop (var ?v) (class ?class) (constraint ?lf))))
    -s1>
    (np (sem ?x) (var ?npvar) (agr ?a) (case (? c sub -)) (mass -)
      (pp_word -))
    (head (vp (constraint ?lf) (class ?class) (gap ?g)
	   (subj (% np (sem ?x) (var ?npvar))) 
	   (var ?v) (vform fin) (agr ?a))))
   
   ;;  the same rule for mass term subjects
    ((s (stype decl) (var ?v) (subjvar ?npvar) (focus ?npvar) (gap ?g)
      (LF (% prop (var ?v) (class ?class) (constraint ?lf))) (wh (? wh - Q)))
     -s1-mass>
     (np (sem ?x) (var ?npvar) (agr ?a) (case (? c sub -)) (mass +)
      (pp_word -) (wh (? wh - Q))) ;; WH can be anything but R (relative clause)
     (head (vp (constraint ?lf) (class ?class) (gap ?g)
	    (subj (% np (sem ?x) (var ?npvar))) 
	    (var ?v) (vform fin) (agr 3s))))
   
   ;;   SETTING questions
   ;;   e.g., Why/How/Where/When/in-which-room/at-what-time did the train arrive?
   
   ((s (stype whq) (wh Q) (qtype ?qt) (focus ?foc) (var ?v) (gap -)
     (lf (% prop (var ?v) (class ?c) (constraint (and ?lf1 ?con)))))
    -wh-setting1> .5
    (advbl (sort (? x setting reason manner)) (argsem ( ? e EVENTUALITY))
	     (focus ?foc) (arg ?v) (wh Q) (qtype ?qt) (lf ?lf1))
    (head (s (stype ynq) (var ?v) (gap -)
	   (lf (% Prop (class ?c) (constraint ?con))))))
   
   
   ;;  PATH questions  e.g., Where is the train going?
   ;;   PATH fills the slot
    ((s (stype whq) (wh Q) (qtype WHERE) (focus ?foc) (var ?v) (gap -)
     (lf (% prop (var ?v) (class ?c) (constraint ?con))))
    -wh-path1>
    (path (var ?v1) (wh Q) (qtype ?qt) (lf ?lf1))
    (head (s (stype ynq) (var ?v) (gap (% path (var ?v1)))
	   (lf (% Prop (class ?c) (constraint ?con))))))
   

   ;;    Wh-questions in DECL sentences. The WH may be anywhere
   ;;   e.g., who/what-dog/whose-cat ate the pizza?
   ;;      we sent the boxcar where?
    
    ((s (stype whq) (qtype Q) (lf ?lf) (wh Q))
     -wh-q1>
     (head (s (stype decl) (gap -) (wh Q) (lf ?lf))))
   
   ;;============================================================================
   ;;   RELATIVE CLAUSES

   ;; e.g., (the route) which went from Corning to Avon
 
   ((s (stype relc) (arg ?arg) (argsem ?argsem) (gap -) (var ?v)
     (lf (% prop (var ?v) (arg ?arg) (class ?c) (constraint ?con))))
    -rel1> .8
    (pro (wh (? wh R)) (sem ?argsem) (agr ?agr) (CASE SUB))
    (head (vp (subj (% np (var ?arg) (sem ?argsem))) (agr ?agr) (gap -) (WH -)
	   (class ?c) (constraint ?con) (vform fin))))
   
   ;; e.g., (the train) that I moved
 
   ((s (stype relc) (arg ?arg) (argsem ?argsem) (gap -)
     (lf ?lf))
    -rel2> .8
    (pro (wh R) (sem ?argsem) (agr ?agr))
    (head (s (gap (% np (var ?arg) (sem ?argsem))) (WH -)
	   (vform fin) (lf ?lf))))
   
   ;; e.g., (the place) where I went
 
   ((s (stype relc) (arg ?arg) (argsem ?argsem) (gap -)
     (lf ?lf))
    -rel-where> .8
    (pro (wh R) (lex where) (sem ?argsem) (agr ?agr))
    (head (s (gap (% path (var ?arg))) (WH -)
	   (vform fin) (lf ?lf))))

   ;; e.g., (that time) when I saw you
 
   ((s (stype relc) (arg ?arg) (argsem ?argsem) (gap -)
     (lf (% prop (var ?v) (class ?c) (constraint (and (at-time ?v ?arg) ?con)))))
    -rel-when> .8
    (pro (wh R) (lex when) (sem ?argsem) (agr ?agr))
    (head (s (gap -) (WH -) (sem eventuality)
	   (vform fin) (lf (% prop (var ?v) (class ?c) (constraint ?con))))))

   ;; e.g., (the train) I moved
 
   ((s (stype relc) (arg ?arg) (argsem ?argsem) (gap -) (reduced +)
     (lf ?lf))
    -rel3> .5
    (head (s (gap (% np (var ?arg) (sem ?argsem))) (WH -) (stype decl)
	   (vform fin) (lf ?lf))))
   
   ;; e.g., (the train) loaded with oranges
   
   ((s (stype relc) (arg ?arg) (argsem ?argsem) (gap -) (reduced +)
     (lf (% prop (var ?v) (arg ?arg) (class ?c) (constraint ?con))))
    -rel-pastprt> .8
    (head (vp (var ?v)
	   (dobj (% np (var ?arg) (sem ?argsem))) 
	   (agr ?agr) 
	   (gap (% np (var ?arg) (sem ?argsem))) 
	   (WH -)
	   (class ?c) 
	   (constraint ?con) (vform pastpart))))
   
   ;;  e.g., (the train) going to Avon
   
   ((s (stype relc) (arg ?arg) (argsem ?argsem) (gap -) (reduced +)
     (lf (% prop (var ?v) (arg ?arg) (class ?c) (constraint ?con))))
    -rel-ing> .8
    (head (vp (var ?v)
	   (subj (% np (var ?arg) (sem ?argsem))) 
	   (agr ?agr) 
	   (WH -)
	   (class ?c) 
	   (constraint ?con) (vform ing))))
   
   ;; "that" and "if" sentences, used embedded, as complements.

   ;; e.g., That the train arrives.
   ((s (stype s-that) (gap ?g) (lf ?lf)) -s-that>
    (word (lex that))
    (head (s (stype decl) (main -) (gap ?g) (lf ?lf))))
   
   ;; e.g., If the train arrives.
   ((s (stype s-if) (gap ?g) (lf (IF ?v))) -s-if>
    (word (lex (? x if whether)))
    (head (s (stype decl) (var ?v) (main -) (gap ?g))))
   
    ;; e.g., If the train arrives, then we can load oranges.
   ((s (stype s-if) (gap -)) -s7b>
    (s (stype s-if) (gap -))
    (word (lex then))
    (head (s (main -) (gap -))))
   
   ;; e.g., If the train arrives, we can load oranges.
   ((s (stype s-if) (gap -)) -s7c>
    (s (stype s-if) (gap -))
    (head (s (main -) (gap -))))
   
   ;;   INFINITIVE SENTENCES

   ;; e.g., To know the train arrived.
    ((s (stype to) (var ?v) (subj ?subj) (gap ?g)
     (LF (% prop (var ?v) (class ?class) (constraint ?lf))))
     -to1>
     (word (lex to))
     (head (vp (constraint ?lf) (class ?class) (gap ?g)
	    (subj ?subj) (subj (% np (sem ?x) (var ?npvar))) 
	    (vform base))))
   
   ;; e.g., For the train to arrive
   
   ((s (stype to) (var ?v) (subj ?subj) (gap ?g)
     (LF (% prop (var ?v) (class ?class) (constraint ?lf))))
    -for-to1>
    (word (lex for))
    (np (sem ?subjsem) (var ?npvar))
    (word (lex to))
    (head (vp (constraint ?lf) (class ?class) (gap ?g)
	   (subj ?subj) (subj (% np (sem ?subjsem) (var ?npvar)))
	    (vform base))))
   
   ;;  WHY DO WE HAVE THIS RULE RATHER THAN USING VP1?
   ;;  VP RULES for BE
   ;;   this allows a PRED complement that is a predicate (ADVBLS,  ADJP or INDEFINIE DESCRIPTION)
   ;;  e.g., the train is orange, the train is at avon.
   ((vp (subj (% np (sem ?subjsem) (var ?subjvar))) (main +) (gap -)
     (sort PRED) (var ?v) (subjvar ?subjvar)
     (class BE) (constraint (AND (LSUBJ ?v ?subjvar) (LCOMP ?v ?lf))))
    -vp-be1>
    (head (v (lf ?c) (sem BE) (comp3 (% pred))))
    (Pred (argsem ?subjsem) (lf ?lf)))
   
   ;;  negation
   
    ((vp (subj (% np (sem ?subjsem) (var ?subjvar))) (main +) (gap -)
      (sort PRED) (var ?v) (subjvar ?subjvar)
      (class (NOT BE)) (constraint (AND (LSUBJ ?v ?subjvar) (LCOMP ?v ?lf))))
    -vp-be-not1>
     (head (v (lf ?c) (sem BE) (comp3 (% pred))))
     (adv (lex not))
     (Pred (argsem ?subjsem) (lf ?lf)))
   
   ;; EQUALITY e.g., "The city is avon", also "This is the cheapest route", at least for now.
   
   ((vp (subj (% np (agr ?agr) (sem ?subjsem) (var ?subjvar))) (main +) (gap -)
     (sort PRED) (var ?v) (subjvar ?subjvar) (agr ?agr)
     (class (BE EQUAL)) (constraint (AND (LSUBJ ?v ?subjvar) (LOBJ ?v ?npvar))))
    -vp-be2>
    (head (v (lf ?c) (sem BE) (DOBJ (% np))))
    (NP (sem ?sem) (agr ?agr) (var ?npvar) (lf (% description (status (? x definite name pro))))))
   
    ((vp (subj (% np (agr ?agr) (sem ?subjsem) (var ?subjvar))) (main +) (gap -)
     (sort PRED) (var ?v) (subjvar ?subjvar) (agr ?agr)
     (class (NOT (BE EQUAL))) (constraint (AND (LSUBJ ?v ?subjvar) (LOBJ ?v ?npvar))))
    -vp-be-not2>
     (head (v (lf ?c) (sem BE) (dobj (% np))))
     (adv (lex not))
     (NP (sem ?sem) (var ?npvar) (agr ?agr) (lf (% description (status (? x definite name pro))))))
   
   ;;  the corresponding yes-no question rule
   ;; e.g., is the train late?
   ((s (stype ynq) (main +) (gap -)
     (subj (% np (sem ?subjsem) (var ?subjvar)))
     (sort PRED) (var ?v)
     (lf (% prop (var ?v) (class be) 
	    (constraint (and (lsubj ?v ?subjvar)
			     (lcomp ?v ?lf))))))
    -s-ynq-be>
    (head (v (lf BE) (sem BE)))
    (np (agr ?a) (var ?subjvar) (sem ?subjsem) (case (? c sub -)))
    (PRED (argsem ?subjsem) (lf ?lf)))
   
   ;;  is this the city? Also, Is this the cheapest route?
   
     ((S (STYPE YNQ) (MAIN +) (GAP -)
       (subj (% np (sem ?sem) (var ?subjvar)))
       (sort PRED) (var ?v)
       (lf (% prop (var ?v) (class (BE EQUAL))
	      (constraint (and (lsubj ?v ?subjvar)
			       (lcomp ?v ?npvar))))))
      -vp-YNQ-be2>
      (head (v (lf ?c) (sem BE) (LF EQUAL)))
      (NP (SEM ?sem) (var ?subjvar) (agr ?agr) (lf (% description (status (? x definite name pro)))))
      (np (sem ?sem) (var ?npvar) (agr ?agr) (lf (% description (status (? y definite name pro))))))
   
   ;;  PRED rules: adjectives, adverbials or vps
   ;; e.g., (the train) is ORANGE
   
   ((pred (lf ?lf) (argsem ?argsem) (var ?v) 
     (lf (% PRED (ARG ?v) (CONSTRAINT ?lf))))
    -pred1>
    (head (qual (lf ?lf) (arg ?v) (argsem ?argsem) (wh -))))
   
   ;; e.g., (the train is) AT AVON
   ((pred (argsem ?argsem) (var ?v) 
     (lf (% PRED (ARG ?v) (CONSTRAINT ?lf))))
    -pred2>
    (head (advbl (arg ?v) (argsem ?argsem) (sort (? sort setting quality)) (lf ?lf))))
   
       
   ;; e.g., (Dansville is) a city. (The length of the route) is seven miles
   ((pred (arg ?arg) (argsem ?argsem) (var ?v) 
     (lf (% PRED (ARG ?v) (CONSTRAINT (?c ?v)))))
    -pred3A>
    (head (np (sem ?argsem)  (lf (% DESCRIPTION (STATUS INDEFINITE)
						  (CLASS ?c) (CONSTRAINT -))))))

   ;; e.g., (Dansville is) a large city.
   ((pred (arg ?arg) (argsem ?argsem) (var ?v) 
     (lf (% PRED (ARG ?v) (CONSTRAINT ((PRED (ARG ?v) (CONSTRAINT (AND (?!c ?v) ?!constr))))))))
    -pred3B>
    (head (np (sem ?argsem) (lf (% DESCRIPTION (STATUS INDEFINITE)
				   (CLASS ?!c) (CONSTRAINT ?!constr))))))
   
      ;; e.g., (The length) is seven miles.
   ((pred (arg ?arg) (argsem ?argsem) (var ?v) 
     (lf (% PRED (ARG ?v) (CONSTRAINT ?!constr))))
    -pred3C>
    (head (np (sem ?argsem) (lf (% DESCRIPTION (STATUS INDEFINITE)
				   (CLASS -) (CONSTRAINT ?!constr))))))
		 
   ;; e.g., (the route is) seven miles long.   
   
    ((pred (arg ?arg) (argsem ?argsem) (var ?v) 
     (lf (% PRED (ARG ?v) (CLASS ?c) (CONSTRAINT (((? sem DOMAIN) of) ?v ?npvar)))))
    -pred4>
     (np (sem (? sem DOMAIN)) (var ?npvar)
	    (lf (% DESCRIPTION (STATUS INDEFINITE)
		   (CLASS ?c) (CONSTRAINT ?constr))))
     (head (adj (sem (? sem DOMAIN)) (argsem ?argsem))))
   
    ;; e.g., (it is) fast/good to go through avon - this rule restricted to uses with IT 
   
    ((pred (arg ?v) (argsem DUMMY) (var ?v1) 
     (lf (% PRED (ARG ?v1) (CONSTRAINT ?lf))))
     -pred-adj-to-comp>
     (head (adjP (lf ?lf) (argsem EVENTUALITY) (arg ?v)))
     (s (stype to) (var ?v) (sem ?argsem) (subj (% np (sem agent) (var (*PRO* agent))))))
   
   ;; e.g., (it is) faster to go through avon - this rule restricted to uses with IT
   
    ((pred (arg ?v) (argsem DUMMY) (var ?v1) 
     (lf (% PRED (ARG ?v1) (CONSTRAINT ?lf))))
     -pred-compar>
     (head (comparative (lf (?pred ?v ?arg)) (lf ?lf) (sem ?sem) (arg ?v) (arg2 (*PRO* ?argsem))))
     (s (stype to) (var ?v) (sem ?argsem) (subj (% np (sem agent) (var (*PRO* agent))))))
   
   ;; e.g., (it is) fastest to go through avon - this rule restricted to uses with IT
   ;;   and specifies the 
   
    ((pred (arg ?v) (argsem DUMMY) (var ?v1) 
     (lf (% PRED (ARG ?v1) (CONSTRAINT ?lf))))
     -pred-superl-to-comp>
     (head (superlative (lf (?pred ?v ?arg)) (lf ?lf) (sem ?sem) (arg ?v) (arg2 (*PRO* ?argsem))))
     (s (stype to) (var ?v) (sem ?argsem) (subj (% np (sem agent) (var (*PRO* agent))))))
   
   ;; e.g., (which way) is the fastest
   ((pred (arg ?arg) (argsem ?argsem) (var ?v1) 
     (lf (% PRED (ARG ?v1) (CLASS ?argsem) (CONSTRAINT ?lf))))
    -pred-superl>
    (word (lex the))
    (head (superlative (lf ?lf) (sem ?sem) (arg ?arg) (arg2 (*PRO* (set-of ?argsem))))))
   
   ;; VP RULES
   
    ((vp (subj ?subj) (main +) (subjvar ?subjvar) (dobjvar ?dobjvar)
      (var ?v) (class ?c) (gap -)
      (constraint (and (LSUBJ ?v ?subjvar) (LOBJ ?v ?dobjvar)
				 (LIOBJ ?v ?iobjvar) (LCOMP ?v ?compvar))))
    -vp1>
    (head (v (lf ?c) (sem (? sem EVENTUALITY)) (VFORM ?vform)
	   (subj ?subj) (subj (% ?s1 (var ?subjvar) (gap -))) ;; note double matching required
	   (iobj ?iobj)  (iobj (% ?s2 (var ?iobjvar) (gap -)))
	   (part ?part) 
	   (dobj ?dobj)			(dobj (% ?s3 (var ?dobjvar) (gap -)))
	   (comp3 ?comp)		(comp3 (% ?s4 (var ?compvar) (gap -)))
	   ))
     ?iobj
     ?dobj 
     ;; (UNIFY (arg1 ?dobj) (arg2 (% ?s3 (var ?dobjvar) (gap -)))) ;; ensure GAP - in DOBJ
     ?part
     ;; (UNIFY (arg1 ?comp) (arg2 (% ?s4 (var ?compvar) (gap -)))) ;; ensure GAP - in COMP
     ?comp)
   
   ;; VP RULE WITH DOBJ GAP
   ((vp (subj ?subj) (subjvar ?subjvar) (dobjvar ?dobjvar)
     (main +) (gap (% NP (Var ?gapvar) (Sem ?gapsem) (AGR ?gapagr)))
     (var ?v)
     (class ?c) (constraint (and (LSUBJ ?v ?subjvar) (LOBJ ?v ?gapvar)
				 (LIOBJ ?v ?iobjvar) (LCOMP ?v ?compvar))))
    -vp-dobj-gap> .9
    (head (v (lf ?c) (sem EVENTUALITY)
	   (subj ?subj) (subj (% ?s1 (var ?subjvar))) ;; note double matching required
	   (iobj ?iobj)  (iobj (% ?s2 (var ?iobjvar)))
	   (part ?part)
	   (dobj (% NP (Var ?gapvar) (Sem ?gapsem) (AGR ?gapagr)))
	   (comp3 ?comp) (comp3 (% ?s4 (var ?compvar) (gap -)))
	   ))
    ?iobj
    ?part
    ?comp)

     ;; VP RULE WITH COMP3  GAP  (typically a PATH from a "where" question)
   ((vp (subj ?subj) (subjvar ?subjvar)  (dobjvar ?dobjvar)
     (main +) (gap (% PATH (Var ?gapvar)))
     (var ?v)
     (class ?c) (constraint (and (LSUBJ ?v ?subjvar) (LOBJ ?v ?dobjvar)
				 (LIOBJ ?v ?iobjvar) (LCOMP ?v ?gapvar))))
    -vp-comp-gap1>
    (head (v (lf ?c) (sem EVENTUALITY)
	   (subj ?subj) (subj (% ?s1 (var ?subjvar) (gap -))) ;; note double matching required
	   (iobj ?iobj)  (iobj (% ?s2 (var ?iobjvar) (gap -)))
	   (part ?part)
	   (dobj ?dobj) (dobj (% ?s3 (var ?dobjvar) (gap -)))
	   (comp3 (% PATH (Var ?gapvar)))
	   ))
    ?iobj
    ?dobj
    ?part)
   
   ;; VP RULE WITH A VP COMP3 with  GAP
   ((vp (subj ?subj) (subjvar ?subjvar)  (dobjvar ?dobjvar)
    (main +) (gap ?!gap)
    (var ?v)
     (class ?c) (constraint (and (LSUBJ ?v ?subjvar) (LOBJ ?v ?dobjvar)
   			 (LIOBJ ?v ?iobjvar) (LCOMP ?v ?compvar))))
    -vp-comp-gap2>
    (head (v (lf ?c) (sem EVENTUALITY)
	   (subj ?subj) (subj (% ?s1 (var ?subjvar) (gap -))) ;; note double matching required
	   (iobj ?iobj)  (iobj (% ?s2 (var ?iobjvar) (gap -)))
	   (part ?part)
	   (dobj ?dobj) (dobj (% ?s3 (var ?dobjvar) (gap -)))
	   (comp3 ?comp3) (comp3 (% ?s4 (var ?compvar)))
	   ))
    ?iobj
    ?dobj
    ?part
    ?comp3
    (UNIFY (arg1 ?comp3) (arg2 (% ?s (gap ?!gap)))))
   
   ;; particle can come before object if object is not a pronoun.  I
   ;; constrain the categories of the particle and the dobj so that if
   ;; there is no particle or no dobj this rule won't fire, because it
   ;; would duplicate the previous rule.

   ;; e.g., "load up the oranges"
   ((vp (subj ?subj) (subjvar ?subjvar)  (dobjvar ?dobjvar) (main +)
      (class ?c) (var ?v)
     (constraint (and (LSUBJ ?v ?subjvar) (LOBJ ?v ?dobjvar)
		      (LCOMP ?v ?compvar))))
     -vp2>
    (head (v (lf ?c)
	   (subj ?subj)  (subj (% ?s1 (var ?subjvar)))
	   (iobj (% -))
	   (part ?part) (part (% word))
	   (dobj ?dobj)  (dobj (% ?s3 (var ?dobjvar)))
	   (comp3 ?comp3) (comp3 (% ?s4 (var ?compvar)))))
    ?part
    ?dobj
    ?comp3)

   ;;   VP rule for comp3 LOC, e.g., put the book in the drawer, keep the train at avon
   
   ;;  ((vp (subj ?subj) (main +) (gap -)
   ;;  (var ?v) (class ?c)
   ;;  (constraint (and (LSUBJ ?v ?subjvar) (LOBJ ?v ?dobjvar)
   ;;			  (LCOMP ?v ?complf))))
;; -vp-pred-verbs>
   ;;(head (v (lf ?c) (sem (? sem EVENTUALITY))
   ;;   (subj ?subj) (subj (% ?s1 (var ?subjvar))) ;; note double matching required
   ;;   (part ?part)
   ;;   (dobj ?dobj)  (dobj (% ?s3 (var ?dobjvar)))
   ;;   (comp3 (% pred (sem ?domain)))
   ;;   ))
   ;; ?dobj
   ;; ?part
   ;; (PRED (SEM ?domain) (LF ?complf) (ARG ?dobjvar)))
 
     
   ;; PASSIVE TRANSFORMATIONS

   ;; Lexical transformation rules for passives.  There are three
   ;; pairs of rules, for moving the direct object, indirect object,
   ;; and object of preposition to subject position.  Each pair
   ;; consists of one rule with and one without the "by" PP.

   ;;  These rules aren't ideal.  They don't allow the "by" PP
   ;; (logical subject) in VPs that also have other PPs.  They also
   ;; don't allow the object of one PP from a PPS to move.

   ((v (vform passive) (subj ?!dobj)
     (dobj (% -)) (iobj ?iobj) (comp3 ?comp3) (part ?part)) 
    -v14>
    (head (v (vform pastpart) (dobj ?!dobj)
     (iobj ?iobj) (comp3 ?comp3) (part ?part))))
   
   ((v (vform passive) (subj ?!dobj)
     (dobj (% -)) (iobj ?iobj)
     (comp3 (% pp (ptype by) (sem ?lsubj-sem))) (part ?part)) 
    -v15>
    (head (v (vform pastpart) (subj (% np (sem ?lsubj-sem)))
     (dobj ?!dobj) (iobj ?iobj) (comp3 (% -)) (part ?part))))
   
   ((v (vform passive) (subj ?!iobj) (iobj-passive +)
     (dobj ?dobj) (iobj (% -)) (comp3 ?comp3) (part ?part)) 
    -v16>
    (head (v (vform pastpart) (dobj ?dobj) (iobj ?!iobj)
     (comp3 ?comp3) (part ?part))))
   
   ((v (vform passive) (subj ?!iobj)
     (dobj ?dobj) (iobj (% -)) (comp3 (% pp (ptype by) (sem ?lsubj-sem)))
     (part ?part)) 
    -v17>
    (head (v (vform pastpart) (subj (% np (sem ?lsubj-sem))) (dobj ?dobj)
     (iobj ?!iobj) (part ?part)
     (comp3 (% -)))))
    
   ;;((v (vform passive) (subj ????) (dobj ?dobj)
   ;; (iobj ?iobj) (comp3 (% p (ptype ?ptype))) (part ?part)) -vp18>
   ;; (head (v (vform pastpart) (dobj ?dobj) (iobj ?iobj)
   ;;  (comp3 (% pp (sem ?obj-sem) (ptype ?ptype))) (part ?part))))
   
   ;; The other member of the pair can't actually be written, since it
   ;; would have two comp3s.  See comment above.

   ;; DITRANSITIVE TRANSFORMATION 
   
   ;; As for the passive transformations, this rule is not ideal,
   ;; because if there's already a comp3 then you can't put the iobj
   ;; there.

   ;; This rule also overgenerates: e.g.
   ;; tell him to go -> *tell to go to him
   ;; that leaves us enough time -> *?that leaves enough time to us
   ((v (vform ?vform) (subj ?subj) (dobj ?dobj) (iobj (% -))
     (comp3 (% pp (ptype to) (sem ?iosem))) (part ?part)) 
    -vp19>
    (head (v (vform ?vform) (subj ?subj) (dobj ?dobj)
	   (iobj (% np (sem ?iosem))) (comp3 (% -)) (part ?part))))
   
   ;;  This rule makes the iobj optional
    ((v (iobj (% -)) (subj ?subj) (dobj ?dobj) (comp3 ?comp3) (part ?part) (vform ?vform))
     -iobj-delete>
     (head (v (iobj (% np)) (subj ?subj) (dobj ?dobj) (comp3 ?comp3) (iobj-passive -) (part ?part) (vform ?vform))))

 
))
  ;;  A few rules with exceptional head features

(augment-grammar
  '((headfeatures
    (vp vform agr neg sem var subjvar dobjvar)
    (s vform neg)
    (Utt var sem setting subjvar dobjvar))

 
    ;;  Discourse adverbials and conjuncts
    ;;    these are basically ignored for now.
   
    ((Utt (sa ?sa) (disc-function (?df ?adv))  (setting ?set) (var ?v) (punctype ?pn) (lf ?lf))
     -utt-cue-phrase1->
     (adv (sort DISC) (ATYPE PRE) (SA-ID -) (disc-function ?df) (LF ?adv))
     (head (Utt (sa ?sa) (var ?v) (punc -)  (setting ?set) (punctype ?pn) (lf ?lf))))

    ((Utt (sa ?sa) (disc-function (?dsc ?adv))  (setting ?set) (var ?v) (punctype ?pn) (lf ?lf))
     -utt-cue-phrase2->
     (adv (sort DISC) (ATYPE PRE) (SA-ID -) (disc-function ?dsc) (lf ?adv))
     (punc (lf comma))
     (head (Utt (sa ?sa) (var ?v) (punc -) (setting ?set)  (punctype ?pn)  (lf ?lf))))
    
     ((Utt (sa ?sa) (disc-function (?dsc ?adv))  (setting ?set) (punctype ?pn) (lf ?lf))
     -utt-cue-phrase2a->
      (head (Utt (sa ?sa) (punctype ?pn)  (setting ?set) (lf ?lf)))
      (adv (sort DISC) (ATYPE POST) (DISC-FUNCTION ?dsc) (SA-ID -) (lf ?adv)))
       
    ;;  Discourse adverbials that change the speech act - primarily INSTEAD at the moment
    
    ;; ((Utt (sa ?!sa) (punctype ?pn)  (setting ?set) (lf (?adv ?v1)))
    ;; -utt-cue-phrase3->
    ;; (adv (sort DISC) (ATYPE PRE) (DISC-FUNCTION SA-ID) (SA-ID ?!sa) (lf ?adv))
    ;; (head (Utt (punc -)  (setting ?set) (lf (% prop (var ?v1))))))

    ;; ((Utt (sa ?!sa) (punctype ?pn) (setting ?set) (lf (?adv ?v1)))
    ;; -utt-cue-phrase4->
    ;; (adv (sort DISC) (ATYPE PRE) (DISC-FUNCTION SA-ID) (SA-ID ?!sa) (lf ?adv))
    ;; (punc (lf comma))
    ;; (head (Utt  (punc -)  (setting ?set) (lf (% prop (var ?v1))))))
    
    ;;  how about avon, instead
    ;;  different rule needed here as suggests have a non-typical LF form, namely a var name
    ;;  REJECT SA is probably too strong here, but needed for backwards compatability in 2.0
    ((Utt (sa REJECT) (punctype ?pn)  (setting ?set) (lf ?lf))
      -utt-cue-phrase5->
     (head (Utt  (setting ?set) (lf ?v1) (sa SUGGEST)))
     (advbl (LF (instead ?x ?y)) (LF ?lf) (ARG ?v1)))
    
    ((Utt (sa REJECT) (punctype ?pn)  (setting ?set) (lf ?lf))
     -utt-cue-phrase6->
     (advbl (LF (instead ?x ?y)) (LF ?lf) (ARG ?v1))
     (head (Utt  (setting ?set) (lf ?v1) (sa SUGGEST))))
     
       
    ;;  REJECTIONS
    
    ;;  e.g., not avon, bath
    ;;  e.g., not to avon, to bath
    ;;  e.g., not to avon, bath
    ;;  e.g., not bath, to avon
   ((Utt (sa REJECT) (lf (instead ?v2 ?v1)))
    -utt-reject1>
    (word (lex not))
    ((? cat1 np path) (sem ?sem) (var ?v1))
    (head ((? cat np path) (sem ?sem) (var ?v2))))
    
    ;; the train, not the plane
    ((Utt (sa REJECT) (lf (instead ?v1 ?v2)))
     -utt-reject2>
     (head (np (sem ?sem) (var ?v1)))
     (word (lex not))
     (np (sem ?sem) (var ?v2)))
    
    ;;  e.g., not avon,  AND not to avon
    ((Utt (sa REJECT) (LF (instead nil ?l)))
     -reject3>
     (word (LEX not))
     (head ((? cat np path) (var ?l))))

    ;;  via avon, not via bath
    ((Utt (sa REJECT) (LF (instead ?l1 ?l2)))
      -reject3c>
     (head (PATH (var ?l1)))
     (word (LEX not))
     (PATH (var ?l2)))
    
    ;;  bath instead (of Corning)
     ((Utt (sa REJECT) (LF ?lf))
     -reject4>
      (head (np (var ?v)))
      (advbl (LF (instead ?x ?y)) (LF ?lf) (ARG ?v)))
    
     ;;  to bath instead (Corning |  to Corning)
    ((Utt (sa REJECT) (LF ?lf))
     -reject4a>
     (head (path (var ?v)))
     (advbl (LF (instead ?x ?y)) (LF ?lf) (ARG ?v)))
    
    ;;  go via bath instead of avon, go from avon instead of to avon, ...
    
    ((Utt (sa REJECT)  (setting ?set) (LF ?lf))
     -reject5>
     (head (s  (setting ?set)  (stype (? x imp decl)) (lf (% prop (var ?v1)))))
     (advbl (LF (instead ?y1 ?y)) (LF ?lf) (ARG ?v1)))
    
    ;;  e.g., "instead of bath/to avon/going to avon, go to Dansville."
    
     ((Utt (sa REJECT) (LF ?lf))
      -reject6>
      (advbl (LF (instead ?x ?y)) (LF ?lf) (ARG ?v1))
      (head (s  (setting ?set) (stype (? x imp decl)) (lf (% prop (var ?v1))))))
    
    ;; forget it, cancel that, scratch that
     ((Utt (sa REJECT) (LF FORGET-IT))
     -reject9>
      (head (v (lf (? lf CANCEL forget)) (vform base))) (np (lex (? a it that))))
    
    ;; excuse me
    ((Utt (sa NOLO-COMPRENDEZ) (LF EXCUSE-ME))
     -nolo1>
     (punc (Lex start-of-utterance))
     (head (word (lex (? w excuse pardon))))
     (word (lex me)))
   
    ;;  DON'T UNDERSTAND
    ;; what?
  
    ((Utt (sa NOLO-COMPRENDEZ) (punc +) (LF WHAT))
     -nolo2>
     (punc (Lex start-of-utterance))
     (head (word (lex (? x what huh))))
     (punc))
    
    ;;  EVALUATIONS
    
    ;; e.g., that's okay
    ((Utt (sa EVALUATION) (punc +) (LF ?lf))
     -eval1> 1.5
     (punc (Lex start-of-utterance))
     (word (lex that))
     (v (LF BE) (VFORM pres) (AGR 3s))
     (head (adjp (arg *PRO*) (var ?v) (LF ?lf) (SEM ACCEPTABILITY))))
    
     ((Utt (sa EVALUATION) (punc +) (LF (not ?lf)))
     -eval2> 1.5
      (punc (Lex start-of-utterance))
      (word (lex that))
      (v (LF BE) (VFORM pres) (AGR 3s))
      (adv (lex not))
      (head (adjp (arg *PRO*) (var ?v) (LF ?lf) (SEM ACCEPTABILITY))))
  
    
    ;;  here a question mark forces a y/n question interp 
    ;; OK?
    ((Utt (sa YN-QUESTION) (lf (?sa ?lf)))
     -utt5>
     (head (uttword (sa (? sa SPEECH-ACT)) (lf ?lf))) (punc (punctype ynq)))
    
    ;; e.g., from which city?
    ((Utt (sa WH-QUESTION) (punc +)) -utt4>
     (head (pp (gap -) (wh Q)))
     (punc))
    
    ;;  the empty utterance
    
    ((Utt (sa NULL))
     -empty-utt>
     (head (word (lex start-of-utterance)))
     (word (lex end-of-utterance)))
    
    ;; standard yes/no questions
    ;;  e.g., will the train arrive at 5:30?
   
    ((s (stype ynq) (gap ?gap) (sem ?sem)
      (subjvar ?subjvar) (dobjvar ?dobjvar) (var ?vpv) ;; NB: values taken from VP
      (LF (% prop (var ?vpv) (class (?auxlf ?class)) (constraint ?constraint))))
    -ynq1>
    (head (aux (lf ?auxlf)
	   (agr ?a)
	   (compform ?cf)))
    (np (agr ?a) (var ?subjvar) (sem ?subjsem) (case (? c sub -)) (wh -))
    (vp (vform ?cf) (gap ?gap) (var ?vpv) (sem ?sem)
     (subj (% np (sem ?subjsem) (var ?subjvar)))
     (dobjvar ?dobjvar)
     (class ?class) (constraint ?constraint)))
    
   
     
    ;;   GAP questions
    ;;    who/what-dog/whose-dog did you see at the store?

    ((s (stype whq) (focus ?npvar) (subjvar ?subjvar) (dobjvar ?dobjvar)
      (qtype Q) (lf ?lf) (var ?v))
     -wh-q2>
     (np (var ?npvar) (sem ?npsem) (wh Q) (agr ?a))
     (head (s (stype ynq) (lf ?lf) (var ?v) 
	    (subjvar ?subjvar) (dobjvar ?dobjvar)
	    (gap (% np (sem ?npsem) (var ?npvar))))))
      
    ;;  VP  adverbials
    ;; e.g., went to Avon maybe
    ((vp (subj ?subj) (gap ?gap) (var ?v)
      (class ?c) (constraint (and ?advbl ?lf)))
     -vp-adv>
     (head (vp (gap ?gap) (subj ?subj) 
	     (class ?c) (constraint ?lf)))
     (advbl (lf ?advbl) (arg ?v) (argsem EVENTUALITY) (atype postvp)))
    
    ;; e.g., maybe went to Avon
    ((vp  (subj ?subj) (gap ?gap) (var ?v)
      (class ?c) (constraint (and (?adv ?v) ?lf)))
      -adv-vp>
     (adv (lf ?adv) (ATYPE PREVP))
     (head (vp (gap ?gap) (subj ?subj) (class ?c) (constraint ?lf))))

    ;;  time/loc setting modification 
    
    ;;   e.g., arrived at 5:30, 
    ((vp (subj ?subj) (gap ?gap)
	 (class ?class) (constraint (and ?mod ?constraint)))
     -vp-setting> .5
     (head (vp (gap ?gap) (subj ?subj) (var ?v)
	       (class ?class) (constraint ?constraint)))
     (advbl (sort (? sort setting manner)) (argsem EVENTUALITY) (atype postvp) (arg ?v) (lf ?mod)))
    
    ;; e.g., in avon, the train arrived
   
    ((S (stype ?stype) (var ?v) (setting ?mod)
      (lf (% prop (var ?v) (class ?class)
         (constraint (and ?mod ?constraint)))))
      -vp-setting2>
     (advbl (sort setting) (atype pre) (arg ?v) (wh -) (lf ?mod))
     (head (s (gap -) (stype ?stype)
        (lf (% prop (var ?v)
    	   (class ?class) (constraint ?constraint))))))
    
    ;;  source setting: e.g.,  from avon, go to bath.
    ;;   this is a hack for now - eventually we need a feature/type that indicates a path has a "from" specified in it
    ((S (stype ?stype) (var ?v)
      (lf ?lf) (Setting ?setting))
     -vp-setting3>  .5
     (path (var ?setting) (lf (% path (Constraint (From ?x ?y)))))
     (head (s (gap -) (stype ?stype) (sem GO) ;; can't use S here right now as imperatives go directly to UTT
	    (lf ?lf))))
    ))

(augment-grammar
  '((headfeatures
    (vp vform agr sem)
    (s vform var neg sem subjvar dobjvar)
    (utt sem setting subjvar dobjvar))
    
    ;; VP HEADED BY AUX

    ((vp (subj ?subj) (var ?v) (gap ?g) (subjvar ?sv) (dobjvar ?ov) (neg ?neg)
      (class (?auxlf ?class)) (constraint ?constraint))
     -vp-aux1>
     (head (aux
	    (lf ?auxlf)
	    (compform ?vf) (neg -)))
     (vp
      (vform ?vf) (gap ?g) (neg ?neg)
      (class ?class) (constraint ?constraint)
      (subj ?subj) (subjvar ?sv) (dobjvar ?ov)
      (var ?v)))
    
     ((vp (subj ?subj) (var ?v) (gap ?g) (subjvar ?sv) (dobjvar ?ov) (neg +)
      (class (not (?auxlf ?class))) (constraint ?constraint))
     -vp-aux-not>
      (head (aux
	     (lf ?auxlf)
	     (compform ?vf)))
      (word (lex not))
      (vp
       (vform ?vf) (gap ?g) (neg -)
       (class ?class) (constraint ?constraint)
       (subj ?subj) (subjvar ?sv) (dobjvar ?ov)
       (var ?v)))
    
     ;;   Basic commands
    
    ;; e.g., tell me the plan
    ((utt (sa REQUEST) (var ?v) (punctype (? x imp decl)) (lf ?lf))
     -command-imp1>
     (head (s (stype imp) (var ?v) (lf ?lf))))
      
    ((s (stype imp)
      (lf (% PROP (var ?v) (class ?class) (constraint  ?constraint))))
     -command-imp2>
     (head (vp (gap -) (sem (? a ACTION)) (var ?v)
	    (subj (% np (var *YOU*) (sem PERSON))) 
	    (constraint ?constraint) (class ?class)
	    (vform base))))
    
    ;;  default rule for non-action VPs (useful when subject is deleted)
    ;;   e.g., have to go to elmira
    
     ((Utt (sa SPEECH-ACT) (var ?sav) (punctype (? x imp decl))
      (lf (% PROP (var ?v) (class ?class) (constraint  ?constraint))))
     -vp-utt-inform> .5
     (head (vp (gap -) (sem (? a STATE ACTIVITY)) (var ?v) (subj (% np (sem PERSON)))
	    (constraint ?constraint) (class ?class)
	    (vform (? vform pres past)) (agr (? agr 1s 1p)))))
    
    ;;   Special form for "let us" - maps directly to request
    
    ((S (stype imp) (var ?v) (LEX LET) (punctype (? p decl imp))
      (lf (% prop (var ?v) (class ?class) (constraint ?con))))
     -command-let-us>
     (v (lex let) (vform base) (var ?v1))
     (np (pro +) (Agr (? agr 1s 3s 1p 3p)) (sem ?s) (var ?subjv))
     (head (vp (gap -) (var ?v) (class ?class)
	    (constraint ?con) (subj (% np (sem ?s) (var ?subjv))))))
   
    ;;  CLOSE speech acts  e.g., I'm done/finished
    ;;  This is hacked in. It would be better to matched the S structure for "I am done" but
    ;;  it is hard to access the "DONE" part as it is not explicit in the LF as it now stands.
    
      ((Utt (sa CLOSE) (LF ?lf))
       -close1> 1.5
       (pro  (agr ?agr) (lex (? l i we)))
       (v (lex be) (agr ?agr) (vform pres) (dobj (% -)))
       (head (qual (lf ((HI COMPLETION) ?x)))))
    
    ((UTT (SA CLOSE) (LF ?LF))
     -CLOSE2> 1.5
     (head (s (neg -) (gap -) (wh -) (stype (? stype imp decl)) (LF ?lf)  (LF (% prop (class quit))))))

    ;;  HACK to capture "I'm done now/please"  - will be able to delete this when BE-verbs are redone
    ((Utt (sa CLOSE) (LF ?lf))
     -close3>
     (head (Utt (sa CLOSE) (LF ?lf)))
     (adv (lex (? x now please))))   
 
    ))
   
(augment-grammar
  '((headfeatures
     (s vform neg dobjvar))
    
    ;;  S rules that violate the SUBJVAR head feature and maybe the VAR head feature
    
    ;; wh-questions  ;; KILL when we systematize BE in version 2.0
    ;;   for instance: we currently can't handle "where is the train NOW" properly
   
    ((s (stype whq) (main +) (gap -) (var ?v) (qtype ?qt) (focus ?foc) (subjvar ?subjv)
      (lf (% prop (var ?v) (class BE) (constraint (and (lsubj ?v ?subjv) (lcomp ?v (pred (arg ?v1) (constraint ?lf1))))))))
     -s-wh-be>
     (advbl (sort (? x setting quality)) (wh Q) (focus ?foc) (var ?v1) (arg ?v1) (qtype ?qt) 
      (lf ?lf1) (argsem ?subjsem))
     (head (v (agr ?a) (LF BE) (vform (? vf PRES PAST)) (var ?v)))
     (np (agr ?a) (var ?subjv) (sem ?subjsem) (case (? case - sub))))
    
    ;; Two rules for Special constructs for paths 
    
    ;; "How far from avon to bath"?
    ;;  Note the use of the * to gensym a VAR value since we don't have a verb
    
     ((s (stype whq) (main +) (gap -) (var *) (qtype ?qt) (focus ?foc) (subjvar ?subjv)
      (lf (% prop (var *) (class BE) (constraint (and (lsubj * ?subjv) (lcomp * (pred (arg ?v1) (constraint ?lf1))))))))
     -s-how-far1>
      (advbl (sort quality) (wh Q) (focus ?foc) (var ?v1) (arg ?v1) (qtype ?qt) (lf ?lf1) (argsem path))
      (head (path (agr ?a) (var ?subjv))))    
    
     ;; "How far is it from avon to bath"?
    
     ((s (stype whq) (main +) (gap -) (var ?v) (qtype ?qt) (focus ?foc) (subjvar ?subjv)
      (lf (% prop (var ?v) (class BE) (constraint (and (lsubj ?v ?subjv) (lcomp ?v (pred (arg ?v1) (constraint ?lf1))))))))
     -s-how-far2>
      (advbl (sort quality) (wh Q) (focus ?foc) (var ?v1) (arg ?v1) (qtype ?qt)  (lf ?lf1) (argsem path))
      (head (v (agr ?a) (sem BE) (vform (? vf PRES PAST)) (var ?v)))
      (pro (lex (? w it that)))
      (path (var ?subjv)))
               
    ;; existence sentences (THERE)
    
     ;; e.g., there is a train at avon
    ((s (stype decl) (EXIST EX) (var ?v1) (subjvar ?v)
      (lf (% prop (var ?v1) (Class EXISTS) (Constraint (LSUBJ ?v1 ?v)))))
     -sthere1>
     (word (lex there))
     (head (v (lex BE) (DOBJ (% np)) (agr ?agr) (var ?v1) (vform fin)))
     (np (var ?v) (agr ?agr) (lf ?lf) (lf (% description (status indefinite))))
     ;; (pp (lf ?pplf))
     )

    ;; e.g., is there a train at avon?
    ((s (stype ynq) (EXIST EX) (var ?v1) (subjvar ?v) 
      (lf (% prop (var ?v1) (class EXISTS) (Constraint (LSUBJ ?v1 ?v)))))
     -sthere2>
     (head (v (lex BE) (DOBJ (% np)) (agr ?agr) (vform fin) (var ?v1)))
     (word (lex there))
     (np (var ?v) (lf ?lf) (agr ?agr) (lf (% description (status indefinite)))))
    
      
    ;;  e.g., well done
   
    ((Utt (sa EVALUATION) (punc +) (LF ((HI ACCEPTABILITY) *PRO*)))
     -eval3> 1.5
      (word (lex WELL))
      (word (LEX DONE)))
    
    ))
