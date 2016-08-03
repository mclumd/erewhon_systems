
(setf *limit* 20)
(setf (current-problem)
      (create-problem
       (name large-3)
       (objects
        (ball1 ball2 BALL))
       (goal
        (and
         (at ball2 14 7)
       ))
       (state
        (and
         (at-robot 8 18)
         (at ball1 7 10)
         (at ball2 17 16)
         (blocked 1 15)
         (blocked 7 18)
         (blocked 15 2)
         (blocked 11 13)
         (blocked 3 6)
         (blocked 8 2)
         (blocked 15 14)
         (blocked 19 8)
         (blocked 5 17)
         (blocked 9 14)
         (blocked 2 4)
         (blocked 6 9)
         (blocked 2 16)
         (blocked 16 11)
         (blocked 0 2)
         (blocked 5 0)
         (blocked 0 11)
         (blocked 4 1)
         (blocked 2 12)
         (blocked 19 16)
         (blocked 5 16)
         (blocked 11 1)
         (blocked 3 16)
         (blocked 4 10)
         (blocked 15 9)
         (blocked 16 4)
         (blocked 12 14)
         (blocked 2 7)
         (blocked 7 4)
         (blocked 10 9)
         (blocked 18 10)
         (blocked 8 11)
         (blocked 8 15)
         (blocked 2 10)
         (blocked 3 7)
         (blocked 7 9)
         (blocked 0 14)
         (blocked 8 13)
         (blocked 19 19)
         (blocked 18 8)
         (blocked 11 11)
         (blocked 17 4)
         (blocked 1 18)
         (blocked 5 11)
         (blocked 8 16)
         (blocked 6 16)
         (blocked 10 13)
         (blocked 15 10)
         (blocked 17 19)
         (blocked 5 19)
         (blocked 19 15)
         (blocked 12 6)
         (blocked 9 5)
         (blocked 9 8)
         (blocked 10 1)
         (blocked 7 16)
         (blocked 6 1)
         (blocked 17 7)
         (blocked 11 19)
         (blocked 18 11)
         (blocked 13 3)
         (blocked 17 15)
         (blocked 4 15)
         (blocked 18 3)
         (blocked 15 11)
         (blocked 8 7)
         (blocked 10 7)
         (blocked 17 17)
         (blocked 8 19)
         (blocked 15 16)
         (blocked 10 18)
         (blocked 1 17)
         (blocked 8 14)
         (blocked 11 3)
         (blocked 11 5)
         (blocked 2 3)
         (blocked 17 8)
         (blocked 14 14)
         (blocked 17 1)
         (blocked 16 1)
         (blocked 7 7)
         (blocked 13 17)
         (blocked 7 8)
         (blocked 16 7)
         (blocked 19 7)
         (blocked 6 0)
         (blocked 17 10)
         (blocked 9 13)
         (blocked 9 11)
         (blocked 16 8)
         (blocked 14 9)
         (blocked 7 15)
         (blocked 10 14)
         (blocked 11 4)
         (blocked 10 11)
         (blocked 0 4)
         (blocked 4 0)
         (blocked 6 4)
         (blocked 1 13)
         (blocked 18 19)
       ))
))