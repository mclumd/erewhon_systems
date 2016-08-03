(setf (current-problem)
      (create-problem
       (name fix2)
       (objects
	(wheel1 wheel2 wheel)
	(hub hub)
	(nuts nut)
	(boot container))
       (state
	(and (open boot) (have jack) (have pump) (have wheel2) (have wrench)
	     (on wheel1 hub) (on-ground hub) (tight nuts hub)))
       (goal
	(and (inflated wheel2) (~ (on-ground hub)) (loose nuts hub)))))





