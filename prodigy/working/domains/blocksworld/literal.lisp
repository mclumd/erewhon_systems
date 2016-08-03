;(objects-are A B C D OBJECT)

(setf cur p4::*current-problem-space*)
(setf literal (p4::instantiate-consed-literal '(on A B)))
(setf op (car (p4::problem-space-operators cur)))
(setf add (p4::operator-add-list op))
(setf add (map nil  #'(lambda (x) (setf (p4::effect-cond-effect x)
				      (cadr (p4::effect-cond-effect x))))
		  add))



