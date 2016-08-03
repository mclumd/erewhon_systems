(defun generate-problem (num-crates problem-num)
  (with-open-file (prob-file-hgn (concatenate 'string
                                          "hgn-depots-"
                                          (write-to-string num-crates)
                                          "-"
                                          (write-to-string problem-num)
                                          ".lisp")
                             :direction :output
                             :if-exists :supersede
                             :if-does-not-exist :create)
    (with-open-file (prob-file-htn (concatenate 'string
                                          "../../../htn/depots/problems/htn-depots-"
                                          (write-to-string num-crates)
                                          "-"
                                          (write-to-string problem-num)
                                          ".lisp")
                             :direction :output
                             :if-exists :supersede
                             :if-does-not-exist :create)
      (with-open-file (prob-file-pddl (concatenate 'string
                                          "untyped-depots-"
                                          (write-to-string num-crates)
                                          "-"
                                          (write-to-string problem-num)                                          
                                          ".lisp")
                             :direction :input
                             :if-does-not-exist nil)
        (let* ((problem-object (read prob-file-pddl nil))
               (init-state (cdr (fifth problem-object)))
               (goal (cdadr (nth 5 problem-object)))
               (problem-name (cadr (nth 1 problem-object))))
          (format t "goal is ~A~%" (nth 5 problem-object))
              ;(htn-task (towers-task-htn num-rings)))
          (format prob-file-hgn "(in-package :shop2)~%")
          (format prob-file-hgn "(defproblem ~A depots-domain-hgn~%" problem-name)
          (format prob-file-hgn "~% ;; initial state ~% ~A ~% ~% ;; goal ~%" init-state)
          (format prob-file-hgn "~A)" goal)
          
          ;; HTN problem file creation
          (format prob-file-htn "(in-package :shop2)~%")
          (format prob-file-htn "(defproblem ~A depots-domain-hgn~%" problem-name)
          (format prob-file-htn "~% ;; initial state ~% ~A ~% ~% ;; task network ~%" init-state)
          (format prob-file-htn "((achieve-goals ~A)))" goal)
#|
          ;; PDDL problem file creation
          (format prob-file-pddl "(define (problem towers~A)~%" num-rings)
          (format prob-file-pddl "(:domain towers)~%")
          (format prob-file-pddl "(:objects t1 t2 t3 ")
          (dotimes (x num-rings)
            (format prob-file-pddl "r~A " (+ x 1)))
          (format prob-file-pddl ")~%")
          (format prob-file-pddl "(:init ")
          (dolist (y hgn-state)
            (format prob-file-pddl "~A~%" y))
          (format prob-file-pddl ")~%")
          (format prob-file-pddl "(:goal ~A))" (cons 'and hgn-goal))
|#
          )))))

(defun generate-on-clause (num1 num2)
	(read-from-string (concatenate 'string 
																 "(on r" 
																 (write-to-string num1)
																 " r"
																 (write-to-string num2)
																 ")")))

(defun generate-on-tower-clause (num1 num2)
	(read-from-string (concatenate 'string 
																 "(on r" 
																 (write-to-string num1)
																 " t"
																 (write-to-string num2)
																 ")")))

(defun generate-towertop-ring-clause (num1 num2)
	(read-from-string (concatenate 'string 
																 "(towertop r" 
																 (write-to-string num1)
                                 " t"
                                 (write-to-string num2)
																 ")")))

(defun generate-towertop-tower-clause (num1 num2)
	(read-from-string (concatenate 'string 
																 "(towertop t" 
																 (write-to-string num1)
                                 " t"
                                 (write-to-string num2)
																 ")")))

(defun generate-smallerthan-clause (m n)
	(read-from-string (concatenate 'string 
																 "(smallerthan r" 
																 (write-to-string m)
																 " r"
																 (write-to-string n)
																 ")")))

(defun generate-ring-clause (num)
  (read-from-string (concatenate 'string
                                 "(ring r"
                                 (write-to-string num)
                                 ")")))

(defun generate-tower-clause (num)
  (read-from-string (concatenate 'string
                                 "(tower t"
                                 (write-to-string num)
                                 ")")))

(defun towers-initial-state-hgn (num-rings)
  (let ((state nil))
    (dotimes (r num-rings)
      (setf state (cons (generate-ring-clause (+ 1 r)) state)))
    (dotimes (n 3)
      (setf state (cons (generate-tower-clause (+ 1 n)) state)))
    (dotimes (r (- num-rings 1))
      (setf state (cons (generate-on-clause (+ 1 r) (+ r 2)) state)))
    (setf state (cons (generate-on-tower-clause num-rings 1) state))
    (setf state (cons (generate-towertop-ring-clause 1 1) state))
    (setf state (cons (read-from-string "(right t1 t2)") state))
    (setf state (cons (read-from-string "(right t2 t3)") state))
    (setf state (cons (read-from-string "(right t3 t1)") state))
    
    ;; add the smallerthan clauses
    (do ((x 1 (+ x 1)))
        ((> x num-rings) nil)
      (do ((y (+ x 1) (+ y 1)))
          ((> y num-rings) nil)
        (setf state (cons (generate-smallerthan-clause x y) state))))

    ;; add the smallerthan relationships between rings and towers
    (do ((x 1 (+ x 1)))
      ((> x num-rings) nil)
      (setf state (cons (read-from-string (concatenate 'string
                                                       "(smallerthan r"
                                                       (write-to-string x)
                                                       " t1)"))
                        state))
      (setf state (cons (read-from-string (concatenate 'string
                                                       "(smallerthan r"
                                                       (write-to-string x)
                                                       " t2)"))
                        state))
      (setf state (cons (read-from-string (concatenate 'string
                                                       "(smallerthan r"
                                                       (write-to-string x)
                                                       " t3)"))
                        state)))

    (setf state (cons (read-from-string "(smallest r1)") state))
    (setf state (cons (read-from-string "(disabled)") state))
    (setf state (cons (read-from-string "(towertop t2 t2)") state))
    (setf state (cons (read-from-string "(towertop t3 t3)") state))

    (if (evenp num-rings)
      (setf state (cons (read-from-string "(even)") state))
      (setf state (cons (read-from-string "(odd)") state)))

    state))

(defun towers-goal-hgn (num-rings)
  (let ((goal nil))
    (dotimes (r (- num-rings 1))
      (setf goal (cons (generate-on-clause (+ 1 r) (+ r 2)) goal)))
    (setf goal (cons (generate-on-tower-clause num-rings 3) goal))

    goal))











