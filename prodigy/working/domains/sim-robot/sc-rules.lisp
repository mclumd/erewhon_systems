
(control-rule PUTDOWN-FOR-ARM-EMPTY
  (if (and (current-goal (arm-empty))
	   (current-operator PUTDOWN)
	   (known (holding <obj>))))
  (then select bindings ((<o2> . <obj>)(<other> . <anything>))))

(control-rule GOTO-OBJ-ROOM
  (if (and (current-goal  (next-to robot <object>))
	   (type-of-object <object> OBJECT)
	   (current-operator GOTO-OBJ)
	   (known (inroom <object> <room>))))
  (then select bindings ((<b> . <object>)(<rm> . <room>))))


(control-rule GO-THRU-LOCKED-DR
  (if (and (current-goal (inroom robot <room>))
	   (current-operator GO-THRU-DR)
	   (known (dr-to-rm <door> <room>))
	   (known (locked <door>))
	   (known (~ (is-key <door> <k1>)))))
  (then reject bindings ((<ddx> . <door>))))
;(<rry> . <anything>)
	   
#|
(control-rule GOTO-DR-ROOM
  (if (and (current-operator GOTO-DR)
	   (partial-bindings-from-goal <pb>)
	   (ana-gen-bindings <pb> <bindings>)))
  (then select bindings <bindings>))


 ((<dx> . <d>) (<rx> . <r>))))

(defun ana-gen-bindings (pb b)
  (list (cons b
	      (list
	       (cons '<dx> (p4::object-name-to-object 'door34 *current-problem-space*))
	       (cons '<rx> (p4::object-name-to-object 'room3 *current-problem-space*))))))
|#

(control-rule GOTO-DR-ROOM
  (if (and (current-goal  (next-to robot <door>))
	   (type-of-object <door> DOOR)
	   (current-operator GOTO-DR)
	   (known (inroom robot <room>))
	   (known (dr-to-rm <door> <room>))))  
  (then select bindings ((<dx> . <door>)(<rx> . <room>))))

;;;rules from Prodigy2.0 version
#|
(control-rule ONLY-PUSH-BOX
  (if (and (current-goal  (next-to robot <x>))
	   (candidate-operator  PUSH-BOX)))
  (then reject operator PUSH-BOX))
|#
(control-rule ONLY-GOTO-DR
  (if (and (current-goal  (next-to robot <x>))
	   (type-of-object <x> DOOR)))
  (then select operator GOTO-DR))

(control-rule ONLY-GOTO-OBJ
  (if (and (current-goal  (next-to robot <x>))
	   (type-of-object <x> OBJECT)))
  (then select operator GOTO-OBJ))

(control-rule ONLY-CARRY-BOX-THRU-DOOR
  (if (and (current-goal  (inroom robot <x>))
	   (candidate-operator  CARRY-THRU-DR)))
  (then reject operator CARRY-THRU-DR))

(control-rule ONLY-PUSH-BOX-THRU-DOOR1
  (if (and (current-goal  (inroom robot <x>))
	   (candidate-operator  PUSH-THRU-DR)))
  (then reject operator PUSH-THRU-DR))

(control-rule ONLY-PUSH-BOX-THRU-DOOR2
  (if (and (current-goal  (next-to <y> <x>))
	   (candidate-operator  PUSH-THRU-DR)))
  (then reject operator PUSH-THRU-DR))

(control-rule ONLY-PUTDOWN-NEXT-TO-1
  (if (and (current-goal  (arm-empty))
	   (candidate-operator  PUTDOWN-NEXT-TO)))
  (then reject operator PUTDOWN-NEXT-TO))

(control-rule ONLY-PUTDOWN-NEXT-TO-2
  (if (and (current-goal  (inroom <xx> <yy>))
	   (candidate-operator  PUTDOWN-NEXT-TO)))
  (then reject operator PUTDOWN-NEXT-TO))
