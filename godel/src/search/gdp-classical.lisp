(in-package :gdp)

;;; writes problem into the problem file 'Prob.pddl'. 
(defun write-problem-as-pddl (objects start-state goal)
  ;	(in-package :shop2-user)
  (format t 
          ;					"entered write-problem with objects : ~A ~% start-state : ~A ~% goal : ~A ... ~%"
          objects
          start-state
          goal)

  (with-open-file (stream (concatenate 'string domain-name "Prob.pddl")
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
    (format stream "(define (problem ~AProb)~%" (domain-name *domain*))
    (format stream "  (:domain ~A)~%" (domain-name *domain*))
    (format stream "  ~S~%" (cons ':objects objects))
    (format stream "  ~S~%" (cons ':init start-state))
    (format stream "  ~S)" (if (null (cdr goal))
                             (cons ':goal goal)
                             (list ':goal (cons 'and goal))))
    (close stream)))
;	(in-package :shop2))

;;; invokes classical planner (in this case, FF) on the planning problem 
;;; (current-state, goal). 
(defun invoke-classical-planner (current-state goals objects)
  (let ((atoms (state-atoms current-state))
        (goal goals)
        (plan-found t)
        (plan-string nil)
        (dom-name (domain-name *domain*)))
    (write-problem-as-pddl dom-name objects atoms goal)
    (format t "ff called to achieve ~A ~%" goal)
    (asdf:run-shell-command (concatenate 'string "./ff" " -o " dom-name "-classical.lisp -f " dom-name "Prob.pddl -i 0 > my-domain.SOL"))
    (with-open-file (ff-output "my-domain.SOL" :direction :input)
      (loop for line = (read-line ff-output nil)
            until (string= line "ff: found legal plan as follows")
            when (null line) do 
            (progn
              (setf plan-found nil)
              (return)))
      ;; if plan-found is nil, means no plan found
      (if plan-found
        (progn
          (loop for line = (read-line ff-output nil)
                until (string= line "     ")
                do (push (subseq line 11) plan-string))
          plan-string)
        'FAIL))))

(defun domain-name-string ()
  (in-package :shop2-user)
  (setf s (concatenate 'string "" (domain-name *domain*)))
  (in-package :shop2)
  s)

(defun process-ff-output (ff-output)
  (let ((processed-output nil))
    (dolist (x ff-output)
      (if (> (length x) 0)
        (setf processed-output (cons (read-from-string x) processed-output))))
    processed-output))













