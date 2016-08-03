(in-package parser)

;;;======================================================================
;;; NLP code for use with Natural Language Understanding, 2nd ed.
;;; Copyright (C) 1994 James F. Allen
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 2, or (at your option)
;;; any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program; if not, write to the Free Software
;;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
;;;======================================================================

;;  THE GRAMMAR AND LEXICON
;;  This file contains functions that manage the grammar and the lexicon
;;  These are mostly I/O routines to provide for a more user-friendly system.

;;*******************************************************************************
;;  THE LEXICON DATA STRUCTURE
;; 
;; The lexicon is a hash table indexed by word, with an entry being a
;;   list of constituents.

;; Definition moved to structures.lisp for easier compilation.
;; (defstruct lex-entry constit id)

;; These functions convert from the user specified format into the more cumbersome
;;   internal format, and compute a rule id. 

;; var tells parser which lexical entries it should tag
;; a discourse variable onto

(defconstant *dummy-lex-var* (make-var :name 'dummy)) ;; since these are always bound immediately
					; the same one is used in each entry

(let ((lexicon (make-hash-table :test 'equal :size 1))
      (lex-ids nil)
      (default-rule-prob 1.0))

  (defun init-lexicon (size)
    (setq lex-ids nil)
    (setq lexicon
      (make-hash-table :test 'equal :size size))
    (setq default-rule-prob 1.0))

  ;; Add constit to lexicon entry for word.  Word is either a symbol
  ;; (for a normal word), or a list (for a multi-word entry).
  (defun add-to-lex (word constit &optional id)
    (push (make-lex-entry :constit constit
			  :id id)
	  (gethash word lexicon)))
  
  ;; retrieve the list of constituents associated with word, which is
  ;; either a symbol or a list of symbols.
  ;; If a number is found that is not in the lexicon, an
  ;; entry is created and returned
  
  (defun retrieve-from-lex (word)
    (let ((temp (gethash word lexicon)))
      (if temp
	  temp
	(if (numberp word)
	    (list (make-lex-entry 
		   :constit (build-constit 'NUMBER 
					   `((lex ,word)
					     (VAR ,(make-var :name 'V))
					     (mass -)
					     (agr 3p)
					     (ntype ,(make-var :name 'N 
							       :values (classify-n word)))
					     (lf ,word))
					   nil)
		   :id nil))))))
  
    
  (defun get-lexicon nil
    lexicon)
  
  (defun get-lex-ids nil
    lex-ids)

  (defun gen-lex-id (id name)
    (if id 
      (cond ((member id lex-ids)
             (Format t "~%Warning: Duplicate lexical id used: ~S in word ~S" id name)
             id)
            (t (setq lex-ids (cons id lex-ids))
               id))
      (let ((id (gen-symbol name)))
        (setq lex-ids (cons id lex-ids))
        id)))
  
  (defun set-default-rule-probability (n)
    (setq default-rule-prob n))
  
  (defun get-default-rule-prob nil
    default-rule-prob)
      
  
  )  ;; end of scope for LEXICON, LEX-IDS, and DEFAULT-RULE-PROB

;;  MAKE-LEXICON deletes the old active lexicon and creates a new one
  
(defun make-lexicon (ls)
  (init-lexicon (length ls))
  (if ls (augment-lexicon ls)))
  
  ;;  AUGMENT-LEXICON extends the current active lexicon

(defun augment-lexicon (ls)
  (mapc #'make-lex ls))


;;   GET-LIST-OF-LEXICON-ENTRIES
;;   This returns a list of all the lex-entries for all words

(defun get-list-of-lexicon-entries nil
  (let ((l nil))
    (maphash #'(lambda (word entries)
		 (declare (ignore word))
		 (setq l (append l entries)))
             (get-lexicon))
    l))
    

;;  DEFINED-WORDS returns a list of all defined words

(defun defined-words nil
    (let ((words nil))
      (maphash #'(lambda (word entrylist)
		   (declare (ignore entrylist))
		   (setq words (cons word words)))
             (get-lexicon))
      words))


;; MAKE-LEX creates a lexical entry from the user-input format

(defun make-lex (entry)
  (init-var-table)
  (let ((l (length entry)))
    (if (not (or (eq l 2) (eq l 3))) 
	(parser-warn "~%WARNING: Bad lexical entry: ~S~%" entry)))
  
  (let* ((name (car entry))
         (def (cadr entry))
         (cat (car def))
         (feats (cdr def))
         (id (third entry)))
  
    (mapcar #'check-feat  feats)
    
    ;;  if not added already, define the literal word
    (if (not (retrieve-from-lex name))
	(add-to-lex name (build-constit 'word (list (list 'lex name)
						    (list 'var *dummy-lex-var*))
					nil)))

    ;;  add default feature values if needed: 
    ;;     LEX - equal to the word
    ;;     LF - equal to the LEX, 
    ;;     VAR - a variable to be bound when entry is retrieved.
    
    (if (not (get-fvalue feats 'LEX)) 
	(setq feats (cons (list 'LEX name) feats)))
    (if (not (get-fvalue feats 'LF)) 
	(setq feats (cons (list 'LF (get-fvalue feats 'LEX)) feats)))
    (if (or (noSemEnabled) (get-fvalue feats 'VAR))
      (add-to-lex name 
		  (build-constit cat (mapcar #'(lambda (x)
						(read-fv-pair x nil))
					    feats) nil)
		  id)
      (add-to-lex name 
		  (build-constit cat (cons (list 'VAR *dummy-lex-var*)
					   (mapcar #'(lambda (x)
						       (read-fv-pair x nil))
						   feats))
				 nil)
		  id))))

;;    CHECK-FEAT verifies that a feature-value pair is in the right format

(defun check-feat (fv)
  (if (not (and (listp fv) (eq (length fv) 2)))
    (Format t "~%Warning: bad feature specification: more than one value in ~S~%" fv)
))

;;  ****************

;; LOOKUPWORD finds the entry in the lexicon for a specific word or
;; list of words, and creates an entry for each interpretation. To do
;; this, is also must know the starting position of the group. It sets
;; ENTRY-PROB to the default value of 1.

(defun lookupword (word n)
  (let ((entries nil)
	(len 1))
    (when (listp word)
      (setq len (length word))
      (if (= len 1)
	  (setq word (car word))))
    (mapcar #'(lambda (lex-entry) 
		(let ((id (lex-entry-id lex-entry)))
                  (setq entries (cons (build-entry 
                                       (instantiateVAR (lex-entry-constit lex-entry))
                                       n (+ n len) nil 
                                       id
                                       1)
                                      entries))))
            (retrieve-from-lex word))
    entries))



;;*******************
;;  LEXICAL CATEGORIES

(let ((lexicalCats '(n v adj art p aux pro qdet pp-wrd name to)))
  
  (defun defineLexicalCats (cs)
    (if (listp cs) 
      (setq lexicalCats cs)
      (Format t "Bad Format in ~S~%  you must pass in a list of lexical categories" cs)))

  (defun addLexicalCat (c)
    (if (symbolp c)
	(if (not (member c lexicalCats))
	    (setq lexicalCats (cons c lexicalCats)))
      (Format t "Lexical categories must be atoms. ~S is ignored" c)))
  
  (defun getLexicalCats nil
    lexicalCats)
  
  (defun lexicalConstit (c)
    (and (constit-p c) (member (constit-cat c) lexicalCats)))
  
  (defun nonLexicalConstit (c)
    (and (constit-p c) (not (member (constit-cat c) lexicalCats))))

)  ;; end scope of LEXICALCATS


;;**************************************************************************
;;  THE GRAMMAR DATA STRUCTURE

;;     Grammar rules are of the form
;;        (<constit-pattern>  ->  <constit-pattern> ... <constit-pattern>)
;; e.g.,  ((S (INV -) (AGR ?a)) -> (NP (AGR ?a)) (VP (AGR ?a)))

;; Definition moved to structures.lisp for easier compilation.
;;(defstruct (rule
;;            (:print-function (lambda (p s k)
;;			       (declare (ignore k))
;;                               (Format s "~%<~S~%   ~S ~S>" (rule-lhs p) (rule-id p) (rule-rhs p)))))
;;  lhs id rhs)
	    
;; this copies all the variables in a rule, making sure that identical variables
;;  in different places are replaced by the identical copy
;;  This allows the same rule to be used multiple times in a parse without
;;   running into any variable conflict problems
;;   Any variables specified in the binding list will be replaced by their value
;;    just as they would using the subst-in function


;;  we first make a copy of all vars in the rule, then substitute
;; these new values into the values of the binding list. 
(defun copy-vars-in-rule (rule bndgs)
  (let* ((copied-vars (make-copy-bndgs (rule-var-list rule)))
	 (new-bndgs (make-modified-bndgs bndgs copied-vars))
	 (lhs (if (rule-*-flag rule)
		  (replace-*-in-constit (rule-lhs rule) nil)
		(rule-lhs rule))))
						    
    (make-rule :lhs (subst-in lhs new-bndgs)
	       :id (rule-id rule)
	       :rhs (subst-in (rule-rhs rule) new-bndgs)
	       :var-list (mapcar #'cadr copied-vars)
	       :*-flag (rule-*-flag rule))
    
    ))

;;   MANAGING THE SPECIAL * FEATURE
;;  this replaces any "*" with a new gensym (the same one for all '* in the rule)

(defun replace-*-in-constit (c embedded)
  (if (not embedded) (new-*-needed))
  (make-constit :cat (constit-cat c)
		:feats (mapcar #'(lambda (x)
				   (let ((val (cadr x))
					 (*val (gen-symbol-for-* 'V)))
				     (cond ((eq val '*)
					    (list (car x) *val))
					   ((constit-p val)
					    (list (car x) (replace-*-in-constit (cadr x) t)))
					   ((consp val)
					    (list (car x) (subst *val '* val)))
					   (t x))))
				   (constit-feats c))
		:head (constit-head c)))

(let ((new-gensym-needed t)
      (current-gensym nil))
  (defun new-*-needed ()
    (setq new-gensym-needed t))
  (defun gen-symbol-for-* (char)
    (when new-gensym-needed
      (setq new-gensym-needed nil)
      (setq current-gensym (gen-symbol char)))
    current-gensym)
  ) ;; end scope of NEW-GENSYM-NEEDED

;;  MANAGING VARIABLE BINDINGS

(defun make-copy-bndgs (vars)
  (mapcar #'(lambda (v)
	      (list v (make-var :name (var-name v)
				:values (var-values v)
				:non-empty (var-non-empty v))))
	  vars))

(defun make-modified-bndgs (bndgs copied-vars)
  (add-non-used-vars copied-vars
		     (mapcar #'(lambda (x)
				 (list (car x) (subst-in (cadr x) copied-vars)))
			     bndgs)))

;;  adds in any copied vars that are not in bndgs
(defun add-non-used-vars (vars bndgs)
  (cond ((null vars) bndgs)
	((assoc (caar vars) bndgs) (add-non-used-vars (cdr vars) bndgs))
	(t (cons (car vars) (add-non-used-vars (cdr vars) bndgs)))))
    
  
 
(let ((grammar nil)
      (rule-ids nil)
      (grammar-index (make-hash-table)))
  
  ;; MAKE-GRAMMAR removes the old active grammar and creates a new one
  
  (defun make-grammar (g)
    (setq rule-ids nil)
    (setq grammar nil)
    (setq grammar-index (make-hash-table))
    (if g (augment-grammar g)))
  
  ;;AUGMENT-GRAMMAR adds a new grammar onto the existing active grammar 
  
  (defun augment-grammar (g)
    (let ((internal-format (convert-grammar g)))
      (setq grammar (append grammar internal-format))
      (index-rules internal-format))
    t)

  
  ;; index-rules takes a grammar in the internal format, and records
  ;; its rules in the index so they can be looked up efficiently.

  (defun index-rules (g)
    (if g
	(let ((rule (car g)))
	  (push rule
		(gethash (constit-cat (car (rule-rhs rule)))
			 grammar-index))
	  (index-rules (cdr g)))))
  
  ;; returns some rules from the grammar for which the first constit
  ;; on the rhs *might* be unifiable with constit.  All rules which
  ;; apply are guaranteed to be in the list, but not all rules on the
  ;; list are guaranteed to be applicable.  Further filtering
  ;; (i.e. actually attempting unification) may be necessary.
  (defun lookup-rules (constit)
    (gethash (constit-cat constit)
	     grammar-index))

  (defun getGrammar nil
    grammar)
  
  (defun get-rule-ids nil
    rule-ids)

  (defun verify-rule-id (id)
    (if (not (member id rule-ids))
       (setq rule-ids (cons id rule-ids))))
  
  ) ;; end scope of variable GRAMMAR

;;  CONSTRUCTION OF GRAMMAR FROM INPUT FORMAT

;;   These functions convert a grammar specified in CAT or headfeature
;;   format into internal grammar format

;; CONVERT-GRAMMAR does the actual conversion from the input formats

(defun convert-grammar (g)
  (let ((format (car g))
        (rules (cdr g)))
    (Cond ((eq format 'CAT)
           (merge-lists (mapcar #'build-rule rules)))
          ((eq (car format) 'Headfeatures)
             (mapcar #'(lambda (x)
                         (insertHeadFeatures x (cdr format)))
                      (merge-lists (mapcar #'build-rule rules))))
          (t (parser-Warn "***WARNING*** Bad grammar format") g))))

;;  MERGE-LISTS collapses a list of lists into one list (using append)
   
(defun merge-lists (g)
  (cond ((null g) nil)
        (t (append (car g) (merge-lists (cdr g))))))

;; given a rule component in list form
;; returns type of component (NP, QUAL, etc. ) -Mark
;;
(defun strip_head (element)
  (if (listp element)
      (if (equal (car element) 'head) (caadr element) (car element))
    'ATOM))


;;  BUILD-RULE
;;   inserts the CAT feature for each constituent and builds all the variables.
;;   It also checks the format of the rule.

(defun build-rule (r)
    (init-var-table)
    (if (not (verify-rule-id (cadr r)))
	(parser-warn "~% WARNING: Duplicate rule id, ~S, used in rule~%   ~S~%"
		(cadr r) r))
    (let* ((lhs (car r))
	   (id (cadr r))
	   (third-element (third r))
	   (prob (if (numberp third-element) third-element (get-default-rule-prob)))
	   (rhs (if (numberp third-element) (cdddr r) (cddr r)))
	   (newrule
	    (make-rule :lhs (Verify-and-build-constit lhs r nil)
		       :id id
		       :prob prob
		       :rhs (mapcar #'(lambda (x)
				       (cond ((isvar x) (read-value x r))
					     ((eq (car x) 'head)
					      (if (caddr x) (parser-warn "~%***WARNING*** Bad head specification format in rule ~%~S~%"
								      r))
					      (verify-and-build-constit (cadr x) r t))
					     (t (verify-and-build-constit x r nil))))
				   RHS)
		       :var-list (get-var-list)
		       :*-flag (is-*-present lhs)
		      )))
      (if (GapsDisabled) (list newrule)
	(generate-gap-features-in-rule newrule))))

(defun is-*-present (lhs)
  "Returns T if a * value is found in the specification of the lhs"
  (cond ((eq lhs '*) t)
	((consp lhs)
	 (some #'is-*-present lhs))))

;;  READ-FV-PAIR reads a single feature-value pair and returns its internal format
;;   The feature must either be an atom or a variable
				      

(defun read-fv-pair (fv-pair rule)
    (if (not (and (listp fv-pair) 
                  (eql (list-length fv-pair) 2)))
      (parser-warn "~%***WARNING*** Bad feature-value specification ~s in rule ~s~%"
		   fv-pair rule)
      (let 
	  ((feat (car fv-pair))
	   (val (cadr fv-pair)))
	(list (cond ((isvar feat)
		     (read-value feat rule))
		    ((symbolp feat)
		     feat)
		    (t (parser-warn "~%***WARNING*** Bad feature-value specification ~s in rule ~s~%"
		   fv-pair rule) feat))
	      (read-value val rule)))))

;;  READ-VALUE checks the value to see if it is a variable, or an embedded
;;   constituent.

(defun read-value (val rule)
  (cond ((isvar val)
	 (let* ((var-name (if (atom val)
			      (string-left-trim "?" val)
			    (symbol-name (cadr val))))
		 (var (get-var var-name)))
           (cond (var
		  (if (and (listp val)
			   (cddr val))
		      (if (and (var-values var)
			       (not (equal (var-values var)
					   (cddr val))))
			  (format t "~&Warning: conflicting values given ~
                                  to the same variable ~s in rule ~s~%"
				  var
				  rule)
			(setf (var-values var) (cddr val))))
		  var)
		 (t
		  ;;  if the fist character of the name is "!", then set the non-empty flag
		  (let ((non-empty (if (eq (char var-name 0) #\!) t nil)))
		    
		    (if (atom val)
			(add-var var-name (build-var (gentemp var-name)
						     nil non-empty))
		    (add-var var-name (build-var (gentemp var-name)
						 (cddr val) non-empty))))))))

        ((isembeddedconstit val)
	 (read-embedded-constit val rule))
	((atom val) val)
        ((listp val) (mapcar #'(lambda (x) (read-value x rule)) val))))

;; read-embedded-consitutent
;; this converts a list of form (% cat feat-val-pair*) into a constituent
(defun read-embedded-constit (spec rule)
  (if (and (or (atom (second spec))
	       (isvar (second spec)))
	   (listp (third spec)))
      (if (and (eq (second spec) '-))
	  *empty-constit*
	(make-constit 
	 :cat (read-value (cadr spec) rule)
	 :feats (mapcar #'(lambda (x) (read-fv-pair x rule))
			(cddr spec))))
    (Format t "~%Warning: bad embedded constituent specification found: ~S~%" spec)))
    

;;  This allows variables to be specified in three different forms 
;;           ?X,  (? X), or (? X Val1 ... Valn)

(defun isvar (expr)
  (or (and (symbolp expr)
           (equal (char (symbol-name expr) 0) #\?))
      (and (listp expr)
           (equal (car expr) '?))))

;;  Embedded constituents are of form (% cat feat-val-list)
(defun isembeddedconstit (expr)
  (and (listp expr)
       (equal (car expr) '%)))


;;   VAR-TABLE MAINTENANCE
;;  These functions maintain a binding list of variables. This is used to make sure
;;   that variables in the input get interpret as the same variable structure.

(let ((var-table nil)
      (var-table-stack nil))

  (defun init-var-table nil
    (setq var-table nil))

   (defun get-var (x)
    (cadr (assoc x var-table :test #'equal)))
  
  (defun add-var (name var)
    (setq var-table (cons (list name var)
                          var-table))
    var)
  

  ;; push-var-table and pop-var-table added by Aaron for use in a
  ;; hierarchical lexicon, where each level in the hierarchy can push
  ;; new bindings onto the stack.

  (defun push-var-table ()
    (push var-table var-table-stack))
  
  (defun pop-var-table ()
    (setq var-table (pop var-table-stack)))
  
  (defun get-var-list ()
    (mapcar #'cadr var-table))

  ) ;; end scope of VAR-TABLE



;;  INSERTHEADFEATURES

;; inserts head features into a rule

(defun insertHeadFeatures (rule headfeatList)
  (let* ((mother (rule-lhs rule))
         (headfeats (cdr (assoc (constit-cat mother) headfeatList)))
         (rhs (rule-rhs rule))
         (head (findfirsthead rhs)))
    (cond 
     ;;  If there are no head features, just return the old rule
     ((null headfeats) rule)
     ;;  Otherwise, construct the feature-value pairs for the headfeats and insert them
     (t
      (cond ((null head)
	     (parser-warn "~%****WARNING: No head specified in rule ~s" rule)
	     rule)
	    (t
	     (Insertfeatures rule 
			     (mapcar #'(lambda (hf)
					 (BuildHeadFeat hf mother head rule))
				     headfeats))))))))

             
;;  BUILDHEADFEAT builds a feature/value pair to insert in the mother and head
;;  We must check both the mother and head to see if these features already are
;;  defined
(defun BuildHeadFeat (headfeat mother head rule)
  (let ((mval (get-value mother headfeat))
        (hval (get-value head headfeat))
        (varname (gen-symbol headfeat)))
    (cond ((and (null mval) (null hval))
           (list headfeat (make-var :name varname)))
          ((null mval)
           (list headfeat hval))
	  ((or (null hval)
	       (equal mval hval))
           (list headfeat mval))
	  (t (parser-warn "~%***WARNING*** Head feature ~s incompatible ~%   in rule ~s"
                     headfeat rule)))))

(defun findFirstHead (rhs)
  (cond ((null rhs) nil)
        ((constit-head (car rhs)) (car rhs))
        (t (findFirstHead (cdr rhs)))))

;;INSERTFEATURES builds the rule, inserts the feature-value pairs (values)
;;   into the mother and any consituent on the rhs marked as a head.

(defun insertfeatures (rule values)
  (let ((newvars (remove-nils (mapcar #'(lambda (x)
			     (let ((val (cadr x)))
			       (if (var-p val) val)))
			 values)))
	(mother (rule-lhs rule)))
   
    (make-rule :lhs (build-constit (constit-cat mother)
                                   (mergefeatures (constit-feats mother) values) nil)
               :id (rule-id rule)
               :rhs (mapcar #'(lambda (c)
				(if (constit-p c)
				    (if (constit-head c)
		 			(build-constit (constit-cat c)
						       (mergefeatures (constit-feats c) values)
						       t)
				      c)
				  c))
                            (rule-rhs rule))
	       :prob (rule-prob rule)
	       :var-list (union (rule-var-list rule) newvars)
	       :*-flag (rule-*-flag rule))
    ))

(defun remove-nils (ll)
  (cond ((null ll) nil)
	((null (car ll)) (remove-nils (cdr ll)))
	(t (cons (car ll) (remove-nils (cdr ll))))))

;; MERGEFEATURES adds the feature-value pairs in feats to the constit,
;; It assumes that the feature value in newfeats is the one desired if
;; both present

(defun mergefeatures (oldfeats newfeats &optional results)
  (if (null oldfeats)
      (append results newfeats)
    (let* ((oldpair (car oldfeats))
	   (feat (car oldpair))
	   (newpair (assoc feat newfeats))
	   (pair (if newpair newpair (car oldfeats))))
      (mergefeatures (cdr oldfeats)
		     (removefeature feat newfeats)
		     (cons pair results)))))


;; REMOVEFEATURE returns a copy of a feature list with the feature named fname removed

(defun removefeature (fname flist)
 (remove-if #'(lambda (y) (eq fname (car y))) flist))

;;  GEN-SYMBOL generates a unique identifier to identify a constituent

(defun gen-symbol (name)
  (gentemp (string name)))

;;***************************************************************************
;;
;;   USER ACCESS TO THE GRAMMAR

(defun get-grammar ()
  (getGrammar))

(defun show-grammar (&rest ruleids)
  (if ruleids
    (mapcar #'%print (remove-if-not #'(lambda (rule)
                                        (member (rule-id rule) ruleids))
                                    (getGrammar)))
    ;;  otherwise print all the rules
    (mapcar #'%print (getGrammar)))
  (values))


(defun %print (obj)
  (Format t "~%~S" obj)
)
         
;;  KEYWORDS

(defvar *keyword-package* (find-package 'keyword))

(defun keywordify (item)
  (if (symbolp item) (intern (string item) *keyword-package*)))

(defun keywordifyList (items)
  (cond ((and (symbolp items) (not (member items '(NIL T))))
         (keywordify items))
	((listp items)
	 (mapcar #'keywordifyList items))
	((var-p items)
	 (let* ((vals (var-values items))
	       (ll (length vals)))
	   (cond
	    ((> ll 1)
	     (cons :OR (keywordifyList vals)))
	    ((= ll 1) (car vals))
	    (t vals))))
	(t items)))


;;  GRAMMAR SPECIFIC FEATURES

(defun classify-n (n)
  ;;  classifies numbers in ranges for clock times, etc.
  (cond ((<= n 9) '(digit hour12 month day))
	((<= n 12) '(hour12 minute month day))
	((<= n 23) '(hour24 minute day))
	((<= n 31) '(minute day))
	((<= n 60) '(minute))
	((and (> n 1600) (< n 200)) '(year))))
