;;; ***************************************************************
;;; Expand the machining goals first. By this I mean the goals not
;;; related to set-ups. Ex Size-of, surface-finish, etc.

;;; set-up goals (from machining op preconds) are:
;;;   holding, holding-weakly, holding-tool,
;;;   has-fluid, hardness-of, (~(has-burrs)), is-clean, on-table.
;;;
;;; set-up goals (from set-up op preconds) are:
;;;   for holding-tool: is-available-tool, is-available-tool-holder
;;;   for has-device: is-available-table, is-available-holding-device
;;;   for on-table: is-available-machine, is-available-part
;;;   for has-center-holes: has-center-hole, is-countersinked

;;; what about: shape-of

;;Warning! This rule does not include surface-finish-side because
;;then, if surface-finish-side is a candidate goal, and size-of has
;;been expanded, SURFACE-SIDE-EFFECT would fire. IF that happens after
;;EXPAND-MAIN-GOALS-FIRST fires, all the goals would be rejected
;;(I don't want to depend on the order the control rules are given)

(control-rule EXPAND-MAIN-GOALS-FIRST
  (if (and (candidate-goal <goal>)
	   (goal-instance-of <goal>
             size-of shape-of has-hole has-spot is-tapped is-countersinked
	     is-counterbored is-reamed
	     ;surface-finish-side
	     surface-finish-quality-side
	     surface-coating-side surface-coating)	     
	   (candidate-goal <other-goal>)
	   (~ (goal-instance-of <other-goal>
             size-of shape-of has-hole has-spot is-tapped is-countersinked
	     is-counterbored is-reamed
	     ;surface-finish-side
	     surface-finish-quality-side
	     surface-coating-side surface-coating))))
  (then reject goal <other-goal>))

