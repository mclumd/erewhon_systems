
(setf result '(
   (time 3.383)
   (nodes 117)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 5)
   (solution ((go langley area51) (break-in area51) (steal noc-list area51) (escape area51) (go area51 london)))))

(setf problem-solved 
   "~/Research/Prodigy/analogy/domains/mission/probs/c2-hard")
(setf goal '((holding noc-list) (at london)))

(setf case-objects '((roswell place) (area51 place) (langley place) (london place) (noc-list secret)))

(setf insts-to-vars '(
   (roswell . <place85>) 
   (area51 . <place69>) 
   (langley . <place92>) 
   (london . <place70>) 
   (noc-list . <secret49>) 
))

(setf footprint-by-goal '(
   ((at london) (pass area51 london) (insecure area51) (pass langley area51) (at langley))
   ((holding noc-list) (stored noc-list area51) (insecure area51) (pass langley area51) (at langley))))
