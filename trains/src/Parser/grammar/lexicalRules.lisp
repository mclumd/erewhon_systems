;;  This file contaions collocations and other rules
;;   specific to the trains domain

(in-package parser)

(augment-grammar
 '((headfeatures
    (np agr)
    (v var agr vform))
   
   
   ;;  COMPOUND CITY NAMES
   
   ((name (var ?v) (QUANT S) (CLASS CITY) (NAME +) (LF Penn_Yan) (SEM CITY)
     (agr 3s))
    <-name1-
    (cv (LEX Penn) (var ?v) ) (cv (LEX Yan)))
   
   ( (name (var ?v)  (CLASS CITY) (NAME +) (LF New_York) (SEM CITY)
     (agr 3s))
    <-name1a-
    (adj (LEX New) (var ?v)) (cv (LEX York)))
   
   ( (name (var ?v)  (CLASS CITY) (NAME +) (LF New_York) (SEM CITY)
     (agr 3s))
    <-name1b-
    (adj (LEX New) (var ?v)) (cv (LEX York)) (word (lex city)))
   
   ((name (var ?v)  (CLASS CITY) (NAME +) (LF East_Aurora) (SEM CITY)
     (agr 3s))
    <-name2-
    (word (var ?v) (LEX East)) (word (LEX Aurora)))
   
   ((name (var ?v)  (CLASS CITY) (NAME +) (LF Mount_Morris) (SEM CITY )
     (agr 3s))
    <-name3-
    (cv (var ?v) (LEX Mount)) (cv (LEX Morris)))
   
   ((name (var ?v)  (CLASS CITY) (NAME +) (LF Watkins_Glen) (SEM CITY)
     (agr 3s))
    <-name4-
    (cv (var ?v) (LEX Watkins)) (cv (LEX Glen)))
   
   ((name (var ?v) (CLASS CITY) (NAME +) (LF Washington) (SEM CITY) (agr 3s))
    <-name5-
    (word (lex Washington) (var ?v)) (word (lex D)) (word (lex C)))
   
   
    ;;   COMPOUND PREPOSITIONS
   
   ((adv (var ?v) (LEX VIA) (SUBCAT NP) (SUBCATSEM (?  X46746 LOCATION FIXED-OBJ)) (SUBCATSORT DESCR) (ARGSEM ?argsem)
     (ARGSORT ?argsort) (ATYPE -) (AGR ?agr) (SORT PATH) (SEM ROUTE) (LF VIA))
     -compoundp1>
    (word (LEX by) (var ?v)) (word (LEX way)) (word (LEX of)))
   
   ((adv (LEX NEAR) (SUBCAT (? subcat NP NP-DELETED)) (SUBCATSEM (? x PHYS-OBJ)) (SUBCATSORT VALUE)
     (ARGSEM (? argsem PHYS-OBJ EVENTUALITY)) (ARGSORT ?argsort) (ATYPE (? atype PRE POSTVP))
     (AGR ?agr) (SORT SETTING) (SEM LOCATION) (LF APPROX-AT-LOC))
    -compoundp2>
    (word (LEX next)) (word (LEX to)))
   

   ;;  ABBREVIATIONS
   
   ((cv (var ?v) (LEX Mount))
    -mount1>
    (cv (var ?v) (lex mt)) (Punc (lex period)))
   
   ;;  OTHER COLLOCATIONS
   
   ;;  no good/better
   ((adj (LF BAD) (SEM ACCEPTABILITY) (ARGSEM ?argsem) (Var ?v))
    -no-good>
    (word (lex no)) (word (var ?v)  (lex (? w good better))))
   
   ;;  in that case
   ((adv (LF IN-THAT-CASE) (SORT DISC) (ATYPE (? a PRE POST)) (DISC-FUNCTION SUMMARIZE) (Var ?v))
    -in-that-case>
    (word (lex in)) (word (lex that)) (word (lex case) (var ?v)))
   
   ;;  in the meantime/meanwhile
   ((adv (LF MEANWHILE) (SORT ?sort) (ATYPE ?atype) (DISC-FUNCTION ?dsc) (Var ?v))
    -meanwhile>
    (word (lex in)) (word (lex the)) (adv (lf meanwhile) (lf ?lf) (sort ?sort) (atype ?atype) (disc-function ?dsc) (var ?v)))
   
   ;;   O K
   ((adj (lex OKAY) (LF good) (Sem acceptability))
    -O-K-> 
    (word (lex o)) (word (lex k)))
     
   ;; SPEECH ACT CUE PHRASES
   
   ((uttWord (SA CONFIRM) (LF ALRIGHT))
    <-sa1- (quan (LEX all)) (adj (LEX right)))
   
   ((uttword (SA CONFIRM) (LF :OKAY))
    <-sa1a- 1.5 (word (lex (? w Okay OK))))
   
   ((sa-id (ID REJECT) (LF NOT))
    <-sa2a- (aux (NEG +)))
   
   ((sa-id (ID REJECT) (LF instead))
    <-sa2b- (word (LEX INSTEAD)))

   ((sa-id (ID REQUEST) (LF PLEASE))
    <-sa4- (word (LEX please)))
   
   ((sa-id (ID ID-GOAL) (LF NEED-WANT))
    <-sa5- (pro (lex (? x i we you))) (v (lex (? y need want)) (vform (? s pres past))))
   
   ((sa-id (ID ID-GOAL) (LF WOULD-LIKE))
    <-sa5a- (pro (lex I)) (aux (lex would)) (v ( lex like)))

   ((sa-id (ID ID-GOAL) (LF NEED-WANT))
    <-sa5b- (pro (lex (? x i we you))) 
    (adv (lex (? w also)))
    (v (lex (? y need want)) (vform (? s pres past))))
    
   ((sa-id (ID YN-QUESTION) (LF question-mark))
    -sa7-> (punc (lex question-mark)))
   
   ;;  LET ME SEE
   
   ((uttWord (SA WAIT) (LF LET-SEE))
    <-sa6- 1.5
    (v (lex let) (vform base)) (pro (lex (? x me us))) (v (lex see) (vform base)))
   
   ((sa-id (ID CONDITIONAL) (LF IF))
    <sa9- (if))
   
   ((sa-id (ID ID-GOAL) (LF HAVE-TO))
    <sa10- (pro (lex (? x i we you))) (aux (lex have)) (word (lex to)))

   ((sa-id (ID ID-GOAL) (LF HAVE-TO))
    <sa10a- (pro (lex (? x i we you))) (aux (lex have)) (v (lex GOT)) (word (lex to)))
  
   ((sa-id (ID REJECT) (LF I-MEAN))
    -sa11-> (pro (lex (? x i you we))) (word (lex mean)))
   
   ((UttWord (SA REJECT) (LF NEVERMIND))
    <-sa-never-mind- 1.5
    (adv (lex never)) (cv (lex mind)))
   
    ((UttWord (SA REJECT) (LF NO))
     <-sa-no-thanks- 1.5
     (uttword (lex no)) (utt (LF  thanks)))
   
    ((UttWord (SA EXPRESSIVE) (LF THANKS))
    <-sa13- 1.5 (v (lex thank) (vform base)) (pro (lex you)))
   
     
   ((UttWord (SA CLOSE) (LF  AM-DONE))
    <-close2- (adj (lex (? x done finished))))
   
   ;;  good, fine, ...
   ((UttWord (SA EVALUATION) (LF ?lf))
    <-sa14- (adjp (arg *PRO*) (var ?v) (LF ?LF) (SEM ACCEPTABILITY)))
   
   ;; good job/work
    ((UttWord (SA EVALUATION) (LF ?lf))
     <-sa15- 
     (adjp (arg *PRO*) (var ?v) (LF ?LF) (SEM ACCEPTABILITY))
     (word (lex (? c work job))))

   ;; hi/hello there
   ((Uttword (SA GREET) (LF ?lf))
    <-sa16- 1.5
    (word (lex (? x hi hello)))
    (word (lex there)))
  
      ))


;;;   MOUSE ACTION GRAMMAR

;;  note, since mouse actions do not take up positions, we must
;;  be careful to use the DIECTIC feature to avoid infinite recursion
;;(augment-grammar
;; '((headfeatures
;;    (np agr sem var)
;;    (pp_word ptype quant sem agr pro))
   ;;  conjoined with a noun phrase
;;   ((NP (DIECTIC +) (lf1 ?lf) (ref ?ref))
;;    -diectic1>
;;    (head (NP (DIECTIC -) (lf ?lf)))
;;    (select (lf ?ref)))
   
   ;; as a noun phrase
;;   ((NP (DIECTIC +) (spec direct) (ref ?ref))
;;    -diectic3>
;;    (head (select (lf ?ref))))
   
;;   ))
   
