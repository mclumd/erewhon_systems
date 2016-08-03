
(setf result '(
   (time 0.35)
   (nodes 17)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 3)
   (solution ((load-rocket robot loca apollo) (move-rocket apollo)
              (unload-rocket robot locb apollo)))))

(setf goal '((at robot locb)))
(setf initial-state '((at apollo loca) (at robot loca)))

(setf case-objects '((loca locb location) (robot object) (apollo rocket)))
(setf insts-to-vars '(
   (loca . <l20>) (locb . <l15>) 
   (robot . <o77>) 
   (apollo . <r31>) 
))

(setf footprint-by-goal '(
   ((at robot locb) (at robot loca) (at apollo loca))))
