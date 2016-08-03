 ;;; example for ../domain.alt.lisp. See comments in that file.

(setf (current-problem)
  (create-problem
    (name p2)
    (objects)
    (state
     (and
      (alt b1)
      (static b1)
      ))
    (goal 
     (g0))))



