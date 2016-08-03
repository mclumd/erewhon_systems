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
(setf to-be-scrambled (fourth (sys:command-line-arguments)))

(let ((methods (domain-methods *domain*)))
	(if to-be-scrambled
		(maphash (lambda (name body)
							 (setf (gethash name methods) (randomize-list body nil)))
						 methods)))

(dolist (p *all-problems*)
	;	(find-plans p :which :first :verbose :plans))
	(multiple-value-bind (plans time-taken) (find-plans p)
		(format t "For problem ~A : ~%" (name p))
		(format t "--plan : ~A ~%" (shorter-plan (first plans)))
		(format t "--plan length : ~A ~%" (length (remove-if-not #'listp (first plans))))
		(format t "--time : ~A ~% ~% ~%" time-taken)))
