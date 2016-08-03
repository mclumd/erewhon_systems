(in-package parser)

;;
;; attachments .lisp
;;
;; Time-stamp: <96/10/23 19:10:52 james>
;;
;;
;; This file contains functions that are semantically attached to rules in the grammar
;;

;; Evaluating the whole buffer reintializes and recreates attachments.
;; Very handy for FI C-c C-b .

(eval-when (:load-toplevel :eval)
  (init-attachments)) 

  
(let ((current-ldc nil))

  (defun reset-current-ldc ()
    (setq current-ldc (make-ldc)))
  
  ;;  used when backing up - remove all entries with end
  ;;    position after n
  (defun Clear-CurrentLDC-after (n)
    (setf (ldc-paths-mentioned current-ldc) 
      (Remove-entries-after (ldc-paths-mentioned current-ldc) n))
    (setf (ldc-focus current-ldc)
       (Remove-entries-after (ldc-focus current-ldc) n))
    (setf (ldc-sa-mentioned current-ldc) 
      (Remove-entries-after (ldc-sa-mentioned current-ldc) n))
    (setf (ldc-sa-flags current-ldc) 
      (Remove-entries-after (ldc-sa-flags current-ldc) n))
    (setf (ldc-actions-mentioned current-ldc) 
      (Remove-entries-after (ldc-actions-mentioned current-ldc) n))
    (setf (ldc-unknown-words current-ldc) 
      (Remove-entries-after (ldc-unknown-words current-ldc) n))
  
    (setf (ldc-objects-mentioned current-ldc) 
      (Remove-entries-after (ldc-objects-mentioned current-ldc) n)))
  
  (defun Remove-entries-after (entries n)
    (remove-if #'(lambda (x) 
		   (> (indexedObject-end x) n))
	       entries))
  
  (defun get-objects-mentioned ()
    (ldc-objects-mentioned current-ldc))
  
  (defun get-paths-mentioned ()
    (ldc-paths-mentioned current-ldc))
  
  (defun get-focus ()
    (ldc-focus current-ldc))
  
  (defun get-sa-mentioned ()
    (ldc-sa-mentioned current-ldc))
  
  (defun get-sa-flags ()
    (ldc-sa-flags current-ldc))
  
  (defun get-actions-mentioned ()
    (ldc-actions-mentioned current-ldc))

  (defun get-unknown-words ()
    (ldc-unknown-words current-ldc))
  
   (defun add-to-unknown-words (word start end)
     (setf (ldc-unknown-words current-ldc)
       (cons (make-indexedObject :object word :start start :end end)
	     (ldc-unknown-words current-ldc))))
   
  ;;---------------
  ;;  FOCUS
  ;; 
  (defun add-to-focus-candidates (object start end)
     (setf (ldc-focus current-ldc)
       (AddToIndexedList object (ldc-focus current-ldc) start end)))
  
  ;;----------------
  ;; PATHS
  ;; Adds a new path to the path focus, removing all those that it
  ;;   subsumes (determined by start and end position)
  ;; note: this must return the entry if it is to be added to the chart
  
  (defun add-to-paths-mentioned (path entry start end)
    (when (not
	   (SubsumedBy (ldc-objects-mentioned current-ldc) start end)) 
      (setf (ldc-paths-mentioned current-ldc)
	(AddToIndexedList path
			  (ldc-paths-mentioned current-ldc) start end)))
    entry)
  
  ;;----------------
  ;; OBJECTS MENTIONED
  
  (defun add-to-objects-mentioned (descr start end)
    (if (constit-p descr)
	(let nil
	  (setf (ldc-objects-mentioned current-ldc)
	    (AddNPToIndexedList descr
				(ldc-objects-mentioned current-ldc) start end))
	  ;; if the object description used a PP modifier that would have
	  ;; been interpreted as a path, that should be deleted as well
	  (setf (ldc-paths-mentioned current-ldc)
	    (removeSubConstits (ldc-paths-mentioned current-ldc) start end)))
      (parser-warn "~%Bad description found: ~S~%" descr)))
  
  ;;----------------
  ;; SPEECH ACTS
  
  (defun add-to-sa-mentioned (sa start end)
    (setf (ldc-sa-mentioned current-ldc)
      (addToIndexedList sa (ldc-sa-mentioned current-ldc) start end)))
  
  (defun add-to-sa-flags (e start end)
    (pushnew (make-indexedObject :object e :start start :end end)
	     (ldc-sa-flags current-ldc)))
  
  ;;----------------
  ;; ACTION-FOCUS
    
  (defun add-to-action-mentioned (act start end)
    (setf (ldc-actions-mentioned current-ldc)
      (AddNPToIndexedList act 
			  (ldc-actions-mentioned current-ldc) start end)))
	  
)   ;; end scope of History List and Current Local Discourse State.




;;================
;;   TRAPPING NPS

(defun npfound (e)
  (trace-msg "-NP found: ~S~%" e)
  (let ((start   (entry-start e))
	(end     (entry-end e))
	(sort (getFvalue e 'SORT))
	(lf (simplify-Description (getFvalue e 'LF))))
    (when (wh-query e)
      ;; (add-to-sa-flags 'WH-QUESTION  start end)
      (add-to-focus-candidates (getFvalue e 'VAR) start end))
 
    (when (eq sort 'DESCR)
      (add-to-objects-mentioned lf start end))
    (setFvalue e 'LF lf)
      )
  e)

(announce '(np (gap -)) #'npfound)
(announce '(np-pp-word) #'npfound)

(defun definite (x)
  (member x '(THE THIS THAT)))

(defun wh-query (e)
  (eq (getFvalue e 'WH) 'Q))

;;--------
;; This simplifies DESCRIPTIONS:
;;    transforming the SORT feature 
;;    and flattening the CONSTRAINT feature

(defun simplify-Description (descr)
  (if (and (constit-p descr)
	   (eq (get-value descr 'cat) 'DESCRIPTION))
      (let* 
	  ((feats (constit-feats descr))
	   (constraint (simplifyConstraint (get-fvalue feats 'constraint)))
	   (set-constraint (simplifyConstraint (get-fvalue feats 'set-constraint)))
	   (sort (transform-sort (get-fvalue feats 'sort))))
	 
	
	(case sort
	  ((Individual Stuff Quantity) 
	   (let ((newfeats (remove-if #'(lambda (x)
					  (member (car x) '(SORT CONSTRAINT SET-CONSTRAINT)))
				      feats))
		 (newconstraint (merge-constraints constraint set-constraint)))
	     (make-constit :cat 'DESCRIPTION
			   :feats   (if newconstraint
					(append newfeats
						(list (list 'SORT sort)
						      (list 'CONSTRAINT newconstraint)))
				      (append newfeats (list (list 'SORT sort)))))))
	  (Set
	   (let* ((var (get-fvalue feats 'var))
		 (newvar  (gen-symbol 'elem))
		 (newfeats (remove-if #'(lambda (x)
					  (member (car x) '(SORT CLASS CONSTRAINT SET-CONSTRAINT))) feats))
		  (newconstraint (if (listp constraint)
				     (substitute newvar var constraint)))
		 (newclass `(PRED
			    	(ARG ,newvar)
			       	(CLASS ,(get-fvalue feats 'class)))))
	     ;;   add constraint slot only if filled
	     (if newconstraint
		 (setq newclass 
		   (append newclass (list (list 'CONSTRAINT newconstraint)))))
				
	 
	     (make-constit :cat 'DESCRIPTION
			   :feats (if set-constraint
				      (append newfeats
					  (list (list 'SORT sort)
						(list 'CLASS newclass)
						(list 'CONSTRAINT set-constraint)))
				    (append  newfeats
					  (list (list 'SORT sort)
						(list 'CLASS newclass))))))))
	  
	 )
	   
    descr))

(defun transform-sort (sort)
  (if (listp sort)
      (let ((number (identify-number (car sort)))
	    (mass (cadr sort)))
	(if (eq number 'SING)
	    (if (eq MASS '+) 'Stuff 'Individual)
	  (if (eq MASS '+) 'Quantity 'Set)))
    (if (member sort '(Individual Set Stuff Quantity))
	sort
      (let nil
	(parser-warn "~%Warning: Bad SORT in transform-sort: ~S" sort)
	'Individual))))

(defun identify-number (x)
  (cond
   ((member x '(1s 2s 3s)) 'SING)
   ((member x '(1p 2p 3p)) 'PLUR)
   ((or (eq x '-) (var-p x)) 'SING) ;; SING is the default
   (t (parser-warn "~% Bad number feature found in description: ~S" x)
      'SING)))

(defun merge-constraints (c1 c2)
  ;;  puts two constraints together
  (cond ((eq c1 '-) (if (eq c2 '-) nil c2))
	((eq c2 '-) c1)
	(t (simplifyConstraint (list 'and c1 c2)))))
;;================
;;   TRAPPING PATHS

(defun pathfound (e)
  (trace-msg "-Path found: ~S~%" (entry-constit e))
  (let ((cat (getFvalue e 'cat))
	(lf (getFvalue e 'lf)))
    (cond
     ((eq cat 'path)
      (let 
	  ;; ((newlf (list (car lf) (second lf) (simplifyConstraint (third lf)))) (list (car lf) (second lf) (simplifyConstraint (third lf))))
	  ((newlf (if (constit-p lf)
		      (replace-feature-value lf 'constraint (simplifyConstraint (get-value lf 'constraint)))
		   lf)))
	(setFvalue e 'lf newlf)
	 (add-to-paths-mentioned 
	  newlf e (entry-start e) (entry-end e))))
     ((eq cat 'vp)
      ;;  if cat is a negated VP with verb SEM GO - we need to add a negated
      ;;    path here, which will delete the earlier positive analysis
      (if (and (listp lf) (eq (car lf) 'not)
	       (listp (cadr lf)) (eq (caadr lf) 'GO-BY-PATH))
	  (add-to-paths-mentioned 
	   (simplifyConstraint 
	    (list 'not (findval 'path (cdadr lf)))) 
	   e (entry-start e) (entry-end e))))))
  e)

(defun findval (val vals)
  (cond ((null vals) nil)
	((eq (car vals) val) (cadr vals))
	(t (findval val (cddr vals)))))

;;  This flattens out the ANDS
(defun simplifyConstraint (expr)
  (cond
   ((eq expr '-) nil)
   ((and (listp expr) (eq (car expr) 'AND))
      (let
	  ((ans (delete-if #'(lambda (x) (or (eq x '-) (null x)))
			   (reverse (flattenAnds (cdr expr) nil)))))
	(if (consp ans)
	    (if (eql (list-length ans) 1)
		(car ans) (cons 'and ans))
	  ans)))
    (t expr)))

(defun flattenAnds (in out)
  (if (null in) out
    (let ((elem (car in)))
      (if (and (listp elem) (eq (car elem) 'and))
	  (flattenAnds (cdr in) (append (flattenAnds (cdr elem) nil) out))
	(flattenAnds (cdr in) (cons elem out))))))
      

(announce '(path (lf ?lf)) #'pathfound)

(announce '(vp (neg +) (sem go)) #'pathfound)

;;================
;;  TRAPPING SPEECH ACT SIGNALS

(defun speechActID (e)
  (trace-msg "-Speech Act Id: ~S ~%" (entry-constit e))
  ;;(add-to-sa-flags (getFvalue e 'id) (entry-start e) (entry-end e))
  e)


;; NAMES

(defun collapse-names (e)
  (let ((lf (getFvalue e 'LF)))
    (if (listp lf)
	(setFvalue e 'LF (intern (concat-names lf)))))
  e)

(announce '(name) #'collapse-names)

;; takes an atom which is either a symbol or a number and returns it
;; as a string
(defun stringify (a)
  (if (numberp a)
      (princ-to-string a)
    (symbol-name a)))

;; concat-names takes a list of atoms (either symbols or numbers)
;; and concats them together with a "_" between the atoms
;; returns a string.
(defun concat-names (list)
  (cond ((null (cdr list))
	 (stringify (car list)))
	(t
	 (concatenate 'string 
		      (stringify (car list))
		      "_"
		      (concat-names (cdr list))))))
   
(announce '(sa-id) #'speechActID)

;;================
;;  HANDLING EVENT/STATES

;;================
;;  TRAPPING VPS  
;;  used to build event structures
;;  we trap VPs for use in partial interpretations

;;   we ignore constituents that have non-filled gaps
(defun vpfound (e)
  (process-vp e)
  e)

(defun process-vp (e)
  (trace-msg "-Event/State identified as ~S~%" (entry-constit e))
  (let* ((cat (getFvalue e 'cat)))
    (if (eq cat 'vp)
	(let* ((constraint1  (simplifyconstraint 
			    (fix-args (getFvalue e 'constraint))))
	      (new-lf (simplify-pred (make-constit :cat 'prop
							:feats `((var ,(getFvalue e 'var))
								 (class ,(getFvalue e 'class))
								 (constraint ,constraint1)))))
	       (class (get-value new-lf 'class))
	       (constraint (get-value new-lf 'constraint)))
	       
	  (setFvalue e 'constraint constraint)
	  (setFvalue e 'lf new-lf)
	  (setFvalue e 'class class))
      (let ((lf (simplify-pred (getFvalue e 'lf)))
	    (gap (getFvalue e 'gap)))
	(setFvalue e 'LF lf)
	(if (and
	     (constit-p lf)
	     (or (null gap) (eq gap '-) (and (constit-p gap) (eq (get-value gap 'cat) '-))))
	    (add-to-action-mentioned lf (entry-start e) (entry-end e)))
	)))
   )
   
(announce '(vp) #'vpfound)

(announce '(s) #'vpfound)


;;  this removes constraints with null values, replaces
;;  full constituents with their var, and then flattens the ANDS

;;  it also reduces lambda expressions and transforms BE verb LFs

(defun simplify-pred (lf)
  (when (constit-p lf)
    (let ((op (get-value lf 'class)))
      (if (or (eq op 'BE) (equal op '(NOT BE)))
	  (let* ((var (get-value lf 'var))
		 (constraints (cdr (get-value lf 'constraint)))
		 (subjc (assoc 'lsubj constraints))
		 (subj (third subjc))
		 (lcomp (assoc 'lcomp constraints))
		 (pred (third lcomp)))
	    
	    (if (or (and (constit-p pred) (eq (constit-cat pred) 'pred))
		    (and (consp pred) (eq (car pred) 'pred)))
		(let* ((predargs (if (constit-p pred) (constit-feats pred)  (cdr pred)))
		       (arg (cadr (assoc 'arg predargs)))
		       (constraint (cadr (assoc 'constraint predargs)))
		       (reduced-constraint (if (listp constraint)
					       (substitute subj arg constraint)))
		       (cpred (car reduced-constraint))
		       (firstarg (second reduced-constraint))
		       (secondarg (third reduced-constraint))
		       (newconstraint (if secondarg   
					  (list 'and (list 'lsubj var firstarg) (list 'lobj var secondarg))
					(list 'and (list 'lsubj var firstarg) )))
		       (newclass (if (eq op 'BE) (list 'BE cpred) (list 'NOT (list 'BE cpred)))))
		  (replace-feature-value (replace-feature-value lf 'class newclass)
					 'constraint
					 newconstraint))
	    (Parser-Warn (format nil "BE verb without PRED found: ~a" lf))))
		  
	   
      (replace-feature-value lf 'constraint
			     (simplifyConstraint (fix-args (get-value lf 'constraint))))))))

(defun fix-args (cs)
  (if (consp cs)
    (let ((firstc (car cs)))
      (cond
       ((eq firstc '-) (fix-args (cdr cs)))
       ((not (and (consp firstc) (eql (length firstc) 3)))
	(cons firstc (fix-args (cdr cs))))
       (t ;; we have a binary constraint - ignore if thrid arg is
	           ;;      -, a variable, or null constit
	(let ((val (third firstc)))
	  (if (or (eq val '-)
		  (and (constit-p val) 
		       (eq (get-value val 'cat) '-)))
	      (fix-args (cdr cs))
	    (cons firstc (fix-args (cdr cs))))))))
    cs))
   	   
;;================
;;  TRAPPING S-based speech act signals

(defun processUtterance (e)
  (trace-msg "-Sentence Found ~S~%" (entry-constit e))
  (let ((start (entry-start e))
	(end (entry-end e)))
    (add-to-sa-mentioned (list (getFvalue e 'sa) (getFvalue e 'lf)) start end))
    e)

(announce '(utt) #'processUtterance)


;; ringger: Moved local discourse state functions and state to
;;          new file:  reference.lisp


;;================
;; MANAGING INDEXED LISTS
;; Element in Indexed lists are of the form (<value> <start> <end>)
;; This function adds a new element to an indexed list unless there
;; is a value that already contains the interval (<start> <end>). 
;; It also deletes any values already on the list that are contained
;; in the new interval.

(defun AddToIndexedList (val ll start end)
  (if (not (subsumedBy ll start end))
      (insertInIndexedList ll val start end)
       ll))

;;   This function checks for identical VAR features as well

(defun AddNPToIndexedList (val ll start end)
  (let ((var (get-value val 'var)))
  (if (not (NPsubsumedBy var ll start end))
      (insertInList val start end
		    (remove-if #'(lambda (x)
				   (and (eq (get-value
					     (indexedObject-object x) 'var) 
					    var)
					(<= start (indexedObject-start x)) 
					(>= end (indexedObject-end x))))
			       ll))
    ll)))
				   
;;--------
;;   remove values that fall between start and end and insert in list
;;   ordered by starting position
(defun insertInIndexedList (constits val start end)
  (insertInList val start end
		(removeSubConstits constits start end)))

;;  insert in list ordered by start position
(defun insertInList (val start end ll)
  (if (null ll)
      (list (make-indexedObject :object val :start start :end end))
    (if (< (indexedObject-start (car ll)) start)
	(cons (car ll) (insertInList val start end (cdr ll)))
      (cons (make-indexedObject :object val :start start :end end)
	    ll))))
	
(defun removeSubConstits (constits start end)
  (remove-if  #'(lambda (x)
		  (and (<= start (indexedObject-start x)) 
		       (>= end (indexedObject-end x))))
	      constits))

;;  sorts a list of indexed constituents so that objects are
;;  seen before they are referenced. Basically its left to
;;  right order except that subconstituents are before superconstituents
(defun sortNPsForReference (ll)
  (sort (copy-list ll)
	#'(lambda (x y)
	    (or (< (indexedObject-end x) (indexedObject-end y))
		(and (<= (indexedObject-end x) 
			 (indexedObject-end y))
		     (> (indexedObject-start x) (indexedObject-start y)))
		(and (= (indexedObject-start x) (indexedObject-start y))
		     (< (indexedObject-end x) (indexedObject-end y)))))))
	
  

;;--------
;; Checks a list of positioned objects and returns T if one of
;;   them would contain a constit with the new start and end positions
(defun subsumedby (objects start end)
  (some #'(lambda (x)
	    (and (<= (indexedObject-start x) start) 
		 (>= (indexedObject-end x) end)))
	objects))

;; this version also checks that the VAR are equal, so NPs
;;   within NPs are allowed.

(defun NPsubsumedby (var objects start end)
  (some #'(lambda (x)
	    (and (eq (get-value (indexedObject-object x) 'var) var)
		 (or (and (< (indexedObject-start x) start) 
			  (>= (indexedObject-end x) end))
		     (and (<= (indexedObject-start x) start) 
			  (> (indexedObject-end x) end)))))
	objects))


