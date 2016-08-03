
(setf result '(
   (time 1.25)
   (nodes 59)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 5)
   (solution ((break-in langley) (steal noc-list langley) (escape langley) (go langley london) (drop-off noc-list london)))))

(setf problem-solved 
   "/afs/cs/user/centaur/Research/Prodigy/analogy/domains/mission/probs/simple-1")
(setf goal '((dropped noc-list london)))

(setf case-objects '((langley place) (london place) (noc-list secret)))

(setf insts-to-vars '(
   (langley . <place51>) 
   (london . <place94>) 
   (noc-list . <secret53>) 
))

(setf footprint-by-goal '(
   ((dropped noc-list london) (pass langley london) (stored noc-list langley) (insecure langley) (at langley))))
