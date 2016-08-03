
(setf result '(
   (time 3.35)
   (nodes 82)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 4)
   (solution ((break-in langley) (steal noc-list langley) (escape langley) (go langley london)))))

(setf problem-solved 
   "~/Research/Prodigy/analogy/domains/mission/probs/compete-original")
(setf goal '((holding noc-list) (at london)))

(setf case-objects '((roswell place) (area51 place) (langley place) (london place) (noc-list secret)))

(setf insts-to-vars '(
   (roswell . <place1>) 
   (area51 . <place9>) 
   (langley . <place86>) 
   (london . <place29>) 
   (noc-list . <secret66>) 
))

(setf footprint-by-goal '(
   ((at london) (pass langley london) (insecure langley) (at langley))
   ((holding noc-list) (stored noc-list langley) (insecure langley) (at langley))))
