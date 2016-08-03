
(setf result '(
   (time 0.733)
   (nodes 25)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 5)
   (solution (((load-rocket newcastle-brown-ale london))
              ((load-rocket kippers london)) ((move-rocket-fast))
              ((unload-rocket kippers pittsburgh) case-node)
              ((unload-rocket newcastle-brown-ale pittsburgh))))))

(setf goal '((at newcastle-brown-ale pittsburgh) (at kippers pittsburgh)))
(setf initial-state '((at rocket london) (at newcastle-brown-ale london)
                      (at kippers london)))

(setf case-objects 'nil)
(setf insts-to-vars '(
))

(setf footprint-by-goal '(
   ((at kippers pittsburgh) (at kippers london) (at rocket london))
   ((at newcastle-brown-ale pittsburgh) (at rocket london)
    (at newcastle-brown-ale london))))
