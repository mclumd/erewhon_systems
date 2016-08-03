 ;;; example 

(setf (current-problem)
  (create-problem
    (name p2)
    (objects)
    (state
     (and
      (alt b1)
      (static b1)
      (static b2)))
    (goal 
     (g0))))



