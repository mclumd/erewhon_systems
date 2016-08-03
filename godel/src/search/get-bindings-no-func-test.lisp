; (setf excl::*global-gc-behavior* :auto)
; (sys:set-stack-cushion 150000000)
;

; (excl:chdir "search/trunk")

; (format t "cla : ~A~%" (sys:command-line-argument-count))
(setf d-file (second (sys:command-line-arguments)))
(setf p-file (third (sys:command-line-arguments)))
(setf o-file (fourth (sys:command-line-arguments)))
;(setf use-heuristic (fifth (sys:command-line-arguments)))
; (setf to-be-scrambled (fifth (sys:command-line-arguments)))
;(setf param (fourth (sys:command-line-arguments)))
;(setf param2 (fourth (sys:command-line-arguments)))
;(format t "num_packages is ~A ~%" num_packages)
;(setf st (get-internal-run-time))

;(setf d-file "/home/svikas/research/code/GDP-test-data/hgn/logistics/domains/logistics-domain-hgn.lisp")
;(setf p-file "/home/svikas/research/code/GDP-test-data/hgn/logistics/problems/hgn-logistics-30-3.lisp")
;(setf o-file "test.out")

; (format t "current directory is ~A~%" (current-directory))

(if (not (>= (sys:command-line-argument-count) 4))
  (progn
    (error "Not enough arguments to alisp. The command should be of the form ~%
           'alisp -# get-bindings.lisp <domain-file> <problem-file> <output-file>'.")))

(require :asdf)
;(asdf:compile-system :gdp)
;(asdf:load-system :gdp)
(asdf:oos 'asdf:compile-op :gdp)
(asdf:oos 'asdf:load-op :gdp)

; (format t "problem file is ~A~%" p-file)

(compile-file d-file)
;(compile-file p-file)

(load d-file)
;(load p-file)

(setf gdp::*hgn-output* o-file)

(in-package :shop2)
(setf simple-prob '(((goal (at obj11 pos1))
(goal (at obj12 apt1))
(in-city apt1 cit1)
(in-city apt3 cit3)
(in-city pos1 cit1)
(in-city pos3 cit3)
(airplane apn1)
(airport apt1)
(airport apt3)
(location apt1)
(location apt3)
(location pos1)
(location pos3)
(city cit1)
(city cit3)
(truck tru1)
(truck tru3)
(at apn1 apt3)
(at obj11 pos3)
(at obj12 apt1)
(at tru1 pos1)
(at tru3 apt3)
(package obj11)
(package obj12)) ((at obj11 pos1))))

(setf simple-prob-obj (make-problem "test" (first simple-prob) (second simple-prob)))

(setf *all-problems* (cons simple-prob-obj *all-problems*)) 

(in-package :gdp)
;(format t "current package is ~A~%" *package*)
(with-open-file (s *hgn-output*
                   :direction :output
                   :if-exists :supersede
                   :if-does-not-exist :create)
  (dolist (my-problem shop2::*all-problems*)

    ; (setf *planning-graph* nil)
    ; (setf *state-changed-p* t)
    ; (setf *infinity* most-positive-fixnum)


    (let* ((state-obj (apply 'shop2.common:make-initial-state *domain* *state-encoding* (shop2::problem->state *domain* my-problem)))
           ; (state-obj-copy (shop2::make-initial-state *domain* *state-encoding* (state-atoms state-obj)))
           (goal-list (goal-list-from-problem my-problem))
           ; (task-list (get-task-list-from-goal-list (list goal-list) nil))
           (start-internal-time (get-internal-run-time))
           ;;           (start-universal-time (get-universal-time))
           )

      (format t "original state: ~A ~%" (shop2::problem->state *domain* my-problem))
      (format t "state obj: ~A ~%" state-obj)
      (format t "goal list : ~A ~%" goal-list)

      ; (dolist (g goal-list)
      ;   (add-atom-to-state (list 'goal g) state-obj 0 nil))

      (format t "getting the bindings ... ~%" (name my-problem))

      ; (format s "--------------------- ~%")
      ; (format s "Problem : ~A ~%" (name my-problem))

      ; (multiple-value-bind (final-tree plan) (achieve-subtasks state-obj task-list nil)
      (let ((bindings nil)
            (methods (domain-methods *domain*))
            (task-goal (set-difference goal-list (state-atoms state-obj) :test #'equal)))
        (format t "methods")
        (maphash
          (lambda (key value)
            (setf bindings
                  (append bindings (bindings-of-gdr-achieving-goal nil
                                                                   task-goal 
                                                                   state-obj
                                                                   value))))
          methods)
        ; (dolist (m (domain-methods *domain*))
        ;   (let ((m-groundings (bindings-of-gdr-achieving-goal nil task-goal state-obj m)))
        ;     (append bindings m-groundings)))
        ; (format t "bindings are as follows: ~%")
        (format s "~A~%" (length bindings))
        (dolist (result bindings)
          (dolist (x result)
            (format s "~(~A~) " x))
          (format s "~%"))
        (format s "~A~%" (/ (float (- (get-internal-run-time) start-internal-time)) internal-time-units-per-second))
        ))))
