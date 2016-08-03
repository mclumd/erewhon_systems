(setf excl::*global-gc-behavior* :auto)
(sys:set-stack-cushion 150000000)

(setf st (get-internal-run-time))
(format t "cla : ~A~%" (sys:command-line-argument-count))
(setf d-file (second (sys:command-line-arguments)))
(setf p-file (third (sys:command-line-arguments)))
(setf o-file (fourth (sys:command-line-arguments)))
;(setf param (fourth (sys:command-line-arguments)))
;(setf param2 (fourth (sys:command-line-arguments)))
;(format t "num_packages is ~A ~%" num_packages)

(if (not (= (sys:command-line-argument-count) 4))
  (progn
    (error "Not enough arguments to alisp. The command should be of the form ~%
            'alisp -#! gnp-load.lisp <domain-file> <problem-file> <output-file>'.")))

(require :asdf)
(asdf:oos 'asdf:load-op :shop2)
(compile-file "my-utils.lisp")
(compile-file "my-funcs.lisp")
(compile-file "my-test.lisp")
;(compile-file "basic-example-replanning.lisp")
(compile-file "ff-heuristic.lisp")
;(compile-file "experiments/hgn-domains/logistics-partial.lisp")
(compile-file d-file)
(compile-file p-file)
;(compile-file (concatenate 'string "examples/hgn/" domain "/domains/" domain "-hgn.lisp"))
;(compile-file (concatenate 'string "examples/hgn/" domain "/problems/hgn-" domain "-" param ".lisp"))

;(load "basic-example-replanning.lisp")
(load "my-utils.lisp")
(load "my-funcs.lisp")
(load "ff-heuristic.lisp")
(load d-file)
(load p-file)
;(load "experiments/hgn-domains/logistics-partial.lisp")
;(load (concatenate 'string "examples/hgn/" domain "/domains/" domain "-hgn.lisp"))
;(load (concatenate 'string "examples/hgn/" domain "/problems/hgn-" domain "-" param ".lisp"))

(setf shop2::*hgn-output* o-file)

(load "my-test.lisp")

(setf et (get-internal-run-time))
(format t "~%job time is ~A ~%" (/ (float (- et st)) internal-time-units-per-second))
;(load "ron/domain.lisp")
;(load "ron/pfile_03.lisp")
;

; (maphash (lambda (key value) (format t "~A ----- ~A~%" key value)) (domain-axioms *domain*))
; (format t "~A~%" (gethash '!pickup (domain-methods *domain*)))
