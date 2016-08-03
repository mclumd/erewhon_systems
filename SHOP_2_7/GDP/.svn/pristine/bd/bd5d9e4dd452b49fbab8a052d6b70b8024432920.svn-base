(in-package :shop2)

;(format t "axioms are ... ~%")
;(maphash (lambda (key value) (format t "~A ----- ~A~%" key value)) (domain-axioms *domain*))
;(format t "methods are ... ~%")
;(maphash (lambda (key value) (format t "~A ----- ~A~%" key value)) (domain-methods *domain*))
;(format t "operators are ... ~%")
;(maphash (lambda (key value) (format t "~A ----- ~A~%" key value)) (domain-operators *domain*))

; (format t "~A is the name of the domain~%" (domain-name *domain*))

(with-open-file (s *hgn-output*
                   :direction :output
                   :if-exists :supersede
                   :if-does-not-exist :create)
  (dolist (my-problem *all-problems*)
    ; *all-problems*
;    (format t "~A" (name my-problem))
    ;(format t "~A~%" (state-atoms my-problem))
    ;(format t "task is ... ~%")

    (let* ((state-obj (apply 'make-initial-state *domain* *state-encoding* (problem->state *domain* my-problem)))
           (state-obj-copy (make-initial-state *domain* *state-encoding* (state-atoms state-obj)))
           (goal-list (goal-list-from-problem my-problem))
           (task-list (get-task-list-from-goal-list goal-list nil))
           (start-internal-time (get-internal-run-time))
           (start-universal-time (get-universal-time)))

      ;		(format t "goal list : ~A ~%" goal-list)
      ;
      ;		(let ((goals goal-list))
      ;			(format t "goal-list is ~A ~%" goal-list)
      ;			(if (and (= (length goal-list) 1) (eq (car (car goal-list)) 'GOAL-ACHIEVED))
      ;				(setf goals (second (car goal-list))))

      ;			(format t "goals are ~A ~%" goals)
      ;			(dolist (g goals)
      ;				(add-atom-to-state (list 'goal g) state-obj 0 nil))
      ;			(add-atom-to-state (list 'goal-asserted goals) state-obj 0 nil))
      ;		(format t "augmented state is : ~A ~%" (state-atoms state-obj))

      ;		(format t "task-list is ~A ~%" task-list)

      ;		(build-action-preconditions state-obj)

      ;;	(format t "initial state before calling make-initial-state is ~A ~%" initial-state)
      ;;	(format t "state obj is ~A~%" (problem->state *domain* my-problem))

      ;	(format t "initial state is ~A~%" (state-atoms state-obj))


      ; #|
      ;  (format t "operators are ... ~%")
      ;  (maphash 
      ;  (lambda (key value)
      ;    (format t "--name : ~S~%" key)
      ;    (format t "----preconditions : ~A~%" (operator-preconditions value))
      ;    (format t "----add effects : ~A~%" (operator-additions value))
      ;    (format t "----del effects : ~A~%" (operator-deletions value))
      ;    (format t "----bindings : ~A~%" (find-satisfiers (operator-preconditions value) state-obj)))
      ;    (format t "~A ----- ~A~%" key (operator-preconditions value))) 
      ;  (domain-operators *domain*))
      ;|#	

      ;#|
      ;  (format t "reached this point now ... ~%")
      ;  (format t "~%methods are ... ~%")
      ;  (maphash 
      ;  (lambda (key value)
      ;    (format t "--name : ~S~%" key)
      ;    (format t "----head : ~A~%" (gdr-head value))
      ;    (format t "----preconditions : ~A~%" (gdr-preconditions value))
      ;    (format t "----goal : ~A~%" (gdr-goal value))
      ;    (format t "----subgoals : ~A~%" (gdr-subgoals value)))
      ;    (format t "bindings : ~A~%" (find-satisfiers (operator-preconditions value) state-obj)))
      ;    (format t "~A ----- ~A~%" key (operator-preconditions value))) 
      ;  (domain-methods *domain*))
      ;|#



      ;	(format t "top-task ~A ~%" top-task)
      ;		(format t "goal-list is ~A~%" goal-list)
      (format t "output file is ~A ~%" *hgn-output*)
      ;	(format t "result : ~A ~%" (achieve-subtasks "logistics" state-obj task-list nil)))

      ;		(format t "objects are : ~A ~%" (state-objects state-obj))
      ;		(setf *problem-objects* (state-objects state-obj))

      ;		(format t "CP : ~A ~%" (invoke-classical-planner "route-finding" state-obj goal-list *problem-objects*))

      (format s "--------------------- ~%")
      (format s "Problem : ~A ~%" (name my-problem))

      (multiple-value-bind (final-tree plan) (achieve-subtasks state-obj task-list nil)
        (let ((end-internal-time (get-internal-run-time))
              (end-universal-time (get-universal-time)))
          (if (eq final-tree 'FAIL)
            (format s "--No plan found!~%~%")
            ;					(with-open-file (stream *hgn-output*
            ;																	:direction :output
            ;																	:if-exists :append
            ;																	:if-does-not-exist :create)
            (progn
              (format s "--plan : ~A ~%" plan)
              (format s "--plan cost : ~A~%" (length plan))
              (format s "--plan generation time : ~A~%" (/ (float (- end-internal-time start-internal-time)) internal-time-units-per-second))
;              (format t "universal run time : ~A ~%" (- end-universal-time start-universal-time))
              (let ((final-state (apply-plan-to-state state-obj-copy plan)))
                (if (subset goal-list final-state)
                  (format s "--plan soundness check : PASS~%~%")
                  (format s "--plan soundness check : FAIL~%~%"))))))))))

;	(format t "objects are : ~A~%" (get-objects-from-state state-obj))

;  (format t "pred test is ~A~%" (shop2.common::state-all-atoms-for-predicate state-obj (car (car goal-list))))
;  (format t "output of gdp is : ~A~%" (goal-decomposition-planner state-obj top-task))

;  (format t "result is ~A~%" (shop2.common::atom-in-state-p (car goal-list) state-obj))
;  (format t "pred test is ~A~%" (shop2.common::state-all-atoms-for-predicate state-obj (car (car goal-list))))
;(format t "~A~%" (tasks my-problem))


