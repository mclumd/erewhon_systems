(setf (current-problem)
      (create-problem
       (name fix4)
       (objects
	(wheel1 wheel2 wheel)
	(hub hub)
	(nuts nut)
	(boot container))
       (state
	(and (intact wheel2) (have jack) (have pump) (have wheel1)
	     (have wrench) (open boot) (inflated wheel2)
	     (on wheel2 hub) (tight nuts hub) (on-ground hub)))
       (goal
	(and (in jack boot) (in pump boot) (in wheel1 boot)
	     (in wrench boot) (inflated wheel2) (on wheel2 hub)
	     (tight nuts hub)))))






