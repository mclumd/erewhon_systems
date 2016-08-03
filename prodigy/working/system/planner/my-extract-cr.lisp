;;; $Revision: 1.3 $
;;; $Date: 1994/05/30 20:56:20 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: my-extract-cr.lisp,v $
;;; Revision 1.3  1994/05/30  20:56:20  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:32  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


#-CLISP
(unless (find-package "PRODIGY4")
	(make-package "PRODIGY4" :nicknames '("P4") :use "LISP"))

(in-package  "PRODIGY4")

;;; pre-tests is what is returned by function
;;; extract-all-tests.  In this function, I have to take into
;;; consideration relevant-vars (see the defination and algorithm of
;;; it in ~/prodigy/notes/June under June 9)

#|
(defun extract-final (pre-tests)
  (re-organize-tests pre-tests nil))

(defun re-organize-tests (pre-tests used-vars)
  (let ((*simple* (first pre-tests))
	(*unary* (second pre-tests))
	(*join* (third pre-tests))
	(vars (fourth pre-tests))) 
    (declare (special *simple* *unary* *join*))
))

(defun do-one-join-test-group (tests pos vars used-vars)
  (declare (special *simple* *unary* *join*))
  (let ((new-vars (find-not-used-vars tests vars used-vars)))
    (if new-vars
	(let ((all-preds
	       (all-preds-with-new-vars
		new-vars :join pos)))))))
|#
	      


(defun find-not-used-vars (tests vars used-vars)
  (let* ((all-vars (all-vars tests)))
    (delete-if #'(lambda (x)
		   (or (member x vars) (member x used-vars)))
	       all-vars)))

	

;;; extract the result from the algorithm i just came up with.
;;; return a list of two buckets (a bucket is a list itself).
;;; the first bucket is a list of unary-tests, and the second is a list of
;;; join tests, each according to the variable order in the operator.

;;; the variables for the operator have to be in the REVERSED order
;;; than the way they appear in the operator.  The reason is because
;;; the recursive nature of function "match" I wrote.  Since it's
;;; being called recursively, the first join test is to join the last
;;; two variables in the variable list.

;;; vars is returned as well to save future computation.

(defun extract-all-tests (rule operator)
  (let* ((lhs (control-rule-if rule))
	 (op-vars (operator-precond-vars operator))
	 (vars (map-op-vars-to-cr op-vars rule))
	 (n (length vars))
	 (*bucket-simple* nil)
	 (*bucket-unary* (make-sequence 'list n))
	 (*bucket-join*
	  (unless (zerop n) (make-sequence 'list (1- n)))))
    (declare (special *bucket-simple* *bucket-unary* *bucket-join*))
    (process-meta-preds lhs vars)
    (list  (nreverse *bucket-simple*)
	   (mapcar #'reverse  *bucket-unary*)
	   (mapcar #'nreverse *bucket-join*)
	   vars)))


;;; op-vars is the variables in the operator; need to be converted to
;;; the corresponding variables in the lhs of the control rule.
(defun map-op-vars-to-cr (op-vars rule)
  (let ((var-alist (fourth (control-rule-then rule))))
    (mapcar #'(lambda (var)
		(cdr (assoc var var-alist)))
	    op-vars)))



;;;     *bucket-simple* *bucket-unary* *bucket-join*


;;; process the lhs of a control rule, putting meta-predicates into
;;; the right place in the right bucket.
;;; vars is a list of variables in the IF part of the control rule,
;;; some of the elements can be nil, this happens when the
;;; corresponding variable in the operator is not relevant to this
;;; control rule.

;;; for example, if an opertor has vars <ob1> <ob2>, but the select
;;; (or reject, or prefer) is (<ob1> . <x>), then vars should be (<x> nil).  

(defun process-meta-preds (lhs vars)
    (declare (special *bucket-simple* *bucket-unary* *bucket-join*))
  (case (car lhs)
    (user::and
     (process-and-meta-preds (cdr lhs) vars))
    (user::or
     (process-or-meta-preds lhs vars))
    (user::forall
     (error "~% sorry, can't have forall in control rule yet/"))
;     (process-forall-meta-preds (cdr lhs) vars)
    (user::exists
     (error "~% sorry, can't have exists in control rule yet/"))
;     (process-exists-meta-preds (cdr lhs) vars)
    (user::~ 
     (process-neg-meta-pred (second lhs) vars))
    ;;; because of the processing in load-domain.lisp, we know that
    ;;; (second lhs) has to be a predicate.
    (t
     (process-one-meta-pred lhs vars)))
  )


(defun process-and-meta-preds (lhs vars)
  (dolist (preds lhs)
    (process-meta-preds preds vars)))



;;; or has to be treated differently.  I can't simply have a dolist,
;;; and put the tests in the right bucket because this will make it an
;;; "and".  I need to put the lhs (or ... ...) as a whole in the right
;;; place of a bucket.
;;; I assume the the scope of OR is a set of predicate (can have
;;; negated ones), but no and inside it.
(defun process-or-meta-preds (lhs vars)
  (let* ((all-vars (delete-duplicates (mapcar #'all-vars (cdr lhs))))
	 (len (length all-vars))
	 (num (number-of-common-vars all-vars vars))
	 (var-number
	  ;; Mei 6/29/92, see comments in process-one-meta-preds.
	  (cond 
	    ((= num len) len)
	    ((and (= (length vars) 1) (zerop num)) 1)
	    (t 2)))

	   ;;; the number of elements of the intersection of all-vars
	   ;;; and vars, i.e. the number of op-variables of my defination.
	 
	 (place (if (= num len)
		    (unless (zerop var-number)
		      (max-position all-vars vars))
		    (1- (length vars))))
	   ;;; place is a number showing at which place the pred
	   ;;; should be put in.  
	 
	 )
    ;;	(format t "~% len ~S num ~S" len num)
    (case var-number
      (0 (add-to-bucket-simple lhs))
      (1 (add-to-bucket-unary lhs place))
      (t (add-to-bucket-join lhs place)))))

;;; since we assume that the scope of the negation is only one
;;; predicate, this because much more simple.
(defun process-neg-meta-pred (pred vars)
    (declare (special *bucket-simple* *bucket-unary* *bucket-join*))
    (unless (eq (car pred) 'user::current-ops)
      (let* ((all-vars (all-vars pred))
	   ;;; all-vars is all the variables appear in pred. 

	     (len (length all-vars))
	     (num (number-of-common-vars all-vars vars))
	     (var-number
	      ;; Mei 6/29/92, see comments in process-one-meta-preds.
	      (cond 
		((= num len) len)
		((and (= (length vars) 1) (zerop num)) 1)
		(t 2)))
	     
	   ;;; the number of elements of the intersection of all-vars
	   ;;; and vars, i.e. the number of op-variables of my defination.
	     (neg-pred (cons 'user::~ (list pred)))
	     (place (if (= num len)
			(unless (zerop var-number)
			  (max-position all-vars vars))
		        (1- (length vars))))
	   ;;; place is a number showing at which place the pred
	   ;;; should be put in.  
	     
	   )
#|
    (unless (eq (car pred) 'user::current-ops)
      (let* ((all-vars (all-vars pred))
	   ;;; all-vars is all the variables appear in pred. 
	     
	     (var-number (number-of-common-vars all-vars vars))
	   ;;; the number of elements of the intersection of all-vars
	   ;;; and vars, i.e. the number of op-variables of my defination.
	     
	     (place (unless (zerop var-number)
		      (max-position all-vars vars)))
	   ;;; place is a number showing at which place the pred
	   ;;; should be put in.  
	     (neg-pred (cons 'user::~ (list pred)))
	   )
|#
	(case var-number
	  (0 (add-to-bucket-simple neg-pred))
	  (1 (add-to-bucket-unary neg-pred place))
	  (t (add-to-bucket-join neg-pred place))))))

  
;;; process only one meta-predicate at a time.
(defun process-one-meta-pred (pred vars)
    (declare (special *bucket-simple* *bucket-unary* *bucket-join*))
    (unless (eq (car pred) 'user::current-ops)
      (let* ((all-vars (all-vars pred))
	   ;;; all-vars is all the variables appear in pred. 

	     (len (length all-vars))
	     (num (number-of-common-vars all-vars vars))
	     (var-number
	      (cond 
		;; Mei 6/29/92
		;; when all the variables in pred are in vars, 
		;; then var number should be equal to len
		((= num len) len)
		;; else, when there is only one variable in vars, but
		;; num is zero, (i.e. the variables in pred do not
		;; appear in vars), the var-number should be set to 1
		;; so this test is put into unary test. (since in this
		;; case, there will be no join tests)
		((and (= (length vars) 1) (zerop num)) 1)
		(t 2)))

	   ;;; the number of elements of the intersection of all-vars
	   ;;; and vars, i.e. the number of op-variables of my defination.
	     
	     (place (if (= num len)
			(unless (zerop var-number)
			  (max-position all-vars vars))
		        (1- (length vars))))
	   ;;; place is a number showing at which place the pred
	   ;;; should be put in.  
	     
	   )
;	(format t "~% len ~S num ~S var-num ~S" len num var-number)
	(case var-number
	  (0 (add-to-bucket-simple pred))
	  (1 (add-to-bucket-unary pred place))
	  (t (add-to-bucket-join pred place))))))
    
(defun number-of-common-vars (vars1 vars2)
  (length (intersection vars1 vars2)))


;;; all-vars and vars are both list of variables. The function
;;; calculates the position of each variable of all-vars in vars, and
;;; returns the max of them.
(defun max-position (all-vars vars)
  (let* ((positions-all
	  (mapcar #'(lambda (var)
		      (position var vars))
		  all-vars))
	 (positions (delete nil positions-all)))
    (if positions
	(apply #'max positions)
	(error "~% MAX-POSITION: ~A and ~A don't intersect"
	       all-vars vars))))


  
;;; add the predicate into bucket-simple.  
(defun add-to-bucket-simple (pred)
    (declare (special *bucket-simple*))
    (setf *bucket-simple*
	  (cons pred *bucket-simple*)))

(defun add-to-bucket-unary (pred place)
    (declare (special *bucket-unary*))
    (setf (nth place *bucket-unary*)
	  (cons pred (nth place *bucket-unary*))))

(defun add-to-bucket-join (pred place)
    (declare (special *bucket-join*))
    (setf (nth (1- place) *bucket-join*)
	  (cons pred (nth (1- place) *bucket-join*))))



  
#|
(defun my-build-test-from-cr (cr op vars1 vars2)
  (declare (type control-rule cr)
	   (type operator op)
	   (list vars1 vars2))
  (let* ((var1 (map-vars-in-cr vars1 cr))
	 (var2 (map-vars-in-cr vars2 cr))
;;	 (v1 (mapcar #'(lambda (x) (if x (list x))) var1))
;;	 (v2 (mapcar #'(lambda (x) (if x (list x))) var2))
	 (all-tests (getf (control-rule-plist cr) :all-tests))
	 (vars (operator-precond-vars op))
	 (useful-funcs (if (null vars1)
			   (if (null vars2)
			       ;; it's simple test
			       (first all-tests) 
			       ;; it's unary test
			       (elt (second all-tests)
				    (position (car vars2) vars)))
			   (elt (third all-tests)
				(1- (position (car vars2) vars))))))

    (if useful-funcs
	(let ((last-test (equal useful-funcs
			     (getf (control-rule-plist cr) :last-test)))
	      (useful-funcs
	       (if (= 1 (length useful-funcs))
		   (list 'quote (car useful-funcs))
		   (list 'quote `(and ,.useful-funcs)))))
	  
	  `(lambda (TEST-BINDINGS1 TEST-BINDINGS2)
	    (declare (special user::*current-node*))
	    
	    (let ((bindings (give-me-bindings 
			    TEST-BINDINGS1 TEST-BINDINGS2 ',var1 ',var2)))
	      ,(if last-test
		   `(and
		     (descend-match ,useful-funcs user::*current-node* bindings)
		     :last-test)
		   `(descend-match ,useful-funcs user::*current-node* bindings)))))
	
	t)))
|#

(defun my-build-test-from-cr (cr op vars1 vars2)
  (declare (type control-rule cr)
	   (type operator op)
	   (list vars1 vars2))
  (let* ((var1 (map-vars-in-cr vars1 cr))
	 (var2 (map-vars-in-cr vars2 cr))
	 (op-name (rule-name op))
;;	 (v1 (mapcar #'(lambda (x) (if x (list x))) var1))
;;	 (v2 (mapcar #'(lambda (x) (if x (list x))) var2))
	 (all-tests (second
		     (assoc op-name (getf (control-rule-plist cr) :all-tests))))
	 (vars (operator-precond-vars op))
	 (useful-funcs (if (null vars1)
			   (if (null vars2)
			       ;; it's simple test
			       (first all-tests) 
			       ;; it's unary test
			       (elt (second all-tests)
				    (position (car vars2) vars)))
			   (elt (third all-tests)
				(1- (position (car vars2) vars))))))

    (if useful-funcs
	(let ((last-test (equal useful-funcs
			     (second (assoc op-name
					    (getf (control-rule-plist cr) :last-test)))))
	      (useful-funcs
	       (if (= 1 (length useful-funcs))
		   (list 'quote (car useful-funcs))
		   (list 'quote `(and ,.useful-funcs)))))
	  
	  `(lambda (TEST-BINDINGS1 TEST-BINDINGS2)
#|	    ,(if (null v2)
		 `(declare (special user::*current-node*)
		   (ignore TEST-BINDINGS2))|#
	    (declare (special user::*current-node*))
	    
	    (let ((bindings (give-me-bindings 
			    TEST-BINDINGS1 TEST-BINDINGS2 ',var1 ',var2)))
#|	    (let* ((bindings1 ,(if var1 `(car TEST-BINDINGS1) `TEST-BINDINGS1))
		   (bindings2 ,(if var1 `(car TEST-BINDINGS2) `TEST-BINDINGS2))
		   (bindings (give-me-bindings 
			      bindings1 bindings2 ',var1 ',var2)))|#
	      ,(if last-test
		   `(and
		     (descend-match ,useful-funcs user::*current-node* bindings)
		     :last-test)
		   `(descend-match ,useful-funcs user::*current-node* bindings)))))
	
	t)))


(defun give-me-bindings (val1 val2 var1 var2)	
  (let ((bindings nil))
    (dolist (var var1)
      (if var
	  (push (cons var (nth (position var var1) val1))
		bindings)))
    (dolist (var var2)
      (if var
	  (push (cons var (nth (position var var2) val2))
		bindings)))
    bindings))


(defun ops-relevent-to-cr (cr)
  "Digs out the list of operators for which a particular binding select
rule was written."
  (find-current-ops (control-rule-if cr)))

(defun find-current-ops (list-structure)
  (cond ((or (null list-structure)
	     (symbolp list-structure))
	 nil)
	((member (car list-structure)
		 '(user::current-op user::current-operator))
	 (cdr list-structure))
	((member (car list-structure)
		 '(user::current-ops user::current-operators))
	 (second list-structure))
	((or (find-current-ops (car list-structure))
	     (find-current-ops (cdr list-structure))))))

(defun same-set-p (set1 set2)
  (and
   (subsetp set1 set2)
   (subsetp set2 set1)))

(defun map-vars-in-cr (vars cr)
  (let ((var-alist (fourth (control-rule-then cr))))
    (mapcar #'(lambda (x) (cdr (assoc x var-alist)))
	    vars)))
