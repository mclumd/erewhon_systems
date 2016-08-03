
(setf result '(
   (time 0.3)
   (nodes 16)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 3)
   (solution ((load-rocket blancmange loca apollo) (move-rocket apollo)
              (unload-rocket blancmange locb apollo)))))

(setf goal '((at blancmange locb)))
(setf initial-state '((at apollo loca) (at blancmange loca)))

(setf case-objects '((loca locb location) (blancmange object) (apollo rocket)))
(setf insts-to-vars '(
   (loca . <l96>) (locb . <l77>) 
   (blancmange . <o39>) 
   (apollo . <r74>) 
))

(setf footprint-by-goal '(
   ((at blancmange locb) (at blancmange loca) (at apollo loca))))
