(in-package parser)

;;   This file contains the functions that manage the features in constituents,
;;   primarily constituent matching and unification

;; (defconstant *success* '((NIL NIL))) ;; moved to structures.lisp

;;============================================================================
;;   MANAGING CONSTITUENTS

;;   A constituent is represented as a list of form 
;;        ((<feature> <value>) ... (<feature> <value>))
;;   where a <value> may be
;;       an atom
;;       a variable
;;       a constrained variable, restricted to one of a list of values

;;  FOOT Features

(let ((footFeatures nil))
  (defun define-foot-feature (f)
    (setq footFeatures (cons f footFeatures)))
  
  (defun get-foot-features nil
    footFeatures)
  
  (defun init-foot-features nil
    (setq footFeatures nil)))


;; Make a constituent of the indicated category with the indicated features

(defun Build-constit (cat feats head)
  (make-constit :cat cat :feats feats
		    :head head))
   


;; Add a new feature-value pair to an existing constituent
;; DESTRUCTIVELY Add a new feature-value pair to an existing constituent

(defun add-feature-value (constit feat val)
  (setf (constit-feats constit)
              (cons (list feat val) (constit-feats constit)))
        constit)


;;   add a set of features into a constit, unless they are there already

(defun Merge-feature-values (constit fvlist)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (if (null fvlist) constit
    (let ((newfvlist nil)
	  (failure-flag nil)
	  (bndgs nil))
      (mapcar #'(lambda (x)
		  (let* ((newbndgs nil)
			 (feat (car x))
			 (newval (cadr x))
			 (oldval (get-value constit feat)))
		    (cond ((null oldval) ;;(eq oldval '-)
			   (setq newfvlist (cons x newfvlist)))
			  ;;  Otherwise, see if values match. If so, either update binding
			  ;;  list and add new value unless oldval was a constant
			  ((setq newbndgs (match-vals feat oldval newval))
			   (setq bndgs (append newbndgs bndgs))
			   (if (not (var-p newval)) (setq newfvlist (cons x newfvlist))))
			  ((not (same-value newval oldval))
			   (setq failure-flag t)))))
			  ;;(parser-warn "Inconsistent foot feature in constit ~S. Features are ~S" constit fvlist)
	      fvlist)
      (if (not failure-flag)
	  (values-list 
	   (list (build-constit (constit-cat constit) 
			 (append (constit-feats constit) newfvlist)
			 (constit-head constit))
		 bndgs))))))

(defun same-value (x y)
  (or (equal x y)
      (and (constit-p x) (constit-p y)
	   (fconstit-match (constit-feats x) (constit-feats y)))))

;; Modified by AK to work on cat feature.
(defun replace-feature-value (constit feat val)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (if (eq feat 'cat)
      (build-constit val
		     (constit-feats constit)
		     (constit-head constit))
    (if (null (get-fvalue (constit-feats constit) feat))
	(add-feature-value constit feat val)
      (build-constit (constit-cat constit)
		     (replace-feat (constit-feats constit) feat val)
		     (constit-head constit)))))

(defun replace-feat (feats feat val)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (cond ((null feats) (list (list feat val)))
        ((eq (caar feats) feat) (cons (list feat val) (cdr feats)))
        (t (cons (car feats) (replace-feat (cdr feats) feat val)))))

;;  Get the value of a specific feature from a constituent

(defun get-value (constit feature)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (if (eq feature 'cat)
    (constit-cat constit)
    (get-fvalue (constit-feats constit) feature)))

; This gets the value from a feature-value list
(defun get-fvalue (featlist feature)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
    (cadr (assoc feature featlist)))

;;===========================================
;;  VARIABLES

;; Check if an expression is a variable

;; Definition moved to structures.lisp for easier compilation.
;;(defstruct (var
;;            (:print-function 
;;             (lambda (p s k)
;;	       (declare (ignore k))
;;               (if (null (var-values p))
;;                 (Format s "?~S" (var-name p))
;;                 (Format s "?~s:~S" (var-name p) (var-values p))))))
;;  name values non-empty)

;; Construct a new variable with the indicated name, and possible values

(defun build-var (name values &optional non-empty)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (make-var :name name :values values :non-empty non-empty))

;;==================================================================================
;; CONSTITUENT MATCHING
;; Rules are specified using constituent patterns, (i.e., constituents with
;;  variable in them. The principle operation is matching a constituent pattern 
;;  from a rule with a constituent. The match returns a list of variable bindings
;;  that will make the pattern have identical features (or a subset of features) 
;;  as the constituent.
;;  Bindings are a list of the form ((<var> <value>) ... (<var> <value>)).
;; A binding list always ends with the entry (NIL NIL). This way you can tell
;;  if the match succeeded. A succesful match requiring no bindings will
;;  return (NIL NIL), where as a failure will return NIL.


;;  FCONSTIT-MATCH matches the two feature lists

(defun fconstit-match (fpattern fconstit)
  ;;(declare (optimize (speed 3) (safety 0) (debug 0)))
 (if (null fpattern) *success*
  (let* ((feat (caar fpattern))
         (val (cadar fpattern))
         (cval (get-fvalue fconstit feat))
         (bndgs (match-vals feat val cval)))
     (if bndgs
      (let ((result
             (fconstit-match (subst-in (cdr fpattern) bndgs)
                        (subst-in fconstit bndgs))))
        (if result 
          (if (equal bndgs *success*) result
              (append bndgs result))))))))


;;   recursively matches each element down the list, substituting for
;;    variables as it goes

(defun match-lists (feat val cval)
  (declare (optimize (speed 2) (safety 0) (debug 0)))
  (cond
   ((and (null val)
         (null cval))
    *success*)
   ((null val)
    nil)
   (t
    (let* ((bndgs (match-vals feat (car val) (car cval)))
           (bndgs2 (if bndgs
		       (match-lists feat
                                (subst-in (cdr val) bndgs) 
                                (subst-in (cdr cval) bndgs)))))
      (cond
       ((equal bndgs2 *success*) 
        bndgs)
       (t
        (append bndgs bndgs2)))))))
            
  
(defun single-value (x)
  (or (atom x) (endp (cdr x))))

;; This return t if the var is in the val. Matching in such cases should fail
(defun occurs-in (var val)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (if (listp val)
    (cond ((null val) nil)
          ((member var val) (Verbose-msg2 "~%OCCURS CHECK ELIMINATES ~S and ~S match~%" var val) t)
          (t (some #'(lambda (x) (occurs-in var x)) val)))
    nil))
  
(defun get-most-specific-binding (var bndgs)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (let ((val (cadr (assoc var bndgs))))
    (if val
      (if (var-p val)
        ;; if its a var, then see if that var is bound
        (let ((val2 (get-most-specific-binding val bndgs)))
          (if val2 val2 val))
        ;; otherwise, it might contain vars that need binding
        (subst-in val bndgs)))))

;;*************************************************************************************                 
;;*************************************************************************************                 
    
    
;;  MANAGING THE GAP FEATURE

(let ((gapsEnabledFlag nil)
      (gap-cats '(NP))
      (gap-feat-lists '((NP AGR SEM CASE))))
                
  (defun gapsDisabled nil
    (not gapsEnabledFlag))

  (defun gapsEnabled nil
    gapsEnabledFlag)

  (defun disableGaps nil
    (setq gapsEnabledFlag nil))

  (defun enableGaps nil
    (setq gapsEnabledFlag t))

  (defun declare-gap-cat (cat feats)
    (if (not (member cat gap-cats))
      (setq gap-cats (cons cat gap-cats)))
    (setq gap-feat-lists
          (cons (cons cat feats)
                (remove-if #'(lambda (x) (eq (car x) cat)) gap-feat-lists)))
    )

  (defun reset-gap-cats nil
    (setq gap-cats nil)
    (setq gap-feat-lists nil))

  (defun get-gap-cats nil
    gap-cats)

  
(defun get-gap-feat-list (cat)
    (cdr (assoc cat gap-feat-lists)))

)  ;; end scope of gapsEnabledFlag

;;********************************************************************************
;;   CODE TO INSERT GAP FEATURES INTO GRAMMAR
;;

;;  This is the main function. It generates the GAP features into the rules as described
;;   in Chapter 5. It returns a list of modified rules, since there may be more than
;;   one gap rule generated from a single original rule.

(defun generate-gap-features-in-rule (rule)
  (if 
    ;; If the rule explicitly sets the GAP feature, then it is left alone
    ;; Rules with lexical lhs also do not have gap features
    (or (gap-defined-already rule)
        (lexicalConstit (rule-lhs rule)))
    (list rule)
    ;; Otherwise, break up the rule and analyse it
    (let* ((rhs (rule-rhs rule))
           (head (findfirsthead rhs))
           (numbNonLex (count-if #'nonLexicalConstit  rhs)))
      (cond
       ;; If no nonlexical subconsitutents, then no GAP possible
       ((<= numbNonLex 0) (list (make-rule :lhs (add-feature-value (rule-lhs rule) 'GAP '-)
					   :id (rule-id rule)
					   :rhs (rule-rhs rule)
					   :prob (rule-prob rule)
					   :var-list (rule-var-list rule)
					   :*-flag (rule-*-flag rule))))

       ;;  If head is a lexical category, propagate GAP to each non-lexical subconstituent
       ((or (null head)
	    (lexicalConstit head))
        (gen-rule-each-NonLex rule numbNonLex))

       ;;  If non-lexical head, set up GAP as a head feature
       (t (let ((var (make-var :name (gen-symbol 'g))))
            (list (make-rule :lhs (add-feature-value (rule-lhs rule) 'GAP var)
                             :id (rule-id rule)
                             :rhs (add-gap-to-heads rhs var)
			     :prob (rule-prob rule)
			     :var-list (rule-var-list rule)
			     :*-flag (rule-*-flag rule)))
			     ))))))

;; This returns true if the rule already specifies the GAP feature

(defun gap-defined-already (rule)
  (cond ((get-value (rule-lhs rule) 'gap) t)
        (t (find-gap-in-rhs (rule-rhs rule)))))

(defun find-gap-in-rhs (rhs)
  (cond ((null rhs) nil)
        ((get-value (car rhs) 'gap) t)
        (t (find-gap-in-rhs (cdr rhs)))))

;;  This adds the gap to every head subconstituent marked as a head

(defun add-gap-to-heads (rhs val)
  (if (null rhs) nil
      (let ((firstc (car rhs)))
        (if (constit-head firstc)
          (cons (add-feature-value firstc 'GAP val)
                (add-gap-to-heads (cdr rhs) val))
          (cons (add-feature-value firstc 'GAP '-) 
                (add-gap-to-heads (cdr rhs) val))))))


;; This generates a new rule for each non-lexical subconstituent
;;   n is the number of non-lexical subconstituents

(defun gen-rule-each-NonLex (rule n)
  (let ((var (make-var :name (gen-symbol 'g))))
    (if (<= n 0) nil
      (cons 
       (make-rule :lhs (add-feature-value (rule-lhs rule) 'GAP var)
		  :id (rule-id rule) 
		  :rhs (insert-gap-features var n (rule-rhs rule))
		  :prob (rule-prob rule)
		  :var-list (rule-var-list rule)
		  :*-flag (rule-*-flag rule))
       (gen-rule-each-NonLex rule (- n 1))))))
      

          
;;  inserts the GAP var in the n'th non-lexical consituent, and - in the others

(defun insert-gap-features (val n rhs)
  (if (null rhs) nil
    (mapcar #'(lambda (c)
                  (cond ((not (lexicalConstit c))
                         (setq n (1- n))
                         (if (= n 0)
                          (add-feature-value c 'GAP val)
                          (add-feature-value c 'GAP '-)))
                        (t c)))
              rhs)))
  
;;*****************************************************************************************
;;  FUNCTIONS USED BY THE PARSER

(defun generate-gaps (arc)
  ;;  Check here if rule might accept an empty consituent 
  ;;     (i.e., non-null GAP or PASSGAP feature of right type)
  ;;    if so, generate the gap
  (let* ((next (car (arc-post arc)))
         (nextcat (constit-cat next))
         (gapvalue (get-value next 'gap)))
    (if (and (not (eq gapvalue '-))
             (not (null gapvalue))
             (member nextcat (get-gap-cats)))
      (insert-gap gapvalue next nextcat arc))))
    
;; This checks to see if the GAP value of the next consituent could be satisfied
;;    the the next constituent. If so, it extends the arc appropriately

(defun insert-gap (gapvalue next nextcat arc)
  ;;  There are two cases where we insert a gap:
  ;;   Case 1: the GAP feature is a constituent that matches the next constit,
  ;;   Case 2: the GAP feature is a variable and the cat of next is NOT the same as the 
  ;;           cat of the mother, since that would create a constituent of form X/X
  (let ((gap
         (if (constit-p gapvalue)
           (if (constit-match gapvalue next) 
             (make-gap-entry gapvalue arc))
           (if (and (var-p gapvalue)
                    (not (eq (constit-cat (arc-mother arc)) nextcat)))
               (make-gap-entry next arc)))))
    (when gap
      (Add-to-agenda gap)
      (verbose-msg2 "Inserting ~S at position ~S to fill a gap~%" gap (arc-end arc))))
  )

;; Takes a constituent as a template an generates a GAP constituent that
;;  would satisfy it. The value of the GAP feature is a copy of the constituent
    
(defun make-gap-entry (constit arc)
  (let* ((cat (constit-cat constit))
        (feats (gen-feats-for-gap cat (constit-feats constit))))
    (make-entry :constit (make-constit 
                          :cat cat
                          ;;  set GAP feature, add +EMPTY
                          :feats (cons '(empty +)
                                     (cons (list 'gap (make-constit :cat cat :feats feats))
                                         feats)))
                :start (arc-end arc) 
                :end (arc-end arc) 
                :rhs nil
                :name (gen-symbol 'GAP)
                :rule-id (if (eq (constit-cat constit) 'NP) 'NP-GAP-INTRO 'GAP-INTRO)
                :prob 1)))
              
;;  Remove GAP feature, and add all features in GAP-FEAT-LIST
;;  that are not currently defined

(defun gen-feats-for-gap (cat feats)
  (let ((feats (remove-if #'(lambda (x) (eq (car x) 'gap)) feats)))
    (mapcar #'(lambda (f)
                (if (not (get-fvalue feats f))
                  (setq feats (cons (list f (make-var :name (gen-symbol f)))
                                    feats))))
            (get-gap-feat-list cat))
    feats))


         
;; *****************************************************************************************
;; ****************************************************************************************
;;    HANDLING THE SEM FEATURE

(let ((semEnableFlag nil))
  (defun semEnabled nil
    semEnableFlag)
  (defun noSemEnabled nil
    (not semEnableFlag))
  (defun enableSem nil
    (setq semEnableFlag t))
  (defun disableSem nil
    (setq semEnableFlag nil)))

;;  MAKE-ENTRY-WITH-SEM makes one pass at simplifying lambda expressions
;;   each time a consituent is constructed. Note this would not guarantee 
;;   that each constit has the most simplified form. But works well for simple
;;    examples and is correct in any case since simplification is not logically necessary!

(defun make-entry-with-sem (constit start end rhs name rule-id prob)
    (make-entry :constit (sem-simplify constit) 
                :start start :end end :rhs rhs :name name :rule-id rule-id :prob prob))

(defun sem-simplify (constit)
  (let* ((sem (get-value constit 'sem))
        (newsem (simplify-lambda sem)))
    (if (equal sem newsem)
      constit
      (make-constit :cat (constit-cat constit)
                    :feats (subst newsem sem (constit-feats constit))
                    :head (constit-head constit)))))

;; Simplify lambda expressions
(defun simplify-lambda (expr)
  (cond ((atom expr) expr)
        ((and (listp (car expr))
              (eq (caar expr) 'lambda)
              (cadr expr))
         (simplify-lambda (subst (cadr expr) (cadar expr) (caddar expr))))
        (t (mapcar #'simplify-lambda expr))))

;; If semantic interpretation is enabled, a discourse variable must be
;;     created for the VAR feature
(defun instantiateVAR (constit)
  (if (semEnabled)
    (subst-in constit (list (list (get-value constit 'VAR) (gen-symbol 'V))))
    constit))
