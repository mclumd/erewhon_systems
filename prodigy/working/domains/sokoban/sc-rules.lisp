;;; sokoban control rules - Manuela

;;;*****************************************************************
;;; Take care of walls

(control-rule cannot-move-off-wall
  (if (and (candidate-goal-to-sel (at <ball> <x> <y>))
	   (true-in-state (at <ball> <x-now> <y-now>))
	   (conflict-wallp <x> <x-now> <y> <y-now>)))
  (then reject goal (at <ball> <x> <y>)))

;;;*****************************************************************
;;; Focus on ball first

(control-rule work-on-ball
  (if (candidate-goal-to-sel (at <ball> <locx> <locy>)))
  (then select goal (at <ball> <locx> <locy>)))

;;;*****************************************************************
;;; Primary effects

(control-rule no-push-n-robot
  (if (current-goal (at-robot <x> <y>)))
  (then reject operator PUSH-N))

(control-rule no-push-s-robot
  (if (current-goal (at-robot <x> <y>)))
  (then reject operator PUSH-S))

(control-rule no-push-e-robot
  (if (current-goal (at-robot <x> <y>)))
  (then reject operator PUSH-E))

(control-rule no-push-w-robot
  (if (current-goal (at-robot <x> <y>)))
  (then reject operator PUSH-W))

;;;*****************************************************************
;;; Use Euclidian distance - just one step lookahead

(control-rule prefer-single-move
  (if (and (current-goal (at-robot <locx> <locy>))
	   (true-in-state (at-robot <locx-c> <locy-c>))
	   (candidate-operator <op>)
	   (e-closer-single-move <op> <other-op>
				 <locx> <locy> <locx-c> <locy-c>)))
  (then prefer operator <op> <other-op>))

(control-rule prefer-single-push
  (if (and (current-goal (at <ball> <locx> <locy>))
	   (true-in-state (at <ball> <locx-c> <locy-c>))
	   (candidate-operator <op>)
	   (e-closer-single-push <op> <other-op>
				 <locx> <locy> <locx-c> <locy-c>)))
  (then prefer operator <op> <other-op>))

;;;*****************************************************************
