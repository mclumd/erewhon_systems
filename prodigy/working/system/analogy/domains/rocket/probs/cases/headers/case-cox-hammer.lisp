
(setf result '(
   (time 0.583)
   (nodes 16)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 3)
   (solution ((load-rocket hammer loca apollo) (move-rocket apollo)
              (unload-rocket hammer locb apollo)))))

(setf problem-solved 
   "/afs/cs/project/prodigy-1/analogy/domains/rocket/probs/prob1-hammer")
(setf goal '((at hammer locb)))

(setf case-objects '((loca locb location) (hammer object) (apollo rocket)))

(setf insts-to-vars '(
   (loca . <l.81>) (locb . <l.50>) 
   (hammer . <o.37>) 
   (apollo . <r.64>) 
))

(setf footprint-by-goal '(
   ((at hammer locb) (at hammer loca) (at apollo loca))))
