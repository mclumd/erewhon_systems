(setf (current-problem)
      (create-problem
       (name fix5)
       (objects
	(wheel1 wheel2 wheel)
	(hub hub)
	(nuts nut)
	(boot container))
       (state
	(and (open boot) (in jack boot) (in pump boot) (in wheel1 boot)
	     (in wrench boot) (inflated wheel2) (on wheel2 hub)
	     (tight nuts hub)))
       (goal
	(and (~ (open boot)) (in jack boot) (in pump boot)
	     (in wheel1 boot) (in wrench boot) (inflated wheel2)
	     (on wheel2 hub) (tight nuts hub)))))




