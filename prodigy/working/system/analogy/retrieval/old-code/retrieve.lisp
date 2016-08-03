;;;******************************************************************
;;; Last version of retrieve-analogs??...
;;; See discussion on page 41 of my yellow notebook.
;;;******************************************************************

(defvar *talk-similar-p* nil)
(defvar *similarity-metric* 'foot-print)
(defvar *best-cover-matches* nil)
(defvar *coverage-threshold* 0.6)

;;;******************************************************************

;; Assumes that:
;;   - the vector *G-INTERACTIONS* is loaded,
;;   - the assoc table *STATE-NET-NAMES* is loaded,
;; prob is the name of a problem.

;;;******************************************************************

(defun retrieve-analogs (prob)
  (setf *new-prob* prob)  ;;fix afterwards 
  (setf *state-common-static*
	(get (get prob 'set-name) 'state-common))
  (setf *print-case* :downcase)
  (let* ((prob-body (p-frame-body (frame prob)))
	 (all-goals (sort (copy-list 
		       (clean-ands (cadr (assoc 'goal prob-body))))
		      #'list-class-lessp))
	 (new-state
	  (or (clean-statics (get-slot prob :inferred-state))
	      (append (clean-statics (clean-ands (cadr (assoc 'state prob-body))))
		      (reduced-state-common-problem prob))))
	 (goals (remove-if #'(lambda (x) (member x new-state
						 :test #'equal))
			   all-goals)))
    (if *talk-similar-p* (pretty-show-problem prob))
    (setf *best-cover-matches*
	  (map 'list #'(lambda (x)
			 (cons x (list '(no-case) '(nil) 0 0 0 nil)))
	       goals))
    (setf *initial-retrieval-time* (get-internal-run-time))
    (setf *retrieval-time-seconds* 0)
    (cover-all-goals prob new-state goals (length goals))
    (setf *retrieval-time-seconds*
	  (+ *retrieval-time-seconds*
	     (/ (- (get-internal-run-time) *initial-retrieval-time*)
		(float internal-time-units-per-second))))
    (format t "~% Analogs to prob ~S:" prob)
    (format t "~% ~S" *best-cover-matches*)
    *best-cover-matches*))

;;;******************************************************************

(defun cover-all-goals (prob new-state uncovered-goals max-covering-size)
  (if uncovered-goals
      (let* ((list-of-stored-interacting-goals
	      (find-largest-possible-covers max-covering-size))
	     (proposed-goal-conjunction-size
	      (length (car list-of-stored-interacting-goals))))
	;;(break "~% In cover-all-goals")
	(when list-of-stored-interacting-goals
	  (match-against-stored-goal-inters
	   prob new-state
	   list-of-stored-interacting-goals
	   uncovered-goals proposed-goal-conjunction-size)
	  (let ((remaining-uncovered
		  (remove-new-covered-goals uncovered-goals)))
	    ;;(break "~% In cover-all-goals after match")
	    (cover-all-goals prob new-state remaining-uncovered
			     (if (>= (length remaining-uncovered)
				     proposed-goal-conjunction-size)
				 (1- proposed-goal-conjunction-size)
				 (length remaining-uncovered))))))))

;;;******************************************************************

(defun match-against-stored-goal-inters (prob new-state memory-list new-goals comb-size)
  (if (eq comb-size 1)
      (setf new-goals (remove-if #'(lambda (x) (simple-goal-p x)) new-goals)))
  (if (and (> (length memory-list) 1)
	   (= (length (car memory-list))
	      (length new-goals)))
      (match-exact-new-goals-memory prob new-state memory-list new-goals)
      (match-memory-new-goals prob new-state memory-list new-goals 0 nil nil)))

;;;******************************************************************

(defun find-largest-possible-covers (covering-size)
  (if (zerop covering-size)
      nil
      (let ((g-interactions-entry (aref *G-INTERACTIONS* covering-size)))
	(if (null g-interactions-entry)
	    (find-largest-possible-covers (1- covering-size))
	    g-interactions-entry))))

;;;******************************************************************

(defun match-exact-new-goals-memory (prob new-state memory-list new-goals)
  (let ((current-memory-elt (find-if #'(lambda (x)
				  (unify-equal-preds new-goals x nil))
			     memory-list)))
    ;;(break "~% In match-exact-new-goals-memory")
    (if current-memory-elt
	(let* ((goal-subst (unify-equal-preds new-goals current-memory-elt nil))
	       (current-goals-comb
		(sublis goal-subst current-memory-elt))
	       (state-net-name
		(cdr (assoc current-memory-elt *STATE-NET-NAMES* :test #'equal))))
	  (if state-net-name
	      (retrieve-from-state-net prob new-state state-net-name
				       goal-subst current-goals-comb))))))

;;;******************************************************************

;; memory-list is '(((at-obj <p0> <ap0>) (inside-airplane <p5> <a3>))
;; --- these goals my have interacted by sharing the airplane <a3>.
;;                  ((at-truck <tr1> <ap0>) (inside-truck <p3> <tr1>)))
;; new-goals is '((at-obj ob12 po5) (inside-airplane ob12 a5) (inside-truck ob4 t5))
;; --- Two pairs of interacting goals in *G-interactions*.
;;
;; There must be a full match between the goal-interaction of the memory-list
;; and a combination of new-goals.
;; Otherwise the goals will be covered by individual goals
;; retrieve-from-state-net updates the global *best-cover-matches*.
	
(defun match-memory-new-goals (prob new-state memory-list new-goals
			       pos-memory combs-seen last-comb-done)
  (let* ((new-match-info (get-new-match new-goals memory-list
					pos-memory combs-seen last-comb-done))
	 (current-memory-elt (if new-match-info
				 (car new-match-info)
				 nil))
	 (current-pos-memory (position current-memory-elt memory-list
				       :test #'equal))
	 (goal-subst (if new-match-info
			 (nth 1 new-match-info)
			 nil))
	 (current-goals-comb
	  (sublis goal-subst current-memory-elt))
	 (state-net-name
	  (cdr (assoc current-memory-elt *STATE-NET-NAMES* :test #'equal))))
    ;;new-match-info returns a list of two elts
    ;;car is the memory elt matched and 2nd is the subst (non nil)
    ;;(break "~% In match-memory-new-goals 1")
    (when state-net-name
      (retrieve-from-state-net prob new-state state-net-name
			       goal-subst current-goals-comb)
      (let ((remaining-uncovered
	     (remove-new-covered-goals new-goals)))
	(if (< (length remaining-uncovered)
	       (length current-memory-elt))
	    nil
	    (match-memory-new-goals prob new-state memory-list remaining-uncovered
				    current-pos-memory
				    (append combs-seen
					    (list current-goals-comb))
				    (if (equal remaining-uncovered new-goals)
					current-goals-comb
					nil)))))))

;;;******************************************************************

;; new-goals is not a shorter list of goals than the list of goals in
;; memory-elt.
;; for example new-goals could be '((bla 1 2) (ble 2 3) (blo 4 5))
;; and memory-elt could be '((bla <a> <b>) (blo <c> <d>))
;;
;; for example new-goals could be '((bla 1 2) (bla 2 3) (blo 4 5))
;; and memory-elt could be '((bla <a> <b>) (blo <c> <d>))

(defun get-new-match (new-goals memory-list pos-memory combs-seen last-comb-done)
  (if (eq pos-memory (length memory-list))
      nil
      (let* ((memory-elt (nth pos-memory memory-list))
	     (reduced-goals (remove-if-not
			     #'(lambda (x)
				 (member x memory-elt
					 :test #'(lambda (y z) 
						   (all-type-unifyp y z))))
			     new-goals))
	     (new-match (process-this-memory-elt
			 reduced-goals
			 memory-elt
			 combs-seen
			 (cond
			   ((possible-comb-p last-comb-done reduced-goals)
			    last-comb-done)
			   (t
			    (format t "~% Not possible last-comb-done")
			    (format t "~% ~S, goals ~S" last-comb-done new-goals)
			    nil)))))
	;;(break "~% In get-new-match")
	(if new-match
	    (list memory-elt new-match)
	    (get-new-match new-goals memory-list
			   (1+ pos-memory) combs-seen nil)))))

(defun process-this-memory-elt (reduced-goals memory-elt combs-seen last-comb-done)
  (when (and reduced-goals (>= (length reduced-goals) (length memory-elt)))
    (let ((new-comb (get-new-comb reduced-goals (length memory-elt) last-comb-done)))
      (if new-comb
	  (if (and (not (member new-comb combs-seen :test #'equal))
		   (perfect-pred-match-p memory-elt new-comb))
	      (let ((subst (unify-equal-preds new-comb memory-elt nil)))
		(if subst
		    (reverse subst)
		    (process-this-memory-elt reduced-goals memory-elt
					     (append (list new-comb) combs-seen)
					     new-comb)))
	      (process-this-memory-elt reduced-goals memory-elt
				       combs-seen new-comb))
	  nil))))
	    
(defun perfect-pred-match-p (memory-elt goal-comb)
  (cond
    ((and (null memory-elt) (null goal-comb)) t)
    ((all-type-unifyp (car memory-elt) (car goal-comb))
     (perfect-pred-match-p (cdr memory-elt)
			   (cdr goal-comb)))
    (t nil)))

(defun unify-equal-preds (goals var-goals substs)
  (cond
    ((null goals) substs)
    ((equal (car goals) (car var-goals))
     (unify-equal-preds (cdr goals) (cdr var-goals) substs))
    (t
     (let ((subst (unify-bind-pairs (cdar goals) (cdar var-goals))))
       (if subst 
	   (unify-equal-preds (cdr goals) (sublis subst (cdr var-goals))
			      (append subst substs))
	   (unify-equal-preds nil nil nil))))))

;;;******************************************************************
;;; Done with this state-net
;; This function returns t if all the goals of the state-net
;; are in *best-cover-matches*
;; and all the "not simple" ones have match-value larger than
;; the *coverage-threshold*
;;;******************************************************************

(defun done-with-state-net-p (goals)
  ;;(break "~% In done-with-state-net-p")
  (and (every #'(lambda (x) (member x *best-cover-matches*
				    :test #'equal :key #'car))
	      goals)
	   (every #'(lambda (x) (and (not (simple-goal-p x))
				     (>= (current-coverage x)
					 *coverage-threshold*)))
		  goals)))

;; This function returns t if all the goals are in *best-cover-matches*
;; and at least one of them "not simple" has match-value larger than
;; the *coverage-threshold*

(defun considered-goal-comb-covered-p (goals)
  ;;(break "~% In considered-goal-comb-covered-p")
  (if (= (length goals) 1)
      t
      (and (every #'(lambda (x) (member x *best-cover-matches*
					:test #'equal :key #'car))
		  goals)
	   (some #'(lambda (x) (and (not (simple-goal-p x))
				    (>= (current-coverage x)
					*coverage-threshold*)))
		 goals))))



(defun current-coverage (goal)
  (nth 3 (cdr (assoc goal *best-cover-matches* :test #'equal))))

(defun simple-goal-p (goal)
  (or (eq (car goal) 'at-truck)
      (eq (car goal) 'at-airplane)))

(defun remove-new-covered-goals (goals)
  ;;(break "~% In remove-new-covered-goals")
  (remove-if #'(lambda (x)
		 (and (member x *best-cover-matches*
			      :test #'equal :key 'car)
		      (>= (current-coverage x)
			  *coverage-threshold*)))
	     goals))

;;;******************************************************************

(defun possible-comb-p (last-comb-done reduced-goals)
  (cond
    ((null last-comb-done) t)
    ((not (member (car last-comb-done) reduced-goals :test #'equal))
     nil)
    ((= 1 (length last-comb-done))
     t)
    ((< (position (car last-comb-done) reduced-goals :test #'equal)
	(position (cadr last-comb-done) reduced-goals :test #'equal))
     (possible-comb-p (cdr last-comb-done) reduced-goals))
    (t nil)))
    
;;;******************************************************************

(defun get-new-comb (new-goals comb-size last-comb-done)
  (if (null last-comb-done)
      (let ((new-pos-list nil))
	(do ((i (1- comb-size) (1- i)))
	    ((eq i -1))
	  (push i new-pos-list))
	(map 'list #'(lambda (x) (nth x new-goals))
	     new-pos-list))
      (let* ((max-elt (1- (length new-goals)))
	     (pos-list (map 'list #'(lambda (x)
				      (position x new-goals
						:test #'equal))
			    last-comb-done))
	     (new-pos-list
	      (increment-pos-list pos-list max-elt)))
	(if new-pos-list
	    (map 'list #'(lambda (x) (nth x new-goals))
		 new-pos-list)
	    nil))))

(defun increment-pos-list (pos-list max-elt)
  (let ((first-pos-to-incr
	 (find-leftmost-rightmost pos-list max-elt
				  (1- (length pos-list)))))
    (if first-pos-to-incr
	(let ((result nil))
	  (dotimes (i (length pos-list))
	    (cond
	      ((< i first-pos-to-incr)
	       (setf result
		     (append result
			     (list (nth i pos-list)))))
	      ((= i first-pos-to-incr)
	       (setf result
		     (append result
			     (list (1+ (nth i pos-list))))))
	      (t
	       (setf result 
		     (append result (list (1+ (car (last result)))))))))
	  result)
	nil)))

(defun find-leftmost-rightmost (pos-list max-elt right-pos)
  (cond
    ((eq (nth right-pos pos-list)
	 (+ right-pos (- (1+ max-elt) (length pos-list))))
     (if (zerop right-pos)
	 nil
	 (find-leftmost-rightmost pos-list max-elt (1- right-pos))))
    (t
     right-pos)))


(defun all-combs (elts comb-size)
  (list-all-combs elts comb-size nil))

(defun list-all-combs (elts comb-size last-comb)
  (let ((new-comb (get-new-comb elts comb-size last-comb)))
    (cond
      (new-comb
       (format t "~% ~S" new-comb)
       (list-all-combs elts comb-size new-comb))
      (t nil))))

;;;******************************************************************

;;; (This function is based on the previous
;;; function named retrieve-from-state-nets.)
;;; This function returns *best-cover-matches*
;;; *best-cover-matches* is an assoc list of the goals and
;;; the best past case that cover that goal.
;;; If the new-goals are ((g1 a b) (g2 c)) then
;;; *best-cover-matches* would be something like
;;; (((g1 a b) . (case-name match length-intersection-initial-state
;;;               percentage-initial-state-matched total-match state-net-name))
;;;  ((g2 c) . same thing))
;;; Example is: (((at-airplane pl1 a9) case-test-4-2-3
;;;               ((<a26> . pl1) (<ap90> . a9) (<p97> . ob2)
;;;                (<t49> . tr5) (<ap20> . a5) (<ap88> . a10)) 1 1.0 5)
;;;              ((inside-airplane ob3 pl1) case-test-5-14-4
;;;               ((<p52> . ob3) (<a91> . pl1) (<p45> . ob1) (<a20> . pl2)
;;;                (<ap32> . a10) (<ap26> . a3)) 2 0.6666667 5)
;;;              ((inside-airplane ob1 pl2) case-test-5-14-4
;;;               ((<p52> . ob3) (<a91> . pl1) (<p45> . ob1) (<a20> . pl2)
;;;                (<ap32> . a10) (<ap26> . a3)) 1 0.5 5)
;;;              ((inside-truck ob2 tr5) case-test-4-2-3
;;;               ((<a26> . pl1) (<ap90> . a9) (<p97> . ob2)
;;;                (<t49> . tr5) (<ap20> . a5) (<ap88> . a10)) 2 0.6666667 5))

(defun retrieve-from-state-net (new-problem new-state state-net-name goal-subst goals)
  (let ((root-frame
	 (read-from-string (format nil "root-~A" state-net-name))))
    ;;load state-net file
    (setf *retrieval-time-seconds*
	  (+ *retrieval-time-seconds*
	     (/ (- (get-internal-run-time) *initial-retrieval-time*)
		(float internal-time-units-per-second))))
    (load (format nil "~Astate-nets/~A" *domain-directory* state-net-name)
	  :verbose *talk-similar-p*)
    (setf *initial-retrieval-time* (get-internal-run-time))
    (set-slot root-frame :matches (list goal-subst))
    ;;(break "~% In retrieve-from-state-net before children")
    (evaluate-top-state-net-children
     root-frame
     goal-subst
     (reverse (get-slot root-frame :children))
     (remove-if-not
      #'(lambda (x)
	  (some #'(lambda (y) (all-type-unifyp x (car y)))
		(sublis goal-subst (get-slot root-frame :all-contents))))
      new-state)
     goals)))

;;;******************************************************************

(defun evaluate-top-state-net-children (root-frame goal-subst top-children new-state goals)
  ;;(break "~% In evaluate-top-state-net-children")
  (let ((good-children top-children))
    (when  (and new-state top-children)
      (dolist (top-child top-children)
	(if (still-promising-p top-child goals)
	    (let ((match-state-node
		   (evaluate-state-net-node root-frame top-child new-state goals)))
	      ;;(break "~% In top after match top-child")
	      (if (every #'(lambda (x) (equal x goal-subst)) match-state-node)
		  (setf good-children (remove top-child good-children))))
	    (setf good-children (remove top-child good-children))))
      (evaluate-state-net-children
       root-frame 
       (get-all-children good-children)
       new-state goals))))

;;;******************************************************************

;;; Children are internal state-net-nodes not top nodes.
	       
(defun evaluate-state-net-children (root-frame children new-state goals)
  ;;(break "~% In evaluate-state-net-children")
  (when children
    (dolist (child children)
      (if (still-promising-p child goals)
	  (evaluate-state-net-node root-frame child new-state goals)))
    (evaluate-state-net-children root-frame
     (get-all-children children)
     new-state goals)))

;;******************************************************************

(defun evaluate-state-net-node (root-frame child new-state goals)
  (set-slot child :evaled-goal-matches
	    (get-slot (get-slot child :parent) :evaled-goal-matches))
  (let* ((old-state-goal (get-slot child :content))
	 (matches
	  (initial-state-matches
	   (get-slot (get-slot child :parent) :matches)
	   (map 'list #'car old-state-goal)
	   new-state)))
    (set-slot child :matches matches)
    (if (and (is-in-p (get-slot child :parent) 'state-root)
	     (equal matches (get-slot (get-slot child :parent) :matches)))
	nil
	(let ((all-goal-evaled-matches 
	       (evaluate-goal-matches
		child goals new-state old-state-goal matches)))
	  (let ((leaf-case
		 (if (get-slot child :children)
		     (find-leaf-at-internal-node child)
		     (car (get-slot child :cases))))) ;no repeats: only one case leaf
	    ;;(break "~% Before leaf-case")
	    (when leaf-case
	      (when (and *talk-similar-p* all-goal-evaled-matches)
		(format t "~%~% Another leaf candidate case analog node: ~S"
			(get-frame-name child))
		;;(format t "~% child evaled ~S" (get-slot child :evaled-goal-matches))
		(format t "~% Similarities array:")
		(print-array-nicely all-goal-evaled-matches goals matches))
	      (get-new-best-cover-matches root-frame all-goal-evaled-matches leaf-case matches goals)
	      (if *talk-similar-p*
		  (format t "~%~% Best-cover-matches - case ~S ~%   ~S~%"
			  leaf-case *best-cover-matches*))))))
    matches))

;;******************************************************************

;;; *best-cover-matches* would be something like
;;; (((g1 a b) . (case-name match length-intersection-initial-state
;;;               percentage-initial-state-matched total-match state-net-name))
;;;  ((g2 c) . same thing))
;;; total-match adds also the goal and the others - not used for evaluation.

(defun get-new-best-cover-matches (root-frame goal-evaled-matches case-name matches new-goals)
  (let* ((no-of-matches (array-dimension goal-evaled-matches 1))
	 (no-of-goals (length new-goals))
	 (total-match-values
	  (compute-total-matches goal-evaled-matches no-of-matches no-of-goals))
	 (new-best-cover *best-cover-matches*))
    ;;(break "~% In get-new-best-cover-matches")
    (do ((match-index 0 (1+ match-index)))
	((eq match-index no-of-matches))
      (when (all-non-simple-non-zero-p goal-evaled-matches new-goals match-index)
	(do ((goal-index 0 (1+ goal-index)))
	    ((eq goal-index no-of-goals))
	  (let* ((goal-cover-pos (position (nth goal-index new-goals) *best-cover-matches*
					   :key #'car :test #'equal))
		 (best-goal-cover (nth goal-cover-pos *best-cover-matches*)))
	    (let ((new-percentage
		   (compute-initial-state-percentage
		    root-frame case-name
		    (rsubstitute-bindings (car best-goal-cover)
					  (nth match-index matches))
		    (aref goal-evaled-matches goal-index match-index 0))))
	      ;;(break "~% Before setting new-best-cover")
	      (cond
		((or (> new-percentage
			(nth 3 (cdr best-goal-cover))) ;better percentage of initial state match
		     (and (= new-percentage (nth 3 (cdr best-goal-cover)))
			  (> (aref total-match-values match-index)
			     (nth 4 (cdr best-goal-cover)))))
		 (setf new-best-cover
		       (substitute (cons (car best-goal-cover)
					 (list case-name (nth match-index matches)
					       (aref goal-evaled-matches goal-index match-index 0)
					       new-percentage
					       (aref total-match-values match-index)
					       (get-state-net-name-from-root-name root-frame)))
				   (car best-goal-cover)
				   new-best-cover :test #'equal :key #'car)))
		(t nil)))))))
    (setf *best-cover-matches* new-best-cover)
    (remove-left-over-goals *best-cover-matches*)))

(defun remove-left-over-goals (best-cover-matches)
  (cond
    ((null best-cover-matches) *best-cover-matches*)
    ((find-if #'(lambda (x)
		  (and 
		   (not (equal (car x) (caar best-cover-matches)))
		   (eq (nth 1 x) (nth 1 (car best-cover-matches)))
		   (equal (nth 2 x) (nth 2 (car best-cover-matches)))))
	      *best-cover-matches*)
     (remove-left-over-goals (cdr best-cover-matches)))
    ((eq (nth 3 (car best-cover-matches))
	 (1- (nth 5 (car best-cover-matches))))
     (remove-left-over-goals (cdr best-cover-matches)))
    (t
     (setf *best-cover-matches*
	   (substitute (cons (caar best-cover-matches)
			     (list '(no-case) '(nil) 0 0 0 nil))
		       (caar best-cover-matches)
		       *best-cover-matches* :test #'equal :key #'car))
     (remove-left-over-goals (cdr best-cover-matches)))))
     
(defun all-non-simple-non-zero-p (goal-evaled-matches goals match-index)
  (let ((result nil))
    (do ((goal-index 0 (1+ goal-index)))
	((eq goal-index (length goals)) (setf result t))
      (if (and (not (simple-goal-p (nth goal-index goals)))
	       (zerop (aref goal-evaled-matches goal-index match-index 0)))
	  (return)))
    result))

(defun compute-initial-state-percentage (root-frame case-name goal initial-state-inters)
  (let ((stored-size
	 (find-if #'(lambda (x) (and (eq (car x) case-name)
					(equal (nth 1 x) goal)))
		     (get-slot root-frame :state-size-per-goal-case))))
    (cond
      (stored-size
       (/ (* 1.0 initial-state-inters)
	  (nth 2 stored-size)))
      (t
       (format t "~% Nil for percentage:")
       (format t "~% root-frame ~S, case-name ~S, goal ~S" root-frame case-name goal)
       0))))
      
(defun compute-total-matches (goal-array-matches no-matches no-goals)
  (let ((totals (make-array no-matches :initial-element 0)))
    (do ((match-index 0 (1+ match-index)))
	((eq match-index no-matches))
      (do ((goal-index 0 (1+ goal-index)))
	  ((eq goal-index no-goals))
	(if (not (eq -1 (aref goal-array-matches goal-index match-index 0)))
	    (setf (aref totals match-index)
		  (+ 1 (aref totals match-index)
		     (aref goal-array-matches goal-index match-index 0))))))
    totals))
  
;;;******************************************************************
;;;                  Unification functions
;;;******************************************************************

(defun unification-matches (new-goals old-goals)
  (setf old-goals
	(remove-if-not #'(lambda (x) (has-variables-p x)) old-goals))
  (let ((substitutions nil))
    (if old-goals
	(dolist (goal new-goals)
	  (let* ((other-goals (remove goal new-goals :test #'equal))
		 (compare-old-new
		  (remove-if-not #'(lambda (x) (eq (car x) (car goal)))
				 old-goals))
		 (goal-substs
		  (if (and compare-old-new
			   (have-variables-p compare-old-new))
		      (unify-one-goal (cdr goal) (map 'list #'cdr compare-old-new) nil)
		      nil))
		 (goal-result nil))
	    (dolist (goal-subst goal-substs)
	      ;;(break "~% In goal-subst loop")
	      (setf goal-result goal-subst)
	      (setf goal-result
		    (merge-substitutions
		     (unification-matches other-goals
					  (substitute-bindings old-goals goal-subst))
		     (list goal-result)))
	      (setf substitutions
		    (append goal-result substitutions))))))
    (remove-duplicates substitutions
		       :test #'(lambda (x y) (and (subsetp x y :test #'equal)
						  (subsetp y x :test #'equal))))))

;;**********************************************************************

(defun unify-one-goal (new-goal old-goals substitutions)
  (if (null old-goals) 
      substitutions
      (let ((subst (unify-bind-pairs new-goal (car old-goals))))
	(unify-one-goal new-goal (cdr old-goals)
			(if subst
			    (append substitutions (list subst))
			    substitutions)))))

(defun unify-bind-pairs (goal effect)
  (do* ((elements1 goal (cdr elements1))
	(elements2 effect (cdr elements2))
	(e1 (car elements1) (car elements1))
	(e2 (car elements2) (car elements2))
	(bindings nil))
      ((or (not (type-unifyp e1 e2))
	   (null elements1)
	   (null elements2))
       (if (null (or elements1 elements2))
	   bindings))
    (let ((bind-pair (cons e2 e1)))
      (if (not (eq e1 e2))
	  (push bind-pair bindings))
      (setq elements1 (substitute-bindings elements1 (list bind-pair))))))

;;**********************************************************************

(defun initial-state-matches (goal-matches old-state new-state)
  (cond
    ((null goal-matches) nil)
    (t
     (let* ((partial-inst-old-state
	     (sublis (car goal-matches) old-state))
	    (reduced-new-state
	     (remove-if-not #'(lambda (x)
				(some #'(lambda (y)
					  (all-type-unifyp x y))
				      partial-inst-old-state))
			    new-state)))
       ;;(break "~% In initial-state-matches")
       (append (merge-substitutions
		(list (car goal-matches))
		(reject-inconsistent (car goal-matches)
				     (unify-initial-states
				      partial-inst-old-state
				      reduced-new-state)))
	       (initial-state-matches (cdr goal-matches) old-state new-state))))))

;; Such a stupid problem... due to test-5-6...
;; Two trucks at the same post-office when matching against case-test-7-2...

(defun reject-inconsistent (previous-match new-matches)
  (remove-if #'(lambda (x) (some #'(lambda (y)
				     (some #'(lambda (z)
					       (and (eq (cdr z) (cdr y))
						    (not (eq (car z) (car y)))))
					   x))
				 previous-match))
	     new-matches))

;;**********************************************************************

(defun unify-initial-states (old-state new-state)
  ;;(break "~% Entering unify-initial-states")
  (cond
    ((null old-state) nil)
    ((not (some #'(lambda (x) (not (is-variable-p x)))
		(cdar old-state)))    ;unconstrained matches at replay time
     (unify-initial-states (cdr old-state) new-state))
    (t
     (let ((matches (unification-matches
		     (remove-if-not
		      #'(lambda (x)
			  (and (eq (car x) (caar old-state))
			       (all-type-unifyp (cdr x) (cdar old-state))))
		      new-state)
		     (list (car old-state)))))
       (cond
	 (matches
	  ;;(break "~% I have matches")
	  (let ((result nil))
	    (dolist (match matches)
	      (setf result
		    (append
		     (merge-substitutions
		      (list match)
		      (unify-initial-states
		       (substitute-bindings (cdr old-state) match)
		       new-state))
		     result)))
	    result))
	 (t
	  (unify-initial-states (cdr old-state) new-state)))))))

;;;******************************************************************

;; Evaluate-goal-matches returns an array of matches per goal.
;; The match value represents the goodness of that match.
;; The higher the number, the better the match.
;; The array is goal X match substitution X match value.

(defun evaluate-goal-matches (child goals new-state old-state-goal matches)
  ;;(break "~% Entering evaluate-goal-matches")
  (let ((result (make-array (list (length goals) (length matches) 1)
			    :initial-element 0)))
    (do ((goal-index 0 (1+ goal-index)))
	((eq goal-index (length goals)) result)
      (let ((goal (nth goal-index goals)))
	(do ((match-index 0 (1+ match-index)))
	    ((eq match-index (length matches)) result)
	  (let ((match (nth match-index matches)))
	    ;;(break "~% Inside evaluate")
	    (if (member goal (sublis match goals)
			:test #'equal)
		(let ((this-child-goal-match-value
		       (specific-state-evaluation
			goal new-state (sublis match old-state-goal))))
		  (merge-evaled-goal-matches
		   (get-slot child :evaled-goal-matches)
		   child goal match 
		   this-child-goal-match-value)
		  (setf (aref result goal-index match-index 0)
			(third (find-if #'(lambda (x) (and (equal (car x) goal)
							   (equal (nth 1 x) match)))
					(get-slot child :evaled-goal-matches))))))))))))

;;;******************************************************************

(defun merge-evaled-goal-matches (past-evals child goal match value)
  ;;(break)
  (let ((result nil)
	(foundp nil))
    (dolist (past-eval past-evals)
      (cond
	((and (equal (car past-eval) goal)
	      (subsetp (second past-eval) match :test #'equal))
	 (setf result
	       (append (list (list (car past-eval) match
				   (+ value (third past-eval))))
		       result))
	 (setf foundp t))
	(t
	  (setf result (append (list past-eval) result)))))
    (if (not foundp)
	(setf result (append (list (list goal match value))
			     past-evals)))
    (set-slot child :evaled-goal-matches result)))

;;;******************************************************************

;;; Could change this evaluations any way I want...
;;; Could be domain dependent, or instances dependent, or
;;; any sophisticated measure.

(defun specific-state-evaluation (goal new-state old-state-goal)
  (case *similarity-metric*
    (direct
     (direct-state-match-value new-state old-state-goal))
    (foot-print
     (foot-print-state-match-value new-state (list goal) old-state-goal))
    (hidden-foot-print
     (hidden-foot-print-match-value new-state (list goal) old-state-goal))
    (t 0)))

;;;******************************************************************

(defun direct-state-match-value (new-state old-state-goal)
  (count-if #'(lambda (x) (and (not (domain-staticp (caar x)))
			       (member (car x) new-state :test #'equal)))
	    old-state-goal))
		 
(defun foot-print-state-match-value (new-state new-goals old-state-goal)
  (count-if #'(lambda (x) (and (not (null (cdr x)))
;			       (not (domain-staticp (caar x)))
			       (member (car x) new-state :test #'equal)
			       (intersection new-goals (cdr x) :test #'equal)))
	    old-state-goal))

(defun hidden-foot-print-match-value (new-state new-goals old-state-goal)
  (+ (foot-print-state-match-value new-state new-goals old-state-goal)
     (count-if #'(lambda (x) (and (or (null (cdr x))
				      (null (intersection new-goals (cdr x) :test #'equal)))
;				  (not (domain-staticp (caar x)))
				  (member (car x) new-state :test #'equal)))
	       old-state-goal)))
     

;;;******************************************************************

;;;******************************************************************
;;;                Extra auxiliary functions
;;;******************************************************************

(defun get-all-children (state-net-nodes)
  (let ((result nil))
    (dolist (state-net-node state-net-nodes)
      (setf result
	    (append result
		    (reverse (get-slot state-net-node :children)))))
    (reverse result)))
	
;;**********************************************************************

(defun have-variables-p (literals)
  (cond
    ((null literals) nil)
    ((some #'(lambda (x) (is-variable-p x))
	   (car literals))
     t)
    (t
     (have-variables-p (cdr literals)))))

(defun has-variables-p (literal)
  (some #'(lambda (x) (is-variable-p x))
	literal))

;;**********************************************************************

(defun merge-substitutions (bindings1 bindings2)
  (cond
   ((null bindings1) bindings2)
   ((null bindings2) bindings1)
   (t
    (let ((res nil))
      (dolist (binds1 bindings1)
	(dolist (binds2 bindings2)
	  (cond
	    ((subsetp binds1 binds2 :key #'car)
	     (setf res (insert-bindings binds2 res)))
	    ((subsetp binds2 binds1 :key #'car)
	     (setf res (insert-bindings binds1 res)))
	    ((intersection binds1 binds2 :test #'(lambda (x y)
					      (or (eq (car x) (car y))
						  (eq (cdr x) (cdr y)))))
	     (setf res (insert-bindings binds1 res))
	     (setf res (insert-bindings binds2 res)))
	    (t
	     (setf res (insert-bindings (append binds1 binds2) res))))))
      res))))

(defun insert-bindings (binds res)
  (pushnew binds res
	   :test #'(lambda (x y) (and (subsetp x y :test #'equal)
				      (subsetp y x :test #'equal)))))

;;;**********************************************************************

(defun compute-new-problem-max-match (new-goals new-state)
  (+ (length new-goals)
     (count-if #'(lambda (x) (not (domain-staticp (car x))))
			 new-state)))

(defun still-promising-p (state-net-node goals)
  (if (done-with-state-net-p goals)
      nil
      ;;(break)
      (let ((cases (get-slot state-net-node :cases)))
	(if (equal (length cases) 1)
	    (if (or (eq (get-prob-name-from-case (car cases)) *new-prob*)
                    (>= (set-number 
                         (get-prob-name-from-case (car cases)) 40)))
		nil t)
	    t))))

  
;;**********************************************************************
;;(not (probe-file
  ;;(concatenate 'string *domain-directory*
  ;;"/cases/" (string-downcase (car cases))
  ;;".lisp"))))
  
;;**********************************************************************

;; Assumes l1 and l2 are of the same length.

(defun all-type-unifyp (l1 l2)
  (cond
    ((null l1) t)
    ((type-unifyp (car l1) (car l2))
     (all-type-unifyp (cdr l1) (cdr l2)))
    (t nil)))

;;;******************************************************************

(defun type-unifyp (e1 e2)
  (cond
    ((and (null e1) (null e2))
     t)
    ((and (not (is-variable-p e1))
	  (not (is-variable-p e2)))
     (equal e1 e2))
    ((not (and (is-variable-p e1)
	       (is-variable-p e2)))
     (equal (get-class-of e1)
	    (get-class-of e2)))
    (t nil)))

;; A predicate is domain static if it is static
;; for all the problems.
;; In the extended-strips domain, connects, dr-to-rm,
;; and is-key are domain static, while pushable and
;; carriable are not, as an object can be pushable in
;; one problem and not in another.

(defun domain-staticp (pred) 
  (and (get-slot pred :staticp)
       (not (eq pred 'pushable))
       (not (eq pred 'carriable))))

;;;******************************************************************

(defun state-common-problem ()
  (if (search "logistics" *domain-directory*)
      (cadar *state-common-static*)
      nil))

(defun reduced-state-common-problem (prob)
  (if (search "logistics" *domain-directory*)
      (get (get prob 'set-name) 'reduced-state-common)
      nil))

(defun clean-statics (literals)
    (if (search "logistics" *domain-directory*)
	(remove-if #'(lambda (x) (or (eq (car x) 'part-of)
				     (eq (car x) 'loc-at)
				     (eq (car x) 'same-city)))
		   literals)
	literals))

;;;******************************************************************

(defun print-array-nicely (all-goal-evaled-matches new-goals matches)
  (do ((goal-index 0 (1+ goal-index)))
      ((eq goal-index (length new-goals)))
    (format t "~% Goal ~S" (nth goal-index new-goals))
    (do ((match-index 0 (1+ match-index)))
	((eq match-index (length matches)))
      (format t "~%     match ~S - sim-value ~S"
	      (nth match-index matches)
	      (aref all-goal-evaled-matches goal-index match-index 0)))))

;;;******************************************************************

(defun eager-cut-analogs (nets-subst-analogs goals)
  (cond
    ((null nets-subst-analogs) nil)
    ((null goals) nil)
    ((null (set-difference goals (nth 2 (car nets-subst-analogs)) :test #'equal))
     (let* ((state-net-name (caar nets-subst-analogs))
	    (root-frame
	     (read-from-string (format nil "root-~A" state-net-name)))
	    (set-number-prob (set-number *new-prob*))
	    (prob-number-prob (prob-number *new-prob*)))
       (setf *retrieval-time-seconds*
	     (+ *retrieval-time-seconds*
		(/ (- (get-internal-run-time) *initial-retrieval-time*)
		   (float internal-time-units-per-second))))
       (load (concatenate 'string *domain-directory* "state-nets/"
			  (string-downcase state-net-name)
			  ".lisp")
	     :verbose *talk-similar-p*)
       (setf *initial-retrieval-time* (get-internal-run-time))
       (if (some #'(lambda (x) (let ((set-n (set-number (get-prob-name-from-case x)))
				     (prob-n (prob-number (get-prob-name-from-case x))))
				 (or (< set-n set-number-prob)
				     (and (= set-n set-number-prob)
					  (< prob-n prob-number-prob)))))
		 (get-slot root-frame :cases))
	   (list (car nets-subst-analogs))
	   (eager-cut-analogs (cdr nets-subst-analogs) goals))))
    ((intersection goals (nth 2 (car nets-subst-analogs)) :test #'equal)
     (append (list (car nets-subst-analogs))
	     (eager-cut-analogs (cdr nets-subst-analogs)
				(remove-if #'(lambda (x)
					       (member x (nth 2 (car nets-subst-analogs))
						       :test #'equal))
					   goals))))
    (t
     (eager-cut-analogs (cdr nets-subst-analogs) goals))))

;;;******************************************************************

(defun fix-syntax (best-cover-matches)
  (cond
    ((null best-cover-matches) nil)
    (t
     (let ((cm (car best-cover-matches)))
       (append (list (cons (car cm) (list (car (nth 1 cm)) (nth 2 cm) (nth 3 cm) (nth 4 cm))))
	       (fix-syntax (cdr best-cover-matches)))))))

;;;******************************************************************
