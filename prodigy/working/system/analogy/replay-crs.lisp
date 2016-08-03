;============================================================================

(control-rule ASK-FOR-GOAL
  (if (and
       (analogy-get-guidance-goal <goal>)))
  (then select goal <goal>))


(control-rule ASK-FOR-OPERATOR
  (if (and
       (analogy-get-guidance-operator <operator>)))
  (then select operator <operator>))

(control-rule ASK-FOR-BINDINGS
  (if (and 
       (analogy-get-guidance-bindings <bindings>)))
  (then select bindings <bindings>))

(control-rule GUIDED-SUBGOAL
  (if (and 
       (analogy-decide-subgoal)))
  (then sub-goal))

(control-rule GUIDED-APPLY
  (if (and 
       (analogy-decide-apply)))
  (then apply))


;============================================================================
