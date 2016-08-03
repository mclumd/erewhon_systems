(setf excl::*global-gc-behavior* :auto)
(sys:set-stack-cushion 150000000)

(format t "cla : ~A~%" (sys:command-line-argument-count))
(setf d-file (second (sys:command-line-arguments)))
(setf p-file (third (sys:command-line-arguments)))
(setf o-file (fourth (sys:command-line-arguments)))
;(setf use-heuristic (fifth (sys:command-line-arguments)))
(setf to-be-scrambled (fifth (sys:command-line-arguments)))
;(setf param (fourth (sys:command-line-arguments)))
;(setf param2 (fourth (sys:command-line-arguments)))
;(format t "num_packages is ~A ~%" num_packages)
(setf st (get-internal-run-time))

;(setf d-file "/home/svikas/research/code/GDP-test-data/hgn/logistics/domains/logistics-domain-hgn.lisp")
;(setf p-file "/home/svikas/research/code/GDP-test-data/hgn/logistics/problems/hgn-logistics-30-3.lisp")
;(setf o-file "test.out")

(if (not (>= (sys:command-line-argument-count) 4))
  (progn
    (error "Not enough arguments to alisp. The command should be of the form ~%
           'alisp -#! gnp-load.lisp <domain-file> <problem-file> <output-file>'.")))

(require :asdf)
(asdf:compile-system :gdp)
(asdf:load-system :gdp)

(compile-file d-file)
(compile-file p-file)

(load d-file)
(load p-file)

(setf gdp::*hgn-output* o-file)

(in-package :gdp)
(format t "current package is ~A~%" *package*)
(with-open-file (s *hgn-output*
		   :direction :output
		   :if-exists :supersede
		   :if-does-not-exist :create)
  (dolist (my-problem shop2::*all-problems*)

    (format t "my-problem is ~A ~%" my-problem)
    (setf *planning-graph* nil)
    (setf *state-changed-p* t)
    (setf *infinity* most-positive-fixnum)


    (let* ((state-obj (apply 'shop2.common:make-initial-state *domain* *state-encoding* (shop2::problem->state *domain* my-problem)))
	   (state-obj-copy (shop2::make-initial-state *domain* *state-encoding* (state-atoms state-obj)))
	   (goal-list (goal-list-from-problem my-problem))
	   (task-list (get-task-list-from-goal-list (list goal-list) nil))
	   (start-internal-time (get-internal-run-time))
	   ;;           (start-universal-time (get-universal-time))
	   )

      (format t "goal list : ~A ~%" goal-list)

      (dolist (g goal-list)
	(add-atom-to-state (list 'goal g) state-obj 0 nil))

      (format t "Solving problem ~A ... ~%" (name my-problem))

      (format s "--------------------- ~%")
      (format s "Problem : ~A ~%" (name my-problem))

      (multiple-value-bind (final-tree plan) (achieve-subtasks state-obj task-list nil)
	(let ((end-internal-time (get-internal-run-time))
	      ;;              (end-universal-time (get-universal-time))
	      )
	  (if (eq final-tree 'FAIL)
	      (format s "--No plan found!~%~%")

	      (progn
		(format s "--plan : ~A ~%" plan)
		(format s "--plan cost : ~A~%" (length plan))
		(format s "--plan generation time : ~A~%" (/ (float (- end-internal-time start-internal-time)) internal-time-units-per-second))

		(let ((final-state (apply-plan-to-state state-obj-copy plan)))
		  (if (subset goal-list final-state)
		      (format s "--plan soundness check : PASS~%~%")
		      (format s "--plan soundness check : FAIL~%~%"))

		  ))))))))
