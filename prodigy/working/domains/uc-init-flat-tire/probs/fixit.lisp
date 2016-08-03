(setf (current-problem)
      (create-problem
       (name fixit)
       (objects
	(wheel1 wheel2 wheel)
	(hub hub)
	(nuts nut)
	(boot container))
       (state
	(and (intact wheel2) (in jack boot) (in pump boot) (in wheel2 boot)
	     (in wrench boot) (on wheel1 hub) (on-ground hub)
	     (tight nuts hub)))
       (goal
	(and (~ (open boot)) (in jack boot) (in pump boot)
	     (in wheel1 boot) (in wrench boot)
	     (inflated wheel2) (on wheel2 hub)))))





