(setf (current-problem)
      (create-problem
       (name fix3)
       (objects
	(wheel1 wheel2 wheel)
	(hub hub)
	(nuts nut)
	(boot container))
       (state
	(and (intact wheel2) (have pump) (have wheel2) (have wrench)
	     (on wheel1 hub) (inflated wheel2) (loose nuts hub)))
       (goal
	(and (tight nuts hub) (on-ground hub) (on wheel2 hub)))))






