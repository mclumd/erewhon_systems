;;rules learned with older method
;; from tst6-info.lisp

(control-rule prefer-goal-9
	      (if (and (candidate-goal (~ (holding-tool <machine> <milling-cutter-1>)))
		       (known (holding-tool <machine> <milling-cutter-1>))
		       (is-subgoal-of-ops (holding-tool <machine> <milling-cutter-1>) <ops>)
		       (first-pending-subgoal-in-subtree <pref-goal> <ops>)
		       (~ (is-subgoal-of-ops <other-goal> <ops>))))
	      (then prefer goal <pref-goal> <other-goal>))

;;from tst7-info.lisp
(control-rule prefer-goal-157
	      (if (and (candidate-goal (holding <machine-2> <vise06> <part> <side27>
						<side1-side48>))
		       (known (on-table <machine-1> <part>))
		       (pending-goal (holding <machine-1> <vise03> <part> <side14>
					      <side3-side65>))
		       (is-subgoal-of-ops (holding <machine-1> <vise03> <part> <side14>
						   <side3-side65>)
					  <ops>)
		       (diff <machine-2> <machine-1>)
		       (first-pending-subgoal-in-subtree <pref-goal> <ops>)
		       (diff <pref-goal> <other-goal>)
		       (~ (is-pending-subgoal-in-subtree <other-goal> <ops>))))
	      (then prefer goal <pref-goal> <other-goal>))

       (control-rule prefer-goal-156
                     (if (and (candidate-goal (holding <machine-2> <holding-device> <part06>
                                               <side27> <side1-side48>))
                              (known (has-device <machine-1> <holding-device>))
                              (or-metapred (known (holding <machine-1> <holding-device> <part03>
                                                   <side24> <side3-side65>))
                                           (pending-goal (holding <machine-1> <holding-device>
                                                          <part03> <side24> <side3-side65>)))
                              (is-subgoal-of-ops (holding <machine-1> <holding-device> <part03>
                                                  <side24> <side3-side65>)
                                                 <ops>)
                              (diff <machine-2> <machine-1>)
                              (first-pending-subgoal-in-subtree <pref-goal> <ops>)
                              (diff <pref-goal> <other-goal>)
                              (~ (is-pending-subgoal-in-subtree <other-goal> <ops>))))
                     (then prefer goal <pref-goal> <other-goal>)))


;;form tst8-info.lisp

(control-rule prefer-goal-164
	      (if (and (candidate-goal (~ (holding-tool <machine> <drill-bit-1>)))
		       (known (holding-tool <machine> <drill-bit-1>))
		       (is-subgoal-of-ops (holding-tool <machine> <drill-bit-1>) <ops>)
		       (first-pending-subgoal-in-subtree <pref-goal> <ops>)
		       (diff <pref-goal> <other-goal>)
		       (~ (is-pending-subgoal-in-subtree <other-goal> <ops>))))
	      (then prefer goal <pref-goal> <other-goal>))

(control-rule prefer-goal-165
	      (if (and (candidate-goal (holding-tool <machine> <twist-drill12>))
		       (is-subgoal-of-ops (holding-tool <machine> <twist-drill12>) <ops>)
		       (pending-goal (holding-tool <machine> <spot-drill01>))
		       (is-subgoal-of-ops (holding-tool <machine> <spot-drill01>)
					  <other-ops>)
		       (is-goal-achieved-by-ops <g> <other-ops>)
		       (is-subgoal-of-ops <g> <ops>)
		       (first-pending-subgoal-in-subtree <pref-goal> <other-ops>)
		       (~ (is-pending-subgoal-in-subtree <other-goal> <other-ops>))))
	      (then prefer goal <pref-goal> <other-goal>))