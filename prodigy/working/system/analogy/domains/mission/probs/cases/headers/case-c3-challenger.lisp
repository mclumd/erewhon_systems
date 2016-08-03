
(setf result '(
   (time 0.85)
   (nodes 43)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 6)
   (solution ((go roswell langley) (go langley area51) (break-in area51) (steal noc-list area51) (escape area51) (go area51 london)))))

(setf problem-solved 
   "~/Research/Prodigy/analogy/domains/mission/probs/c3-challenger")
(setf goal '((holding noc-list) (at london)))

(setf case-objects '((roswell place) (area51 place) (langley place) (london place) (noc-list secret)))

(setf insts-to-vars '(
   (roswell . <place90>) 
   (area51 . <place79>) 
   (langley . <place66>) 
   (london . <place26>) 
   (noc-list . <secret8>) 
))

(setf footprint-by-goal '(
   ((at london) (pass area51 london) (insecure area51) (pass langley area51) (pass roswell langley) (at roswell))
   ((holding noc-list) (stored noc-list area51) (insecure area51) (pass langley area51) (pass roswell langley) (at roswell))))
