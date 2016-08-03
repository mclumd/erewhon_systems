(CONTROL-RULE REJECT-GOTO-EFF
    (IF (and (current-goal (at <sth> <x> <y>))
	     (not (p4::type-of-object <sth> 'ROBOT))))
    (THEN reject operator 'GOTO-LOCATION))

(CONTROL-RULE REJECT-GO-THRU-DOOR
    (IF (and (candidate-operator 'GOTO-LOCATION)
	     (candidate-operator 'GO-THRU-DOOR)
	     (current-goal (at <robot> <x> <y>))
	     (true-in-state (in-room <robot> <room>))
	     (true-in-state (loc-next-to-door <door> <room> <x> <y>))))
    (THEN reject operators GO-THRU-DOOR))

(CONTROL-RULE REJECT-PUSH-THRU-DOOR
    (IF (and (candidate-operator 'PUSH-THRU-DOOR)
	     (candidate-operator 'PUSH-TO-LOCATION)
	     (current-goal (at <obj> <x> <y>))
	     (true-in-state (in-room <obj> <room>))
	     (true-in-state (loc-next-to-door <door> <room> <x> <y>))))
    (THEN reject operators push-thru-door))


(CONTROL-RULE REJECT-T-PUSH-THRU-DOOR
    (IF (and (candidate-operator 'T-PUSH-THRU-DOOR)
	     (candidate-operator 'T-PUSH-TO-LOCATION)
	     (current-goal (at <obj> <x> <y>))
	     (true-in-state (in-room <obj> <room>))
	     (true-in-state (loc-next-to-door <door> <room> <x> <y>))))
    (THEN reject operators T-PUSH-THRU-DOOR))

(CONTROL-RULE PREFER-GOTO
    (IF (and (current-goal (at <robot> <x> <y>))
	     (p4::type-of-object <robot> 'ROBOT)
	     (candidate-operator 'PUSH-TO-LOCATION)
	     (candidate-operator 'GOTO-LOCATION)))
    (THEN prefer operators GOTO-LOCATION PUSH-TO-LOCATION))

(CONTROL-RULE REJECT-GOTO-SAME-LOC
    (IF (and (current-ops (GOTO-LOCATION))
	     (same-loc (<x1> <y1> <x2> <y>))))
    (THEN reject bindings ((<xs> . <x1>) (<ys> . <y1>) (<xdest> . <x2>)
			   (<ydest> . <y2>))))


(defun same-loc (x1 y1 x2 y2)
  (and (= x1 x2) (= y1 y2)))
