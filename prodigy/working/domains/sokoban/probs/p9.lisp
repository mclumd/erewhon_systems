
(setf *limit* 10)
(setf (current-problem)
      (create-problem
       (name p-9)
       (objects
        (ball1 BALL))
       (state
        (and
         (at-robot 4 7)
         (at ball1 7 3)
         (blocked 9 9)
         (blocked 8 4)
         (blocked 6 1)
         (blocked 3 5)
         (blocked 4 2)
       ))
       (goal
        (and
         (at ball1 0 8)
       ))
))