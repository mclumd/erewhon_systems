(in-package parser)

;; SUBST-IN FUNCTION
;;  Given a list of bindings, instantiates the variables in the expression
;;  This is used to instantiate constituents and rules.

(defun subst-in-list (x bndgs)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (mapcar #'(lambda (y) 
              (subst-in y bndgs))
          x))

(defun subst-in (x bndgs)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (cond
   ((or (symbolp x)
        (numberp x))
    x)
   ((or (null bndgs)
        ;;         (equal bndgs '((nil nil)))
        (and (consp bndgs)
             (consp (car bndgs))
             (endp (cdr bndgs))
             (null (caar bndgs))
             (null (cadar bndgs))
             (endp (cddar bndgs))))     ; speed
    x)
   ((consp x)
    (subst-in-list x bndgs))
   ((var-p x)
    (or (get-most-specific-binding x bndgs)
        x))
   ((constit-p x)
    (make-constit :cat (subst-in (constit-cat x) bndgs)
                  :feats (subst-in (constit-feats x) bndgs)
                  :head (constit-head x)))
   ((entry-p x)
    (make-entry :constit (subst-in (entry-constit x) bndgs)
                :start (entry-start x)
                :end (entry-end x)
                :rhs (entry-rhs x)
                :name (entry-name x)
                :rule-id (entry-rule-id x)
                :prob (entry-prob x)))
   (t 
    x)))

;; Matches two constituents and returns the binding list if they can
;; be unified.  The first constituent must be a pattern from a rule,
;; and the second must be an actual constituent from the chart.
(defun constit-match (pattern constit)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (fix-bindings 
  (if (and (constit-p pattern) (constit-p constit))
      (let ((bndgs (match-vals 'cat
			       (constit-cat pattern)
			       (constit-cat constit))))
	(if bndgs
	    (let ((result (fconstit-match
			   (subst-in (constit-feats pattern) bndgs)
			   (subst-in (constit-feats constit) bndgs))))
	      (if result
		  (if (equal bndgs *success*)
		      result
		    (append bndgs result)))))))))

;;  this substitutes var bindings into values to ground out 
;;   the bindings as much as possible
(defun fix-bindings (bndgs)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (mapcar #'(lambda (bndg)
	      (list (car bndg)
		    (subst-in (cadr bndg) bndgs)))
	  bndgs))
  


;; Matches two values and returns the binding list if they can be
;; unified.  The first value must come from a pattern in a rule, and
;; the second must be taken from an actual constituent on the chart.
(defun match-vals (feat patternval constitval)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (if (null constitval) (setq constitval '-))     ;; Use - as the default

  (cond ((and (symbolp constitval)
	      (symbolp patternval)
	      (compat feat constitval patternval))
	 *success*)
	
	((eq constitval patternval) *success*) ;; added this to handle numbers

	;; if one or both of the values are variables, and the two
	;; values can be unified, then return the bindings necessary
	;; for the unification.  Note that bindings for constitval are
	;; not used during parsing, but are used during generation.
	((var-p constitval)

	 ;; if both arguments are the same variable, no bindings
	 ;; necessary.
	 (if (eq constitval patternval)
	     *success*
	   (if (and (var-non-empty constitval) 
		    (member patternval (list '- *empty-constit*)))
	       nil
	     (let ((intersection (feature-intersect feat
						    constitval
						    patternval)))
	       (if intersection
		   (append (if (not (equal constitval intersection))
			       (list (list constitval intersection)))
			   (if (and (var-p patternval)
				    (not (equal patternval intersection)))
			       (list (list patternval intersection)))))))))

	((var-p patternval) ;; patternval is a var and constitval isn't
	 ;; if var has non-empty restriction and val is -', then fail
	 (if (and (var-non-empty patternval) 
		  (member constitval (list '- *empty-constit*)))
	     nil
	   (let ((intersection (feature-intersect feat
						  patternval
						  constitval)))
	     (if (and intersection
		      (not (equal patternval intersection)))
		 (list (list patternval intersection))))))
              
	;;  matching two lists
	((and (listp patternval) (listp constitval))
	 (match-lists feat patternval constitval))

	;;  recursive matching of two values that are constituents
	((and (constit-p patternval) (constit-p constitval))
	 (constit-match patternval constitval))))


(defun Make-New-BU-Active-Arcs (entry name)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  ;; if *optimize*
       (let ((c (entry-constit entry))
        (start (entry-start entry))
        (end (entry-end entry)))
    (mapcar #'(lambda (x)
                (let ((bndgs (Constit-Match (car (rule-rhs x)) C)))
                  (if bndgs
                    (Opt-make-arc-from-rule x entry name start end bndgs))))
            (lookup-rules c))))

(defun Opt-make-arc-from-rule (rule entry name start end bndgs)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
    ;;  Add arc or new entry to agenda depending on whether arc is completed or not
    (If (> (length (rule-rhs rule)) 1) 
	 (extend-arc-with-constit
		       entry 
		       name
		       (make-arc-from-rule rule
					   (entry-start entry) bndgs)
		       bndgs)
	 ;;   rule contains only one constit on RHS - just build new constit
	 (let* ((copyrule (copy-vars-in-rule rule bndgs))
		(id (rule-id copyrule))
		(rhs (rule-rhs copyrule))
		(foot-feats (augment-foot-feats entry (car (rule-rhs rule)) nil))
		(mother (merge-feature-values (rule-lhs copyrule) (cons (list 1 name) foot-feats)))
		(constit (entry-constit entry))
		(prob (* (get-rule-prob rule start) (entry-prob entry))))
   	   (Add-to-agenda (build-entry mother start end rhs id prob)))))

;; FEATURE-INTERSECT - Takes a variable and an arg (val) that is a value,
;;      simple variable or constrained variable
;;  returns the intersection in the cases where
;;     val is an expression and is in the list of values, then the answer is val
;;     val is an unconstrained variable, then the answer is the var
;;     val is a constrained variable, then the answer is a variable constrained
;;     to the intersection between its possible values and the values of the var
;;
;; Unlike for the above functions, it doesn't matter which argument is
;; from the chart and which is from a rule pattern.
(defun feature-intersect (feat var val)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (let* ((value-list (var-values var))
	(ans (cond 

	      ;; If value-list is nil, the var is unconstrained.
	      ;;   Succeed unless var occurs in val
	      ((null value-list) (if (occurs-in var val) nil val))

	      ;;  If val is in the value-list, then it is the answer
	      ((and (not (var-p val))
		    (member-match feat val value-list))
	       val)

	      ;; otherwise, compute the intersection
	      ((var-p val)
	       (let* ((other-values (var-values val))
		      (int-values (intersection-match feat value-list other-values)))
		 (cond 
		  ;;  If other-values was nil, the val was an unconstrained variable
		  ((null other-values) var)
		  ;;  If int-values is null, then the match failed
		  ((null int-values) nil)
		  ;;   If int-values consist of one element, return as an atom
		  ((endp (cdr int-values)) (car int-values))
		  ;;  else return int-values as the answer
		  (t (build-var (var-name var) int-values))))))))
    (if (and (listp ans) (eq (length ans) 1))
	(setq ans (car ans)))
    ans))


(defun verify-and-build-constit (constit rule head)
  (let* ((temp (car constit))
	 (cat (if (atom temp) temp
		 (read-value temp rule)))) ;;  handles vars as CAT
    (if (and (not (symbolp cat)) (not (var-p cat)))
	(parser-warn "~%***WARNING*** Constituent category must be an atom or variable. Bad constituent ~s~%     in rule ~s~%"
		constit rule))
    (let ((feats (mapcar #'(lambda (x) (read-fv-pair x rule))
			     (cdr constit))))
      (build-constit cat feats head))))
 


(defun member-match (feat val vlist)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (let (ans)
    (cond ((null vlist) nil)
	  ((equal val (car vlist))
	   val)
	  ((setq ans (compat feat val (car vlist)))
	   ans)
	  (t
	   (member-match feat val (cdr vlist))))))


(defun intersection-match (feat vlist1 vlist2)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (let ((ans))
    (cond ((null vlist1) nil)
          ((setq ans (compat-match feat (car vlist1) vlist2))
           (cons ans (intersection-match feat (cdr vlist1) vlist2)))
          ((intersection-match feat (cdr vlist1) vlist2)))))

(defun compat-match (feat val vlist)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (let ((ans))
    (cond ((null vlist) nil)
        ((eq val (car vlist)) val)
        ((setq ans (compat feat val (car vlist))) ans)
        (t (member-match feat val (cdr vlist))))))

;;  This function  returns the the more specific value is v1 is a subtype of v2
;;     or v2 is a subtype of v1

(defun compat (feat v1 v2)
   (declare (optimize (speed 3) (safety 0) (debug 0)))
  (cond ((eq v1 v2) v1)
        ((subtype feat v1 v2) v1)
        ((subtype feat v2 v1) v2)))
