(setf excl::*global-gc-behavior* :auto)

(setf d-file (second (sys:command-line-arguments)))
(setf p-file (third (sys:command-line-arguments)))
;(format t "num_packages is ~A ~%" num_packages)

(require :asdf)
(asdf:oos 'asdf:load-op :shop2)

(compile-file d-file)
(compile-file p-file)
(load d-file)
(load p-file)

(compile-file "list-shuffle.lisp")
(load "list-shuffle.lisp")

(in-package :shop2)
(setf to-be-scrambled (fifth (sys:command-line-arguments)))
(setf o-file (fourth (sys:command-line-arguments)))

(let ((methods (domain-methods *domain*)))
	(if to-be-scrambled
		(maphash (lambda (name body)
							 (setf (gethash name methods) (randomize-list body nil)))
						 methods)))

(with-open-file (htn-output o-file
                            :direction :output
                            :if-exists :supersede
                            :if-does-not-exist :create)
  (dolist (p *all-problems*)
    ;	(find-plans p :which :first :verbose :plans))
    (multiple-value-bind (plans time-taken) (find-plans p)
      (format htn-output "--------------------- ~% Problem : ~A ~%" (name p))
      (format htn-output "--plan : ~A ~%" (shorter-plan (first plans)))
;      (format htn-output "--plan cost : ~A ~%" (length (remove-if-not #'listp (first plans))))
      (format htn-output "--plan cost : ~A ~%" (length (shorter-plan (first plans))))
      (format htn-output "--plan generation time : ~A ~% ~%" time-taken))))
