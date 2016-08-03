
(setf *limit* 10)
(setf (current-problem)
      (create-problem
       (name p-5)
       (objects
        (ball1 BALL))
       (state
        (and
         (at-robot 2 3)
         (at ball1 3 9)
         (blocked 1 2)
         (blocked 9 4)
         (blocked 3 5)
         (blocked 8 1)
         (blocked 3 7)
       ))
       (goal
        (and
         (at ball1 2 5)
       ))
))