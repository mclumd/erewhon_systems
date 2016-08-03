
(setf result '(
   (time 0.65)
   (nodes 16)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 3)
   (solution ((load-rocket robot loca apollo) (move-rocket apollo)
              (unload-rocket robot locb apollo)))))

(setf problem-solved 
   "/afs/cs/project/prodigy-1/analogy/domains/rocket/probs/prob1-robot")
(setf goal '((at robot locb)))

(setf case-objects '((loca locb location) (robot object) (apollo rocket)))

(setf insts-to-vars '(
   (loca . <l.1>) (locb . <l.9>) 
   (robot . <o.86>) 
   (apollo . <r.29>) 
))

(setf footprint-by-goal '(
   ((at robot locb) (at robot loca) (at apollo loca))))
