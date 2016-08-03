(load "/usr/wxm/prodigy4/domains/blocksworld/mydomain")
(load-domain) ; build static preds.
(load "/usr/wxm/prodigy4/domains/blocksworld/types")
(load "/usr/wxm/prodigy4/domains/blocksworld/literal")


;(load "/usr/wxm/prodigy4/domains/blocksworld/bindings")
;(setf foo (p4::build-generator-for-rule *binding*))
;(funcall foo nil) ;no binding coming from right-hand side.
;(setf data (funcall foo nil))
;(setf cur p4::*current-problem-space*)
;(setf op (car (p4::problem-space-operators cur)))
;(setf 1-tests (p4::get-static-1-tests op))
;(setf n-tests (p4::get-static-n-tests op))
;(setf result (p4::match (reverse 1-tests) (reverse n-tests) data))
