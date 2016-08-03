
(setf result '(
   (time 0.117)
   (nodes 16)
   (exhaustedp NIL)
   (solutionp T)
   (solution-length 3)
   (solution ((PUT-DOWN A) (INFER-ARMEMPTY) (PICK-UP B)))))

(setf problem-solved 
   "/afs/cs/user/centaur/Research/Prodigy/analogy/domains/blocksworld/probs/p3")
(setf goal '((HOLDING B)))

(setf case-objects '((A B C OBJECT)))

(setf insts-to-vars '(
   (A . <OBJECT93>) (B . <OBJECT49>) (C . <OBJECT34>) 
))

(setf footprint-by-goal '(
   ((HOLDING B) (CLEAR B) (ON-TABLE B) (~ (HOLDING C)) (~ (HOLDING B)) (HOLDING A))))
