
(setf *limit* 10)
(setf (current-problem)
      (create-problem
       (name p-7)
       (objects
        (ball1 BALL))
       (state
        (and
         (at-robot 0 4)
         (at ball1 7 1)
         (blocked 2 0)
         (blocked 8 8)
         (blocked 9 1)
         (blocked 4 5)
         (blocked 6 6)
       ))
       (goal
        (and
         (at ball1 4 7)
       ))
))