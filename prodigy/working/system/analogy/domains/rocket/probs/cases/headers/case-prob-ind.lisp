
(setf result '(
   (time 0.65)
   (nodes 35)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 6)
   (solution ((load-rocket hammer loca r2) (move-rocket r2) (unload-rocket hammer locb r2)
              (load-rocket robot loca r1) (move-rocket r1) (unload-rocket robot locb r1)))))

(setf problem-solved 
   "/usr/mmv/p1/analogy/domains/rocket/probs/prob-ind")
(setf goal '((at hammer locb) (at robot locb)))

(setf case-objects '((loca locb location) (hammer robot object) (r1 r2 rocket)))

(setf insts-to-vars '(
   (loca . <l86>) (locb . <l29>) 
   (hammer . <o66>) (robot . <o22>) 
   (r1 . <r65>) (r2 . <r72>) 
))

(setf footprint-by-goal '(
   ((at robot locb) (at r1 loca) (at robot loca))
   ((at hammer locb) (at hammer loca) (at r2 loca))))
