(setf (current-problem)
      (create-problem
       (name HotWater)
       (objects
         (somewater water)
          (mypan dutch-oven) )
       (state
        (and (is-clear somewater)
              (is-empty mypan)
        ))
       (goal
             (is-boiling-water somewater ) 
       )
     )
      )
