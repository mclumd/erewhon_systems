;; adapted from testpart6-1hole. Only one part available. Only one
;; size reduction goal, but two ops in drill before moving the part to
;; the milling machine.

(setf (current-problem)
      (create-problem
       (name simple7)
       (objects
	(object-is drill1 DRILL)
        (object-is milling-machine1 MILLING-MACHINE)

        (object-is vise1 VISE)

	(object-is spot-drill1 SPOT-DRILL)
	(object-is twist-drill13 TWIST-DRILL)
	(object-is tap14 TAP)
	(object-is counterbore2 COUNTERBORE)	
	(object-is high-helix-drill1 HIGH-HELIX-DRILL)
	(object-is tap1 TAP)
	(object-is plain-mill1 PLAIN-MILL)
	(object-is end-mill1 END-MILL)
	
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)

        (objects-are part5 PART)
	(objects-are hole1 hole2 HOLE))
       (state
	(and
	 (always-true)
	 (diameter-of-drill-bit twist-drill13 1/4)
	 (diameter-of-drill-bit tap14 1/4)
	 (size-of-drill-bit counterbore2 1/2)
	 (diameter-of-drill-bit high-helix-drill1 1/32)
	 (diameter-of-drill-bit tap1 1/32)
	 (material-of part5 ALUMINUM)
	 (size-of part5 LENGTH 5)
	 (size-of part5 WIDTH 3)
	 (size-of part5 HEIGHT 3)))
       (goal
	((<part> PART))
	(and 
	 (size-of <part> HEIGHT 0.5)
	 (is-counterbored <part> hole1 side1 .5 1/4 1/2 1.5 1/2)
	 (size-of <part> LENGTH 0.5)
	 ))))

#|
If the goals are (in this particular order)
	 (size-of <part> LENGTH 4)
	 (is-tapped <part> hole1 side1 .5 1/4 1/2 1.5)
	 (is-counterbored <part> hole1 side1 .5 1/4 1/2 1.5 1/2)

the solution obtained with eff-rules.lisp is the same as with
eff-rules.lisp but without switch-mach-operation-same-tool,
switch-mach-operation-same-hd-setup and switch-mach-operation-same-machine

If the goals are (in this order)

	 (is-tapped <part> hole2 side1 .5 1/4 2.25 1.5)
	 (size-of <part> LENGTH 4)
	 (is-counterbored <part> hole1 side1 .5 1/4 1/2 1.5 1/2)

as the finishing hole ops are expanded first, then the order is
tweaked (not achieving the behavior I want: the use of
switch-mach-operation-same-machine.

Same thing if the goals are (in this order)

	 (has-hole <part> hole2 side1 .5 1/4 2.25 1.5)
	 (size-of <part> LENGTH 4)
	 (is-counterbored <part> hole1 side1 .5 1/4 1/2 1.5 1/2)

as the milling-machine is used for has-hole (becase the control rule
that rejects the milling machine does not fire)

Same thing if the goals are (in this order)

	 (size-of <part> LENGTH 4)
	 (is-counterbored <part> hole1 side1 .5 1/4 1/2 1.5 1/2)
	 (size-of <part> HEIGHT 1)

because prefer-dim prefers starting with HEIGHT, and then LENGTH goal
follows. In fact two size-of goals won't help because of the bindings
for face-mill and side-mill are chosen right, the two goals are
achieved with the same set-up and then one of them is achieved
opportunistically. Unless the the two goals have to be achieved with
face-mill (because of the size of the size reduction). 
|#