(in-package :parser)

;; From newRules.lisp

(augment-grammar
 '((headfeatures
     (adv var lf lex subcat subcatsem subcatsort argsem argsort atype agr sort sem lf))

   ;; ROBUST RULES: This is an error correction rule to handle repeated preposition speech repairs
   
   ;;  e.g., X Y -> X
   ((p (LEX ?lex) (VAR ?v)) 
    -repeated-p1> .3
    (p (LEX ?lex) (VAR ?v))
    (p (LEX ?lex1)))
   
   ;; e.g., X Y -> Y
    ((p (LEX ?lex1) (VAR ?v)) 
    -repeated-p2> .3
    (p (LEX ?lex) (VAR ?v))
    (p (LEX ?lex1)))

   ;; e.g., X Y -> X
   ((adv (lex ?l)) 
    -repeat-adv> .3
    (head (adv (lex ?l) (sort ?s)))
    (adv (lex ?l1) (sort ?s)))
   
     ;; e.g., X Y -> Y
   ((adv (lex ?l1)) 
    -repeat-adv2> .3
    (adv (lex ?l) (sort ?s))
    (head (adv (lex ?l1) (sort ?s))))
   
   ;; special rules for FROM, in which we take the FROM to be more reliable
   
   ((adv (lex FROM)) 
    -repeat-adv-from1> .5
    (adv (lex ?l) (sort ?s))
    (head (adv (lex FROM) (sort ?s))))
   
   
   ((adv (lex FROM)) 
    -repeat-adv-from2> .5
    (head (adv (lex FROM) (sort ?s)))
    (adv (lex ?l) (sort ?s)))
   
   ;;  This deletes the: e.g., "the avon" -> "avon"
   
   ((name (var ?v)  (CLASS CITY) (NAME +) (LF ?lf) (SEM CITY )
     (agr 3s))
    -delete-the-> .5
    (word (lex the))
    (name (var ?v)  (CLASS CITY) (NAME +) (LF ?lf) (SEM CITY )
     (agr 3s)))
   
   ;;  The inserts a to, e.g., "from Avon Bath" -> "from Avon to Bath"
   ((path  (var ?v) (lf (% Path (var ?v) (constraint (:and ?lf1 (:to ?v ?v1))))))
    -missing-to> .5
    (advbl (arg ?v) (var ?v) (sort path) (lf ?lf1) (lf (from ?x ?y)))
    (np (name +) (SEM CITY) (var ?v1)))

))

;; From vp-grammar.lisp

(augment-grammar
  '((headfeatures
    (vp vform agr sem)
    (s vform var neg sem subjvar dobjvar)
    (utt sem setting subjvar dobjvar))
    
     
    ;;   This is here just to catch "Where are the train" - a common error in 1.01
    ((s (stype whq) (main +) (gap -) (qtype ?qt) (focus ?foc) (subjvar ?subjv) (var ?v)
	(lf (% prop (var ?v) (class BE) (constraint (and (lsubj ?v ?subjv) (lcomp ?v (pred (arg ?v1) (constraint ?lf1))))))))
     -s-wh-be-default> .5
     (advbl (sort (? x setting reason manner)) (arg ?v1)
	    (focus ?foc) (arg ?subjv) (wh Q) (qtype ?qt) (lf ?lf1))
     (head (v (lf ?c) (var ?v) (agr 3p) (sem BE) (LF BE)))
     (np (agr 3s) (var ?subjv) (sem ?subjsem) (case (? case - sub))))))
    
;; From np-grammar.lisp

(augment-grammar 
  '((headfeatures
     (NP VAR CASE MASS NAME agr SEM PRO CLASS))
    
    ;;  ROBUST RULE: This is here to try to handle the common speech error
    ;;  of missing a initial determiner.  To limit the search, we restrict
    ;;  it to trains until we have a better control mechanism for the parser
    
    ;;  train at Montreal
     ((NP (LF (% Description (STATUS DEFINITE) (VAR ?v) (SORT (?agr -))
	     (CLASS ?c) (CONSTRAINT ?r)))
      (SORT DESCR))
     -bare-sing-robust> .5
      (head (N1 (MASS -) (AGR 3s) (VAR ?v) (CLASS ?c) (SEM TRANS-AGENT) (RESTR ?r))))
))
