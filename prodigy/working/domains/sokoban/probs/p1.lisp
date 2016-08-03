
(setf *limit* 10)
(setf (current-problem)
      (create-problem
       (name p-1)
       (objects
        (ball1 BALL))
       (state
        (and
         (at-robot 7 8)
         (at ball1 8 8)
         (blocked 7 5)
         (blocked 9 4)
         (blocked 3 5)
         (blocked 5 4)
         (blocked 7 1)
       ))
       (goal
        (and
         (at ball1 9 9)
       ))
))