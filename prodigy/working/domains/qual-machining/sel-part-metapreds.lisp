(in-package 'user)

;;works only if <part> is th only var in the goal
;;I haven't worry about efficiency as it is called only at node 4

(defun est-binding-cost (part cost)
  (if (p4::strong-is-var-p part)
      (error "~A has to be bound.~%" part)
      (list (list (cons cost (estimate (unmatched-top-goals part)))))))


;;this fn is domain-independent:

(defun unmatched-top-goals (var-value)
  "returns a list of literals corresponding to the conjuncts of the
goal, instantiated for var-value, that are not true in the state"
  (declare (special *current-node* *current-problem-space*))
  (let* ((obj
	  (if (p4::prodigy-object-p var-value) var-value
	      (p4::object-name-to-object var-value *current-problem-space*)))
	 (instop
	 ;;the instantiation corresponding to that var-value
	  (find-if #'(lambda (io)
		       (eq obj (car (p4::instantiated-op-values io))))
		   ;;the instantiations of *finish*
		   (p4::operator-node-bindings-left *current-node*))))
    (remove-if    
     #'p4::literal-state-p       ;;only works for positive goals
     ;; a list of the goal literals (instantiated for that part)
     (cdr (p4::instantiated-op-precond instop)))))



;;for now only a subset of the possible goals
;;assume all the goals are for the same part

;;the actual computation of the estimate is domain dep.
(defun estimate (unmatched-goals)
  "computes an estimate of the cost of achieving unmatched-goals. The
cost fn is related to the setup and machining operations"
  (declare (list unmatched-goals))
  (let ((size-goals
	 (remove-if-not
	  #'(lambda (g)
	      (goal-instance-of g 'size-of))
	  unmatched-goals))
	(hole-goals
	 (remove-if-not
	  #'(lambda (g)
	      (goal-instance-of
	       g 'has-hole 'has-spot 'is-tapped 'is-counterbored
	         'is-countersinked 'is-reamed))
	  unmatched-goals))
	estimate)
    (terpri)
    (setf estimate
	  (+
	   ;;cost of size-of goals
	   ;;assume all the size-of goals are for the same part
	   ;;set-ups include cleaning the part before holding
	   (case (length size-goals)
	    (0
	     (progn (p4::output 3 t "0 = no size goals~%")
	       0))
	    (1 (progn (p4::output 3 t "13 = one size goal ~A~%" size-goals)
	     13))
	    (2
	     (progn (p4::output 3 t "14 = face-mill + side-mill with same setup~A~%"
			    size-goals)
		    14)) ;face-mill + side-mill with same setup
	    (3
	     (progn (p4::output 3 t "22 = three size goals~A~%" size-goals)
	     22)))
	   ;;cost of hole goals
	   (apply
	    #'+
	    (mapcar
	     #'(lambda (side)
		 (estimate-hole-goals
		  (hole-goals-for-side side hole-goals)))
	     '(side1 side2 side3 side4 side5 side6)))))
    (p4::output 3 t "Total for ~A = ~A~%"
	    (aref (p4::literal-arguments (car unmatched-goals)) 0)
	    estimate)
    estimate))

(defun hole-goals-for-side (side goals)
  (remove-if-not
   #'(lambda (g)
       ;;side argument
       (equal (p4::literal-name (aref (p4::literal-arguments g) 2))
	      side))
   goals))


(defun estimate-hole-goals (hole-goals)
  ;;hole-goals is a list of literals has-hole, has-spot, is-tapped,
  ;;is-counterbored, is-countersinked, is-reamed, all for the same
  ;;side 
  ;;somehow I have to sort them by holes. For example to tap a hole
  ;;the args of has-hole have to be the same as those for is-tapped.
  (do* ((goal (next-hole-goal hole-goals)
	      (next-hole-goal rem-goals))
	(rem-goals (remove goal hole-goals)
		   (remove goal rem-goals))
	(estimate 0) result)
       ((null goal) estimate)
    (setf result
	  (case (p4::literal-name goal)
	    ((is-tapped is-countersinked is-counterbored is-reamed)
	     (estimate-finish-goal goal rem-goals))
	    (has-hole (estimate-has-hole goal rem-goals))
	    (has-spot (estimate-has-spot goal rem-goals))))
    (setf estimate (+ estimate (car result)))
    (if (cdr result) 
	(push (cdr result) rem-goals))))

(defun next-hole-goal (goals)
  ;;this gives the order in which the goals are analyzed
  (or (car (member 'is-tapped goals :key #'p4::literal-name))
      (car (member 'is-counterbored goals :key #'p4::literal-name))
      (car (member 'is-countersinked goals :key #'p4::literal-name))
      (car (member 'is-reamed goals :key #'p4::literal-name))      
      (car (member 'has-hole goals :key #'p4::literal-name))
      (car (member 'has-spot goals :key #'p4::literal-name))))

		     
;;; ***********************************************

(defun estimate-finish-goal (finish-goal all-goals)
  (declare (type p4::literal finish-goal)
	   (list all-goals))
  ;;this function returns (value . literal-or-nil) where
  ;;literal-or-nil will be added by caller to rem-goals.
  ;;All of the finishing goals, and has-hole, for the same hole have
  ;;the first 7 arguments in common 
  (let ((args (subseq (coerce (p4::literal-arguments finish-goal) 'list)
		      0 7)))
    (cons
     (progn
       (p4::output 3 t "9 = cost of tap operation and tool ~A~%" finish-goal)
       (+ 6 2 1); cost of tap operation and tool (includes cleaning the part)
       )
     (if
      (or
       ;;other finishing or has-hole goals for same hole. Hole will be
       ;;checked for them instead (so it is accounted for only once)
       ;;other costs will be added when has-hole is analyzed
       (member args all-goals :test #'same-hole-finish-goal)

       ;;tap is the only goal on that hole, is the hole made already?
       (p4::literal-state-p (p4::instantiate-literal 'has-hole args))
       )
      nil
      ;;add has-hole to set of goals
      (p4::instantiate-literal 'has-hole args)))))

(defun same-hole-finish-goal (args goal)
  (declare (type p4::literal goal)(list args))
  ;;all of the finishing goals, and has-hole, have the first 7
  ;;arguments common (args has length 7)
  (equal args (subseq (coerce (p4::literal-arguments goal) 'list) 0 7)))

(defun estimate-has-hole (has-hole-goal all-goals)
  (declare (type p4::literal has-hole-goal)
	   (list all-goals))
  ;;this function returns (value . literal-or-nil) where
  ;;literal-or-nil will be added by caller to rem-goals
  ;;has-hole and has-spot, for the same hole, have the first 3 and the
  ;;two last args in common
  ;;I won't care about two holes sharing the same tool for now.
  (let* ((args (coerce (p4::literal-arguments has-hole-goal) 'list))
	 (has-spot-goal
	  (p4::instantiate-literal
	   'has-spot 
	   (append (subseq args 0 3)(subseq args 5 7)))))
    (cons
     (progn
       (p4::output 3 t "3 = cost of drill hole op and tool ~A~%" has-hole-goal)
       (+ 2 1)) ;cost of drill hole op and tool
     (if ;;at this point we know there is not a hole yet
      ;;is there a spot-hole, or that is in the goals too
      (or (p4::literal-state-p has-spot-goal)
	  (member has-spot-goal all-goals))
      nil
      ;;add has-spot to set of goals
      has-spot-goal))))

(defun estimate-has-spot (has-spot-goal all-goals)
  (declare (type p4::literal has-spot-goal)
	   (list all-goals))
  ;;this function returns (value . literal-or-nil) where
  ;;literal-or-nil will be added by caller to rem-goals
  (list
   (if all-goals
       ;;there are other spot-holes to make on this side
       ;;share the same set-up (count only spot-drill operation)
       (progn (p4::output 3 t "2 = count only spot-drill operation ~A~%" has-spot-goal)
	      2)
       ;;count drill-spot plus set-up (hold includes clean)
       (progn
	 (p4::output 3 t "11 = count drill-spot plus set-up (hold includes ~
                    clean) ~A~%" has-spot-goal)
	 11))))

#|
(defun gname-to-literal (gname args)
  ;;note that all the finish goals don't have the same arguments
  (p4::instantiate-literal gname objects
  (p4::instantiate-consed-literal
   gname args))
|#

#|
(is-reamed <part> <hole> <side> <hole-depth> <hole-diameter> 
	   <loc-x> <loc-y>)
(is-counterbored <part> <hole> <side> <hole-depth> <hole-diameter>
		 <loc-x> <loc-y> <counterbore-size>)
(is-countersinked <part> <hole> <side> <hole-depth> <hole-diameter> 
		  <loc-x> <loc-y> <angle>)
(is-tapped <part> <hole> <side> <hole-depth> <hole-diameter> 
	   <loc-x> <loc-y>)
(has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
	  <loc-x> <loc-y>)
(has-spot <part> <hole> <side> <loc-x> <loc-y>)
|#