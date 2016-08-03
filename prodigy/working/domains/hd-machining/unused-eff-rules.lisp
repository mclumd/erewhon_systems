#|
(control-rule make-another-spot
  (if (and (candidate-goal
	    (has-spot <part> <hole2> <side> <x2> <y2>))
	   (known (holding <machine> <holding-device> <part> <side>))
	   (known (holding-tool <machine> <spot-drill>))
	   (type-of-object <spot-drill> SPOT-DRILL)))
  (then prefer goal (has-spot <part> <hole2> <side> <x2> <y2>)
                    <other>))

(control-rule make-another-hole
  (if (and (candidate-goal
	    (has-hole <part> <hole> <side> <depth> <diam> <x> <y>)) 
	   (known (holding <machine> <holding-device> <part> <side>))
	   (known (holding-tool <machine> <drill-bit>))
	   (type-of-object <drill-bit> DRILL-BIT)
	   (~ (type-of-object <drill-bit> SPOT-DRILL))))
  (then prefer goal (has-hole <part> <hole> <side> <depth> <diam> <x> <y>)
                    <other>))
|#


;;; ************************************************************
#|
(control-rule ASK-FOR-OPERATOR
  (if (and (current-goal <goal>)
	   (at-node)
	   (only-once)
	   (user-given-operator <op>)))
  (then prefer operator <op> <other-op>))

(control-rule ASK-FOR-BINDINGS
  (if (and (current-goal <goal>)
	   (at-node)
	   (only-once)
	   (user-given-bindings <bindings>)))
  (then prefer bindings <bindings> <other-op>))
|#
;;; ************************************************************

;;prefer to do all operations in same part consecutively
#|
(control-rule Q1
  (if (and (last-achieved-goal <prev-goal>)
	   ;;part it was working on
	   (goal-first-arg <prev-goal> <part>)
	   (type-of-object <part> PART)
	   ;;new suggested part
	   (goal-first-arg <other-goal> <other-part>)
	   (type-of-object <other-part> PART)
	   ;;other candidates parts
	   (candidate-goal <goal>)
	   (goal-first-arg <goal> <part>)

  (then prefer goal <goal> <other-goal>))
|#	   

#|
;;choose fine/rough grind depending on the size reduction. If
;;reduction is large, and finish operator is used, the part will have
;;to be cut again to achieve the proper size reduction. 

;;can't put FINISH-GRIND directly in the rhs (matcher gets confused)
(control-rule Q2
  (if (and (current-goal (surface-finish-quality-side <p> <sd> GROUND))
	   (current-operator IS-GROUND-SURFACE-QUALITY)
	   (candidate-goal-to-sel (size-of <p> <dim> <new-size>))
	   (known (side-up-for-machining <dim> <sd>))
	   (known (size-of <p> <dim> <old-size>))
	   (~(finishing-size <old-size> <new-size>))
	   (same <finish> FINISH-GRIND)))
  (then reject bindings	((<sf> . <finish>))))
|#

#|
;;before undoing a set-up, see if it can be used by others

;;note that pending-goal is false if the goal is true in the state
;;(after I fixed a bug in test-match-goals)
(control-rule POSTPONE-REMOVE-TOOL
  (if (and (applicable-operator
	    (remove-tool-from-machine <machine> <tool>))
	   (pending-goal (holding-tool <machine> <tool>))))
  (then sub-goal))
;  (then apply)
|#

