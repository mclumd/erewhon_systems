
(setf *predicates* '(at at-robot))

(setf (get 'at 'arg1) 'BALL)

(setf *print-case* :downcase)

;;;***************************************************************      
(defun create-probs-sokoban ()
  (format t "~%Enter the specifications:~%")
  (let* ((n-probs (ask-for "Number of problems to be created? "))
	 (prob (ask-for "Prefix for name of problems? "))
	 (examplep (yes-or-no-p "Same static layout as Dagstuhl example? yes/no "))
	 (grid-size (if examplep 7 (ask-for "Size of the grid? ")))
	 (n-balls (ask-for "Number of balls? "))
	 (n-blocked (if examplep nil
		      (ask-for "Number of blocked locations? "))))
    (dotimes (count-prob n-probs)
      (let ((filename
	     (concatenate 'string "/usr/mmv/prodigy4.0/domains/sokoban/probs/"
			  (format nil "~A~A.lisp" prob (1+ count-prob)))))
	(with-open-file 
	 (ofile filename :direction :output 
		:if-exists :rename-and-delete
		:if-does-not-exist :create)
	 (setf *occupied* (if examplep (get-pre-occupied) nil) *limit* grid-size)
	 ;;set grid limit
	 (format ofile "~%(setf *limit* ~S)" grid-size)
	 ;;set prelims
	 (format ofile "~%(setf (current-problem)")
	 (format ofile "~%      (create-problem")
	 (format ofile "~%       (name ~A-~S)" prob (1+ count-prob))
	 ;;set instances
	 (format ofile "~%       (objects")
	 (format ofile "~%        (")
	 (dotimes (ball-number n-balls)
	   (format ofile "ball~S " (1+ ball-number)))
	 (format ofile "BALL))")
	 ;;set goal
	 (format ofile "~%       (goal")
	 (format ofile "~%        (and")
	 (let ((goalchoice (random 10)))
	   (cond
	    ((< goalchoice 2) ;only move robot
	     (let ((locxy (get-unoccupied-loc 0 *limit*)))
	       (format ofile "~%         (at-robot ~S ~S)"
		       (car locxy) (cadr locxy))))
	    ((< goalchoice 8)  ;move only one ball
	     (let ((ball-number (random n-balls))
		   (locxy (get-unoccupied-loc 0 *limit*)))
	       (format ofile "~%         (at ball~S ~S ~S)"
		       (1+ ball-number) (car locxy) (cadr locxy))))
	    (t ;move all balls
	     (dotimes (ball-number n-balls)
	       (let ((locxy (get-unoccupied-loc 0 *limit*)))
		 (format ofile "~%         (at ball~S ~S ~S)"
			 (1+ ball-number) (car locxy) (cadr locxy)))))))
	 (format ofile "~%       ))")
	 ;;set initial state
	 (format ofile "~%       (state")
	 (format ofile "~%        (and")
	 (let ((locxy (get-unoccupied-loc 0 *limit*)))
	   (format ofile "~%         (at-robot ~S ~S)"
		   (car locxy) (cadr locxy)))
	 (dotimes (ball-number n-balls)
	   (let ((locxy (get-unoccupied-loc 1 (1- *limit*))))
	     (format ofile "~%         (at ball~S ~S ~S)"
		     (1+ ball-number) (car locxy) (cadr locxy))))
	 (cond
	  (examplep
	   (dolist (locxy (get-pre-occupied))
	     (format ofile "~%         (blocked ~S ~S)"
		     (car locxy) (cadr locxy))))
	  (t
	   (dotimes (counter n-blocked)
	     (let ((locxy (get-unoccupied-loc 0 *limit*)))
	       (format ofile "~%         (blocked ~S ~S)"
		       (car locxy) (cadr locxy))))))
	 (format ofile "~%       ))")
	 (format ofile "~%))"))))))

(defun get-pre-occupied ()
  '(
    (0 0) (0 1) (0 3) (0 4) (0 5) (0 6) (0 7)
    (7 0) (7 1) (7 2) (7 3) (7 4) (7 5) (7 6) (7 7)
    (1 7) (2 7) (3 7) (4 7) (5 7) (6 7)
    (1 0) (2 0) (3 0) (4 0) (5 0) (6 0)
    (3 2) (4 2) (5 2)
    (2 4) (2 5) (3 5) (4 5)
    ))

(defun get-unoccupied-loc (l-bound u-bound)
  (let ((locx (random u-bound))
	(locy (random u-bound)))
    (cond
     ((member (list locx locy) *occupied* :test #'equal)
      (get-unoccupied-loc l-bound u-bound))
     (t
      (push (list locx locy) *occupied*)
      (list locx locy)))))

;;;***************************************************************      
(defun ask-for (string)
  (format t " ~A" string)
  (read))

;;;***************************************************************      
;;; Runs a set of nprobs problems named with prefix
;;; example (run-set 'new 5)

(defun run-set (prefix nprobs)
  (dotimes (i nprobs)
    (let ((prob-name (read-from-string (format nil "~A~A" prefix (1+ i)))))
      (format t "~%~% Solving problem ~S" prob-name)
      (problem prob-name)
      (draw-prob-sokoban)
      (run :output-level 1)
      (format t "~%~S~%" *prodigy-result*))))

;;;***************************************************************
