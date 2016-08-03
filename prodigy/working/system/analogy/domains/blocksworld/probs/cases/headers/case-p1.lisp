
(setf result '(
   (time 0.05)
   (nodes 12)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 2)
   (solution ((put-down a) (infer-armempty)))))

(setf problem-solved 
   "~/Research/Prodigy/analogy/domains/blocksworld/probs/p1")
(setf goal '((arm-empty)))

(setf case-objects '((a b c object)))

(setf insts-to-vars '(
   (a . <object8>) (b . <object13>) (c . <object24>) 
))

(setf footprint-by-goal '(
   ((arm-empty) (holding a))))
