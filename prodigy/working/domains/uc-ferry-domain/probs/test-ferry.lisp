(setf (current-problem)
      (create-problem
       (name test-ferry)
       (objects
	(objects-are a b PLACE)
	(objects-are c1 c2 AUTO))
       (state (and (at c1 a)(at c2 a)(at-ferry a)(empty-ferry))) 
       (goal (and (at c1 b)(at c2 b)))))


;;;Solution:
;;;        <board c1 a>
;;;        <sail a b>
;;;        <debark c1 b>
;;;        <sail b a>
;;;        <board c2 a>
;;;        <sail a b>
;;;        <debark c2 b>
;;;(((:STOP . :ACHIEVE) . #<APPLIED-OP-NODE 33 #<DEBARK [<X> C2] [<Y> B]>>) #<BOARD [<X> C1] [<Y> A]>

