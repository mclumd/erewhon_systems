(control-rule prefer-bnds-drill-spot-milling-machine2
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (current-operator drill-spot-milling-machine)
		       (known (holding-tool <machine-3> <drill-bit-4>))
		       (or (diff <machine-3> <machine-1>) (diff <drill-bit-4> <drill-bit-2>))))
	      (then prefer bindings ((<machine> . <machine-3>) (<drill-bit> . <drill-bit-4>))
		    ((<machine> . <machine-1>) (<drill-bit> . <drill-bit-2>))))

(control-rule prefer-drill-spot-milling-machine1
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (known (holding-tool <machine> <drill-bit>))
		       (type-of-object <drill-bit> spot-drill)
		       (type-of-object <machine> milling-machine)))
	      (then prefer operator drill-spot-milling-machine drill-spot-drill-press))

(control-rule prefer-bnds-drill-spot-milling-machine4
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (current-operator drill-spot-milling-machine)
		       (known (on-table <machine-2> <part>)) (diff <machine-2> <machine-1>)))
	      (then prefer bindings ((<machine> . <machine-2>)) ((<machine> . <machine-1>))))

(control-rule prefer-drill-spot-milling-machine3
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (known (on-table <machine> <part>))
		       (type-of-object <machine> milling-machine)))
	      (then prefer operator drill-spot-milling-machine drill-spot-drill-press))

(control-rule prefer-bnds-drill-spot-milling-machine6
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (current-operator drill-spot-milling-machine)
		       (known (has-device <machine-3> <holding-device-4>))
		       (or (diff <machine-3> <machine-1>)
			   (diff <holding-device-4> <holding-device-2>))))
	      (then prefer bindings
		    ((<machine> . <machine-3>) (<holding-device> . <holding-device-4>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>))))

(control-rule prefer-drill-spot-milling-machine5
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (known (has-device <machine> <holding-device>))
		       (type-of-object <machine> milling-machine)))
	      (then prefer operator drill-spot-milling-machine drill-spot-drill-press))

(control-rule prefer-bnds-drill-hole-milling-machine8
	      (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth> <hole-diameter>
					       <loc-x> <loc-y>))
		       (current-operator drill-hole-milling-machine)
		       (known (has-device <machine-3> <holding-device-4>))
		       (or (diff <machine-3> <machine-1>)
			   (diff <holding-device-4> <holding-device-2>))))
	      (then prefer bindings
		    ((<machine> . <machine-3>) (<holding-device> . <holding-device-4>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>))))

(control-rule prefer-drill-hole-milling-machine7
	      (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth> <hole-diameter>
					       <loc-x> <loc-y>))
		       (known (has-device <machine> <holding-device>))
		       (type-of-object <machine> milling-machine)))
	      (then prefer operator drill-hole-milling-machine
		    drill-hole-drill-press))

(control-rule prefer-bnds-drill-spot-milling-machine9
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (current-operator drill-spot-milling-machine)
		       (pending-goal (holding <machine-4> <holding-device-5> <part> <side>
					      <side-pair-6>))
		       (or (diff <machine-4> <machine-1>)
			   (diff <holding-device-5> <holding-device-2>)
			   (diff <side-pair-6> <side-pair-3>))))
	      (then prefer bindings
		    ((<machine> . <machine-4>) (<holding-device> . <holding-device-5>)
		     (<side-pair> . <side-pair-6>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>)
		     (<side-pair> . <side-pair-3>))))

(control-rule prefer-bnds-drill-spot-drill-press10
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (current-operator drill-spot-drill-press)
		       (pending-goal (holding <machine-4> <holding-device-5> <part> <side>
					      <side-pair-6>))
		       (or (diff <machine-4> <machine-1>)
			   (diff <holding-device-5> <holding-device-2>)
			   (diff <side-pair-6> <side-pair-3>))))
	      (then prefer bindings
		    ((<machine> . <machine-4>) (<holding-device> . <holding-device-5>)
		     (<side-pair> . <side-pair-6>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>)
		     (<side-pair> . <side-pair-3>))))

(control-rule prefer-bnds-side-mill12
	      (if (and (current-goal (size-of <part> <dim> <value>)) (current-operator side-mill)
		       (known (holding <machine-5> <holding-device-6> <part> <side-7> <side-pair-8>))
		       (or (diff <machine-5> <machine-1>)
			   (diff <holding-device-6> <holding-device-2>) (diff <side-7> <side-3>)
			   (diff <side-pair-8> <side-pair-4>))))
	      (then prefer bindings
		    ((<machine> . <machine-5>) (<holding-device> . <holding-device-6>) (<side> . <side-7>)
		     (<side-pair> . <side-pair-8>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>) (<side> . <side-3>)
		     (<side-pair> . <side-pair-4>))))

(control-rule prefer-side-mill11
	      (if (and (current-goal (size-of <part> <dim> <value>))
		       (known (holding <machine> <holding-device> <part> <side> <side-pair>))
		       (known (sides-for-holding-device <side> <side-pair>))
		       (known (side-for-side-mill <dim> <side> <mach-side>))
		       (not-in-side-pair <mach-side> <side-pair>)
		       (type-of-object <machine> milling-machine)))
	      (then prefer operator side-mill face-mill))

(control-rule prefer-bnds-side-mill15
	      (if (and (current-goal (size-of <part> <dim> <value>)) (current-operator side-mill)
		       (pending-goal (holding <machine-5> <holding-device-6> <part> <side-7>
					      <side-pair-8>))
		       (or (diff <machine-5> <machine-1>)
			   (diff <holding-device-6> <holding-device-2>) (diff <side-7> <side-3>)
			   (diff <side-pair-8> <side-pair-4>))))
	      (then prefer bindings
		    ((<machine> . <machine-5>) (<holding-device> . <holding-device-6>) (<side> . <side-7>)
		     (<side-pair> . <side-pair-8>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>) (<side> . <side-3>)
		     (<side-pair> . <side-pair-4>))))

(control-rule prefer-side-mill14
	      (if (and (current-goal (size-of <part> <dim> <value>))
		       (pending-goal (holding <machine> <holding-device> <part> <side> <side-pair>))
		       (known (sides-for-holding-device <side> <side-pair>))
		       (known (side-for-side-mill <dim> <side> <mach-side>))
		       (not-in-side-pair <mach-side> <side-pair>)
		       (type-of-object <machine> milling-machine)))
	      (then prefer operator side-mill face-mill))

(control-rule prefer-bnds-face-mill13
	      (if (and (current-goal (size-of <part> <dim> <value>)) (current-operator face-mill)
		       (pending-goal (size-of <part> <dim-1> <value-2>))
		       (known (sides-for-holding-device <side-7> <side-pair-8>))
		       (known (side-for-side-mill <dim-1> <side-7> <mach-side>))
		       (not-in-side-pair <mach-side> <side-pair-8>)
		       (forall-metapred (known (side-for-side-mill <dim-1> <side-3> <mach-side-9>))
					(or (~
					     (known (sides-for-holding-device <side-3>
									      <side-pair-4>)))
					    (~ (not-in-side-pair <mach-side-9> <side-pair-4>))))
		       (or (diff <side-7> <side-3>) (diff <side-pair-8> <side-pair-4>))))
	      (then prefer bindings
		    ((<machine> . <machine-5>) (<holding-device> . <holding-device-6>) (<side> . <side-7>)
		     (<side-pair> . <side-pair-8>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>) (<side> . <side-3>)
		     (<side-pair> . <side-pair-4>))))

(control-rule prefer-bnds-drill-spot-drill-press21
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (current-operator drill-spot-drill-press)
		       (known (has-device <machine-3> <holding-device-4>))
		       (or (diff <machine-3> <machine-1>)
			   (diff <holding-device-4> <holding-device-2>))))
	      (then prefer bindings
		    ((<machine> . <machine-3>) (<holding-device> . <holding-device-4>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>))))

(control-rule prefer-drill-spot-drill-press20
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (known (has-device <machine> <holding-device>))
		       (type-of-object <machine> drill)))
	      (then prefer operator drill-spot-drill-press
		    drill-spot-milling-machine))

(control-rule prefer-bnds-drill-spot-drill-press17
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (current-operator drill-spot-drill-press)
		       (pending-goal (holding <machine-4> <holding-device-5> <part> <side>
					      <side-pair-6>))
		       (or (diff <machine-4> <machine-1>)
			   (diff <holding-device-5> <holding-device-2>)
			   (diff <side-pair-6> <side-pair-3>))))
	      (then prefer bindings
		    ((<machine> . <machine-4>) (<holding-device> . <holding-device-5>)
		     (<side-pair> . <side-pair-6>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>)
		     (<side-pair> . <side-pair-3>))))

(control-rule prefer-drill-spot-drill-press16
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (pending-goal (holding <machine> <holding-device> <part> <side>
					      <side-pair>))
		       (known (sides-for-holding-device <side> <side-pair>))
		       (type-of-object <machine> drill)))
	      (then prefer operator drill-spot-drill-press
		    drill-spot-milling-machine))

(control-rule prefer-goal-22
	      (if (and (candidate-goal (holding <drill05> <vise06> <part> <side17>
						<side2-side58>))
		       (known (holding <machine-1> <holding-device-2> <part> <side-3>
				       <side-pair-4>))
		       (is-subgoal-of-ops (holding <machine-1> <holding-device-2> <part>
						   <side-3> <side-pair-4>)
					  <ops>)
		       (first-pending-subgoal-in-subtree <pref-goal> <ops>)
		       (diff <pref-goal> <other-goal>)
		       (~ (is-pending-subgoal-in-subtree <other-goal> <ops>))))
	      (then prefer goal <pref-goal> <other-goal>))

(control-rule prefer-bnds-drill-hole-milling-machine24
	      (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
					       <hole-diameter> <loc-x> <loc-y>))
		       (current-operator drill-hole-milling-machine)
		       (known (on-table <machine-2> <part>)) (diff <machine-2> <machine-1>)))
	      (then prefer bindings ((<machine> . <machine-2>)) ((<machine> . <machine-1>))))

(control-rule prefer-drill-hole-milling-machine23
	      (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
					       <hole-diameter> <loc-x> <loc-y>))
		       (known (on-table <machine> <part>))
		       (type-of-object <machine> milling-machine)))
	      (then prefer operator drill-hole-milling-machine
		    drill-hole-drill-press))

(control-rule prefer-drill-hole-milling-machine25
	      (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
					       <hole-diameter> <loc-x> <loc-y>))
		       (pending-goal (size-of <part-1> <dim-2> <value-3>))))
	      (then prefer operator drill-hole-milling-machine
		    drill-hole-drill-press))

(control-rule prefer-goal-26
	      (if (and (candidate-goal (is-available-tool-holder <machine>))
		       (known (holding-tool <machine> <milling-cutter>))
		       (is-subgoal-of-ops (holding-tool <machine> <milling-cutter>) <ops>)
		       (first-pending-subgoal-in-subtree <pref-goal> <ops>)
		       (diff <pref-goal> <other-goal>)
		       (~ (is-pending-subgoal-in-subtree <other-goal> <ops>))))
	      (then prefer goal <pref-goal> <other-goal>))

(control-rule prefer-bnds-side-mill28
	      (if (and (current-goal (size-of <part> <dim> <value>))
		       (current-operator side-mill)
		       (pending-goal (has-hole <part> <hole-1> <side-2> <hole-depth-2>
					       <hole-diameter-3> <loc-x-4> <loc-y-5>))
		       (diff <side-2> <side-1>)))
	      (then prefer bindings ((<side> . <side-2>)) ((<side> . <side-1>))))

(control-rule prefer-side-mill27
	      (if (and (current-goal (size-of <part> <dim> <value>))
		       (pending-goal (has-hole <part> <hole-1> <side> <hole-depth-2>
					       <hole-diameter-3> <loc-x-4> <loc-y-5>))
		       (known (sides-for-holding-device <side> <side-pair>))
		       (known (side-for-side-mill <dim> <side> <mach-side>))
		       (not-in-side-pair <mach-side> <side-pair>)))
	      (then prefer operator side-mill face-mill))

(control-rule prefer-bnds-drill-hole-milling-machine29
	      (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
					       <hole-diameter> <loc-x> <loc-y>))
		       (current-operator drill-hole-milling-machine)
		       (pending-goal (holding <machine-4> <holding-device-5> <part> <side>
					      <side-pair-6>))
		       (or (diff <machine-4> <machine-1>)
			   (diff <holding-device-5> <holding-device-2>)
			   (diff <side-pair-6> <side-pair-3>))))
	      (then prefer bindings
		    ((<machine> . <machine-4>) (<holding-device> . <holding-device-5>)
		     (<side-pair> . <side-pair-6>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>)
		     (<side-pair> . <side-pair-3>))))

(control-rule prefer-bnds-drill-spot-milling-machine31
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (current-operator drill-spot-milling-machine)
		       (pending-goal (holding <machine-4> <holding-device-5> <part> <side>
					      <side-pair-6>))
		       (or (diff <machine-4> <machine-1>)
			   (diff <holding-device-5> <holding-device-2>)
			   (diff <side-pair-6> <side-pair-3>))))
	      (then prefer bindings
		    ((<machine> . <machine-4>) (<holding-device> . <holding-device-5>)
		     (<side-pair> . <side-pair-6>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>)
		     (<side-pair> . <side-pair-3>))))

(control-rule prefer-drill-spot-milling-machine30
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (pending-goal (holding <machine> <holding-device> <part> <side>
					      <side-pair>))
		       (known (sides-for-holding-device <side> <side-pair>))
		       (type-of-object <machine> milling-machine)))
	      (then prefer operator drill-spot-milling-machine
		    drill-spot-drill-press))

(control-rule prefer-bnds-face-mill32
	      (if (and (current-goal (size-of <part> <dim> <value>))
		       (current-operator face-mill)
		       (pending-goal (holding <machine-5> <holding-device-6> <part> <side-7>
					      <side-pair-8>))
		       (or (diff <machine-5> <machine-1>)
			   (diff <holding-device-6> <holding-device-2>)
			   (diff <side-7> <side-3>) (diff <side-pair-8> <side-pair-4>))))
	      (then prefer bindings
		    ((<machine> . <machine-5>) (<holding-device> . <holding-device-6>)
		     (<side> . <side-7>) (<side-pair> . <side-pair-8>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>)
		     (<side> . <side-3>) (<side-pair> . <side-pair-4>))))

(control-rule prefer-goal-34
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

(control-rule prefer-goal-33
	      (if (and (candidate-goal (holding <machine-2> <holding-device> <part06>
						<side27> <side1-side48>))
		       (known (has-device <machine-1> <holding-device>))
		       (pending-goal (holding <machine-1> <holding-device> <part03> <side24>
					      <side3-side65>))
		       (is-subgoal-of-ops (holding <machine-1> <holding-device> <part03>
						   <side24> <side3-side65>)
					  <ops>)
		       (diff <machine-2> <machine-1>)
		       (first-pending-subgoal-in-subtree <pref-goal> <ops>)
		       (diff <pref-goal> <other-goal>)
		       (~ (is-pending-subgoal-in-subtree <other-goal> <ops>))))
	      (then prefer goal <pref-goal> <other-goal>))

(control-rule prefer-bnds-side-mill37
	      (if (and (current-goal (size-of <part> <dim> <value>))
		       (current-operator side-mill)
		       (pending-goal (is-countersinked <part> <hole-1> <side-2>
						       <hole-depth-2> <hole-diameter-3> <loc-x-4> <loc-y-5>
						       <angle-6>))
		       (diff <side-2> <side-1>)))
	      (then prefer bindings ((<side> . <side-2>)) ((<side> . <side-1>))))

(control-rule prefer-side-mill36
	      (if (and (current-goal (size-of <part> <dim> <value>))
		       (pending-goal (is-countersinked <part> <hole-1> <side> <hole-depth-2>
						       <hole-diameter-3> <loc-x-4> <loc-y-5> <angle-6>))
		       (known (sides-for-holding-device <side> <side-pair>))
		       (known (side-for-side-mill <dim> <side> <mach-side>))
		       (not-in-side-pair <mach-side> <side-pair>)))
	      (then prefer operator side-mill face-mill))

(control-rule prefer-bnds-drill-spot-drill-press41
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (current-operator drill-spot-drill-press)
		       (known (holding <machine-4> <holding-device-5> <part> <side>
				       <side-pair-6>))
		       (or (diff <machine-4> <machine-1>)
			   (diff <holding-device-5> <holding-device-2>)
			   (diff <side-pair-6> <side-pair-3>))))
	      (then prefer bindings
		    ((<machine> . <machine-4>) (<holding-device> . <holding-device-5>)
		     (<side-pair> . <side-pair-6>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>)
		     (<side-pair> . <side-pair-3>))))

(control-rule prefer-drill-spot-drill-press40
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (known (holding <machine> <holding-device> <part> <side> <side-pair>))
		       (known (sides-for-holding-device <side> <side-pair>))
		       (type-of-object <machine> drill)))
	      (then prefer operator drill-spot-drill-press
		    drill-spot-milling-machine))

(control-rule prefer-bnds-drill-hole-drill-press39
	      (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
					       <hole-diameter> <loc-x> <loc-y>))
		       (current-operator drill-hole-drill-press)
		       (known (holding <machine-4> <holding-device-5> <part> <side>
				       <side-pair-6>))
		       (or (diff <machine-4> <machine-1>)
			   (diff <holding-device-5> <holding-device-2>)
			   (diff <side-pair-6> <side-pair-3>))))
	      (then prefer bindings
		    ((<machine> . <machine-4>) (<holding-device> . <holding-device-5>)
		     (<side-pair> . <side-pair-6>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>)
		     (<side-pair> . <side-pair-3>))))

(control-rule prefer-drill-hole-drill-press38
	      (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
					       <hole-diameter> <loc-x> <loc-y>))
		       (known (holding <machine> <holding-device> <part> <side> <side-pair>))
		       (known (sides-for-holding-device <side> <side-pair>))
		       (type-of-object <machine> drill)))
	      (then prefer operator drill-hole-drill-press drill-hole-milling-machine))