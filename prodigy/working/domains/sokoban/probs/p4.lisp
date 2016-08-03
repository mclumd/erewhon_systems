
(setf *limit* 10)
(setf (current-problem)
      (create-problem
       (name p-4)
       (objects
        (ball1 BALL))
       (state
        (and
         (at-robot 4 8)
         (at ball1 8 4)
         (blocked 5 4)
         (blocked 0 7)
         (blocked 2 9)
         (blocked 7 5)
         (blocked 3 3)
       ))
       (goal
        (and
         (at ball1 0 1)
       ))
))