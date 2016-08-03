;;; $Revision: 1.4 $
;;; $Date: 1995/03/13 00:39:37 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: rete-match.lisp,v $
;;; Revision 1.4  1995/03/13  00:39:37  jblythe
;;; General clean-ups, including a definition of gen-from-pred that can have
;;; more than one variable in the literal.
;;;
;;; Revision 1.3  1994/05/30  20:56:27  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:40  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


;;; If there are n variables in an operator, there should be 
;;; n unary tests, n-1 n-ary tests. 

#-CLISP
(unless (find-package "PRODIGY4")
	(make-package "PRODIGY4" :nicknames '("P4") :use "LISP"))

(in-package  "PRODIGY4")

(defun get-vars-for-op (op)
 (reverse (operator-precond-vars op)))		; reverse makes a new list.

;;; get the unary test for each variable in the precond list of operator.
(defun get-static-1-tests (op) 
  (do ((vars (get-vars-for-op op) (cdr vars))
       (tests nil
	      (cons (combine-prec-and-spec
		     (extract-static-preconds
		      op nil (list (car vars)))
		     (extract-binding-spec-functions
		      op nil (list (car vars))))
		    tests)))
      ((null vars) tests)))


(defun get-all-simple-tests (op)
  (let ((crs (rule-select-bindings-crs op))
	(static (get-static-simple-tests op)))
    (do ((cr crs (cdr cr))
	 (tests (list static)
		(cons (combine-simple
		       static
		       (get-simple-tests-for-cr op (car cr)))
		      tests)))
	((endp cr) tests))))


;; extract-binding-spec-function is probably not needed.
(defun get-simple-tests-for-cr (op crule)
  (my-build-test-from-cr crule op nil nil))


(defun get-static-simple-tests (op)
  (let ((extat (extract-static-preconds op nil nil)))
    (if (eq extat t)
	t
      (maybe-compile
       `(lambda ()
	  (funcall ',extat
		   :no-arg :no-arg))))))


(defun combine-simple (static-test cr-test)
  (let* ((cr-bit (or (eq cr-test t)
		     `(funcall ',cr-test nil nil)))
	 (stat-test-bit
	  (if (eq static-test t)
	      cr-bit
	    `(if (funcall ',static-test) ,cr-bit))))
    (if (eq stat-test-bit t)
	t
      (maybe-compile
       `(lambda () ,stat-test-bit)))))



;;; get all  the unary-tests for an operator.
;;; it's a list of unary tests, each correspond to tests combined from
;;; a control rule and static tests, except that the last element of
;;; unary-tests comes only from static tests (this is necessary in case none
;;; of the control rules fires, we need to generate bindings from only
;;; static tests.
(defun get-all-unary-tests (op)
  (let* ((static (get-static-1-tests op))
	 (crs (rule-select-bindings-crs op)))
    (do ((cr crs (cdr cr))
	 (tests (list static)
		(cons (mapcar #'combine-static-and-cr
			      static (get-unary-tests-for-cr op (car cr)))
		      tests)))
	((endp cr)  tests))))

  

;;; similar to "get-all-unary-tests", except that it's getting join tests.
(defun get-all-join-tests (op)
  (let ((vars (operator-precond-vars op)))
    (unless (= (length vars) 1)
      (let* ((static (get-static-n-tests op))
	     (crs (rule-select-bindings-crs op)))
	(do ((cr crs (cdr cr))
	     (tests (list static)
		    (cons (mapcar #'combine-static-and-cr
				  static (get-join-tests-for-cr op
								(car cr)))
			  tests)))
	    ((endp cr) tests))))))

  
;;; get the list of unary tests from a select binding control rule.  It is
;;; used later to combine with static unary tests in "get-all-unary-tests".
(defun get-unary-tests-for-cr (op crule)
  (do ((vars (get-vars-for-op op) (cdr vars))
       (tests nil
              (cons (my-build-test-from-cr crule op nil (list (car vars))) 
                    tests)))
      ((endp vars) tests)))


;; there is one fewer join tests than unary tests, that's why the stop
;; condition is different.
(defun get-join-tests-for-cr (op crule)
  (do ((vars (get-vars-for-op op) (cdr vars))
       (tests nil
              (cons (my-build-test-from-cr crule
                                           op
                                           (reverse (cdr vars))
                                           (list (car vars)))
                    tests)))
      ((endp (cdr vars)) tests)))


;;; get the n-ary tests for variables in the precond list.
(defun get-static-n-tests (op)
  (do* ((vars (get-vars-for-op op) (cdr vars))
	(var1 (reverse (cdr vars)) (reverse (cdr vars)))
	(var2 (list (car vars)) (list (car vars)))
	(tests (list
		(combine-prec-and-spec
		 (extract-static-preconds op var1 var2)
		 (extract-binding-spec-functions op var1 var2)))
	       
	       (cons (combine-prec-and-spec
		      (extract-static-preconds op var1 var2)
		      (extract-binding-spec-functions op var1 var2))
		     tests)))
       ((endp (cdr var1)) tests)))

(defun get-all-neg-simple-tests (op)
  (let ((crs (rule-reject-bindings-crs op)))
    (do ((cr crs (cdr cr))
	 (tests nil
		(cons (get-simple-tests-for-cr op (car cr)) tests)))
	((endp cr) tests))))
  
(defun get-all-neg-unary-tests (op)
  (let ((tests nil))
    (dolist (var (get-vars-for-op op))
      (let ((res nil))
	(dolist (cr (rule-reject-bindings-crs op))
	  (push (my-build-test-from-cr cr op nil (list var)) res))
	(push res tests)))
    tests))

(defun get-all-neg-join-tests (op)
  (let ((tests nil)
	(vars (get-vars-for-op op)))
    (dotimes (n (1- (length vars)))
      (let ((res nil))
	(dolist (cr (rule-reject-bindings-crs op))
	  (push
            (my-build-test-from-cr
             cr op (reverse (nthcdr (1+ n) vars)) (list (nth n vars))) res))
	(push res tests)))
    tests))





;;; infinite types cannot be generated at unary test time, it can only
;;; be generated at cartesian-product time.  maybe i should get the
;;; unary test for infinite types into its predicate/generator.
(defun match (1-tests n-tests neg-1-tests neg-n-tests data op)
  (if (null n-tests)
      (let ((set2
	     (unary-test
	      (car 1-tests) (car neg-1-tests) (second data) op))
	    (neg-t-tests
	     (make-sequence 'list (length (car neg-1-tests)) :initial-element  t)))
	(and set2 (rev-cartesian t neg-t-tests (list (first data))
				 set2 op)))
      (let* ((set1
	      (match (butlast 1-tests) (butlast n-tests) (butlast neg-1-tests)
		     (butlast neg-n-tests) (butlast data) op))
	     (set2 (if set1 (unary-test
			     (car (last 1-tests)) (car (last neg-1-tests))
			     (car (last data)) op))))
	(and set1
	     set2
	     (rev-cartesian
	      (car (last n-tests)) (car (last neg-n-tests)) set1 set2 op)))))


;; at the time of unary test, data is plain data, without the stuff
;; from negated test, but it has to return stuff with negated
;; things... 
(defun unary-test (1-test neg-1-tests data op)
  (cond ((inf-type-var data) ;; if it's inf type, preserve the
			     ;; neg-tests and i will use this at
			     ;; gen-var time.	 
	 (append data (list 1-test neg-1-tests)))
	(t
	 (let ((selected
		(if (eq 1-test t)
		    (copy-list data)
		    (remove-if-not
		     #'(lambda (x) (funcall 1-test nil (list x))) data))))
	   (unary-neg-match neg-1-tests selected op)))))

;;; data looks like ( A B C), neg-tests is a list of tests.
(defun unary-neg-match (neg-1-tests data op)
  (let ((res nil))
    (dolist (datum data)
      (let ((matched (unary-neg-match-one neg-1-tests datum op)))
	(unless (eq matched :last-test)
	  (push matched res))))
    res))


;;; return (cons datum label)
;; changed to indicate rule firing. Mei, 2/10/92
(defun unary-neg-match-one (neg-1-tests datum op)
  (if (null neg-1-tests)
      (cons datum nil)
      (let ((lab nil))
	(dotimes (n (length neg-1-tests) (cons datum (nreverse lab)))
	  (let ((matched
		 (if (eq (nth n neg-1-tests) t) 
		     t (funcall (nth n neg-1-tests) nil (list datum)))))
;	    (print matched)
	    (cond ((eq matched :last-test)
		   (output 3 t "~%Firing reject binding rule ~S"
			   (control-rule-name
			    (nth n (reverse (rule-reject-bindings-crs op)))))
		   (return :last-test))
		  (t (push (if matched t nil) lab))))))))
		 

#|
(defun unary-neg-match-one (neg-1-tests datum)
  (if (null neg-1-tests)
      (cons datum nil)
      (let ((lab nil))
	(do* ((tests neg-1-tests (cdr tests))
	      (test (car tests) (car tests))
	      (matched (if (eq test t)
			   t
			   (funcall test nil (list datum)))))

	     ((or (endp tests) (eq lab :last-test))
	      (if (listp lab)
		  (cons datum (nreverse lab))
		  :last-test))
	  (if (eq matched :last-test)
	      (setf lab :last-test)
	      (push matched lab))))))
|#

(defun neg-one-simple-match (tests)
  (if (or (null tests) (eq tests t))
      t
      (funcall tests nil nil)))

(defun neg-simple-match (tests op)
  (let* ((len (length tests))
	 (lab (make-sequence 'list len :initial-element nil)))
    (dotimes (n len (cons nil lab))
      (let ((matched (neg-one-simple-match (nth n tests))))
	(cond ((eq matched :last-test)
	       (output 3 t "~%Firing reject binding rule ~S"
		       (control-rule-name
			(nth n (reverse (rule-reject-bindings-crs op)))))
	       (return :last-test))
	      (t (setf (nth n lab) matched)))))))




#|    (do ((n 0 (1+ n)))
	((or (eq n len) (eq lab :last-test))
	 (unless (eq lab :last-test)
	   (cons nil lab)))
      (let ((res (neg-one-simple-match (nth n tests))))
	(if (eq res :last-test)
	    (setf lab :last-test)
	    (setf (nth n lab) res))))))
|#
	      
;; modified to output binding rejection rule's firing.
;; Mei, 2/10/92
(defun neg-rev-match (neg-n-tests y x op)
  (let* ((labely (cdr y))
	 (labelx (cdr x))
	 (len (length labely))
	 (label (make-sequence 'list len :initial-element nil)))
    (dotimes (n len (cons (append (car y) (list (car x))) label))
      (if (and (nth n labely) (nth n labelx))
	  (let* ((test (nth n neg-n-tests))
		 (res (if (eq test t)
			  t
			  (funcall test (car y) (list (car x))))))
;	       (format t "~%res: ~S" res)
	    (cond ((eq res :last-test)
		   (output 3 t "~%Firing reject binding rule ~S"
			   (control-rule-name
			    (nth n (reverse (rule-reject-bindings-crs op)))))
		   (return nil))
		  (res (setf (nth n label) t))))))))
      

  
#|
(defun neg-rev-match (neg-n-tests y x)
  (let* ((labely (cdr y))
	 (labelx (cdr x))
	 (len (length labely))
	 (label (make-sequence 'list len :initial-element nil)))
    ;;    (format t "~% label ~S" label)
    (do ((n 0 (1+ n)))
	((or (eq n len) (eq label :last-test))
	 (if (equal label :last-test)
	     nil
	     (cons (append (car y) (list (car x))) label)))
      (if (and (nth n labely) (nth n labelx))
	  (let* ((test (nth n neg-n-tests))
		 (res (if (eq test t)
			  t
			  (funcall test (car y) (list (car x)) ))))
	    (if res
		(if (eq res :last-test)
		    (setf label :last-test)
		    (setf (nth n label) t))))))))
|#

(defun rev-cartesian (test neg-n-tests set1 set2 op)
  (let ((res nil))
    (dolist (y set1)
      (dolist (x (if (inf-type-var set2)
		     (gen-var y (cdr set2) op)
		     set2))
	(let ((matched (if (eq test t)
			   (neg-rev-match neg-n-tests y x op)
			   (and (funcall test (car y) (list (car x)))
				(neg-rev-match neg-n-tests y x op)))))
	  (if matched (push matched res)))))
    res))


;;; set1 is a lob, set2 is a list of tuples, where a tuples is represented as
;;; a list of obj.  Returning tuples that pass the test.
(defun cartesian-product-filter (test set1 set2 condi)
  (if (eq test t)
      (cross-product set1 set2)
;;;   (delete-if-not #'(lambda (x)
;;;			 (funcall test (list (car x)) (cdr x) condi))
;;;		     (cross-product set1 set2))
      ;; This piece of code is supposed to do the same thing while
      ;; only consing up what is needed.
      (let ((res nil))
	(dolist (y set1)
	  (dolist (x set2)
	    (if (funcall test (list y) x condi)
		(push (cons y x) res))))
	res)
   ))



;;; test looks like
;;; (<x> (and INF generator) (operator-precond-vars op) unary-test neg-1-tests)
(defun gen-var (val test op)
  (let* ((real-val (car val))
	 (expr (third (second test)))
	 (bindings (sublis (bind-me real-val (third test)) (cdr expr)))
	 (data (if (strong-is-var-p (car test))
		   (apply (car expr) bindings)
		   (and (apply (car expr)
			       (sublis (list (car test)) bindings))
			(list (cdar test))))))
    (unary-test (fourth test) (fifth test) data op)))

(defun bind-me (val vars)
  (mapcar #'(lambda (x y) (cons y x)) val vars))

(defun inf-type-var (set)
  (and (listp set) (eq (car set) :inf)))

(defun rev-cross-product (set1 set2)
  (mapcan #'(lambda (y)
	      (mapcar #'(lambda (x) (append y (list x)))
				set2))
	      set1))

(defun cross-product (set1 set2)
  (mapcan #'(lambda (y)
	      (mapcar #'(lambda (x) (cons y x)) set2))
	  set1))

;;; Only compiles if necessary.
(defun combine-prec-and-spec (prec spec)
  (combine-tests prec spec))


(defun combine-tests (&rest tests)
  (let ((actual-tests (delete t tests)))
    (if actual-tests
	(if (= (length actual-tests) 1)
	    (car actual-tests)
	  (maybe-compile
	   `(lambda (vals1 vals2)
	      (and 
	       ,.(mapcar #'call-test actual-tests)))))
      t)))

(defun call-test (test)
  `(funcall ',test vals1 vals2))

(defun combine-static-and-cr (static-test cr-test)
  (cond ((eq static-test t)
	 (or (eq cr-test t)
	     (maybe-compile
	      `(lambda (test-bindings1 test-bindings2)
		 (funcall ',cr-test test-bindings1 test-bindings2)))))
	((eq cr-test t)
	 static-test)
	(t
	 (maybe-compile
	  `(lambda (t1 t2)
	     (if (funcall ',static-test t1 t2)
		 (funcall ',cr-test t1 t2)))))))



(defun simple-match (tests)
  (if (or (null tests) (eq tests t))
      t
      (funcall tests)))

