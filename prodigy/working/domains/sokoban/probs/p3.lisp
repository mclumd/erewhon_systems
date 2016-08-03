
(setf *limit* 10)
(setf (current-problem)
      (create-problem
       (name p-3)
       (objects
        (ball1 BALL))
       (state
        (and
         (at-robot 2 0)
         (at ball1 5 3)
         (blocked 6 0)
         (blocked 1 9)
         (blocked 8 7)
         (blocked 5 1)
         (blocked 9 4)
       ))
       (goal
        (and
         (at ball1 1 2)
       ))
))