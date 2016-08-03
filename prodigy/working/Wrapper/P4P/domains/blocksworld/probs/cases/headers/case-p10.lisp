
(setf result '(
   (time 0.01)
   (nodes 12)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 2)
   (solution ((pick-up blocka) (stack blocka blockb)))))

(setf problem-solved 
   "/usr/local/mcox/Research/ABMIC/Boris/domains/blocksworld/probs/p10")
(setf goal '((on blocka blockb)))

(setf case-objects '((objects-are blocka blockb object)))

(setf insts-to-vars '(
   (blocka . <object.46>) (blockb . <object.65>) 
))

(setf footprint-by-goal '(
   ((on blocka blockb) (clear blockb) (arm-empty) (on-table blocka) (clear blocka))))
