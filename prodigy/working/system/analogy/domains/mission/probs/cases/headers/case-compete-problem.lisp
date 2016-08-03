
(setf result '(
   (time 0.484)
   (nodes 32)
   (exhaustedp NIL)
   (solutionp T)
   (solution-length 7)
   (solution ((BREAK-IN LANGLEY) (STEAL X-FILE LANGLEY) (STEAL NOC-LIST LANGLEY) (ESCAPE LANGLEY) (GO LANGLEY LONDON) (DROP-OFF X-FILE LONDON)
              (DROP-OFF NOC-LIST LONDON)))))

(setf problem-solved 
   "~/Research/Prodigy/analogy/domains/mission/probs/compete-problem")
(setf goal '((DROPPED NOC-LIST LONDON) (DROPPED X-FILE LONDON)))

(setf case-objects '((LANGLEY PLACE) (LONDON PLACE) (NOC-LIST SECRET) (X-FILE SECRET)))

(setf insts-to-vars '(
   (LANGLEY . <PLACE81>) 
   (LONDON . <PLACE50>) 
   (NOC-LIST . <SECRET37>) 
   (X-FILE . <SECRET64>) 
))

(setf footprint-by-goal '(
   ((DROPPED X-FILE LONDON) (PASS LANGLEY LONDON) (STORED X-FILE LANGLEY) (INSECURE LANGLEY) (AT LANGLEY))
   ((DROPPED NOC-LIST LONDON) (PASS LANGLEY LONDON) (STORED NOC-LIST LANGLEY) (INSECURE LANGLEY) (AT LANGLEY))))
