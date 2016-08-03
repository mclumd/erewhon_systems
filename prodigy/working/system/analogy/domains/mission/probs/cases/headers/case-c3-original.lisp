
(setf result '(
   (time 1.25)
   (nodes 40)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 6)
   (solution ((break-in langley) (steal noc-list langley) (escape langley) (go langley area51) (go area51 london) (drop-off noc-list london)))))

(setf problem-solved 
   "~/Research/Prodigy/analogy/domains/mission/probs/c3-original")
(setf goal '((dropped noc-list london)))

(setf case-objects '((roswell place) (area51 place) (langley place) (london place) (noc-list secret)))

(setf insts-to-vars '(
   (roswell . <place58>) 
   (area51 . <place85>) 
   (langley . <place89>) 
   (london . <place72>) 
   (noc-list . <secret76>) 
))

(setf footprint-by-goal '(
   ((dropped noc-list london) (pass langley area51) (pass area51 london) (stored noc-list langley) (insecure langley) (at langley))))
