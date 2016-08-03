;(setf excl::*global-gc-behavior* :auto)
;(sys:set-stack-cushion 150000000)
(pushnew "/home/svikas/research/code/GNP/trunk/" asdf:*central-registry* :test #'equal)

(setf d-file "/home/svikas/research/code/GDP-test-data/hgn/logistics/domains/logistics-domain-hgn.lisp")
(setf p-file "/home/svikas/research/code/GDP-test-data/hgn/logistics/problems/hgn-logistics-50-9.lisp")
(setf o-file "test.out") 

					; (if (not (>= (sys:command-line-argument-count) 4))
					; (progn
					; (error "Not enough arguments to alisp. The command should be of the form ~%
					; 'alisp -#! gnp-load.lisp <domain-file> <problem-file> <output-file>'; .")))
;; (let ((d-file "/home/svikas/research/code/GDP-test-data/hgn/logistics/domains/logistics-domain-hgn.lisp")
;;       (p-file "/home/svikas/research/code/GDP-test-data/hgn/logistics/problems/hgn-logistics-50-9.lisp")
;;       (o-file "test.out"))
(require :asdf)
(asdf:compile-system :gdp)
(asdf:load-system :gdp)
;; (compile-file "gdp-utils.lisp")
;; (compile-file "gdp-funcs.lisp")
;; (compile-file "gdp-test.lisp")
;; (compile-file "gdp-decls.lisp")
;; (compile-file "gdp-search.lisp")
;; (compile-file "gdp-classical.lisp")
;; (compile-file "utils.lisp")
;; ; (compile-file "basic-example-replanning.lisp")
;; (compile-file "ff-heuristic.lisp")
;; ; (compile-file "experiments/hgn-domains/logistics-partial.lisp")
(compile-file d-file)
(compile-file p-file)

;; (load "gdp-utils.lisp")
;; (load "gdp-funcs.lisp")
;; (load "ff-heuristic.lisp")
;; (load "gdp-decls.lisp")
;; (load "gdp-search.lisp")
;; (load "gdp-classical.lisp")
;; (load "utils.lisp")
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