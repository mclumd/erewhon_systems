(load
 "/afs/cs/project/prodigy/version4.0/domains/machining/more-meta-predicates")
(load
 "/afs/cs/project/prodigy/version4.0/domains/machining/my-meta-predicates")

;;; ***************************************************************

;;Maybe we could replace the following rules by restricting the type
;;of <holding-device>  for these operators not to be VISE (when the
;;part is cylindrical) . However,
;;a Vise could be used if we first hold them weakly and then hold them
;;with the vise, even if the part is cylindrical.

;;Prodigy4 does not like the OR of two current-operator meta-preds

(control-rule AVOID-VISE-FOR-DRILL-WITH-SPOT-DRILL
 (if (and (current-goal (has-spot <part> <hole> <side> <x> <y>))
	  (current-operator drill-with-spot-drill)
	  (type-of-object-gen <holding-device> VISE)
	  ;;check if the part is cylindrical 
	  (known (size-of <part> DIAMETER <diameter>))))
 (then reject bindings ((<holding-device> . <holding-device>))))

(control-rule AVOID-VISE-FOR-DRILL-WITH-CENTER-DRILL
 (if (and (current-goal (has-center-hole <part> <hole> <side> <x> <y>))
	  (current-operator drill-with-center-drill)
	  (type-of-object-gen <holding-device> VISE)
	  ;;check if the part is cylindrical 
	  (known (size-of <part> DIAMETER <diameter>))))
 (then reject bindings ((<holding-device> . <holding-device>))))

(control-rule AVOID-VISE-FOR-SIDE-MILL
 (if (and (current-goal (size-of <part> <dim> <size>))
	  (current-operator SIDE-MILL)
	  ;;check if the part is cylindrical 
	  (known (size-of <part> DIAMETER <diameter>))
	  (type-of-object-gen <holding-device> VISE)))
 (then reject bindings ((<holding-device> . <holding-device>))))

;;;***************************************************************

(control-rule AVOID-CENTERS-FOR-METAL-SPRAY-COATING-RECTANGULAR-PARTS
 (if (and (current-goal (surface-coating-side <part> <side> <coating>))
	  (current-operator METAL-SPRAY-COATING)
	  ;;check if the part is rectangular
	  (known (size-of <part> HEIGHT <h>))
	  (type-of-object-gen <holding-device> CENTERS)))
 (then reject bindings ((<holding-device> . <holding-device>))))

(control-rule AVOID-V-BLOCK-FOR-RECTANGULAR-PARTS
  (if (and (current-goal-first-arg <part>)
	   ;;check if the part is rectangular
	   (known (size-of <part> HEIGHT <h>))
	   ;;all ops that may use v-blocks
	   (current-ops (DRILL-WITH-SPOT-DRILL
			 DRILL-WITH-TWIST-DRILL
                         DRILL-WITH-HIGH-HELIX-DRILL
			 DRILL-WITH-STRAIGHT-FLUTED-DRILL
			 DRILL-WITH-OIL-HOLE-DRILL
                         DRILL-WITH-GUN-DRILL
			 DRILL-WITH-CENTER-DRILL
			 TAP COUNTERSINK COUNTERBORE REAM
			 SIDE-MILL FACE-MILL
			 DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE
			 DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE
                         ROUGH-GRIND-WITH-HARD-WHEEL
                         ROUGH-GRIND-WITH-SOFT-WHEEL
                         FINISH-GRIND-WITH-HARD-WHEEL
                         FINISH-GRIND-WITH-SOFT-WHEEL
			 CUT-WITH-CIRCULAR-COLD-SAW			 
                         CUT-WITH-CIRCULAR-FRICTION-SAW))
	   (type-of-object-gen <v-block> V-BLOCK)))
  (then reject bindings ((<holding-device> . <v-block>))))

;;;***************************************************************

(control-rule DONT-WELD-TO-HOLD-PART1
  (if (and (current-goal (holding <welder> <holding-device> <part> <side>))
	   (type-of-object <welder> METAL-ARC-WELDER)))
  (then reject operator WELD-CYLINDERS-METAL-ARC))

#|
(control-rule DONT-WELD-TO-HOLD-PART2
  (if (and (current-goal (holding <welder> <holding-device> <part> <side>))
	   (type-of-object <welder> GAS-WELDER)))
  (then reject operator WELD-CYLINDERS-GAS))
|#
#| ;this does not work: the rule fires but it rejects "<op>" instead
   ;of its value 
(control-rule DONT-WELD-TO-HOLD-PART2
  (if (and (current-goal (holding <welder> <holding-device> <part> <side>))
	   (type-of-object <welder> WELDER)
	   (candidate-operator <op>)
	   (one-of-metapred <op> (WELD-CYLINDERS-GAS WELD-CYLINDERS-METAL-ARC))))
  (then reject operator <op>))
|#

;;;***************************************************************


;;if the part is ~holding == is-available we don't use 
;;RELEASE-FROM-HOLDING-DEVICE but PUT-ON-MACHINE-TABLE
;;We have to test here either ~(holding ) or is-available. The latter
;;is only added when the corresponding inference rule fires.
#|
;;I think it is cheaper to mark the rule as eager and test here for
;;is-available, but the inference rule gives an error
(control-rule PUT-ON-MACHINE-TABLE-IF-NOT-HOLDING
  (if (and (current-goal (on-table <machine> <part>))
	   (known (is-available-part <part>))))
  (then select operator PUT-ON-MACHINE-TABLE))

(control-rule PUT-ON-SHAPER-TABLE-IF-NOT-HOLDING
  (if (and (current-goal (on-table <machine> <part>))
	   (type-of-object <machine> SHAPER)
	   (known (is-available-part <part>))))
  (then select operator PUT-ON-SHAPER-TABLE))
|#

(control-rule PUT-ON-MACHINE-TABLE-IF-NOT-HOLDING
  (if (and (current-goal (on-table <machine> <part>))
	   (~ (type-of-object <machine> SHAPER))
;	   (known (~ (holding <machine> <holding-device> <part> <side>)))
	   ;;the meaning of this is "forall". I don't want to generate
	   ;;bindings 
	   (false-in-state-forall-values
	    (holding <machine> <holding-device> <part> <side>)
	    (<holding-device> HOLDING-DEVICE) (<side> SIDE))
;	   (~(known (holding-weakly <machine> <holding-device> <part> <side>)))
	   (false-in-state-forall-values
	    (holding-weakly <machine> <holding-device> <part> <side>)
	    (<holding-device> HOLDING-DEVICE) (<side> SIDE))))
  (then select operator PUT-ON-MACHINE-TABLE))

(control-rule REMOVE-FROM-TABLE
  (if (and (current-goal (~ (on-table <machine> <part>)))
	   (not-candidate-goal (on-table <other-machine> <part>))))
  (then select operator REMOVE-FROM-MACHINE-TABLE))

;;;***************************************************************

;don't make the shape of the part rectangular in order to hold it with
;vise or toe-clamp
(control-rule DONT-MAKE-RECTANGULAR-TO-HOLD-WITH-TOE-CLAP
  (if (and (current-goal (holding <machine> <holding-device> <part> <side>))
	  ;;this is to ask if the part is cylindrical 
	  (known (size-of <part> DIAMETER <diameter>))))
  (then reject operator HOLD-WITH-TOE-CLAMP2))

;this may replace the first rule of this file
(control-rule DONT-MAKE-RECTANGULAR-TO-HOLD-WITH-VISE
  (if (and (current-goal (holding <machine> <holding-device> <part> <side>))
	  ;;this is to ask if the part is cylindrical 
	  (known (size-of <part> DIAMETER <diameter>))))
  (then reject operator HOLD-WITH-VISE))

;;;***************************************************************
;;; rules for choosing the fluids. I think this kind of rules could be
;;; derived from the domain specification (by looking at the preconds
;;; of the add-fluid operators)

(control-rule USE-MINERAL-OIL
  (if (and (current-goal-first-arg <part>)
           (current-ops (DRILL-WITH-OIL-HOLE-DRILL
                         DRILL-WITH-HIGH-HELIX-DRILL
                         DRILL-WITH-GUN-DRILL REAM
                         ROUGH-GRIND-WITH-HARD-WHEEL
                         ROUGH-GRIND-WITH-SOFT-WHEEL
                         FINISH-GRIND-WITH-HARD-WHEEL
                         FINISH-GRIND-WITH-SOFT-WHEEL
                         CUT-WITH-CIRCULAR-FRICTION-SAW))
	   (known (material-of <part> IRON))
	   (type-of-object-gen <fluid> mineral-oil)))
  (then select bindings ((<fluid> . <fluid>))))

(control-rule USE-SOLUBLE-OIL
  (if (and (current-goal-first-arg <part>)
           (current-ops (DRILL-WITH-OIL-HOLE-DRILL
                         DRILL-WITH-HIGH-HELIX-DRILL
                         DRILL-WITH-GUN-DRILL REAM
                         ROUGH-GRIND-WITH-HARD-WHEEL
                         ROUGH-GRIND-WITH-SOFT-WHEEL
                         FINISH-GRIND-WITH-HARD-WHEEL
                         FINISH-GRIND-WITH-SOFT-WHEEL
                         CUT-WITH-CIRCULAR-FRICTION-SAW))
	   (or (known (material-of <part> STEEL))
	       (known (material-of <part> ALUMINUM)))
	   (type-of-object-gen <fluid> soluble-oil)))
  (then select bindings ((<fluid> . <fluid>))))

(control-rule USE-ANY-OIL
  (if (and (current-goal-first-arg <part>)
           (current-ops (DRILL-WITH-OIL-HOLE-DRILL
                         DRILL-WITH-HIGH-HELIX-DRILL
                         DRILL-WITH-GUN-DRILL REAM
                         ROUGH-GRIND-WITH-HARD-WHEEL
                         ROUGH-GRIND-WITH-SOFT-WHEEL
                         FINISH-GRIND-WITH-HARD-WHEEL
                         FINISH-GRIND-WITH-SOFT-WHEEL
                         CUT-WITH-CIRCULAR-FRICTION-SAW))
	   (or (known (material-of <part> BRASS))
	       (known (material-of <part> BRONZE))
	       (known (material-of <part> COPPER)))
	   (type-of-object-gen <fluid> cutting-fluid)))
  (then select bindings ((<fluid> . <fluid>))))


;;;***************************************************************
;;; Rules for choosing operators to add the fluids

(control-rule ADD-OIL-ANY
  (if (and (current-goal (has-fluid <mach> <fluid> <part>))
	   (known (material-of <part> <mat>))
	   (one-of-metapred <mat> (BRASS BRONZE COPPER))))
  (then select operator ADD-ANY-CUTTING-FLUID))
			 
;;;***************************************************************

;;soft wheel for hard materials
(control-rule SOFT-WHEEL-FOR-FINISH-GRIND
  (if (and ;(current-goal (surface-finish-side <part> <side> <sf>))
	   (current-goal (surface-finish-side <part> <side> FINISH-GRIND))
	   (or (known (material-of <part> STEEL))
	       (known (material-of <part> IRON)))))
  (then reject operator FINISH-GRIND-WITH-HARD-WHEEL))

;;hard wheel for soft materials
(control-rule HARD-WHEEL-FOR-FINISH-GRIND
  (if (and ;(current-goal (surface-finish-side <part> <side> <sf>))
	   (current-goal (surface-finish-side <part> <side> FINISH-GRIND))
	   (or (known (material-of <part> BRASS))
	       (known (material-of <part> COPPER))
	       (known (material-of <part> BRONZE))
	       (known (material-of <part> ALUMINUM)))))
  (then reject operator FINISH-GRIND-WITH-SOFT-WHEEL))

;;soft wheel for hard materials
(control-rule SOFT-WHEEL-FOR-ROUGH-GRIND
  (if (and ;(current-goal (surface-finish-side <part> <side> <sf>))
	   (current-goal (surface-finish-side <part> <side> ROUGH-GRIND))
	   (or (known (material-of <part> STEEL))
	       (known (material-of <part> IRON)))))
  (then reject operator ROUGH-GRIND-WITH-HARD-WHEEL))

;;hard wheel for soft materials
(control-rule HARD-WHEEL-FOR-ROUGH-GRIND
  (if (and ;(current-goal (surface-finish-side <part> <side> <sf>))
	   (current-goal (surface-finish-side <part> <side> ROUGH-GRIND))
	   (or (known (material-of <part> BRASS))
	       (known (material-of <part> COPPER))
	       (known (material-of <part> BRONZE))
	       (known (material-of <part> ALUMINUM)))))
  (then reject operator ROUGH-GRIND-WITH-SOFT-WHEEL))

;;;***************************************************************

(control-rule SURFACE-FINISH-CYLINDRICAL
  (if (and (current-goal (surface-finish-side <part> <side> <surface-finish>))
	   (candidate-operator HAVE-SURFACE-FINISH-CYLINDRICAL-PART-SIDES)))
  (then reject operator HAVE-SURFACE-FINISH-CYLINDRICAL-PART-SIDES))

(control-rule SURFACE-FINISH-RECTANGULAR
  (if (and (current-goal (surface-finish-side <part> <side> <surface-finish>))
	   (candidate-operator HAVE-SURFACE-FINISH-RECTANGULAR-PART-SIDES)))
  (then reject operator HAVE-SURFACE-FINISH-RECTANGULAR-PART-SIDES))

#|
(control-rule SURFACE-FINISH-RECTANGULAR
  (if (and (current-goal (surface-finish-side <part> <side> <surface-finish>))
	   (candidate-operator HAVE-SURFACE-FINISH-RECTANGULAR-PART-SIDES)
	   (candidate-operator <op>)))
  (then prefer operator <op> HAVE-SURFACE-FINISH-RECTANGULAR-PART-SIDES))
|#

(control-rule SURFACE-COATING-SIDE-CYLINDRICAL
  (if (and (current-goal (surface-coating-side <part> <side> <surface-coating>))
	   (candidate-operator HAVE-SURFACE-COATING-CYLINDRICAL-PART-SIDES)))
  (then reject operator HAVE-SURFACE-COATING-CYLINDRICAL-PART-SIDES))

(control-rule SURFACE-COATING-SIDE-RECTANGULAR
  (if (and (current-goal (surface-coating-side <part> <side> <surface-coating>))
	   (candidate-operator HAVE-SURFACE-COATING-RECTANGULAR-PART-SIDES)))
  (then reject operator HAVE-SURFACE-COATING-RECTANGULAR-PART-SIDES))

(control-rule SURFACE-COATING-CYLINDRICAL
  (if (and (current-goal (surface-coating <part> <surface-coating>))
	   ;;check if the part is cylindrical
	   (known (size-of <part> DIAMETER <diameter>))))
;	   (candidate-operator HAS-SURFACE-COATING-CYLINDRICAL-PART)
  (then select operator HAS-SURFACE-COATING-CYLINDRICAL-PART))

(control-rule SURFACE-COATING-RECTANGULAR
  (if (and (current-goal (surface-coating <part> <surface-coating>))
	   ;;check if the part is rectangular
	   (known (size-of <part> HEIGHT <h>))))
;	   (candidate-operator HAS-SURFACE-COATING-RECTANGULAR-PART)
  (then select operator HAS-SURFACE-COATING-RECTANGULAR-PART))

;;;***************************************************************

(control-rule CANNOT-ENLARGE-PART
 (if (and (candidate-goal (size-of <part> <dim> <new-size>))
	  (known (size <part> <dim> <curr-size>))
	  (smaller <curr-size> <new-size>)))
 (then reject goal (size <part> <dim> <new-size>)))
 
;;; ***************************************************************
;;; This is to avoid trying the opposite order of holding-tool and
;;; holding when one them fails: do always holding before holding-tool

(control-rule HOLDING-BEFORE-HOLDING-TOOL
  (if (and (candidate-goal (holding <machine> <hd> <part> <side>))
	   (candidate-goal (holding-tool <machine> <tool>))))
  (then reject goal (holding-tool <machine> <tool>)))


;;;***************************************************************

