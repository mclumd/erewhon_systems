
(setf result '(
   (time 0.583)
   (nodes 17)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 3)
   (solution ((load-rocket hammer loca apollo) (move-rocket apollo)
              (unload-rocket hammer locb apollo)))))

(setf goal '((at hammer locb)))
(setf initial-state '((at apollo loca) (at hammer loca)))

(setf case-objects '((loca locb location) (hammer object) (apollo rocket)))
(setf insts-to-vars '(
   (loca . <l1>) (locb . <l54>) 
   (hammer . <o44>) 
   (apollo . <r1>) 
))

(setf footprint-by-goal '(
   ((at hammer locb))))
