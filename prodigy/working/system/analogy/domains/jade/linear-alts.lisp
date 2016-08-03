
;;; This is the most radical linear mode.
;;; Add this to the end of the domain file.

(in-package user)

(defun linear-remove-alts (signal)
  (cond
   ((p4::goal-node-p *current-node*)
    ;;(format t "~% I am here goal.")
    (setf (p4::goal-node-goals-left *current-node*) nil))
   ((p4::a-or-b-node-p *current-node*)
    ;;(format t "~% I am here a-or-b-node.")
    (setf (p4::a-or-b-node-applicable-ops-left *current-node*) nil)
    (setf (p4::a-or-b-node-goals-left *current-node*) nil))
   (t nil))
  nil)

(clear-prod-handlers) 
(define-prod-handler :always #'linear-remove-alts) 

