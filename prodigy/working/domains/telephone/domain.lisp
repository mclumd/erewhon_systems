;;; The telephone call assignment domain.
;;;

(create-problem-space 'telephone :current t)

(ptype-of Node :top-type)
(ptype-of Call :top-type)

(infinite-type Capacity #'numberp)

(operator
 add-call-link
 (params <call> <from> <to>)
 (preconds
  ((<call> Call)
   (<from> Node)
   (<to> Node))
  (and
   (routed-to <call> <from>)
   (physical-link <from> <to>)		; static pred to control bindings
   (can-accept-more-calls <from> <to>))) ; maintained by an eager rule
 (effects
  ((<old-cap> (and Capacity
		   (gen-from-pred (residual-capacity <from> <to> <old-cap>))))
   (<new-cap> (and Capacity
		   (one-less <old-cap>))))
  ((del (residual-capacity <from> <to> <old-cap>))
   (add (residual-capacity <from> <to> <new-cap>))
   (add (routed <from> <to> <call>))
   (add (routed-to <call> <to>)))))

;;; This static rule sets up the residual-capacity of each link to
;;; equal the capacity initially, and sets up the "physical-link"
;;; static predicate to keep the possible bindings list down.
;;; WARNING: if capacity is changed so it is no longer static, this
;;; rule will keep resetting the residual-capacity. That might be what
;;; you want, though.
(inference-rule
 set-up-capacity
 (mode eager)
 (params <from> <to> <cap>)
 (preconds
  ((<from> Node)
   (<to> Node)
   (<cap> (and Capacity (gen-from-pred (capacity <from> <to> <cap>)))))
  (capacity <from> <to> <cap>))
 (effects
  ()
  ((add (residual-capacity <from> <to> <cap>))
   (add (physical-link <from> <to>)))))

;; This rule doesn't need to be eager, but planning is faster when it
;; is because less subgoaling is involved.
(inference-rule
 can-accept-more-calls
 (mode eager)
 (params <from> <to>)
 (preconds
  ((<from> Node)
   (<to> Node)
   (<cap> (and Capacity
	       (gen-from-pred (residual-capacity <from> <to> <cap>))
	       (greater-than-zero <cap>))))
  ;; This precondition is not needed, but is here to persuade Prodigy
  ;; that this rule is not static.
  (residual-capacity <from> <to> <cap>))
 (effects
  ()
  ((add (can-accept-more-calls <from> <to>)))))


;;; Functions

(defun one-less (old) (list (1- old)))

(defun greater-than-zero (cap)
  (if (> cap 0) (list cap)))

