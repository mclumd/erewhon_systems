(use-package 'p4)
(load "/usr/jblythe/prodigy4/domains/blocksworld/domain")
(load-domain) ; build static preds.

(p4::objects-are A B C D OBJECT)

(setf literal (p4::instantiate-consed-literal '(on A B)))
(p4::instantiate-consed-literal '(red A))
(p4::instantiate-consed-literal '(red B))

(setf cur p4::*current-problem-space*)
(setf op (car (p4::problem-space-operators cur)))


;(setf add (p4::operator-add-list op))
;(load "/usr/jblythe/prodigy4/domains/blocksworld/bindings")
;(setf foo (p4::build-generator-for-rule *binding*))
;(funcall foo nil) ;no binding coming from right-hand side.
;(setf data (funcall foo nil))
;(setf cur p4::*current-problem-space*)
;(setf op (car (p4::problem-space-operators cur)))
;(setf 1-tests (p4::get-static-1-tests op))
;(setf n-tests (p4::get-static-n-tests op))
;(setf result (p4::match (reverse 1-tests) (reverse n-tests) data))
