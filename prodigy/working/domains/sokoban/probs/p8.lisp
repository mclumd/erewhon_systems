
(setf *limit* 10)
(setf (current-problem)
      (create-problem
       (name p-8)
       (objects
        (ball1 BALL))
       (state
        (and
         (at-robot 3 8)
         (at ball1 1 3)
         (blocked 2 0)
         (blocked 8 6)
         (blocked 3 1)
         (blocked 1 8)
         (blocked 9 5)
       ))
       (goal
        (and
         (at-robot 3 0)
       ))
))