(setf (current-problem)
      (create-problem
       (name hanoi)
       (objects
	(objects-are d1 d2 d3 Disk)
	(objects-are p1 p2 p3 Peg-or-disk))
       (state
	(and
	 (SMALLER D1 P1) (SMALLER D2 P1) (SMALLER D3 P1)
	 (SMALLER D1 P2) (SMALLER D2 P2) (SMALLER D3 P2)
	 (SMALLER D1 P3) (SMALLER D2 P3) (SMALLER D3 P3)
	 (SMALLER D1 D2) (SMALLER D1 D3) (SMALLER D2 D3) 
	 (CLEAR P1)(CLEAR P2) (CLEAR D1)	 
	 (ON D1 D2) (ON D2 D3) (ON D3 P3)))
       (goal (and (ON D1 D2) (ON D2 D3) (ON D3 P1)))))



;;;Solution:
;;;        <move-disk d1 d2 p2>
;;;        <move-disk d1 p2 p1>
;;;        <move-disk d2 d3 p2>
;;;        <move-disk d1 p1 d3>
;;;        <move-disk d1 d3 d2>
;;;        <move-disk d3 p3 p1>
;;;        <move-disk d1 d2 p3>
;;;        <move-disk d2 p2 d3>
;;;        <move-disk d1 p3 d2>
;;;
;;;
;;;(((:STOP . :ACHIEVE)
;;;  . #<APPLIED-OP-NODE 48 #<MOVE-DISK [<DISK> D1] [<BELOW-DISK> P3] [<NEW-BELOW-DISK> D2]>>)
