(setf (current-problem)
      (create-problem
       (name fix1)
       (objects
	(wheel1 wheel2 wheel)
	(hub hub)
	(nuts nut)
	(boot container))
       (state
	(and (in jack boot) (in pump boot) (in wheel2 boot) (intact wheel2)
	     (in wrench boot) (on wheel1 hub) (on-ground hub)
	     (tight nuts hub)))
       (goal
	(and (have jack) (have pump) (have wheel2) (have wrench)))))



