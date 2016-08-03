#|
;;; Juergen's example
X X X X X X X X
X . . . . . . X
X . X X X B . X
X . X . . . . X
X . . . . M . X
D . . X X X . X
X . . . . . . X
X X X X X X X X

.  free place
X  Wall
D  door = goal place
B  ball
M  man
|#

(setf *limit* 7) ;coordinates range from 0 to 7
(setf (current-problem)
      (create-problem
       (name j-ball13)
       (objects
        (ball1 BALL))
       (goal
        (and
         (at ball1 1 3)
	 ))
       (state
        (and
	 (at-robot 5 3)
         (at ball1 5 5)

	 (blocked 0 0)  
	 (blocked 0 1)
	 (blocked 0 3)
	 (blocked 0 4)
	 (blocked 0 5)
	 (blocked 0 6)
	 (blocked 0 7)

	 (blocked 7 0)
	 (blocked 7 1)
	 (blocked 7 2)
	 (blocked 7 3)
	 (blocked 7 4)
	 (blocked 7 5)
	 (blocked 7 6)
	 (blocked 7 7)

	 (blocked 1 7)
	 (blocked 2 7)
	 (blocked 3 7)
	 (blocked 4 7)
	 (blocked 5 7)
	 (blocked 6 7)

	 (blocked 1 0)
	 (blocked 2 0)
	 (blocked 3 0)
	 (blocked 4 0)
	 (blocked 5 0)
	 (blocked 6 0)

	 (blocked 3 2)
	 (blocked 4 2)
	 (blocked 5 2)

	 (blocked 2 4)
	 (blocked 2 5)	 
	 (blocked 3 5)
	 (blocked 4 5)
	 ))
       ))
