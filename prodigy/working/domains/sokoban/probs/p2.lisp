
(setf *limit* 10)
(setf (current-problem)
      (create-problem
       (name p-2)
       (objects
        (ball1 BALL))
       (state
        (and
         (at-robot 1 5)
         (at ball1 8 1)
         (blocked 2 7)
         (blocked 9 8)
         (blocked 2 4)
         (blocked 7 2)
         (blocked 8 8)
       ))
       (goal
        (and
         (at ball1 6 0)
       ))
))