
(setf *limit* 10)
(setf (current-problem)
      (create-problem
       (name p-6)
       (objects
        (ball1 BALL))
       (state
        (and
         (at-robot 2 2)
         (at ball1 8 6)
         (blocked 3 3)
         (blocked 7 2)
         (blocked 7 0)
         (blocked 6 8)
         (blocked 1 4)
       ))
       (goal
        (and
         (at-robot 8 5)
       ))
))