;;the rules I've been used as of June 8 1993

;;; *****************************************************************
;;before undoing a set-up, see if it can be used by others.
;;Reject that set-up goal and all the subgoals needed by the parent
;;op: this means switch the attention to the subgoals of other
;;machining operator

;;As this rule will be tested in many nodes for the same goal and
;;goal-op, could we cache them (in a hash table)?

;;I replaced candidate-goal with first-candidate-goal only to make it
;;more efficient (it only fires if holding-tool is the first
;;candidate), however this will not work if some preference rule
;;reorders the goals and prefers holding-tool. It would not work
;;also, if holding-tool is not the first set up goal worked on, we may
;;achieve other set-up ops before realizing that we want to switch to
;;other part. It didn't work when there were several (holding-tool
;;...) goals, as only the first one is considered and rejected (the
;;rule is called only once)
;;Note that this is only relevant to order goals for tools in the SAME
;;machine. 

;;If a subgoal belongs both to the current operation (the one for
;;which the tool is set up) and to a rejected one, don't reject it.

;; I run into a problem with (~(has-burrs)) because it was rejected
;; when tried to achieve for hold-with-vise, because it was a subgoal
;; of tap (<goal-op>), but not of counterbore (<op> the current one),
;; but of one of its subgoals (holding with vise). Therefore I changed
;; the rule so it would only fire when we are trying to achieve a
;; main goal (and not a set up goal) This would solve the has-burrs
;; problem and would fire the rule fewer times. 

;; As I assume that changing tools is cheaper than changing
;; fixtures and moving part to other machine, this rule is a prefer
;; rule (so it orders the alts left after the other rules fire)

(control-rule SWITCH-MACH-OPERATION-SAME-TOOL
  (if (and (last-expanded-goal <g>) ;a main goal
	   (goal-instance-of <g>
             size-of shape-of has-hole has-spot is-tapped is-countersinked
	     is-counterbored is-reamed
	     ;surface-finish-side
	     surface-finish-quality-side
	     surface-coating-side surface-coating)	     
	   ;;current set-up
	   (known (holding-tool <mach> <curr-tool>))
	   ;;some open ops need current set-up
	   ;;(make sure it is a pending op!! (not one we've applied))
	   (is-subgoal-of-ops (holding-tool <mach> <curr-tool>) <ops>)
	   (is-subgoal-of-ops <pref-goal> <ops>)
	   ;;this avoids preference cycles
	   (~(is-subgoal-of-ops <other-goal> <ops>))
	   ))
  (then prefer goal <pref-goal> <other-goal>))


#| This rule works, but see comment above
;; April 21 Changed is-subgoal-of-p to is-subgoal-of-ops. The former
;; did not work for testpart3.lisp because several ops have
;; holding-tool as a subgoal, and they reject each other's remaining
;; subgoals (such as holding a part on diff sides) therefore deleting
;; all the goals. In addition, by using is-subgoal-of-ops the rule
;; doesn't fire redundantly 
(control-rule SWITCH-MACH-OPERATION-SAME-TOOL
  (if (and (last-expanded-goal <g>) ;a main goal
	   (goal-instance-of <g>
             size-of shape-of has-hole has-spot is-tapped is-countersinked
	     is-counterbored is-reamed
	     ;surface-finish-side
	     surface-finish-quality-side
	     surface-coating-side surface-coating)	     
	   ;;candidate set-up goal
           (candidate-goal (holding-tool <mach> <tool>))
	   ;(first-candidate-goal (holding-tool <mach> <tool>))
	   ;;current set-up
	   (known (holding-tool <mach> <curr-tool>))
	   ;;some open ops need current set-up
	   ;;(make sure it is a pending op!! (not one we've applied))
	   (is-subgoal-of-ops (holding-tool <mach> <curr-tool>) <ops>)
	   ;;reject candidate goal and the other goals for its same op
	   (is-subgoal-of-ops (holding-tool <mach> <tool>) <goal-ops>)
	   ;;<rej-goal> should include the cand-goal!!
	   (is-subgoal-of-ops <rej-goal> <goal-ops>)
	   (~ (is-subgoal-of-ops <rej-goal> <ops>))
	   ))
  (then reject goals <rej-goal>))
|#

#|This rule works but selects the subgoals of <op>. Therefore can't
solve the problem because the subgoals of hold ops are not selected.
For this to work it would have to be very similar to the reject
version (select the ones not subgoals of the op that requires a
different tool) in which case we wouldn't save much)
(control-rule SWITCH-MACH-OPERATION-SAME-TOOL
  (if (and ;;current set-up
	   (known (holding-tool <mach> <other-tool>))
	   ;;some open op needs current set-up
	   ;;(make sure it is a pending op!! (no one we've applied))
	   (is-subgoal-of-p (holding-tool <mach> <other-tool>) <op>)
	   ;;select the other goals for that operator
	   (is-subgoal-of-p <sel-goal> <op>)))
  (then select goals <sel-goal>))
|#

(control-rule SWITCH-MACH-OPERATION-SAME-HD
  (if (and (candidate-goal
	    (holding <machine> <hd> <part> <side> <s-pair>))
	   ;;current set-up
	   (known (has-device <machine> <other-hd>))
	   (diff <hd> <other-hd>)
	   ;;some open op needs current set-up
	   (candidate-goal
	    (holding <machine> <other-hd> <some-part> <s> <sp>))
	   (is-subgoal-of-p
	    (holding <machine> <other-hd> <some-part> <s> <sp>) <op>) 
	   ;;reject candidate goal and the other goals for its same op
	   (is-subgoal-of-p
	    (holding <machine> <hd> <part> <side> <s-pair>) <goal-op>)
	   ;;<rej-goal> should include the cand-goal!!
	   (is-subgoal-of-p <rej-goal> <goal-op>)))
  (then reject goals <rej-goal>))

;;diff with previous rule: some ops may need the same device but a
;;different set-up (holding a diff side-pair). 
(control-rule SWITCH-MACH-OPERATION-SAME-HD-SETUP
  (if (and (candidate-goal 	      
	    (holding <machine> <hd> <part> <side> <s-pair>))
	   ;;current set-up (<hd> and <some-hd> may be the same)
	   (known (holding <machine> <some-hd> <part> <s> <sp>))
	   (or (diff <side> <s>)
	       (diff <s-pair> <sp>))
	   ;;some open op needs current set-up
	   (is-subgoal-of-ops
	    (holding <machine> <some-hd> <part> <s> <sp>) <ops>)
	   ;;reject candidate goal and the other goals for its same op
	   (is-subgoal-of-ops
	    (holding <machine> <hd> <part> <side> <s-pair>) <goal-ops>)
	   ;;<rej-goal> should include the cand-goal!!
	   (is-subgoal-of-ops <rej-goal> <goal-ops>)
	   (~ (is-subgoal-of-ops <rej-goal> <ops>))))
  (then reject goals <rej-goal>))

;;; ******************************************************************
;;;If there are pending operations on a part in the same machine where
;;;the part is, don't move the part to other machine.

(control-rule SWITCH-MACH-OPERATION-SAME-MACHINE
  (if (and (candidate-goal
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   (known (holding <machine> <some-hd> <part> <s> <sp>))
	   (diff <machine> <new-mach>)
	   ;;some open op will machine the part in the same machine
	   (is-subgoal-of-ops
	    (holding <machine> <some-hd> <part> <s> <sp>) <same-mach-ops>)
	   (is-subgoal-of-ops
	    (holding <new-mach> <hd> <part> <side> <s-pair>) <ops>)
	   (is-subgoal-of-ops <rej-goal> <ops>)
	   (~ (is-subgoal-of-ops <rej-goal> <same-mach-ops>))))
  (then reject goals <rej-goal>))

;;reject goals for ops that use a different machine.
;;next rule deals with cases different from those in
;;switch-mach-operation-same-machine, 
;;as the same machine may be used by several operations without having
;;exactly the same set-up (side, hd, side-pair). We'd save the
;;put-on-machine-table operation. The cases captured by
;;switch-mach-operation-same-machine are not here because the current
;;set-up
;;(known (holding <machine> <curr-hd> <part> <curr-s> <curr-sp>)) is
;;true in the state and therefore not a candidate goal, but satisfies
;;is-subgoal-of-ops.

;;We might generalize both with something like (I haven't tried it):
;;   (known (on-table <machine> <part>))
;;   (or-metapred
;;     (known (holding <machine> <some-hd> <part> <some-s> <some-sp>))
;;     (candidate-goal (holding <machine> <some-hd> <part> <some-s> <some-sp>)))
;;   (is-subgoal-of-ops
;;     (holding <machine> <some-hd> <part> <some-s> <some-sp>) <same-mach-ops>)

;;I need (candidate-goal ...) to get bindings for <some...> or else
;;is-subgoal-of-ops gives an error

(control-rule SWITCH-MACH-OPERATION-SAME-MACHINE2
  (if (and (candidate-goal
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   ;;current set-up
	   ;;(known (on-table <machine> <part>))
	   (known (holding <machine> <curr-hd> <part> <curr-s> <curr-sp>))
	   (diff <machine> <new-mach>)
	   ;;I need this to get bindings for <some...> or else
	   ;;is-subgoal-of-ops gives an error 
	   (candidate-goal (holding <machine> <some-hd> <part> <some-s> <some-sp>))
	   ;;some open op will machine the part in the same machine
	   (is-subgoal-of-ops
	    (holding <machine> <some-hd> <part> <some-s> <some-sp>) <same-mach-ops>)
	   (is-subgoal-of-ops
	    (holding <new-mach> <hd> <part> <side> <s-pair>) <ops>)
	   (is-subgoal-of-ops <rej-goal> <ops>)
	   (~ (is-subgoal-of-ops <rej-goal> <same-mach-ops>))))
  (then reject goals <rej-goal>))


#|
;as switch-mach-operation-same-machine2 but for has-device (instead of
;for on-table). It is more specific (setup to keep is mach + hd, while
;for on-table is only mach). Works for simple7. 
(control-rule temp1
  (if (and (candidate-goal
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   ;;current set-up
	   ;;(known (on-table <machine> <part>))
	   (known (holding <machine> <curr-hd> <part> <curr-s> <curr-sp>))
	   (diff <machine> <new-mach>)
	   ;;I need this to get bindings for <some...> or else
	   ;;is-subgoal-of-ops gives an error 
	   (candidate-goal (holding <machine> <curr-hd> <part> <some-s> <some-sp>))
	   ;;some open op will machine the part in the same machine
	   (is-subgoal-of-ops
	    (holding <machine> <curr-hd> <part> <some-s> <some-sp>) <same-mach-ops>)
	   (is-subgoal-of-ops
	    (holding <new-mach> <hd> <part> <side> <s-pair>) <ops>)
	   (is-subgoal-of-ops <rej-goal> <ops>)
	   (~ (is-subgoal-of-ops <rej-goal> <same-mach-ops>))))
  (then reject goals <rej-goal>))
|#
