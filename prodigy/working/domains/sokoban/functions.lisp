;;;*****************************************************************
;;; Functions used for variable bindings in operators

(defun decrease1 (x)
  (if (< (1- x) 0)
      nil
    (list (1- x))))

(defun increase1 (x)
  (if (> (1+ x) *limit*)
      nil
    (list (1+ x))))

(defun no-ball-p (x y)
  (not (true-in-state (list 'at '<ball> x y))))

;;;*****************************************************************
;;; Functions used in control rules

(defun candidate-goal-to-sel (goal)
  (declare (special *current-node*))
  (test-match-goals
   goal
   (remove-if
    #'(lambda (x)(p4::goal-loop-p *current-node* x))
    (p4::give-me-all-pending-goals *current-node*))))

(defun conflict-wallp (xg xs yg ys)
  (or (and (= xs *limit*) (not (= xg *limit*)))
      (and (= xs 0) (not (= xg 0)))
      (and (= ys 0) (not (= yg 0)))
      (and (= ys *limit*) (not (= yg *limit*)))))

;;; This function gets op and other-op already bound and 
;;; returns t if op is better than other-op, otherwise nil
;;; euclidian distance - no blocked - one step lookahead

(defun e-closer-single-move (op other-op locx locy locx-c locy-c)
  ;;(format t "~%goalx ~S goaly ~S currentx ~S current y ~S" locx locy locx-c locy-c)
  (let* ((distance-n 
	  (cons 'MOVE-N (e-distance locx locy locx-c (1+ locy-c))))
	 (distance-s 
	  (cons 'MOVE-S (e-distance locx locy locx-c (1- locy-c))))
	 (distance-w 
	  (cons 'MOVE-W (e-distance locx locy (1- locx-c) locy-c)))
	 (distance-e 
	  (cons 'MOVE-E (e-distance locx locy (1+ locx-c) locy-c)))
	 (sorted-distance 
	  (sort (list distance-n distance-s distance-w distance-e)
		#'(lambda (x y) (< (cdr x) (cdr y)))))
	 (pos-op 
	  (position op sorted-distance 
		    :test #'(lambda (x y) (eq (p4::operator-name x) (car y)))))
	 (pos-other-op
	  (position other-op sorted-distance 
		    :test #'(lambda (x y) (eq (p4::operator-name x) (car y))))))
    (= pos-op (1- pos-other-op))))

;;; same as e-closer-single-move to push ball operators
;;; could have a single function and pass names of operators as parameters - later

(defun e-closer-single-push (op other-op locx locy locx-c locy-c)
  ;;(format t "~%goalx ~S goaly ~S currentx ~S current y ~S" locx locy locx-c locy-c)
  (let* ((distance-n 
	  (cons 'PUSH-N (e-distance locx locy locx-c (1+ locy-c))))
	 (distance-s 
	  (cons 'PUSH-S (e-distance locx locy locx-c (1- locy-c))))
	 (distance-w 
	  (cons 'PUSH-W (e-distance locx locy (1- locx-c) locy-c)))
	 (distance-e 
	  (cons 'PUSH-E (e-distance locx locy (1+ locx-c) locy-c)))
	 (sorted-distance 
	  (sort (list distance-n distance-s distance-w distance-e)
		#'(lambda (x y) (< (cdr x) (cdr y)))))
	 (pos-op 
	  (position op sorted-distance 
		    :test #'(lambda (x y) (eq (p4::operator-name x) (car y)))))
	 (pos-other-op
	  (position other-op sorted-distance 
		    :test #'(lambda (x y) (eq (p4::operator-name x) (car y))))))
    (= pos-op (1- pos-other-op))))
		     
(defun e-distance (x1 y1 x2 y2) 
  (expt (+ (expt (- x1 x2) 2) (expt (- y1 y2) 2)) 0.5))


;;;*****************************************************************
;;; Functions to draw state and now writes goal state - could draw it too
(setf *goal-markers*  '(1 2 3 4 5 6 7 8 9 10 11 12))
(setf *state-markers* '(A B C D E F G H I J K L))

(defun draw-prob-sokoban ()
  (let ((state (get-lits-no-and (p4::problem-state (current-problem))))
	(goal (get-lits-no-and (p4::problem-goal (current-problem))))
	(balls (butlast (car (p4::problem-objects (current-problem))))))
    (if balls (format t "~% Balls: ~S" balls))
    (format t "~% Goal: ~S" goal)
    (format t "~% Initial state:")
    (format t "~%    ~S" (car (member 'at-robot state 
				      :test #'(lambda (x y)  
						(eq x (car y))))))
    (if balls 
	(dolist (ball balls)
	  (format t "~%    ~S" 
		  (car (member (list 'at ball) state 
			       :test #'(lambda (x y)  
					 (and (eq (car x) (car y))
					      (eq (nth 1 x) (nth 1 y)))))))))
    (dotimes (i (1+ *limit*))
      (let ((y (- *limit* i)))
	(format t "~%   ")
	(dotimes (x (1+ *limit*))
	  (cond
	   ((member (list 'at-robot x y) state :test 'equal)
	    (format t "R "))
	   ((member (list 'blocked x y) state :test 'equal)
	    (format t "X "))
	   (t
	    (let ((ballp nil))		;shows state if ball there
	      (when balls
		(dolist (ball balls)
		  (when (member (list 'at ball x y) state 
				:test 'equal)
		    ;;(format t "~D " (1+ (position ball balls)))
		    (format t "~A " (nth (position ball balls) *state-markers*))
		    (setf ballp t)
		    (return))))
	      (unless ballp             ;checks for goal location
		(when balls 
		  (dolist (ball balls)
		    (when (member (list 'at ball x y) goal 
				  :test 'equal)
		      (format t "~D " (nth (position ball balls) *goal-markers*))
		      (setf ballp t)
		      (return)))))
	      (unless ballp 
		(format t ". "))))))))))

(defun get-lits-no-and (messy-rep)
  (let ((lits (cdr messy-rep)))
    (if (eq (caar lits) 'and)
	(setf lits (cdr (car lits))))
    lits))

;;;*****************************************************************

(load "/usr/mmv/prodigy4.0/domains/sokoban/functions")

