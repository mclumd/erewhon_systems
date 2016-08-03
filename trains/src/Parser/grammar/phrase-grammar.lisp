(in-package parser)

;; WH is a foot feature: it should not appear in the mother constituent of a rule

(define-foot-feature 'WH)

(addLexicalCat 'cv) ;; contraction
(addLexicalCat '^) ;; quote
(addLexicalCat '^S)
(addLexicalCat 'adv)
(addLexicalCat 'conj)
(addLexicalCat 'ordinal)
(addLexicalCat 'POSS) ;; possessive pronoun
(addLexicalCat 'quan) ;; quantifer
(addLexicalCat '@) ;; colon


;;  Basic structure of NP rules

;;     NP -> SPEC N1
;;     SPEC -> DET ORDINAL CARDINAL
;;     N1 -> QUAL* N


;;  ADVERBIALS

(setq *grammar-adverbials*
  '((headfeatures
     (PP VAR KIND CASE MASS NAME agr SEM SORT PRO SPEC CLASS)
     (ADVBLS VAR SEM SORT ATYPE ARG ARGSEM ARGSORT NEG TO)
     (ADVBL VAR SEM SORT ARGSEM ARGSORT ATYPE TO)
     (ADV SORT ATYPE DISC-FUNCTION SA-ID LF SEM NEG TO LEX)
     )	       		

    ;;   GENERAL RULES FOR ADVERBIAL PHRASES

    ;;  e.g., immediately
    ((ADVBL (ARG ?arg) (LF (?lf ?arg))) 
     -advbl1>
     (head (adv (WH -) (SORT (? sort SETTING PATH DISC)) (SUBCAT -) (LF ?lf)))
     )
    
    ;;  Manner adverbials: e.g., quickly
    ((ADVBL (ARG ?arg) (LF (Manner ?arg ?lf)))
     -advbl-manner>
     (head (adv (WH -) (Sort Manner) (SUBCAT -) (LF ?lf)))
     )
    ;; e.g., in the morning, at 5 o'clock, from  Dansville
    ;;   note: agreement is needed to handle "between" properly,
    ;;   as it must take a plural complement
    
    ((ADVBL (ARG ?arg) (QTYPE ?wh) (WH ?wh) (FOCUS ?var) (LF (?reln ?arg ?var)))
     -advbl2>
     (head (adv (SUBCATSEM ?sem) (SUBCAT NP) (LF ?reln) (AGR ?a)))
     (np (SORT DESCR) (WH ?wh) (SEM ?sem) (VAR ?var) (AGR ?a)))
    
    ;; General rule for adverbs with subcategorized constituents
    ;;   instead of avon
    ((ADVBL (ARG ?arg) (QTYPE ?wh) (FOCUS ?var) (LF (?lf ?arg ?v)))
     -advbl-subcat>
     (head (adv (lf ?lf) (SUBCAT ?!sub) (SUBCAT (% ?cat (var ?v)))))
     ?!sub)

    ;;  prepositions with omitted objects, e.g., nearby, near, below, about, ...
    
    ((ADVBL (ARG ?arg) (QTYPE ?wh) (FOCUS ?var) 
      (LF (?reln ?arg (*PRO* ?sem))))
     -advbl2a> .5
      (head (adv (SUBCATSEM ?sem) (SEM (? sem1 LOCATION))
	     (SUBCAT NP-DELETED) (LF ?reln) (AGR ?a))))
      
    ;; e.g.,  before arriving in Dansville
    ((ADVBL (ARG ?arg) (ARGSEM EVENTUALITY) (LF (?reln ?arg ?v)))
     -advbl3>
     (head (adv (SUBCATSEM ?sem) (SUBCAT VP) (LF ?reln)))
     (VP (SEM ?sem) (VAR ?v) (VFORM (? x ING PASTPART)) (LF ?lf)))

    ;; e.g.,  after the train arrives in Avon
    ((ADVBL (ARG ?arg) (ARGSEM EVENTUALITY) (LF (?reln ?arg ?v)))
     -advbl4>
     (head (adv (SUBCATSEM ?sem) (SUBCAT S) (LF ?reln)))
     (S (SEM ?sem) (var ?v) (STYPE decl) (VFORM FIN) (LF ?lf)))
    
    ;; MINIMIZING scales: e.g., as quickly/cheaply as possible
    ((ADVBL (ARG ?arg) (ARGSEM EVENTUALITY) (LF (MANNER ?arg (MIN ?scale))) (ATYPE (? atype PRE POSTVP)))
     -as..as1>
     (word (lex as))
     (head (adv (SUBCATSEM ?sem) (SORT MANNER) (COMP-OP LESS) (LF (?old-op ?scale))))
     (word (lex as))
     (word (lex possible)))
    
     ;; MAXIMIZING SCALES: e.g., as slowly/expensively as possible
    ((ADVBL (ARG ?arg) (ARGSEM EVENTUALITY) (LF (MANNER ?arg (MAX ?scale))) (ATYPE (? atype PRE POSTVP)))
     -as..as2>
     (word (lex as))
     (head (adv (SUBCATSEM ?sem) (SORT MANNER) (COMP-OP MORE) (LF (?old-op ?scale))))
     (word (lex as))
     (word (lex possible)))
    
    ;;  ADVERBIAL MODIFICATION OF ADVERBIALS
    
    ;; e.g., comparatives e.g., more quickly, less slowly
    ((ADVBL (ARG ?arg) (LF ((?comp ?sem) ?arg (*pro* ?argsem))))
     -comp-adv>
     (adv (SORT COMPARATIVE) (SUBCATSEM ?sem) (LF ?mod))
     (head (ADV (SEM ?sem) (ARGSEM ?argsem) (COMP-OP ?comp) (LF ?lf))))
    
    
    ;; e.g., directly to avon
    ((ADVBL (ARG ?arg)  (LF ((?mod ?reln) ?arg ?val)))
     -advbl-advbl1>
     (adv (ATYPE PRE) (SUBCAT ADVBL) (LF ?mod) (IGNORE -)) 
     (head (ADVBL (ARG ?arg) (SEM (? sem PATH)) (LF (?reln ?arg ?val)))))

    ;; e.g.,  up to avon == to avon
    ((ADVBL (ARG ?arg) (LF ?lf))
     -advbl-advbl2>
     (adv (ATYPE PRE) (SUBCAT ADVBL) (SUBCATSEM ?sem) (LF ?mod) (IGNORE +)) 
     (head (ADVBL (ARG ?arg) (SEM ?sem) (LF ?lf))))
    
    ;; e.g., to avon directly

    ((ADVBL (ARG ?arg) (LF ((?mod ?reln) ?arg ?val)))
     -advbl-advbl3>
     (head (ADVBL (ARG ?arg) (SEM ?sem) (LF (?reln ?arg ?val))))
     (adv (ATYPE POST) (SUBCAT ADVBL) (SUBCATSEM ?sem) (LF ?mod) (IGNORE -)))

    ;; ADVBLS allows multiple constraints, e.g., tomorrow in the morning at 5:35, from avon to bath
    
    ((ADVBLS (LF ?lf))
     -advbl5>
     (head (ADVBL (LF ?lf))))

    ((ADVBLS (LF (AND ?lf1 ?lf2)))
     -advbl6>
     (head (ADVBL (LF ?lf1) (ARG ?a) (SEM ?s)))
     (ADVBLS (ARG ?a) (LF ?lf2) (SEM ?s)))

    ;;  Conjunctive adverbials
    ;;   e.g., to Rochester and then to Bath
    ((ADVBLS (LF (?conj ?lf1 ?lf2)))
     -advbl-conjunction>
     (ADVBLS (LF ?lf1) (ARG ?a) (SEM ?s))
     (head (CONJ (lex ?conj)))
     (ADVBLS (ARG ?a) (LF ?lf2) (SEM ?s)))
    
    ;;   Mode adverbials
    ;;   e.g.,  travel BY TRAIN
    ((ADVBL (LF (?lf ?a ?c)) (ARG ?a) (ARGSEM GO))
     -advbl-mode>
     (head (adv (SEM TRAVEL-MODE) (Lf ?lf)))
     (n1 (sem (? sem TRANS-AGENT)) (class ?c)))
    
    ;; Some special rules for INSTEAD - since the subcategorization is not good enough to get these
    
     ((ADVBL (LF (?lf ?a ?c)) (ARG ?a) (LF (INSTEAD ?a ?v)))
      -advbl-instead>
      (head (adv (lex instead) (subcat ?!pp)))
      (word (lex of))
      ((? cat path vp) (gap -) (var ?v) (lf ?lf)))
      
    
    ;; COMMA preceding POST adverbials
    
    ((ADV)
     -comma-adv>
     (punc (lf comma))
     (head (adv (ATYPE POST))))
    
    
    ;;  the PP rule is used for syntactic PPs that act as subcategorized arguments
    ;;   Note that the subcatsem of the prep is ignored here, as it is specified
    ;;   by the verb as a SEM restriction on the PP, and SEM is a head feature.
    ;;  e.g., on the top
    
    ((PP (PTYPE ?pt) (LF ?lf))
     -pp1>
     (prep (LEX ?pt))
     (head (np (lf ?lf) (sort DESCR))))
    
 
    ))  ;; end *GRAMMAR-TIMELOC*

;;  PATH DETECTION
;; these rule construct special forms of adverbials that are
;;  subcategorized for by verbs: PATH and LOCATIONS

(augment-grammar
 '((headfeatures
     (adv var lf lex subcat subcatsem subcatsort argsem argsort atype agr sort sem lf))
   
   ;;  any PATH adverbial, e.g., "to avon"
   ((path (var ?v) (lf (% Path (var ?v) (constraint ?lf))))
    -path1>
    (advbls (arg ?v) (sort path) (var ?v) (lf ?lf)))
   
   ;; to raleigh and to new york, to avon but not to bath.
   
   ((path  (var ?v) (lf (% Path (var ?v) (constraint (lex-and ?lf ?lf1)))))
    -path2>
    (advbls (arg ?v) (sort path) (var ?v) (lf ?lf))
    (word (lex (? x and but)))
    (advbls (arg ?v) (sort path) (lf ?lf1)))
   
   ;; ((path  (var ?v) (lf (% Path (var ?v) (constraint (or ?lf ?lf1)))))
   ;; -path3>
   ;;(advbls (arg ?v) (sort path) (var ?v) (lf ?lf))
   ;; (word (lex (? x or)))
   ;; (advbls (arg ?v) (sort path) (lf ?lf1)))
   
   ;; columbus to raleigh  (implicit FROM)
    ((path  (var ?v) (lf (% Path (var ?v) (constraint (:and (:from ?v ?v1) ?lf1)))))
    -path4>
     (np (name +) (SEM CITY) (var ?v1))
     (advbls (arg ?v) (var ?v) (sort path) (lf ?lf1)))
   
   ;;  this rule forces a wide scoping of directly
   
   ((path (var ?v) (lf (% Path (var ?v) (constraint (directly ?lf)))))
    -path5>
    (word (lex (? x directly straight)))
    (advbls (arg ?v) (sort path) (var ?v) (lf ?lf)))
   
   
   ((Loc (var ?v) (lf (% Loc (var ?v) (constraint ?lf))))
    -loc1>
    (advbls (sem LOCATION) (sort SETTING) (ARG ?v) (VAR ?v) (LF ?lf)))
      
   ))

;; Special rules that violate head features

(setq *Grammar-misc*
   '((headfeatures
      )
      ;; e.g., via/by/using  the shortest/quickest route   - eventually needs to be replaces by a more general rule
    ((ADVBL (ARG ?arg) (ARGSEM EVENTUALITY) (LF (:PREFERENCE ?cname)) (ATYPE (? atype PRE POSTVP)))
     -via-preference>
     (word (lex (? s via by using)))
     (np (lf (% description (class (? x route path)) (constraint (?cname ?carg))))))
     ))

(setq *Grammar-pp-words*
  
 '((headfeatures
    (ADVBL SEM SORT ARGSORT TO)
    (NP VAR CASE MASS NAME agr)
     )
   
   ;;  The PP-word rules use the special feature value * to force the
   ;;  creation of a new VAR value. This is required to allow the
   ;; advbl object to be disitnguish from the NP object,
   ;;   In particular, we need it to handle "there" as a path.
   
   ;; PP-words, e.g., here, there, tomorrow
   ((ADVBL (ARG ?arg) (VAR *) (ATYPE ?atype) (ARGSEM ?argsem) (LF (?pred ?arg ?v))) ;;  NB: "*" creates new constant
    -pp-word1>
    (head (np-pp-word (WH -) (ATYPE ?atype) (ARGSEM ?argsem) (VAR ?v) (PRED ?pred))))
   
   ;;  special treatment of wh PP-words
   ;;     e.g., when -> (at-time event-arg time-arg)
    
   ((ADVBL (ARG ?arg) (VAR *) (ATYPE ?atype) (QTYPE ?lex) (WH Q) (ARGSEM ?argsem) (FOCUS ?v) ;; NB: the VAR value  * creates a gensymed value
	   (LF (?pred ?arg ?v)))
    -whQ-advbl>
    (head (NP-PP-WORD (PRED ?pred) (VAR ?v) (ATYPE ?atype) (ARGSEM ?argsem) (WH Q) (LF ?lf) (LEX ?lex))))

   ;;  HOW X questions. make "how x" a PP-WORD to create WH object
    
   ((NP-PP-WORD (SORT(? x QUALITY)) (VAR ?v) (SEM ?pred) (lex HOW-X) ; NB: to change this HOW-X, we must fix rule wh-question2>
     (ARGSEM ?argsem) (PRED (?pred of)) (WH Q)
     (LF (% Description (status (how much)) (var ?v) (Class ?pred) (SORT STUFF)
	    (Lex ?lex))))
    -how-adj>
    (adv (LEX how) (VAR ?v) (LF ?adv))
    (head (adj (LF ?lf) (lex ?lex) (SORT ORDERED-DOMAIN) (SEM ?pred) (ARGSEM ?argsem))))
   
   
   ;; how long etc, used as NP complements e.g., "It took how long?"
   ((NP (WH Q) (VAR ?v) (SEM ?sem)
     (LF (% description (STATUS HOW-MUCH) (VAR ?v) (SORT STUFF)
	    (CLASS ?sem) (lex (how ?l))))
     (CLASS ?sem))
    -np-how-x>
    (adv (LEX how) (LF ?adv))
    (head (adj (LEX ?l) (SORT ORDERED-DOMAIN) (SEM ?sem))))
   
   ;;  how much - use a special rule as MUCH is not treated as as ADJ
   
   ((NP (WH Q) (VAR ?v) (SEM (? x STUFF))
     (LF (% description (STATUS WH) (VAR ?v) (SORT STUFF)
	    (CLASS (? x STUFF)) (lex (HOW MUCH))))
     (CLASS ?argsem))
    -np-how-much1> .8
    (adv (LEX how) (LF ?adv))
    (head (adv (lex much))))
   
   ))


;;   SPEC Rules
;;     This uses a set of features to collect info on spec
;;       SEM - DEFINITE/INDEFINITE/QUANTIFIER
;;       LF - the actual determiner/quantifier
;;       ARG - the placeholder for the object described
;;       RESTR - restrictions on object described, including
;;         (COUNT ?arg N) - cardinality
;;         (SEQUENCE ?arg N) - position in sequence (e.g., first, ...)
;;       POSS +/-  - possessive determiner. If +, then we have
;;         POSS-VAR - the var of the possessor NP
;;         POSS-SEM - the SEM of the possessor NP
;;       BAREDET + if the SPEC consists of a single determiner (e.g., the)

(setq *grammar-SPEC*
      '((headfeatures
	 (DET VAR AGR)
         (SPEC AGR POSS VAR MASS POSS-VAR POSS-SEM)
	 (POSS VAR SEM)
	 (CARDINALITY VAR))

    ;;  QUANTIFICATIONS/SPECIFIER STRUCTURE FOR NOUN PHRASES

    ;;  DEFINITE/INDEFINITE FORMS

    ;;  e.g., the, a
    ((SPEC (SEM ?def) (ARG ?arg) (BAREDET +)  (lex ?lex) (LF ?l))
     -spec-det1>
     (head (DET (sem ?def) (POSS -) (lex ?lex) (LF ?l))))
	
    ;;  e.g., possessive determiners. the engine's
    ((SPEC (SEM ?def) (ARG ?arg) (BAREDET -)  (LF ?l))
     -spec-det2>
     (head (DET (sem ?def) (POSS +) (LF ?l))))

    ;; e.g., the first
    ((SPEC (SEM ?def) (ARG ?arg) (LF ?l) (RESTR (SEQUENCE ?arg ?q)))
     -spec2>
     (head (DET (sem ?def) (LF ?l)))
     (ordinal (LF ?q)))

    ;;  e.g., the first five
    ((SPEC (SEM ?def) (ARG ?arg) (LF ?l) 
	   (CARD ?c) (RESTR (AND (SEQUENCE ?arg ?q) (COUNT ?arg ?c))))
     -spec3>
     (head (DET (sem ?def) (AGR ?a) (LF ?l)))
     (ordinal (LF ?q))
	 (cardinality (LF ?c) (AGR ?a)))

    ;;  e.g., the five
    ((SPEC (SEM ?def) (ARG ?arg) (LF ?l) 
      (CARD ?c) (RESTR (COUNT ?arg ?c)))
     -spec4>
     (head (art (sem ?def) (AGR ?a) (LF ?l)))
     (cardinality (LF ?c) (AGR ?a)))

    ;;  e.g., five
    ((SPEC (SEM INDEFINITE) (ARG ?arg) (LF ?l) (BAREDET +)
	   (CARD ?c) (RESTR (COUNT ?arg ?c)))
     -spec5>
     (head (cardinality (LF ?c))))
	
	  ;; e.g., bare quantifiers: all, few, most, ...
    ((SPEC (SEM INDEFINITE) (ARG ?arg) (QTYPE BARE) (LF ?s) (RESTR (count ?arg ?s)))
     -det3>
      (head (quan (SEM ?sem) (LF ?s))))


    ;;  DETERMINERS:  articles, possessives, quantifiers

    ;; e.g., the
    ((DET (SEM ?def) (ARG ?arg) (MASS ?m) (LF ?l))
     -det1>
     (head (art (sem ?def) (MASS ?m) (AGR ?a) (LF ?l))))

	
	;;   HOW many/few
	
	((DET (SEM how-many) (Lex (How ?l)) (ARG ?arg) (MASS ?m) (WH Q))
	 -how-quan>
	 (word (lex how))
	 (head (quan (sem ?def) (MASS ?m) (AGR ?a) (LF ?l) (qtype cardinality))))
	
	;;   HOW much
	
	((DET (SEM how-much) (Lex (How ?l)) (ARG ?arg) (MASS ?m) (WH Q))
	 -how-much>
	 (word (lex how))
	 (head (quan (sem ?def) (MASS ?m) (AGR ?a) (LF MUCH))))
	

	;;  Possessive constructs
    ;; e.g., the engine's
    ((DET (SEM DEFINITE) (AGR (? a 3s 3p)) (MASS ?m) (POSS +) (POSS-VAR ?v) (POSS-SEM ?sem))
     -det2>
     (head (POSS (VAR ?v) (SEM ?sem))))
    
    ;; e.g., the engine's, elmira's
    ((POSS (AGR ?a))
     -poss1>
     (head (NP (PRO -) (AGR 3s))) (^S))
    
    ;;  e.g., engines'
    ((POSS (AGR ?a))
     -poss2>
     (head (NP (PRO -) (AGR 3p))) (^))
	
    ;;   e.g., his
    ((POSS (AGR ?a))
     -poss3>
     (head (PRO (POSS +))))
					     
  
    
    ;;  phrases that indicate CARDINALITY

    ;;  e.g., seven
    ((CARDINALITY (LF ?c) (AGR ?a))
     -cardinality1> 
     (head (NUMBER (LF ?c) (AGR ?a))))

    ;;  e.g.,  many, few, several
    ((CARDINALITY (LF ?c) (AGR ?a))
     -cardinality2>
     (head (quan (QTYPE CARDINALITY) (LF ?c) (AGR ?a))))
   
))  ;; end *grammar-SPEC*



;;  N1 rules: qualifiers, head nouns and complements
;;   Important features:
;;       SORT - with values PRED - phrase defines a predicate on ?var
;;                          FUNC - phrase requires an ?arg to form a PRED
;;             For objects with SORT FUNC, we also have
;;                RELN - indicating where arg can be: OF (of complement)
;;                                                    POSS (possessive), or 
;;                                                    BARE (omitted)
;;       VAR - the object being modified
;;       CLASS - the main predicate defining VAR
;;       RESTR - other constraints on VAR

(setq *grammar-N1*
      '((headfeatures
	 (N1 VAR AGR MASS SEM)
	 (QUAL ARG ARGSEM VAR)
	 (ADJP VAR SEM ARGSEM ATYPE)
	 (COMPARATIVE VAR SEM ARGSEM ATYPE)
	 (SUPERLATIVE VAR SEM ARGSEM ATYPE))
	
        ;;  bare common nouns
        ;;  boxcar, juice, trains
	((N1 (SORT PRED) (CLASS ?lf))
	 -N1_1>
	 (head (n (SORT PRED) (LF ?lf))))
	
	;; N1 built out of FUNC noun

	;; e.g., distance, total, engine
	;;  this takes a FUNC, puts in a dummy arg to make it a pred on
	;; a value: e.g., distance -> ((Distance of something) ?arg)
	;;   currently using special atom *PRO* for the implicit arg
	
	((N1 (SORT PRED) (VAR ?v) (CLASS ?lf) 
	  (RESTR ((?lf OF) (*PRO* ?sem) ?v)))
	 -N1-reln1>
	 (head (n  (SORT FUNC) (LF ?lf) (ARGSEM ?sem) (RELN BARE))))

	;; e.g., weight (as in the train's weight)
	;; SORT as FUNC so it can combine with the possessive
	
       	((N1 (SORT FUNC) (VAR ?v) (ARG ?arg) (ARGSEM ?argsem) (CLASS ?lf) (RESTR ((?lf OF) ?arg ?v)))
	 -N1-reln2>
	 (head (n (SORT FUNC) (LF ?lf) (ARGSEM ?argsem) (RELN POSS))))
 
	;; FUNC with PP(of) complement.  e.g., distance of the route
	
	((N1 (VAR ?v) (SORT PRED) (CLASS ?lf) 
	  (RESTR ((?lf OF) ?v1 ?v)))
	 -N1-reln3>
	 (head (n (SORT FUNC) (LF ?lf) (RELN OF) (ARGSEM ?argsem)))
	 (pp (ptype of) (var ?v1) (SEM ?argsem) (LF ?lf2)))

        ;; FUNC with PATH complement.  e.g., distance from A to B
	
	((N1 (VAR ?v) (SORT PRED) (CLASS ?lf) 
	  (RESTR ((?lf OF) ?v1 ?v)))
	 -N1-path>
	 (head (n (SORT FUNC) (LF ?lf) (ARGSEM PATH)))
	 (path (var ?v1) (LF ?lf2)))

	;;  FUNC with to-complement
	
	((N1 (VAR ?v) (SORT PRED) (CLASS ?lf) 
	  (RESTR ((?lf OF) ?v1 ?v)))
	 -N1-to-comp>
	 (head (n (SORT FUNC) (LF ?lf) (ARGSEM ACTION)))
	 (s (stype to) (var ?v1)))
	
	;; simple qualifier modifiers
	;; e.g., orange train
        ((N1 (RESTR  (and ?qual ?r)) (CLASS ?c) (SORT PRED) (RELN ?reln))
         -N1-qual1>
         (QUAL (LF ?qual) (ARG ?v) (ARGSEM ?s))
         (head (N1 (RESTR ?r) (VAR ?v) (SEM ?s) (CLASS ?c) (SORT PRED) (RELN ?reln))))
	
	 ;; COMPARATIVE adjective modifiers
	 
	;; ((N1 (RESTR (and ?qual ?r)) (CLASS ?c) (SORT PRED) (RELN ?reln))     REDUNDANT given -qual2>
	;; -N1-compar1>
	;;  (COMPARATIVE (LF ?qual) (ARG ?v) (ARG2 (*pro* ?s)) (ARGSEM ?s))
	;;  (head (N1 (RESTR ?r) (VAR ?v) (SEM ?s) (CLASS ?c) (SORT PRED) (RELN ?reln))))
	
	((N1 (RESTR (and ?qual ?r)) (CLASS ?c) (SORT PRED) (RELN ?reln))
         -N1-compar2>
	 (COMPARATIVE (LF ?qual) (ARG ?v) (ARG2 ?v2) (ARGSEM ?s))
	 (head (N1 (RESTR ?r) (VAR ?v) (SEM ?s) (CLASS ?c) (SORT PRED) (RELN ?reln)))
	 (word (lex than))
	 (np (sem ?s) (VAR ?v2)))
	 
	
	;; adjective that can come after
	;;  e.g., the boxcar empty, the train nearby
	((N1 (RESTR (and ?qual ?r)) (CLASS ?c) (SORT PRED) (RELN ?reln))
         -N1-post-adj>
	 (head (N1 (RESTR ?r) (VAR ?v) (SEM ?s) (CLASS ?c) (SORT PRED) (RELN ?reln)))
	 (ADJP (LF ?qual) (ATYPE POST) (ARG ?v) (ARGSEM ?s)))

	
	;;  spatio/temporal  modification
	;;  e.g., the train at avon
	((N1 (RESTR (and ?l1 ?r)) (SORT ?sort) (CLASS ?c) (RELN ?reln))
         -N1-advbl1>
	 (head (N1 (RESTR ?r) (VAR ?v) (SEM ?s) 
		(SORT ?sort) (class ?c) (RELN ?reln)))
	 (ADVBLS (LF ?l1) (ARG ?v) (SORT SETTING) (ARGSEM ?s)))

	;;  origin modification
	;;  e.g., the boxcar from elmira
	((N1 (RESTR (and (FROM ?v ?l1) ?r)) (SORT ?sort) (CLASS ?c) (RELN ?reln))
         -N1-from1>
	 (head (N1 (RESTR ?r) (VAR ?v) (SEM (? s MOVABLE-OBJ)) 
		(SORT ?sort) (class ?c) (RELN ?reln)))
	 (PP (ptype from) (VAR ?l1) (SEM (? x CITY LOCATION))))
	
	;;  identification of problems
	;;  e.g., the city with congestion
	((N1 (RESTR (and (HAS-PROBLEM ?v ?l1) ?r)) (SORT ?sort) (CLASS ?c) (RELN ?reln))
         -N1-with1>
	 (head (N1 (RESTR ?r) (VAR ?v) (SEM (? s LOCATION CITY TRACK))
		(SORT ?sort) (class ?c) (RELN ?reln)))
	 (PP (ptype with) (VAR ?l1) (LF ?pred-name) (SEM (? x PROBLEM))))
	
	;;  qual
        ((QUAL (LF ?l) (sem ?sem))
         -qual2>
         (head (adjP (sem ?sem) (LF ?l) (COMPARATIVE -))))
	
	((QUAL (LF ?lf) (sem ?sem))
	 -qual-compar1>
	 (head (COMPARATIVE (LF ?lf) (arg2 (*PRO* ?argsem)) (ARGSEM ?argsem))))
	
	((QUAL (LF ?lf) (sem ?sem))
	 -qual-superl1>
	 (head (SUPERLATIVE (LF ?lf) (argsem ?argsem) (arg2 (*PRO* (SET-OF ?argsem))))))
	
	;; comparative constructs
	
	;;   faster
	((COMPARATIVE (LF (?l ?arg ?arg2)) (sem ?sem) (arg ?arg) (arg2 ?arg2))
	 -compar1>
	 (head (adj (sem ?sem) (LF ?l) (COMPARATIVE +))))
	
       
	((COMPARATIVE (LF ((?op ?sem) ?arg ?arg2)) (sem ?sem) (arg ?arg) (arg2 ?arg2))
	 -compar-more>
	 (word (lex more))
	 (head (adj (sem ?sem) (LF ?l) (COMP-OP ?op))))
	
	;; 
	((COMPARATIVE (LF ((less ?sem) ?arg ?arg2)) (sem ?sem) (arg ?arg) (arg2 ?arg2))
	 -compar-less1>
	 (word (lex less))
	 (head (adj (sem ?sem) (LF ?l) (COMP-OP more))))
	
	;;
	((COMPARATIVE (LF ((more ?sem) ?arg ?arg2)) (sem ?sem) (arg ?arg) (arg2 ?arg2))
	 -compar-less2>
	 (word (lex less))
	 (head (adj (sem ?sem) (LF ?l) (COMP-OP less))))
	
	;; superlatives
	
	((SUPERLATIVE  (LF (?l ?arg ?arg2)) (arg ?arg) (arg2 ?arg2))
	 -superl1>
	 (head (adj (LF ?l) (COMPARATIVE SUPERL))))

	;;============================================================================
	;; ADJECTIVE PHRASES
	
	;; e.g., little
	((ADJP (ARG ?arg) (LF (?lf ?arg)) (COMPARATIVE -))
	 -adj1>
	 (head (ADJ (LF ?lf) (COMPARATIVE -) (COMPL -) (SORT ADJ))))
	
	;; e.g., close to Avon
	((ADJP (ARG ?arg) (LF (?lf ?arg ?compvar)) (COMPARATIVE -))
	 -adj2>
	 (head (ADJ (LF ?lf) (COMPARATIVE -)  (COMPL ?!compl) (COMPL (% ?s1 (var ?compvar))) (SORT ADJ)))
	 ?!compl)
	
	;; e.g., close
	((ADJP (ARG ?arg) (LF (?lf ?arg (*pro* ?compsem))) (COMPARATIVE -))
	 -adj2-reduced>
	 (head (ADJ (LF ?lf) (COMPARATIVE -)  (COMPL ?!compl) (COMPL (% ?s1 (sem ?compsem))) (SORT ADJ)))
	 )
	
	;; e.g. very little
	((ADJP (ARG ?arg) (LF (?mod ?lf)) (COMPARATIVE -))
	 -adv-adj>
	 (adv (SUBCATSEM ?sem) (SUBCAT ADJ) (LF ?mod))
	 (head (ADJP (SEM ?sem) (ARG ?arg) (var ?v) (LF ?lf))))
	

	;; SCALE-based adjectives e.g., easy, hard
	((ADJP (ARG ?arg) (LF ((?lf ?sem) ?arg)) (COMPARATIVE -))
	 -adj-scale>
	 (head (ADJ (LF ?lf) (SEM ?sem) (COMPARATIVE -) (SORT ORDERED-DOMAIN))))
	
	
	
	;;=============================================================================
	;; NOUN-NOUN type  modification
	;;  specific rules should get a 1.1 weight to be preferred over general rules

	;; e.g.,  Elmira route/train
	((N1 (RESTR (and (ASSOC-WITH  ?v2 ?v1) ?r)) (CLASS ?c) (SORT ?sort))
	 -N1-assoc1> 1.1
	 (np (name +) (SEM (? sem PHYS-OBJ)) (VAR ?v1))
	 (head (N1 (VAR ?v2) (SEM (? s ROUTE TRANS-AGENT)) 
		(RESTR ?r) (CLASS ?c) (SORT ?sort))))
    
	;; oranges for OJ, the train for the oranges, the train for the avon route
	((N1 (RESTR (and (ASSOC-WITH ?v1 ?v2) ?r)) (CLASS ?c) (SORT ?sort))
	 -N1-assoc2>
	 (head (N1 (VAR ?v1) (SEM (? sem TRANS-AGENT COMMODITY))
		(RESTR ?r) (CLASS ?c) (SORT ?sort)))
	 (pp (ptype for) (VAR ?v2) (SEM (? sem1 PHYS-OBJ ROUTE))))
	
	;;  orange juice
	
	((N1 (RESTR (and (MADE-FROM ?v2 ?v1) ?r)) (CLASS ?c) (SORT ?sort))
	 -N1-made-from> 1.1
	  (n (SEM (? sem SOLID-COMMODITY)) (VAR ?v1))
	  (head (N1 (VAR ?v2) (SEM (? s JUICE))
		    (RESTR ?r) (CLASS ?c) (SORT ?sort))))
	 ;;=======================
	;;
	;;  RELATIVE CLAUSES
	;;

	
	;; e.g., the train that went to Avon, the train that I moved, the train that is in Avon
	;;  NB: the LF is taken apart and reconstructed to eliminate the ARG slot
	((N1 (RESTR (and (% prop (var ?vv) (class ?cc) (constraint ?const))  ?r))
	  (CLASS ?c) (SORT ?sort))
	 -n1-rel>
         (head (N1 (VAR ?v) (RESTR ?r) (SEM ?sem) (CLASS ?c) (SORT ?sort)))
         (s (stype relc) (ARG ?v) (ARGSEM ?sem) 
	  (LF (% prop (var ?vv) (class ?cc) (constraint ?const)))))
	
	;; ROUTE complements
	;; e.g., the route from Avon to Bath
	((N1 (RESTR (PATH ?v1 ?v))
             (CLASS ROUTE) (SORT ?sort))
	 -n1-route>
         (head (N1 (VAR ?v1) (RESTR -) ;; RESTR - avoids multiple nestings of ADVBL modifiers
		(SEM ?sem) (CLASS ROUTE) (SORT ?sort)))
         (path (var ?v) (LF ?lf)))
	
	
	
	;;   simple appositives,
	;;  e.g., city avon, as in "the city avon"
	;;
	((N1 (RESTR (and (EQ ?v1 ?v2) ?r)) (CLASS ?c) (SORT ?sort))
	 -N1-appos1>
	 (head (N1 (VAR ?v1) (RESTR ?r) (CLASS ?c) (SORT ?sort)))
	 (np (name +) (CLASS ?c) (VAR ?v2)))
	
	((N1 (RESTR (and (EQ ?v1 ?v2) ?r)) (CLASS ?c) (SORT ?sort))
	 -N1-appos2>
	 (head (N1 (VAR ?v1) (RESTR ?r) (CLASS ?c) (SORT ?sort)))
	 (punc (lf comma))
	 (np (name +) (CLASS ?c) (VAR ?v2)))
	
	))
	

(setq *grammar-n1-aux* 
  '((headfeatures
     (N1 VAR AGR SEM)) ;;  excludes MASS as a head feature
	
    ;;  quantities of stuff. 
    ;;  e.g., gallons of OJ

    ((N1 (VAR ?v) (SORT UNIT) (CLASS ?c) (QUANTITY ?q)
      (RESTR (AND (?domain ?v (?unit ?q)) ?constr)))
     -n1-unit1>
     (head (N (SORT UNIT) (SEM ?domain) (LF ?unit) (ARGSEM ?argsem)))
     (PP (PTYPE of) (SEM ?argsem) (MASS +)
      (LF (% description (CLASS ?c) (CONSTRAINT ?constr)))
      (VAR ?v1)))
    
    ;;  quantities with bare plural complements
    ;;  e,g, pounds of oranges.
     ((N1 (VAR ?v) (SORT UNIT) (CLASS ?c) (QUANTITY ?q)
      (RESTR (AND (?domain ?v (?unit ?q)) ?constr)))
     -n1-unit2>
     (head (N (SORT UNIT) (SEM ?domain) (LF ?unit) (ARGSEM ?argsem)))
     (PP (PTYPE of) (SEM ?argsem) (MASS -) (AGR 3p)
      (LF (% description (CLASS ?c) (CONSTRAINT ?constr)))
      (VAR ?v1)))
    
    ;;   quantities with no complement
    ;;   e.g., pounds
    
    ((N1 (VAR ?v) (SORT UNIT) (CLASS ?argsem) (Quantity ?q) (lex ?l)
      (RESTR (AND (EQUAL ?v (?unit ?q)))))
     -n1-unit3>
     (head (N (SORT UNIT) (SEM ?domain) (LF ?unit) (lex ?l) (ARGSEM ?argsem)))
     )
    
    ;; container loads of commodities
    ((N1 (VAR ?v) (SORT UNIT) (CLASS ?c) (QUANTITY ?q)
      (RESTR (AND (?pred ?v ((?lf load) ?q)) ?constr)))
     -n1-container-commodity>
     (N (SEM CONTAINER) (PRED ?pred) (LF ?lf) (ARGSEM ?argsem))
     (head 
      (PP (PTYPE of) (SEM ?argsem) (MASS -) (AGR 3p)
       (LF (% description (CLASS ?c) (CONSTRAINT ?constr)))
       (VAR ?v))))
    
    ))

;;=========================================================================
;;   NP rules build description structures, which consist of
;;         STATUS - definite/indefinite/quantifiers
;;         VAR - as usual
;;         SORT - a complex expression combine the AGR and MASS features,
;;                that is simplified by an attachment as follows:
;;                (1s/2s/3s -) -> Individual
;;                (1p/2p/3p -) -> Set
;;                (1s/2s/3s +) -> Stuff
;;                (1p/2p/3p +) -> Stuff (quantities of stuff)
;;        CONSTRAINT - the restrictions from N1
;;        SET-CONSTRAINT - the restrictions from SPEC
;;        In singular NPs, the two constraints a re simply combined
;;        In plural NPs, the SET-CONSTRAINT apply to the set, and 
;;        the CONSTRAINT to individuals in the set
  
(setq *grammar-NP* 
  '((headfeatures
     (NP VAR CASE MASS NAME agr SEM PRO CLASS))
    
    ;;   Basic noun phrases: all combinations of AGR and MASS
    ;;  e.g., the train, some trains, the sand in the corner, five pounds of sand
    ;; with non-possessive SPEC

    ((NP (LF (% description (STATUS ?ref-type) (VAR ?v) (SORT (?agr ?m))
		(CLASS ?c) (CONSTRAINT ?r) (SET-CONSTRAINT ?restr)))
      (SORT DESCR) (QTYPE ?w) (WH ?w)) ;; must move WH feature up by hand here as it is explicitly specified in a daughter.
     -np-indv>
     (SPEC (MASS ?m) (LF ?spec) (ARG ?v) (POSS -)
           (WH ?w) (agr ?agr) (SEM ?ref-type) (RESTR ?restr))
     (head (N1 (VAR ?v) (SORT PRED) (CLASS ?c) (MASS ?m) 
	    (KIND -)(agr ?agr) (RESTR ?r))))
    
     ;;  special treatment of possessive SPECS

     ;; for relational nouns
     ;;  e.g., the boxcar's weight
     
    ((NP (LF (% description (STATUS DEFINITE) (VAR ?v) (SORT (?agr ?m))
		(CLASS ?c) (CONSTRAINT ?reln) (SET-CONSTRAINT ?restr)))
       (VAR ?v)  (SORT DESCR))
     -np-poss-func1>
     (SPEC (POSS +) (RESTR ?restr) (POSS-VAR ?obj) (POSS-SEM ?sem))
     (head (N1 (SORT FUNC) (ARG ?obj) (VAR ?v) (MASS ?m) (CLASS ?c)
	    (agr ?agr) (ARGSEM ?sem) (RESTR ?reln))))
    
    ;; for non-relational nouns, default to POSS-BY
    ;; e.g., the engine's boxcar
    ((NP (LF (% description (STATUS DEFINITE) (VAR ?v) (SORT (?agr ?m))
		(CLASS ?c) (CONSTRAINT (AND (POSS-BY ?v ?obj) ?reln))
		(SET-CONSTRAINT ?restr)))
       (VAR ?v)  (SORT DESCR))
     -np-poss-func2>
     (SPEC (POSS +) (RESTR ?restr) (POSS-VAR ?obj))
     (head (N1 (VAR ?v) (CLASS ?c) (SORT PRED) (MASS ?m) (agr ?agr) (LF ?reln))))
    
     
    ;; MASS NPs
    ;;  e.g., sand, sand in the corner
    ((NP (MASS +) 
      (LF (% Description (STATUS INDEFINITE) (VAR ?v) (SORT STUFF)
	     (CLASS ?c) (CONSTRAINT ?r)))
      (SORT DESCR))
     -mass>
     (head (N1 (MASS +) (VAR ?v) (CLASS ?c) (RESTR ?r))))
    
    ;; QUANTITIES OF STUFF
    ;;   five pounds (of sand), three pounds (of bad oranges)
    ;;    Warning: this will ignore the "first" in the "the first five pounds of sand" since the RESTR in the SPEC is ignored
    
    ;;  ((NP (LF (% description (STATUS ?ref-type) (VAR ?v) (SORT STUFF)
    ;;	(CLASS ?c) (CONSTRAINT ?r)))
    ;; (SORT DESCR) (QTYPE ?w))
    ;;-quantity1>
    ;;(SPEC (MASS ?m) (LF ?spec) (ARG ?v) (POSS -) (AGR 3s)
    ;;       (WH ?w) (agr ?agr) (SEM ?ref-type) (RESTR ?restr))
    ;; (head (N1 (VAR ?v) (SORT UNIT) (CLASS ?c) (MASS ?m) (QUANTITY 1) ;;WHY TWO RULES HERE????
    ;;    (KIND -)(agr ?agr) (RESTR ?r))))
    
    ;;   three hours
     ((NP (LF (% description (STATUS ?ref-type) (VAR ?v) (SORT STUFF)
		 (CLASS ?c) (CONSTRAINT ?r)))
      (SORT DESCR) (QTYPE ?w))
     -quantity2>
     (SPEC (MASS ?m) (LF ?spec) (ARG ?v) (POSS -) (CARD ?q) (AGR 3p)
           (WH -) (agr ?agr) (SEM ?ref-type))
     (head (N1 (VAR ?v) (SORT UNIT) (CLASS ?c) (MASS ?m) (QUANTITY ?q)
	    (KIND -)(agr ?agr) (RESTR ?r))))
    
    ;; how many/few hours/etc - unfortunately we lose th units in this analysis
    ;;   but do get the right scale. "how many hours" comes out like "how long"
    
    ((NP (LF (% description (STATUS :how-much) (VAR ?v) (SORT STUFF) (lex ?lex)
		(CLASS ?c)))
      (SORT DESCR) (QTYPE ?w))
     -how-many-unit>
     (SPEC (MASS ?m) (LF ?spec) (ARG ?v) (POSS -) (CARD ?q) (AGR 3p) (lex ?lex)
      (sem how-many) (agr ?agr) (SEM ?ref-type) (RESTR ?restr))
     (head (N1 (VAR ?v) (SORT UNIT) (CLASS ?c) (MASS ?m) (QUANTITY ?q)
	    (KIND -) (agr ?agr) (RESTR ?r))))
    
    ;;  BARE PLURALS
    
    ;;  trains
     ((NP (LF (% Description (STATUS INDEFINITE) (VAR ?v) (SORT SET)
	     (CLASS ?c) (CONSTRAINT ?r)))
      (SORT DESCR))
     -bare-plural>
      (head (N1 (MASS -) (AGR 3p) (VAR ?v) (CLASS ?c) (RESTR ?r))))
    
 
    
    ;; DEFAULT RULE CONVERTS PHYSICAL OBJECTS INTO LOCATIONS
    
      
      ;; QUANTIFIER CONSTRUCTS WITH  NP COMPLEMENT

    ;; just a little train, only avon's cargo
    ;;   these are ignored for now: i.e., only the engine = the engine
    ((np (MASS ?m) (LF ?lf))
     -np-just>
     (quan (LF ONLY))
     (head (np (lf ?lf))))
    
    ;;  all the boys, all the sand
    ;;   also ignored for now, all the boys = the boys
    ((np (MASS ?m) (LF ?lf))
     -np-all>
     (quan (MASS ?m) (LF ?s) (LEX all))
     (head (np (MASS ?m) (AGR 3p) (LF (% DESCRIPTION (STATUS DEFINITE))) (LF ?lf))))

    ;;  all/some/each/many of the boys, some/all of the sand
    ((np (LF (% Description (STATUS ?qsem) (VAR ?v) (SORT ?sort) (set-constraint (?qlf ?v))
			  (CLASS ?class) (CONSTRAINT (REF-SET ?v ?lf))))
      (MASS ?m) (SORT DESCR))
     -quan-pp>
     (quan (Mass ?m) (AGR ?a) (SEM ?qsem) (VAR ?v) (lf ?qlf))
     (head (pp (ptype of) (MASS ?m) (AGR ?a)
	    (lf (% description (class ?class) (SORT ?sort))) (lf ?lf))))
					;  NB: LF matched twice on purpose
    
    ;;  COMMAS
    ;;  e.g., the train ,
    ((NP (LF ?r) (SORT ?sort))
     -np-comma>
     (head (NP (LF ?r) (SORT ?sort) (COMPLEX -))) (punc (LF comma)))

    ;; NP -> WH-PRO
    ;;  e.g., who, what, ...
    
    ((NP (SORT DESCR) (VAR ?v) (SEM (? s ANY-SEM)) (lex ?lex) (WH (? wh Q R)) (QTYPE ?lex)
      (LF (% Description (status WH) (var ?v) (Class (? s ANY-SEM)) (SORT (?agr -))
	     (Lex ?lex))))
     -wh-pro1>
     (head (pro (SEM ?s) (PP-WORD -) (AGR ?agr) (LEX ?lex) 
	    (VAR ?v) (WH Q))))
	    
    ;; NP -> NAME
    ((NP (SORT DESCR) (var ?v) (Class ?s)
      (LF (% Description (Status Name) (var ?v) (Sort Individual)
	     (Class ?s) (lex ?l))))
     -np-name>
     (head (name (lf ?l))))
    
  
))


;; CONJUNCTION CONSTRUCTIONS
;; allows changing of SEM and VAR features

(setq *grammar-CONJ* 
  '((headfeatures
     (NP CASE MASS NAME PRO)
     (NPSEQ CASE MASS NAME PRO)
     (NP-PP-WORD VAR SEM LEX SORT ATYPE))
    
    ;; WH-DESC forms
    
    ;;  WH-term as gap in an S structure
     ;; e.g., (I know) what the man said
   ((np (sort wh-desc)  (gap -) (sem INFORMATION) (var ?npvar)
     (lf (% description (status ?status) (VAR ?npvar) (class ?npsem) (constraint (and ?cons ?lf-s)) (sort ?sort))))
     -wh-desc1>
    (head (np (var ?npvar) (sem ?npsem) (wh Q) (agr ?a) 
     (lf (% description (status ?status) (constraint ?cons) (sort ?sort)))))
    (s (stype decl) (main -) (lf ?lf-s)
     (gap (% np (sem ?npsem) (var ?npvar)))))
    
    ;;  WH-term as setting in an S structure
    ;; e.g., (I know) when the train arrived
    ((np (sort wh-desc)  (gap -) (sem INFORMATION) (var ?npvar) (case obj)
      (lf (% description (status ?status) (VAR ?npvar) (class ?npsem) (constraint (and (?pred ?s-v ?npvar) ?lf-s)) (sort ?sort))))
     -wh-desc1a>
     (head (np-pp-word (var ?npvar) (sem ?npsem) (wh Q) (agr ?a) (sort (? x SETTING MANNER)) (PRED ?pred)
	    (lf (% description (status ?status) (sort ?sort)))))
     (s (stype decl) (main -) (var ?s-v) (lf ?lf-s) (gap -)))
    
    ;;  (show me) who arrived
    ((np (sort wh-desc)  (gap -) (sem INFORMATION) (var ?npvar) (case obj)
     (lf (% description (status ?status) (VAR ?npvar) (class ?npsem) (constraint (and ?cons ?lf-s)) (sort ?sort))))
     -wh-desc2> .5
     (head (np (var ?npvar) (sem ?npsem) (wh Q) (agr ?a) 
	   (lf (% description (status ?status) (constraint ?cons) (sort ?sort)))))
     (vp (lf ?lf-s) (subjvar ?npvar) 
      (subj (% np (sem ?npsem) (var ?npvar)))))

    ;; wh-term as gap
    ;; (tell me) what to do in avon
    
     ((np (sort wh-desc)  (gap -) (sem INFORMATION) (var ?npvar) (case obj)
     (lf (% description (status ?status) (VAR ?npvar) (class ?npsem) (constraint (and ?cons ?lf-s)) (sort ?sort))))
     -wh-desc3>
     (head (np (var ?npvar) (sem ?npsem) (wh Q) (agr ?a) 
	   (lf (% description (status ?status) (constraint ?cons) (sort ?sort)))))
     (s (stype to) (lf ?lf-s)
      (gap (% np (sem ?npsem) (var ?npvar)))))
    
    ;;  wh-term as adverbial (how etc)
    ;; (tell me) how to get to avon
    
     ((np (sort wh-desc)  (gap -) (var ?v) (sem INFORMATION) (case obj)
       (lf (% description (status WH) (VAR ?v) (class METHOD) (constraint (and (method-achieved ?s-var ?v)  ?lf-s)) (sort desc))))
      -wh-desc4>
      (head (pp-word (lex how) (sort Manner) (var ?v)))
      (s (stype to) (lf ?lf-s) (var ?s-var) (gap -)))
    
     ;; NP -> pronoun
    
    ;; non-wh and pp-word pro's: e.g., I, you, he, ...
    ;;  placed here because the CLASS isn't defined for PRO lexical items,
    ;;  so it can not be a head feature.
    
    ((NP (SORT DESCR) (VAR ?v) (SEM ?s) (lex ?lex) (Class ?s) (AGR ?agr)
      (LF (% Description (status pro) (var ?v) (Class ?s) (SORT (?agr -))
	     (Lex ?lex))))
     -np-pro1>
     (head (pro (SEM ?s) (AGR ?agr) (VAR ?v) (POSS -)
	    (LEX ?lex) (VAR ?v) (WH -))))
    
    
       ;; NP -> PP-WORD        Note: NP is built here to define a referent,
    ;;      but this NP is only used in  adverbials
    ;;  e.g., where
    
    ((NP-PP-WORD (SORT ?sort) (VAR ?v) (SEM ?s) (lex ?lex) 
      (ARGSEM ?argsem) (PRED ?pred) (WH Q)
      (LF (% Description (status WH) (var ?v) (Class ?s) (SORT (?agr -))
	     (Lex ?lex))))
     -np-pp-word1>
     (head (pp-word (SEM ?s) (AGR ?agr) (SORT ?sort)
	     (ARGSEM ?argsem) (PRED ?pred)
	    (LEX ?lex) (VAR ?v) (WH Q))))
    
    ;;  same rule, but for there, here, tomorrow (no WH terms)
    ((NP-PP-WORD (SORT ?sort) (VAR ?v) (SEM ?s) (lex ?lex)
      (ARGSEM ?argsem) (PRED ?pred)
      (LF (% Description (status PRO) (var ?v) (Class ?s) (SORT (?agr -))
	     (Lex ?lex))))
     -np-pp-word2>
     (head (pp-word (SEM ?s) (AGR ?agr) (SORT ?sort)
	     (ARGSEM ?argsem) (PRED ?pred)
	    (LEX ?lex) (VAR ?v) (WH -))))
    
    ;; *** NP formed by conjunction
    ;;  Note: I changed matching code to require normal unification
    ;;    rather than the more general "intersection matching"
    ;;    See change in EXTEND-ARC.   11/94 JFA
    
  
    ;;   sequence constructions (SEQ +),  e.g., X, Y and/or Z.
    ((NP (ATTACH ?a) (var ?v) (agr 3p) (SEM ?s)  
      (LF (% Description (Status DEFINITE) (var ?v) (Sort SET) (CLASS ?s)
	     (set-constraint (EQ ?v (SET-OF ?lf1 ?v2))))) ;; put in set-constraint as it is a constraint on the set
      (COMPLEX +) (SORT DESCR))
     np-conj1> .8
     (NPSEQ (var ?v1) (SEM ?s) (lf ?lf1))
     (conj (SEQ +) (LF AND) (SUBCAT NP) (var ?v))
     (head (NP (VAR ?v2) (SEM ?s) (ATTACH ?a))))
    
    ((NP (ATTACH ?a) (var ?v) (agr 3p) (SEM ?s)  
      (LF (% Description (Status INDEFINITE) (var ?v) (Sort INDIVIDUAL) (CLASS ?s)
	     (constraint (ONE-OF ?v (SET-OF ?lf1 ?v2))))) ;; put in set-constraint as it is a constraint on the set
      (COMPLEX +) (SORT DESCR))
     np-conj2>
     (NPSEQ (var ?v1) (SEM ?s) (lf ?lf1))
     (conj (SEQ +) (LF OR) (SUBCAT NP) (var ?v))
     (head (NP (VAR ?v2) (SEM ?s) (ATTACH ?a))))
  
    
    ;;  SEQ allows list of semantically identical NPs to be
    ;;   conjoined    e.g., Dansville Elmira Avon
    
    ((NPSEQ  (SEM (? s PHYS-OBJ)) (LF ?v1) (AGR 3s) )
     np1-3-2>
     (head (NP (SEM ?s) (VAR ?v1)  (CASE ?c) (MASS ?m) (COMPLEX -))))   
    
    ((NPSEQ  (SEM  (? s PHYS-OBJ)) (LF (LIST ?lf ?v2)) (AGR 3s))
     np1-3-3>
    (head (NPSEQ  (SEM ?s) (VAR ?v1) (LF ?lf) (CASE ?c) (MASS ?m)))
    (NP (SEM ?s) (VAR ?v2)  (CASE ?c) (MASS ?m) (COMPLEX -)))

    
    ))


;; GRAMMAR 4
;; allows changing of LF, agr, LF SEM and QUANT feature
;; for conjunctions and constructions:
;;  NUMBER PP(OF)
;;  NP -> NP1 (QUANT: P or ONE)
;;
(setq *grammar4*
  '((headfeatures
     (NP KIND CASE MASS NAME PRO SEM)
     (PP VAR agr SEM KIND VAR2)
     )
  	    
					; **** BOTH NP and NP
    ((NP (agr 3p) (VAR ?v) (LF (and ?l1 ?l2)) (LF AND) (ATTACH ?A))
     -np5-4>
     (quan (LF BOTH)) 
     (NP (SEM ?s) (VAR ?l1)) 
     (conj (LF and) (VAR ?v)) 
     (head (NP (SEM ?s) (VAR ?l2) (ATTACH ?a))))
    
    ;; *** NP -> NUMBER (of ANY-SEM)
    ;;  e.g., two of the engines
    ((NP (WH ?w) (VAR ?v) (SORT DESCR) (AGR 3p)
       (lf (% description (status ?spec) (var ?v) (sort SET)
	     (Class ?c) (set-constraint (and ?r (subset ?v ?setvar))))))
     -np-number-of1>
     (spec (bare-det +) (poss -) (sem ?spec) (arg ?v)
      (restr ?r) (agr 3p) (var ?v))
     (head (PP (PTYPE of) (WH ?w) (VAR ?setvar) 
	    (class ?c) (agr 3p))))
    
    ;;  singular
    ;;   e.g., one of the engines
    ((NP (WH ?w) (VAR ?v) (SORT DESCR) (AGR 3s)
      (lf (% description (status ?spec) (var ?v) (sort INDIVIDUAL)
	     (Class ?c) (constraint (member-of ?v ?setvar)))))
     -np-number-of2>
     (spec (LF ?r) (bare-det +) (poss -) (agr 3s) (var ?v) (sem ?spec))
     (head (PP (PTYPE of) (WH ?w) (VAR ?setvar)
      (class ?c) (agr 3p))))

   
    ))

;; GRAMMAR 6 
;;
;; KIND/AMOUNT/QUAN OF ANY-SEM
;;
(setq *grammar6* 
  '((headfeatures
     (NP SPEC QUANT VAR agr PRO))
    
    ;;  HEADLESS CONSTRUCTIONS
    
    ;;  e.g., the one/two  at avon / one at avon
    ;;  only allowed with determiners that involve a count
    ((NP (SORT ?sort) (CLASS ?c) (VAR ?v) (sem ?s)
       (lf (% description (status ?spec) (var ?v) (sort INDIVIDUAL)
	     (Class ?s) (constraint ?l1))))
    -NP-missing-head1> .8
     (head (spec  (poss -) (wh -) (restr (count ?x ?y)) (sem ?spec) (arg ?v) (agr 3s) (var ?v)))
     (ADVBLS (LF ?l1) (ARG ?v) (SORT SETTING) (ARGSEM ?s)))

    ;;   origin specification: the one from bath / one from bath
     ((NP (SORT ?sort) (CLASS (? c MOVABLE-OBJ)) (VAR ?v) (sem ?c)
       (lf (% description (status ?spec) (var ?v) (sort INDIVIDUAL)
	     (Class ?c) (constraint (FROM ?v ?l1)))))
    -NP-missing-head2> .8
     (head (spec (poss -) (sem ?spec) (restr (count ?x ?y)) (arg ?v) (agr 3s) (var ?v)))
     (PP (ptype from) (VAR ?l1) (SEM (? x CITY LOCATION))))

    ;;   Need similar rules for the plural forms with missing heads
    ;;  converting a physical object like "avon" into a location.
    ;;   Note: currently we don't change the LF but we might want to at a later date
     
    ((np (lf ?lf) (sem (? sem LOCATION)))
     -object-to-loc> .8
     (head (np (lf ?lf) (sem PHYS-OBJ) (MASS -) (AGR 3s) (POSS -))))
))
   

;; various misc rules for collocations

(setq *grammar8*
  '((headfeatures
     (NAME VAR NAME)
     (ADV var)
     (conj var)
     (quan var)
     (adj var)
     )		


    ((adv (LF AT_LEAST))
     -a1>
     (word (Lex AT)) (head (word (Lex LEAST))))
    
    ((adv (LF A_LITTLE))
     -a2>
     (word (Lex A)) (head (word (Lex LITTLE))))
    
    ((adv (LF A_LOT))
     -a3>
     (word (Lex A)) (head (word (Lex LOT))))
    
    ((adv (LF BACK_AND_FORTH))
     -a4>
     (word (Lex BACK)) (head (word (Lex AND))) (word (Lex FORTH)))
    
    ((conj (LF AS_WELL_AS) (SUBCAT (? sub S PP VP NP)))
     -c1>
     (word (Lex as)) (head (word (Lex WELL))) (word (Lex AS)))

    ((adv (SORT DISC) (DISC-FUNCTION instead-of) (SUBCAT NP)
      (SUBCATSEM ?sem) (SA-ID REJECT) (AGR ?a)
      (LF INSTEAD-OF))
     -c2>
     (head (word (Lex instead))) (word (Lex of)))

     ((adv (SORT DISC) (DISC-FUNCTION instead-of) (SUBCAT NP)
       (SUBCATSEM ?sem) (SA-ID REJECT) (AGR ?a)
       (LF INSTEAD-OF))
      -c3>
      (head (word (Lex rather))) (word (Lex than)))
    
    
    ((quan (LF AT_MOST) (agr 3p) (dis +))
     -q1>
     (word (lex AT)) (head (word (Lex MOST))))

    ((adj (LF WARM-UP))
     -aj1>
     (head (word (Lex WARM))) (word (Lex UP)))


    ;;   RNUMBER allows a bare number,e.g., 1, or the phrase NUMBER 1
	 
    ((RNUMBER (LF ?i) (agr ?a))
     -rn1>
     (n (LF number)) (NUMBER (LF ?i) (agr ?a)))

    ((RNUMBER (LF ?i) (agr ?a))
     -rn2>
     (NUMBER (LF ?i) (agr ?a)))

					; multiword versions of
					; AM and PM
    ((a-p-m (LF A.M.))
     -cv1>
     (cv (LF A) ) (cv (LF M) ))
    
    ((a-p-m (LF A.M.))
     -cv2>
     (cv (LF A) ) (punc (LF PERIOD)) (cv (LF M)) (punc (LF PERIOD)))
     ((a-p-m (LF A.M.))
     -cv3>
     (cv (LF A.M)) (punc (LF PERIOD)))
    
    ((a-p-m (LF P.M.))
     -cv4>
     (cv (LF P) ) (cv (LF M) ))
    
     ((a-p-m (LF P.M.))
      -cv5>
      (cv (LF P) ) (punc (LF PERIOD)) (cv (LF M)) (punc (LF PERIOD)))
     ((a-p-m (LF P.M.))
      -cv6>
     (cv (LF P.M)) (punc (LF PERIOD)))


;;  RULE FOR COMPLEX NAMES FROM LETTER AND NUMBER COMBINATIONS


     ;;   names constructed from letter and numbers, e.g., E 1

    ((name (VAR ?d) (LF (?letter ?n)) (LET-NUMB +) (agr 3s) (SEM (? sem ANY-SEM)))
     -name-letter1>
     (head (name (SEM LETTER) (LF ?letter))) 
     (RNUMBER (LF ?n)))
	 
    ;;  e.g., ENGINE E 1

    ((name (LF (?lf ?letnumb)) (class ?cl) (SEM (? x PHYS-OBJ)) (agr 3s))
     -name-letter2>
     (head (n (SEM ?x) (lf ?cl) (LF ?lf))) 
     (name (LET-NUMB +) (SEM ?x) (LF ?letnumb)))


    ;; e.g., ENGINE 1

    ((name (LF (?lf ?n)) (Class ?cl) (SEM (? x PHYS-OBJ)))
     -name-letter3>
     (head (n (SEM PHYS-OBJ) (lf ?cl) (LF ?lf)))
     (RNUMBER (LF ?n)))

))


;;====================================================================================
;;
;;   THE RULES FOR VALUES, UNITS AND MEASURES
;;

;;   TIME

(setq *grammar-Values*
  '((headfeatures
     (NP VAR KIND NAME PRO SPEC ATTACH)
     (PP VAR KIND CASE MASS NAME agr SEM PRO SPEC QUANT ATTACH)
     (ADVBL VAR SEM ATYPE)
     (VALUE VAR)
     )			

    ;;   BASIC TIME-OF-DAY VALUES
    
    ;;   e.g.,  5:30, 5:30 AM, 5 o'clock, 5 tomorrow, 5:30 tomorrow, 

    ;;  e.g., 5
    
    ((value (lex (% Time-of-day (Hour ?r) (am-pm ?x)))
      (AGR 3s) (SEM TIME-OF-DAY))
     -time0>
     (head (NUMBER (LF ?r) (NTYPE (? n HOUR12))))) ;; also HOUR24 in general

    ;;  e.g., 5:30
    ((value (lex (% Time-of-day (Hour ?r) (Minute ?r2) (am-pm ?x)))
      (AGR 3s)  (SEM TIME-OF-DAY))
     -time1>
     (head (NUMBER (LF ?r) (NTYPE (? n HOUR12 HOUR24))))
     (punc (lex punc-colon))
     (NUMBER (LF ?r2) (NTYPE MINUTE)))
    
    ;;  E.G., FIVE THIRTY
    ((value (Lex (% Time-of-day (Hour ?r) (Minute ?r2) (am-pm ?x)))
      (AGR 3s)  (SEM TIME-OF-DAY))
     -time1A>
     (head (NUMBER (LF ?r) (NTYPE (? n HOUR12 HOUR24))))
     (NUMBER (LF ?r2) (NTYPE MINUTE)))
   
    ;;  e.g.,  5 am, 5 pm
    ((value (Lex (% Time-of-day (Hour ?n) (am-pm ?lf)))
      (AGR 3s)  (SEM TIME-OF-DAY))
     -time2>
     (head (NUMBER (LF ?n) (NTYPE HOUR12)))
     (N (SORT INTERVAL) (SEM TIME-OF-DAY) (LF ?lf)))

    ;;  e.g., 5 o'clock
    ((value (Lex (% Time-of-day (Hour ?n) (am-pm ?x)))
      (AGR 3s)  (SEM TIME-OF-DAY))
     -time3>
     (head (NUMBER (LF ?n) (NTYPE HOUR12)))
     (o^)
     (CV (LEX oclock)))

    ;;  DATE VALUES

    ;;  e.g., Monday

    ((value (Lex (% Date (day-of-week ?i)))
      (SEM DATE))
     -date0>
     (head (value (sem DAY) (INDEX ?i))))
    
    ;;  e.g.,  July
    ((value (Lex (% Date (month ?i)))
        (SEM DATE))
     -date1>
     (head (value (sem MONTH) (INDEX ?i))))

    ;; e.g., July 25
    ((value (Lex (% Date (month ?i) (day ?n)))
        (AGR 3s)  (SEM DATE))
     -date2>
     (head (value (sem MONTH) (INDEX ?i)))
     (number (Lex ?n) (NTYPE DAY)))
    
    ;; e.g., Monday,, July 25
    
    ((value (Lex (% Date (day-of-week ?dw) (month ?m) (day ?d)))
      (AGR 3s) (SEM DATE))
     -date3>
     (head (value (sem DAY) (LF (% Date (day-of-week ?dw)))))
     (value (sem DATE) (LF (% Date (month ?m) (day ?d)))))

    ;; e.g., July 1994, July 25, 1994
    ((value (Lex (% Date (month ?m) (day ?d) (year ?n)))
      (AGR 3s)  (SEM DATE) (YEAR +))
     -date4>
     (head (NP  (SEM DATE) (LF (% DATE (month ?m) (day ?d))) (YEAR -) (INDEX ?i)))
     (Number (Lex ?n) (NTYPE YEAR)))

    ;;========================================
    ;; UNIT BASED VALUES
    ;;   three pounds, one gallon
    
    ((value (Lex (% ?SEM (?unit ?n))) (SEM ?SEM)
      (ARGSEM ?argsem))
     -unit1>
     (number (Lex ?n) (Agr ?a))
     (head (n (SORT UNIT) (ARGSEM ?argsem) 
	    (SEM ?SEM) (LF ?unit) (AGR ?a))))
    
    ;;   three pounds, two ounces
     ((value (Lex (% ?d (complex (plus ?lf1 ?lf2)))) (ARGSEM ?argsem) (SEM ?d))
     -unit2>
      (head (value (Lex ?lf1) (SEM ?d) (ARGSEM ?argsem)))
      (value (Lex ?lf2) (SEM ?d) (ARGSEM ?argsem)))
  
    ;;   RATES
    ;;   e.g.,  seven miles per hour
    
    ((value (Lex (% RATE (UNIT (Per ?u-lf ?t-lf)) (VAL ?n) (SEM (Per ?u-lf ?t-lf)))))
     -unit4> 
     (number (LF ?n) (Agr ?a))
     (head (n (SORT UNIT) (LF ?u-lf) (SEM ?SEM) (AGR ?a)))
     (adv (LEX per))
     (n (LF ?t-lf) (SORT UNIT) (SEM TIME-DURATION)))
    
    ;;   e.g., seven mph
    
    ((value (Lex (% RATE (UNIT ?lf) (VAL ?n))) (SORT RATE)
      (SEM ?SEM) (AGR ?a))
     -unit5>
     (number (Agr ?a) (LF ?n))
     (head (n (SORT RATE) (LF ?lf) (SEM ?SEM) (AGR ?a))))

    ))


;;======================================================================================
;;
;;     TIME AND LOCATION PHRASES
;;
;;======================================================================================

(setq *grammar-TIME-LOC*
  '((headfeatures
     (np var))
    
    ;; TIME-LOC are expressions that identify a specific time of day
    ;;   either directly or indirectly. All TIME-LOC can be the object of the preposition AT.
    
    ;;  5 a.m., 5 o'clock, 5:30
    
      ((np (lf (% description 
		  (status direct)
		  (var ?v)
		  (sort INDIVIDUAL)
		  (class time-loc)
		  (constraint (time-of-day ?v ?lf))))
	(sem TIME-OF-DAY) (var ?v) (CASE ANY-CASE) (SORT DESCR) (AGR 3s))
       -time-np1>
       (head (value  (SEM TIME-OF-DAY) (Lex ?lf))))
    
    ;; 5 o'clock tomorrow, 5 am today, 5:30 in the morning, 5 tomorrow in the morning

     ((np (lf (% description 
		 (status direct)
		 (var ?v)
		 (sort INDIVIDUAL)
		 (class time-loc)
		 (constraint (and (time-of-day ?v ?lf) ?constraint))))
       (SEM TIME-OF-DAY) (var ?v) (CASE ANY-CASE) (SORT DESCR) (AGR 3s))
      -time-np2>
      (head (value  (SEM TIME-OF-DAY) (Lex ?lf)))
      (ADVBLS (SORT TIME-CONSTRAINT) (ARG ?v) (LF ?constraint)))

    ;;  e.g., yesterday morning, tomorrow afternoon, tomorrow a.m.

    ((np (SORT DESCR) (SEM TIME-OF-DAY)
      (LF (% description
	     (status direct)
	     (var ?v)
	     (sort INTERVAL)
	     (class time-loc)
	     (constraint (intersection ?v ?lf1 ?lf2))))
      (CASE ANY-CASE) (AGR 3s))
     -time-np3>
     (np (PRO +) (SEM DAY) (LF ?lf1))
     (head (n (SORT INTERVAL) (SEM TIME-OF-DAY) (Lex ?lf2))))
    
    ;;  e.g., yesterday noon, tomorrow midnight, tomorrow 3 o'clock
    
     ((np (SORT DESCR) (SEM TIME-OF-DAY)
      (LF (% description
	     (status direct)
	     (var ?v)
	     (sort INDIVIDUAL)
	     (class time-loc)
	     (constraint (and (within ?v ?lf1) (time-of-day ?v  ?lf2)))))
      (CASE ANY-CASE) (AGR 3s))
     -time-np4>
     (np (PRO +) (SEM DAY) (LF ?lf1))
      (head (value  (SEM TIME-OF-DAY) (Lex ?lf2))))
    
    ;;  dates: e.g., Monday, July 25, 1999.
    
    ((np (lf (% description 
		(status direct)
		(var ?v)
		(sort INDIVIDUAL)
		(class time-loc)
		(value ?val)
		(constraint ?lf)))
	(sem DATE) (var ?v) (CASE ANY-CASE) (SORT DESCR) (AGR 3s))
       -time-np5>
       (head (value (SEM DATE) (lex ?val) (LF ?lf))))
))


(augment-grammar *grammar-TIME-LOC*)
(augment-grammar *grammar-values*)
(augment-grammar *grammar-adverbials*)
(augment-grammar *grammar-pp-words*)
(augment-grammar *grammar-SPEC*)
(augment-grammar *grammar-N1*)
(augment-grammar *grammar-N1-aux*)
(augment-grammar *grammar-CONJ*)
(augment-grammar *grammar4*)
(augment-grammar *grammar-NP*)
(augment-grammar *grammar6*)
(augment-grammar *grammar8*)
(augment-grammar *grammar-misc*)
