 ;;; example 
;;; NOTE that in the plan-exec dir on Pushkin, this definition does not have
;;; the static literals in the initial state.

(setf (current-problem)
  (create-problem
    (name p1)
    (objects)
    (state
     (and
      (alt b1)
      (static b1) ;Should be *n-binding-alts* of these.
      (static b2)))
    (goal 
     (g0))))



