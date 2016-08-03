
;; state-list  is just '((I3) (I2) (I11) (I12) (I7) (I13) (I9) (I1) (I10) (I14) ...)
;; goal-list is '((G9) (G12))

(defun create-problem-from-state-goal-lists (state-list goal-list)
  (setf (current-problem)
	(create-problem
	 (name test)
	 (objects nil)))
  (setf (p4::problem-state (current-problem)) 
	(cons 'state (list (cons 'and state-list))))
  (setf (p4::problem-goal (current-problem)) 
	(cons 'goal (list (cons 'and goal-list)))))


(defun run-all-examples ()
  (dolist (examples-fixed-number-of-goals *examples*)
     (dolist (prob examples-fixed-number-of-goals)
	(let ((state-list (car prob))
	      (goal-list (cadr prob)))
	  (create-problem-from-state-goal-lists state-list goal-list)
	  (run :depth-bound 1000 :output-level 1)))))

;;; probsets in *examples*
;;; probsets is for example '(1 2 3 4) meaning 
;;; solve and store the problems with 1,2,3, and 4 goals.

(defun solve-and-store (probsets)
  (load "/usr0/mmv/prodigy4.0/domains/art-md-ns/cases15.lisp")
  (dolist (probset-number probsets)
     (let ((prob-number 1))
       (dolist (prob (nth (1- probset-number) *examples*))
          (let ((state-list (car prob))
		(goal-list (cadr prob)))
	    (create-problem-from-state-goal-lists state-list goal-list)
	    (setf (p4::problem-name (current-problem))
		  (read-from-string (format nil "prob-~S-~S" 
					    probset-number prob-number))))
	  (incf prob-number)
	  (run :depth-bound 1000 :output-level 1 :max-nodes 10000)
	  (store-case)
	  ))))



(defun random-problem (m)
  "Make and a random problem with m goals"
  (eval
   `(create-problem
     (name randomly-generated-problem)
     (objects nil)
     (goal (and ,@(random-art0d-goals m *number-a-ops*)))
     (state (and ,@(random-order (art0d-listm 'i *number-a-ops*)))))))

(defun random-art0d-goals (m n)
  (when (> m n)
    (format t "~%Warning: trying to create more goals than possible.~%")
    (setf m n))
  (let ((res nil)
	(bag-o-goals (art0d-listm 'g *number-a-ops*)))
    (dotimes (i m)
      (let ((elt (elt bag-o-goals (random (length bag-o-goals)))))
	(push elt res)
	(setf bag-o-goals (delete elt bag-o-goals))))
    res))

;;; Given a symbol (eg i) and a number, return the list of symbols
;;; ((i1) .. (in)).
(defun art0d-listm (sym n)
  (let ((res nil)
	(*print-case* :upcase))
    (dotimes (i n)
      (push (list (intern (format nil "~S~S" sym (- n i))))
	    res))
    res))

;;; takes a list and returns a list of the elements in a random order.
;;; Not particularly efficient.
(defun random-order (list)
  (if list
      (let ((random-el (elt list (random (length list)))))
	(cons random-el
	      (random-order (remove random-el list))))))

;; m number of goals, n total number of goals (*number-a-ops*, i.e. 15)
;; total -- how many probs

(defun generate-list-of-probs (total m n)
  (let ((examples nil))
    (dotimes (i total)
      (push (list (art0d-listm 'i n) (random-art0d-goals m n))
	    examples))
    (dolist (ex examples)
       (format t "~% ~S" ex))))


    
	  
;;; ***********************************************************
;;; Art-md-ns -- Ihrie & Kambhampati experiments
;;;
;;; Consider 15 operators in the art-md-ns domain
;;;
;;; m number of goals 

(defun run-replay-store-all (m)
  (dotimes (i m) ))

(defun perm (l)
  (cond
   ((eq (length l) 1) l)
   (t
    (mapcar #'(lambda (x) 
		(cons x (perm (remove x l))))
	    l))))

