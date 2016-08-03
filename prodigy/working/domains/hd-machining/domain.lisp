;;;************************************************************
;;;************************************************************
;;; MACHINING DOMAIN
;;;
;;; Yolanda Gil, July 1991.
;;;
;;; Ref: "A Specification of Manufacturing Processes for Planning",
;;; Yolanda Gil. Technical report CMU-CS-91-179.
;;;
;;; Translated for prodigy 4.0 by:
;;;
;;; -- Jim Blythe,   August 1991 (type hierarchy)
;;;
;;; -- Alicia Perez, May 1992
;;;
;;;
;;; Please send any bugs/comments to "aperez@cs.cmu.edu"
;;;************************************************************
;;; Notes:
;;; - (always-true) should be in the initial state (for the rules 
;;; with no (other) preconditions to fire
;;; - I would recommend to change announce-plan so only the operators
;;; are displayed
;;;************************************************************
;;;
;;; RULES: total of 117
;;;
;;; OPERATORS: total of 36
;;;            xx machining operations
;;;            xx operators for setups
;;;
;;; INFERENCE RULES: total of 44
;;;************************************************************
;;;
;;; This is a simplification of the complete domain:
;;; - for changing the sides/holding.
;;; - using only drill and milling-machine. Only holding with vise.
;;; - changed the number and meaning of side arguments of holding.
;;; Before it meant the side of the part facing up. Now it means the
;;; two sides facing the holding device. The only practical (at search
;;; time) difference is in operator side-mill: the side machined is
;;; one of the sides (not the one facing up) and it cannot be the one
;;; touching the holding device either. Also the change makes sense as
;;; to specified the orientation of the part without ambiguity we need
;;; to specify two of the sides. This meant changing inference rule
;;; side-up. 

(create-problem-space 'hd-machining :current t)

(setf (getf (p4::problem-space-plist *current-problem-space*)
	    :depth-bound) 500)
(setf  p4::*print-also-inf-rules-p* nil)

;;;************************************************************
;;; Types
;;;************************************************************

(ptype-of Machine :Top-Type)
(ptype-of Drill Machine)
(ptype-of Lathe Machine)
(ptype-of Shaper Machine)
(ptype-of Planer Machine)
(ptype-of Grinder Machine)
(ptype-of Band-Saw Machine)
(ptype-of Circular-Saw Machine)
(ptype-of Milling-Machine Machine)
(ptype-of Welder Machine)
(ptype-of Electric-Arc-Spray-Gun Machine)

(ptype-of Metal-Arc-Welder Welder)
(ptype-of Gas-Welder Welder)

(ptype-of Holding-Device :Top-Type)
(ptype-of V-Block Holding-Device)
(ptype-of Vise Holding-Device)
(ptype-of Toe-Clamp Holding-Device)
(ptype-of Centers Holding-Device)
(ptype-of 4-Jaw-Chuck Holding-Device)
(ptype-of Collet-Chuck Holding-Device)
(ptype-of Magnetic-Chuck Holding-Device)

(ptype-of Tool :Top-Type)
(ptype-of Machine-Tool Tool)
(ptype-of Operator-Tool Tool)

;;;Kinds of Machine-Tools
(ptype-of Drill-Bit Machine-Tool)
(ptype-of Lathe-Toolbit Machine-Tool)
(ptype-of Cutting-Tool Machine-Tool)
(ptype-of Grinding-Wheel Machine-Tool)
(ptype-of Band-Saw-Attachment Machine-Tool)
(ptype-of Circular-Saw-Attachment Machine-Tool)
(ptype-of Milling-Cutter Machine-Tool)
(ptype-of Electrode Machine-Tool)
(ptype-of Welding-Rod Machine-Tool)

;;;Drill-Bits
(ptype-of Spot-Drill Drill-Bit)
(ptype-of Center-Drill Drill-Bit)
(ptype-of Straight-Fluted-Drill Drill-Bit)
(ptype-of High-Helix-Drill Drill-Bit)
(ptype-of Oil-Hole-Drill Drill-Bit)
(ptype-of Gun-Drill Drill-Bit)
(ptype-of Core-Drill Drill-Bit)
(ptype-of Tap Drill-Bit)
(ptype-of Countersink Drill-Bit)
(ptype-of Counterbore Drill-Bit)
(ptype-of Reamer Drill-Bit)
(ptype-of Twist-Drill Drill-Bit)

;;;Lathe Toolbits
(ptype-of Rough-Toolbit Lathe-Toolbit)
(ptype-of Finish-Toolbit Lathe-Toolbit)
(ptype-of V-Thread Lathe-Toolbit)
(ptype-of Knurl Lathe-Toolbit)

;;;Cutting Tools
(ptype-of Roughing-Cutting-Tool Cutting-Tool)
(ptype-of Finishing-Cutting-Tool Cutting-Tool)

;;;Saw Attachments
(ptype-of Cold-Saw  Circular-Saw-Attachment)
(ptype-of Friction-Saw Circular-Saw-Attachment) 

(ptype-of Saw-Band Band-Saw-Attachment)
(ptype-of Band-File Band-Saw-Attachment)

;;;Milling Cutters
(ptype-of Plain-Mill Milling-Cutter)
(ptype-of End-Mill Milling-Cutter)

;;;Operator Tools
(ptype-of Lathe-File Operator-Tool)
(ptype-of Abrasive-Cloth Operator-Tool)
(ptype-of Torch Operator-Tool)
(ptype-of Brush Operator-Tool)

;;;Wires
(ptype-of Wire :Top-Type)
(ptype-of Spraying-Metal-Wire Wire)

;;;Fluids
(ptype-of Fluid :Top-Type)
(ptype-of Cutting-Fluid Fluid)
(ptype-of  Soluble-Oil Cutting-Fluid)
(ptype-of Mineral-Oil Cutting-Fluid)

;;;Materials
(ptype-of Material :Top-Type)
(pinstance-of COPPER ALUMINUM STEEL STAINLESS-STEEL BRASS EMERY BRONZE
	      IRON TUNGSTEN MOLYBDENUM ZIRCONIUM-OXIDE ALUMINUM-OXIDE 
	      Material)

;;;Alloys
(ptype-of Alloy :Top-Type)
(pinstance-of FERROUS NON-FERROUS Alloy)

;;;Surface coatings
(ptype-of Surface-Coating :Top-Type)
(pinstance-of CORROSION-RESISTANT HEAT-RESISTANT WEAR-RESISTANT FUSED-METAL
	      Surface-Coating)

;;;Surface finishes
(ptype-of Surface-finish :Top-Type)
(pinstance-of COLD-ROLLED POLISHED SAWCUT TAPPED KNURLED 
	      FINISH-MILL FINISH-TURN FINISH-SHAPED FINISH-GRIND FINISH-PLANED
	      ROUGH-MILL ROUGH-TURN ROUGH-SHAPED ROUGH-GRIND ROUGH-PLANED
	      Surface-finish)

;;;Surface finish qualities
(ptype-of Surface-finish-quality :Top-Type)
(pinstance-of MACHINED GROUND surface-finish-quality)

;;;Hardnesses of materials
(ptype-of Hardness :Top-Type)
(pinstance-of HARD SOFT Hardness)

;;;Grits of wheel
(ptype-of Grit :Top-Type)
(pinstance-of FINE-GRIT COARSE-GRIT Grit)

;;; Parts
(ptype-of Part :Top-Type)
(ptype-of Side :Top-Type)
(pinstance-of SIDE0 SIDE1 SIDE2 SIDE3 SIDE4 SIDE5 SIDE6 Side)
(ptype-of Side-Pair :Top-Type)
(pinstance-of SIDE1-SIDE4 SIDE2-SIDE5 SIDE3-SIDE6 Side-Pair)

;;;Holes 
(ptype-of Hole :Top-Type)
;;classes (eg hole) can't have both subclasses and instances
;(ptype-of Center-Hole Hole)
(ptype-of Center-Hole :Top-Type)
(pinstance-of CENTER-HOLE-SIDE3 CENTER-HOLE-SIDE6 Center-Hole)

;;;Part Dimensions
(ptype-of Dimension :Top-Type)
(pinstance-of WIDTH LENGTH HEIGHT DIAMETER Dimension)

;;;Part shapes
(ptype-of Shape :Top-Type)
(pinstance-of RECTANGULAR CYLINDRICAL Shape)

(infinite-type Hole-Depth #'numberp)
(infinite-type Hole-Diameter #'numberp)
(infinite-type Hole-Location #'numberp)
(infinite-type Size #'numberp)
(infinite-type Angle #'numberp)

;;; Operators

;;;************************************************************
;;; MACHINE: DRILL
;;;
;;;aperez:
;;; only these devices can be used on a drill (see operator
;;; PUT-HOLDING-DEVICE-IN-DRILL) 
;;; -  4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP
;;; (but V-block can only be used to hold-weakly the part, and is
;;; needed when toe-clamp is used by the operator to hold a
;;; cylindrical part) 
;;; Tool has to be of type Drill-bit

; operators for making holes

(Operator DRILL-WITH-SPOT-DRILL
 (params <machine> <drill-bit> <holding-device> <part> <hole> <side>
	 <side-pair> <loc-x> <loc-y>)
 (preconds
  ((<machine> Drill)
   (<drill-bit> Spot-Drill)
   (<holding-device> (or 4-JAW-CHUCK VISE TOE-CLAMP))
   (<part> Part)
   (<side> Side) ;side up
   (<side-pair> Side-Pair) ;sides to holding-device
   (<hole> Hole)
   (<loc-x> (and Hole-Location (x-location-of <part> <loc-x>)))
   (<loc-y> (and Hole-Location (y-location-of <part> <loc-y>))))
  (and
   (sides-for-holding-device <side> <side-pair>)
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side> <side-pair>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (add (has-spot <part> <hole> <side> <loc-x> <loc-y>)))))

(Operator DRILL-WITH-TWIST-DRILL
 (params <machine> <drill-bit> <holding-device> <part> <hole>
	 <side> <side-pair> <hole-depth> <hole-diameter>
	 <drill-bit-diameter> <loc-x> <loc-y>) 
 (preconds
  ((<machine> Drill)
   (<drill-bit> Twist-Drill)
   (<holding-device> (or 4-JAW-CHUCK VISE TOE-CLAMP))
   (<hole> Hole)
   (<drill-bit-diameter>
    (and Hole-Diameter
	 (gen-from-pred (diameter-of-drill-bit <drill-bit> <drill-bit-diameter>))))
   (<hole-diameter> (and Hole-Diameter (same <hole-diameter> <drill-bit-diameter>)))
   (<side> Side)
   (<side-pair> Side-Pair) ;sides to holding-device
   (<part> Part)
   (<loc-x> (and Hole-Location (x-location-of <part> <loc-x>)))
   (<loc-y> (and Hole-Location (y-location-of <part> <loc-y>)))
   (<hole-depth> Hole-Depth))
  (and
   (sides-for-holding-device <side> <side-pair>)
   (has-spot <part> <hole> <side> <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side> <side-pair>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
;;if the top level goals are both has-spot and has-hole in
;;the same location, it wil make the spot twice because it is removed
;;when the hole is made. This does not make much sense (the second
;;spot is made in the same location as the hole)
;   (del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
   (add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
                  <loc-x> <loc-y>)))))

(Operator DRILL-WITH-HIGH-HELIX-DRILL
 (params <machine> <drill-bit> <holding-device> <part> <hole>
	 <side> <side-pair> <fluid> <hole-depth> <hole-diameter>
	 <loc-x> <loc-y>)
 (preconds
  ((<machine> Drill)
   (<drill-bit> High-Helix-Drill)
   (<holding-device> (or 4-JAW-CHUCK  VISE TOE-CLAMP))
   (<fluid> Fluid)
   (<part> Part)
   (<side> Side)
   (<side-pair> Side-Pair) ;sides to holding-device
   (<hole> Hole)
   (<loc-x> (and Hole-Location (x-location-of <part> <loc-x>)))
   (<loc-y> (and Hole-Location (y-location-of <part> <loc-y>)))
   (<hole-depth> Hole-Depth)
   (<hole-diameter>
    (and Hole-Diameter
	 (gen-from-pred (diameter-of-drill-bit <drill-bit> <hole-diameter>)))))
  (and
   (sides-for-holding-device <side> <side-pair>)
   (has-fluid <machine> <fluid> <part>)
   (has-spot <part> <hole> <side> <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side> <side-pair>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
;   (del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
   (add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
                  <loc-x> <loc-y>)))))

 
;; operators for finishing holes

(Operator TAP 
 (params <machine> <drill-bit> <holding-device> <part> <hole> <side>
	 <side-pair> <hole-depth> <hole-diameter> <drill-bit-diameter>
	 <loc-x> <loc-y>) 
 (preconds
  ((<machine> DRILL)
   (<drill-bit> TAP)
   (<holding-device> (or 4-JAW-CHUCK VISE TOE-CLAMP))
   (<part> PART)
   (<hole> HOLE)
   (<side> Side)
   (<side-pair> Side-Pair) ;sides to holding-device
   (<hole-depth> Hole-Depth)
   (<drill-bit-diameter>
    (and Hole-Diameter
	 (gen-from-pred
	  (diameter-of-drill-bit <drill-bit> <drill-bit-diameter>))))
   (<hole-diameter>
    (and Hole-Diameter (same <drill-bit-diameter> <hole-diameter>)))
   (<loc-x> (and Hole-Location (x-location-of <part> <loc-x>)))
   (<loc-y> (and Hole-Location (y-location-of <part> <loc-y>))))
  (and    
   (sides-for-holding-device <side> <side-pair>)
   (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
             <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> <side> <side-pair>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (if (is-reamed <part> <hole> <side> <hole-depth> <hole-diameter> 
                  <loc-x> <loc-y>)
       ((del (is-reamed <part> <hole> <side> <hole-depth> <hole-diameter> 
                       <loc-x> <loc-y>))))
   (add (is-tapped <part> <hole> <side> <hole-depth> <hole-diameter> 
                   <loc-x> <loc-y>)))))

(Operator COUNTERSINK 
 (params <machine> <drill-bit> <holding-device> <part> <hole> <side>
	 <side-pair> <hole-depth> <hole-diameter> <angle> <loc-x>
	 <loc-y>)
 (preconds
  ((<machine> DRILL)
   (<drill-bit> COUNTERSINK)
   (<holding-device> (or 4-JAW-CHUCK  VISE TOE-CLAMP))
   (<part> PART)
   (<hole> Hole)
   (<side> Side)
   (<side-pair> Side-Pair)  ;sides to holding-device
   (<hole-depth> Hole-Depth)
   (<hole-diameter> Hole-Diameter)
   (<loc-x> (and Hole-Location (x-location-of <part> <loc-x>)))
   (<loc-y> (and Hole-Location (y-location-of <part> <loc-y>)))
   (<angle>
    (and Angle (gen-from-pred (angle-of-drill-bit <drill-bit> <angle>)))))
  (and
   (sides-for-holding-device <side> <side-pair>)
   (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
             <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> <side> <side-pair>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (add (is-countersinked <part> <hole> <side> <hole-depth> <hole-diameter> 
                          <loc-x> <loc-y> <angle>)))))

 
(Operator COUNTERBORE 
 (params <machine> <drill-bit> <holding-device> <part> <hole> <side>
	 <side-pair> <hole-depth> <hole-diameter> <counterbore-size>
	 <loc-x> <loc-y>)
 (preconds
  ((<machine> DRILL)
   (<drill-bit> COUNTERBORE)
   (<holding-device> (or 4-JAW-CHUCK  VISE TOE-CLAMP))
   (<part> Part)
   (<hole> Hole)
   (<side> Side)
   (<side-pair> Side-Pair)   ;sides to holding-device
   (<counterbore-size>
    (and Hole-Diameter (gen-from-pred
	       (size-of-drill-bit <drill-bit> <counterbore-size>))))
   (<hole-depth> Hole-Depth)
   (<hole-diameter> Hole-Diameter)
   (<loc-x> Hole-Location)
   (<loc-y> Hole-Location))
  (and
   (sides-for-holding-device <side> <side-pair>)
   (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
             <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> <side> <side-pair>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (add (is-counterbored <part> <hole> <side> <hole-depth> <hole-diameter>
                         <loc-x> <loc-y> <counterbore-size>)))))

(Operator REAM 
 (params <machine> <drill-bit> <holding-device> <part> <hole> 
	 <side> <side-pair> <fluid> <hole-depth> <hole-diameter>
	 <drill-bit-diameter> <loc-x> <loc-y>)
 (preconds
  ((<machine> DRILL)
   (<drill-bit> REAMER)
   (<holding-device> (or 4-JAW-CHUCK  VISE TOE-CLAMP))
   (<part> PART)
   (<hole> HOLE)
   (<side> Side)
   (<side-pair> Side-Pair)  ;sides to holding-device
   (<fluid> FLUID)
   (<hole-depth> (and Hole-Depth (smaller <hole-depth> 2)))
   (<loc-x> Hole-Location)
   (<loc-y> Hole-Location)
   (<drill-bit-diameter>
    (and Hole-Diameter
	 (gen-from-pred (diameter-of-drill-bit <drill-bit> <drill-bit-diameter>))))
   (<hole-diameter>
    (and Hole-Diameter
	 (same <hole-diameter> <drill-bit-diameter>))))
  (and
   (sides-for-holding-device <side> <side-pair>)
   (has-fluid <machine> <fluid> <part>)
   (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
             <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> <side> <side-pair>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (is-tapped <part> <hole> <side> <hole-depth> <hole-diameter> 
		   <loc-x> <loc-y>))
   (add (is-reamed <part> <hole> <side> <hole-depth> <hole-diameter> 
                   <loc-x> <loc-y>)))))



;;;************************************************************
;;; MACHINE: MILLING MACHINE
;;;
;;;aperez:
;;; only these devices can be used on a milling machine  (see
;;; PUT-HOLDING-DEVICE-IN-MILLING-MACHINE)
;;; -  4-JAW-CHUCK V-BLOCK VISE COLLET-CHUCK TOE-CLAMP
;;; (but V-block can only be used to hold-weakly the part, and is
;;; needed when toe-clamp is used by the operator to hold a
;;; cylindrical part) 
;;; Tools can be:
;;; - Milling-Cutter Drill-bit

;;; side-mill is also known as end-mill.

(Operator FACE-MILL
 (params <machine> <part> <milling-cutter> <holding-device> 
	 <side> <side-pair> <dim> <value-old> <value>)
 (preconds
  ((<machine> MILLING-MACHINE)
   (<milling-cutter> MILLING-CUTTER)
   (<holding-device> (or 4-JAW-CHUCK VISE COLLET-CHUCK TOE-CLAMP))
   (<part> Part)
;   (<dim> (and Dimension (same <dim> 'HEIGHT)))
   (<dim> Dimension)
   (<side> Side)
   (<side-pair> Side-Pair) ;sides to holding-device
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (smaller <value> <value-old>))))
  (and
   (shape-of <part> RECTANGULAR)
   (side-up-for-machining <dim> <side>)
   (sides-for-holding-device <side> <side-pair>)
   (holding-tool <machine> <milling-cutter>)
   (holding <machine> <holding-device> <part> <side> <side-pair>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<surface-finish> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <surface-finish>))
   (add (surface-finish-side <part> <side> ROUGH-MILL))
   (add (size-of <part> <dim> <value>))
   (del (size-of <part> <dim> <value-old>)))))

(Operator SIDE-MILL
 (params <machine> <part> <milling-cutter> <holding-device> 
	 <side> <side-pair> <mach-side> <dim> <value-old> <value>)
 (preconds 
  ((<machine> MILLING-MACHINE)
   (<part> Part)
   (<milling-cutter> MILLING-CUTTER)
   (<holding-device> (or 4-JAW-CHUCK  VISE COLLET-CHUCK TOE-CLAMP))
;   (<dim> (and  Dimension  (one-of <dim> '(WIDTH LENGTH))))
   (<dim> Dimension)
   (<side> Side) ;side facing up ;(one-of <side> '(SIDE1 SIDE4))
   (<side-pair> Side-Pair) ;sides to holding-device
   (<mach-side>         ;side touched by the operation
    (and Side (not-in-side-pair <mach-side> <side-pair>)))
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (smaller <value> <value-old>)
		  (smaller-than-2in <value-old> <value>))))
  (and
   (side-for-side-mill <dim> <side> <mach-side>)
   (sides-for-holding-device <side> <side-pair>)
   (holding-tool <machine> <milling-cutter>)
   (holding <machine> <holding-device> <part> <side> <side-pair>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<surface-finish> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <mach-side> <surface-coating>))
   (del (surface-finish-side <part> <mach-side> <surface-finish>))
   (add (surface-finish-side <part> <mach-side> ROUGH-MILL))
   (add (size-of <part> <dim> <value>))
   (del (size-of <part> <dim> <value-old>)))))

(Operator DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE
 (params <machine> <drill-bit> <holding-device> <part> <hole> <side>
	 <side-pair> <loc-x> <loc-y>)
 (preconds
  ((<machine> MILLING-MACHINE)
   (<drill-bit> SPOT-DRILL)
   (<holding-device> (or 4-JAW-CHUCK  VISE COLLET-CHUCK TOE-CLAMP))
   (<part> Part)
   (<side> Side)
   (<side-pair> Side-Pair) ;sides to holding-device
   (<loc-x> (and Hole-Location (x-location-of <part> <loc-x>)))
   (<loc-y> (and Hole-Location (y-location-of <part> <loc-y>)))
   (<hole> Hole))
  (and
   (sides-for-holding-device <side> <side-pair>)
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side> <side-pair>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (add (has-spot <part> <hole> <side> <loc-x> <loc-y>)))))

(Operator DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE
 (params <machine> <drill-bit> <holding-device> <part> <hole>
	 <side> <side-pair> <hole-depth> <hole-diameter>
	 <drill-bit-diameter> <loc-x> <loc-y>)
 (preconds
  ((<machine> MILLING-MACHINE)
   (<drill-bit> TWIST-DRILL)
   (<holding-device> (or 4-JAW-CHUCK  VISE COLLET-CHUCK TOE-CLAMP))
   (<part> Part)
   (<side> Side)
   (<side-pair> Side-Pair)  ;sides to holding-device
   (<hole> Hole)
   (<drill-bit-diameter>
    (and Hole-Diameter (gen-from-pred
	       (diameter-of-drill-bit <drill-bit> <drill-bit-diameter>))))
   (<hole-diameter>
    (and Hole-Diameter (same <drill-bit-diameter> <hole-diameter>)))
   (<loc-x> Hole-Location)
   (<loc-y> Hole-Location)
   (<hole-depth> Hole-Depth))
  (and   
   (sides-for-holding-device <side> <side-pair>)
   (has-spot <part> <hole> <side> <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side> <side-pair>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
;   (del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
   (add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
                  <loc-x> <loc-y>)))))


;;;************************************************************
;;; OTHER OPERATIONS

(Operator CLEAN
 (params <part>)
 (preconds
  ((<part> PART))
  (is-available-part <part>))
 (effects
  ()
  ((add (is-clean <part>)))))


(Operator REMOVE-BURRS
 (params <part> <brush>)
 (preconds
  ((<brush> BRUSH)
   (<part> PART))
  (is-available-part <part>))
 (effects
  ()
  ((del (is-clean <part>))
   (del (has-burrs <part>)))))


;;;************************************************************
;;;************************************************************
; operators for preparing the machines

;;;************************************************************
; tools in machines


;;this allows any kind of drill-bit tobe held by the milling machine,
;;but the ops onlycan use spot-drills and twist-drills.

(Operator PUT-TOOL-ON-MILLING-MACHINE
 (params <machine> <attachment>)
 (preconds
  ((<machine> MILLING-MACHINE)
   (<attachment> (or MILLING-CUTTER DRILL-BIT)))
  (and
   (is-available-tool-holder <machine>)
   (is-available-tool <attachment>)))
 (effects
  ()
  ((add (holding-tool <machine> <attachment>)))))

(Operator PUT-IN-DRILL-SPINDLE
 (params <machine> <drill-bit>)
 (preconds
  ((<machine> DRILL)
   (<drill-bit> DRILL-BIT))
  (and
   (is-available-tool-holder <machine>)
   (is-available-tool <drill-bit>)))
 (effects
  ()
  ((add (holding-tool <machine> <drill-bit>)))))

(Operator REMOVE-TOOL-FROM-MACHINE
 (params <machine> <tool>)
 (preconds
  ((<machine> MACHINE)
   (<tool> TOOL))
  (holding-tool <machine> <tool>))
 (effects
  ()
  ((del (holding-tool <machine> <tool>)))))

;;;************************************************************
; holding devices in machines

(Operator PUT-HOLDING-DEVICE-IN-MILLING-MACHINE
 (params <machine> <holding-device>)
 (preconds
  ((<machine> MILLING-MACHINE)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE COLLET-CHUCK TOE-CLAMP)))
  (and 
   (is-available-table <machine> <holding-device>)
   (is-available-holding-device <holding-device>)))
 (effects
  ()
  ((add (has-device <machine> <holding-device>)))))

(Operator PUT-HOLDING-DEVICE-IN-DRILL
 (params <machine> <holding-device>)
 (preconds
  ((<machine> DRILL)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP)))
  (and 
   (is-available-table <machine> <holding-device>)
   (is-available-holding-device <holding-device>)))
 (effects
  ()
  ((add (has-device <machine> <holding-device>)))))

(Operator REMOVE-HOLDING-DEVICE-FROM-MACHINE
  (params <machine> <holding-device>)
  (preconds
   ((<machine> Machine)
    (<holding-device> Holding-device))
   (and
    (has-device <machine> <holding-device>)
    (is-empty-holding-device <holding-device> <machine>)))
 (effects
  ()
  ((del (has-device <machine> <holding-device>)))))

;;;************************************************************
;;; cutting fluid in machines
;;; The fluid type depends on the material:
;;; - iron:             mineral-oil
;;; - steel, aluminum:  soluble-oil
;;; - brass, copper, bronze: any cutting fluid


(Operator ADD-SOLUBLE-OIL
 (params <machine> <fluid>)
 (preconds
  ((<machine> Machine)
   (<part> Part)
   (<fluid> SOLUBLE-OIL))
  (and
   (or (material-of <part> STEEL)
       (material-of <part> ALUMINUM))))
 (effects
  ()
  ;;should we delete has-fluid for other parts?
  ((add (has-fluid <machine> <fluid> <part>)))))

(Operator ADD-MINERAL-OIL
 (params <machine> <fluid>)
 (preconds
  ((<machine> Machine)
   (<part> Part)
   (<fluid> MINERAL-OIL))
  (material-of <part> IRON))
 (effects
  ()
  ((add (has-fluid <machine> <fluid> <part>)))))

(Operator ADD-ANY-CUTTING-FLUID
 (params <machine> <fluid>)
 (preconds
  ((<machine> Machine)
   (<part> Part)
   (<fluid> CUTTING-FLUID))
  (or (material-of <part> BRASS)
      (material-of <part> BRONZE)
      (material-of <part> COPPER)))
 (effects
  ()
  ((add (has-fluid <machine> <fluid> <part>)))))

;;;************************************************************
;;;************************************************************
;;; operators for holding parts with a device in a machine

(Operator PUT-ON-MACHINE-TABLE
 (params <machine> <part>)
 (preconds
  ((<machine> (COMP Machine Shaper))
   (<part> Part))
  (and
   (is-available-part <part>)
   (is-available-machine <machine>)))
 (effects
  ((<another-machine> Machine))
  ((del (on-table <another-machine> <part>))
   (add (on-table <machine> <part>)))))
#|
(Operator HOLD-WITH-V-BLOCK
 (params <machine> <holding-device> <part> <side>)
 (preconds
  ((<holding-device> V-BLOCK)
   (<machine> MACHINE)
   (<part> Part)
   (<side> (and Side (same <side> 'SIDE0))))
  (and   
   (has-device <machine> <holding-device>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (on-table <machine> <part>)
   (shape-of <part> CYLINDRICAL)
   (is-empty-holding-device <holding-device> <machine>)
   (is-available-part <part>)))
 (effects
  ()
  ((del (on-table <machine> <part>))
   (add (holding-weakly <machine> <holding-device> <part> SIDE0)))))
|#

(Operator HOLD-WITH-VISE
 (params <machine> <holding-device> <part> <side> <side-pair>)
 (preconds
  ((<holding-device> VISE)
   (<machine> Machine)
   (<part> Part)
   (<side> Side) ;(<side-hd1> Side)(<side-hd2> Side)
   (<side-pair> Side-Pair))   
  (and 
   (has-device <machine> <holding-device>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (on-table <machine> <part>)
   (is-empty-holding-device <holding-device> <machine>)
   (is-available-part <part>)))
 (effects
  ()
  ((del (on-table <machine> <part>))
   (if (shape-of <part> CYLINDRICAL)
       ((add (holding-weakly <machine> <holding-device> <part> <side> <side-pair>))))
   (if (shape-of <part> RECTANGULAR)
       ((add (holding <machine> <holding-device> <part> <side> <side-pair>)))))))
#|
#|split this in two operators
Mei:
Prodigy4 doesn't like the or of two functions in the specification
of <side> (fixed load-domain to give the proper error message)

I could write a functionto take care of the OR, but the point is that
if the part is rectangular, we don't care about the value of <side>
(Operator HOLD-WITH-TOE-CLAMP
 (params <machine> <holding-device> <part> <side>)
 (preconds
  ((<holding-device> TOE-CLAMP)
   (<machine> Machine)
   (<part> Part)
   (<side> (and Side (or (gen-from-pred (shape-of <part> RECTANGULAR))
			 (one-of <side> '(SIDE3 SIDE6))))))
  ;; can hold cylindrical parts only with toe clamp for sides 3 & 6 
  (and 
   (has-device <machine> <holding-device>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (on-table <machine> <part>)
   (is-empty-holding-device <holding-device> <machine>)
   (is-available-part <part>)))
 (effects
  ()
  ((del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))
|#

(Operator HOLD-WITH-TOE-CLAMP1
 (params <machine> <holding-device> <part> <side>)
 (preconds
  ((<holding-device> TOE-CLAMP)
   (<machine> Machine)
   (<part> Part)
   (<side> (and Side (one-of <side> '(SIDE3 SIDE6)))))
  ;; can hold cylindrical parts only with toe clamp for sides 3 & 6 
  (and
   (has-device <machine> <holding-device>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (on-table <machine> <part>)
   (is-empty-holding-device <holding-device> <machine>)
   (is-available-part <part>)))
 (effects
  ()
  ((del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(Operator HOLD-WITH-TOE-CLAMP2
 (params <machine> <holding-device> <part> <side>)
 (preconds
  ((<holding-device> TOE-CLAMP)
   (<machine> Machine)
   (<part> Part)
   (<side> Side))
  (and
   (shape-of <part> RECTANGULAR)
   (has-device <machine> <holding-device>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (on-table <machine> <part>)
   (is-empty-holding-device <holding-device> <machine>)
   (is-available-part <part>)))
 (effects
  ()
  ((del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(Operator SECURE-WITH-TOE-CLAMP
 (params <machine> <holding-device> <part> <side>)
 (preconds
  ((<holding-device> TOE-CLAMP)
   (<another-holding-device> HOLDING-DEVICE)
   (<machine> Machine)
   (<part> Part)
   (<side> Side))
  (and 
   (~ (has-burrs <part>))
   (is-clean <part>)
   (shape-of <part> CYLINDRICAL)
   (holding-weakly <machine> <another-holding-device> <part> <side>)
        ; (is-available-part) is not a precondition, since 
        ;the part is being held weakly by another holding device.
   ;;I put has-device here because we need the other to use
   ;;another-holding-device first to hold-weakly the part (this could
   ;;be done with a prefer goal control rule)
   (has-device <machine> <holding-device>)
   (is-empty-holding-device <holding-device> <machine>)))
 (effects
  ()
  ((del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(Operator HOLD-WITH-CENTERS
 (params <machine> <holding-device> <part> <side>)
 (preconds
  ((<holding-device> CENTERS)
   (<machine> MACHINE)
   (<part> PART)
   (<side> Side))
  (and   
   (has-device <machine> <holding-device>)
   (has-center-holes <part>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (on-table <machine> <part>)
   (shape-of <part> CYLINDRICAL)
   (is-empty-holding-device <holding-device> <machine>)
   (is-available-part <part>)))
 (effects
  ()
  ((del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(Operator HOLD-WITH-4-JAW-CHUCK
 (params <machine> <holding-device> <part> <side>)
 (preconds
  ((<holding-device> 4-JAW-CHUCK)
   (<machine> MACHINE)
   (<part> PART)
   (<side> Side))
  (and
   (has-device <machine> <holding-device>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (on-table <machine> <part>)
   (is-empty-holding-device <holding-device> <machine>)
   (is-available-part <part>)))
 (effects
  ()
  ((del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(Operator HOLD-WITH-COLLET-CHUCK
 (params <machine> <holding-device> <part> <side>)
 (preconds
  ((<holding-device> COLLET-CHUCK)
   (<machine> MACHINE)
   (<part> Part)
   (<side> Side))
  (and
   (has-device <machine> <holding-device>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (on-table <machine> <part>)
   (shape-of <part> CYLINDRICAL)
   (is-empty-holding-device <holding-device> <machine>)
   (is-available-part <part>)))
 (effects
  ()
  ((del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(Operator HOLD-WITH-MAGNETIC-CHUCK
 (params <machine> <holding-device> <part> <side>)
 (preconds
  ((<holding-device> MAGNETIC-CHUCK)
   (<machine> MACHINE)
   (<part> Part)
   (<side> Side))
  (and
   (has-device <machine> <holding-device>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (on-table <machine> <part>)
   (is-empty-holding-device <holding-device> <machine>)
   (is-available-part <part>)))
 (effects
  ()
  ((del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))
|#
;;aperez: added March 4
(Operator REMOVE-FROM-MACHINE-TABLE
  (params <machine> <part>)
  (preconds
   ((<machine> MACHINE)
    (<part> Part))
   (and
    (on-table <machine> <part>)
    (is-available-part <part>)))
  (effects
   ()
   ((del (on-table <machine> <part>)))))


(Operator RELEASE-FROM-HOLDING-DEVICE
 (params <machine> <holding-device> <part> <side> <side-pair>)
 (preconds
  ((<machine> MACHINE)
   (<holding-device> Holding-device)
   (<part> PART)
   (<side> SIDE) (<side-pair> SIDE-PAIR))
  (holding <machine> <holding-device> <part> <side> <side-pair>))
 (effects
  ()
  ((del (holding <machine> <holding-device> <part> <side> <side-pair>))
   (add (on-table <machine> <part>)))))
#|
(Operator RELEASE-FROM-HOLDING-DEVICE-WEAK
 (params <machine> <holding-device> <part> <side>)
 (preconds
  ((<machine> MACHINE)
   (<holding-device> Holding-device)
   (<part> PART)
   (<side> SIDE))
  (holding-weakly <machine> <holding-device> <part> <side>))
 (effects
  ()
  ((del (holding-weakly <machine> <holding-device> <part> <side>))
   (add (on-table <machine> <part>)))))
|#

;;;************************************************************
;;;
;;; Inference Rules
;;;
;;;************************************************************
#| split this rule in two because Prodigy4 does not take OR of
functions in the var specifications
(Inference-Rule HAS-CENTER-HOLES
 (params <part> <x2> <y2>)
 (preconds
  ((<part> PART)
   (<x> (and Size
	     (or (and (gen-from-pred (shape-of <part> RECTANGULAR))
		      (gen-from-pred (size-of <part> WIDTH <x>)))
		 (and (gen-from-pred (shape-of <part> CYLINDRICAL))
		      (gen-from-pred (size-of <part> DIAMETER <x>))))))
   (<y> (and Size
	     (or (and (gen-from-pred (shape-of <part> RECTANGULAR))
		      (gen-from-pred (size-of <part> HEIGHT <y>)))
		 (and (gen-from-pred (shape-of <part> CYLINDRICAL))
		      (gen-from-pred (size-of <part> DIAMETER <y>))))))
   (<x2> (and Size (half-of <x> <x2>)))
   (<y2> (and Size (half-of <y> <y2>))))
  (and
   (has-center-hole <part> CENTER-HOLE-SIDE3 SIDE3 <x2> <y2>)
   (is-countersinked <part> CENTER-HOLE-SIDE3 SIDE3 1/8 1/16 
                     <x2> <y2> 60)
   (has-center-hole <part> CENTER-HOLE-SIDE6 SIDE6 <x2> <y2>)
   (is-countersinked <part> CENTER-HOLE-SIDE6 SIDE6 1/8 1/16 
                     <x2> <y2> 60)))
 (effects
  ()
  ((add (has-center-holes <part>)))))
|#

(Inference-Rule HAS-CENTER-HOLES1
 (params <part> <x2> <y2>)
 (preconds
  ((<part> PART)
   (<x> (and Size (gen-from-pred (size-of <part> WIDTH <x>))))
   (<y> (and Size (gen-from-pred (size-of <part> HEIGHT <y>))))
   (<x2> (and Hole-Location (half-of <x> <x2>)))
   (<y2> (and Hole-Location (half-of <y> <y2>))))
  (and
   (shape-of <part> RECTANGULAR)
   (has-center-hole <part> CENTER-HOLE-SIDE3 SIDE3 <x2> <y2>)
   (is-countersinked <part> CENTER-HOLE-SIDE3 SIDE3 1/8 1/16 
                     <x2> <y2> 60)
   (has-center-hole <part> CENTER-HOLE-SIDE6 SIDE6 <x2> <y2>)
   (is-countersinked <part> CENTER-HOLE-SIDE6 SIDE6 1/8 1/16 
                     <x2> <y2> 60)))
 (effects
  ()
  ((add (has-center-holes <part>)))))

(Inference-Rule HAS-CENTER-HOLES2
 (params <part> <x2> <y2>)
 (preconds
  ((<part> PART)
   (<x> (and Size (gen-from-pred (size-of <part> DIAMETER <x>))))
   (<y> (and Size (same <y> <x>)))
;   (<y> (and Size (gen-from-pred (size-of <part> DIAMETER <y>))))
   (<x2> (and Hole-Location (half-of <x> <x2>)))
   (<y2> (and Hole-Location (same <y2> <x2>))))
  (and
   (shape-of <part> CYLINDRICAL)
   (has-center-hole <part> CENTER-HOLE-SIDE3 SIDE3 <x2> <y2>)
   (is-countersinked <part> CENTER-HOLE-SIDE3 SIDE3 1/8 1/16 
                     <x2> <y2> 60)
   (has-center-hole <part> CENTER-HOLE-SIDE6 SIDE6 <x2> <y2>)
   (is-countersinked <part> CENTER-HOLE-SIDE6 SIDE6 1/8 1/16 
                     <x2> <y2> 60)))
 (effects
  ()
  ((add (has-center-holes <part>)))))

;;;************************************************************

(Inference-Rule SIDES-FOR-HD
 (mode eager)
 (params)
 (preconds
  ()(always-true))
 (effects
  ()
  ;;args are <side-up> <side-pair>
  ((add (sides-for-holding-device SIDE1 SIDE2-SIDE5))
   (add (sides-for-holding-device SIDE1 SIDE3-SIDE6))
   (add (sides-for-holding-device SIDE2 SIDE1-SIDE4))
   (add (sides-for-holding-device SIDE2 SIDE3-SIDE6))
   (add (sides-for-holding-device SIDE3 SIDE2-SIDE5))
   (add (sides-for-holding-device SIDE3 SIDE1-SIDE4))
   (add (sides-for-holding-device SIDE4 SIDE2-SIDE5))
   (add (sides-for-holding-device SIDE4 SIDE3-SIDE6))
   (add (sides-for-holding-device SIDE5 SIDE1-SIDE4))
   (add (sides-for-holding-device SIDE5 SIDE3-SIDE6))
   (add (sides-for-holding-device SIDE6 SIDE1-SIDE4))
   (add (sides-for-holding-device SIDE6 SIDE2-SIDE5)))))
   
   

(Inference-Rule SIDE-UP
 (mode eager)
 (params)
 (preconds
  ()
  (always-true))
 (effects
  ()
  ((add (side-up-for-machining LENGTH SIDE3))
   (add (side-up-for-machining LENGTH SIDE6))
   (add (side-up-for-machining WIDTH SIDE2))
   (add (side-up-for-machining WIDTH SIDE5))
   (add (side-up-for-machining HEIGHT SIDE1))
   (add (side-up-for-machining HEIGHT SIDE4))
   (add (side-up-for-machining DIAMETER SIDE1))
   (add (side-up-for-machining DIAMETER SIDE0))
   )))

;;; Side-mill is the only operator that does not machine the part that
;;; is up, but one of the sides. Once the part is held with some
;;; orientation, it is impossible to side-mill both sides as one is
;;; being covered by the holding device. This is avoided in the
;;; SIDE-MILL operator. Therefore to machine both sides the part has
;;; to be released and held again.
;;; Here we model the part sides and orientations. 

(Inference-Rule SIDE-FOR-END-MILL
 (mode eager)
 (params)
 (preconds
  ()
  (always-true))
 (effects
  ()
  ;;args are <dim> <side-up> <machined-side>
  ((add (side-for-side-mill WIDTH SIDE1 SIDE2))
   (add (side-for-side-mill WIDTH SIDE1 SIDE5))
   (add (side-for-side-mill WIDTH SIDE3 SIDE2))
   (add (side-for-side-mill WIDTH SIDE3 SIDE5))
   (add (side-for-side-mill WIDTH SIDE4 SIDE2))
   (add (side-for-side-mill WIDTH SIDE4 SIDE5))
   (add (side-for-side-mill WIDTH SIDE6 SIDE2))
   (add (side-for-side-mill WIDTH SIDE6 SIDE5))

   (add (side-for-side-mill LENGTH SIDE1 SIDE3))
   (add (side-for-side-mill LENGTH SIDE1 SIDE6))
   (add (side-for-side-mill LENGTH SIDE2 SIDE3))
   (add (side-for-side-mill LENGTH SIDE2 SIDE6))
   (add (side-for-side-mill LENGTH SIDE4 SIDE3))
   (add (side-for-side-mill LENGTH SIDE4 SIDE6))
   (add (side-for-side-mill LENGTH SIDE5 SIDE3))
   (add (side-for-side-mill LENGTH SIDE5 SIDE6))

   (add (side-for-side-mill HEIGHT SIDE2 SIDE1))
   (add (side-for-side-mill HEIGHT SIDE2 SIDE4))   
   (add (side-for-side-mill HEIGHT SIDE3 SIDE1))
   (add (side-for-side-mill HEIGHT SIDE3 SIDE4))   
   (add (side-for-side-mill HEIGHT SIDE5 SIDE1))
   (add (side-for-side-mill HEIGHT SIDE5 SIDE4))   
   (add (side-for-side-mill HEIGHT SIDE6 SIDE1))
   (add (side-for-side-mill HEIGHT SIDE6 SIDE4)))))

;;;************************************************************
;;; inference rules for availability

;;; This section is kind of messy. I should spend some time finding
;;; out whether the infer not-available rules are still needed (I
;;; added them because there was a bug in the TMS)
;;; I checked this in april 1 1993 and still is not working.

#|
;;doesn't subgoal on on-table to make the machine available
(Inference-Rule MACHINE-AVAILABLE
 (params <machine>)
 (preconds
  ((<machine> Machine))
  (~ (exists ((<other-part> Part))
	     (on-table <machine> <other-part>))))
 (effects
  ()
  ((add (is-available-machine <machine>)))))
|#

;;new version copied from PART-AVAILABLE
(Inference-Rule MACHINE-AVAILABLE
 (params <machine>)
 (preconds
  ((<machine> Machine))
  (forall ((<part> Part)(<holding-device> Holding-Device)
	   (<side> Side)
	   (<side-pair> 
	    (and Side-Pair (gen-from-pred (sides-for-holding-device <side> <side-pair>)))))
	  (and (~ (on-table <machine> <part>))
	       (~ (holding <machine> <holding-device> <part> <side>
			   <side-pair>)))))
 (effects
  ()
  ((add (is-available-machine <machine>)))))

;;added for p4 because of problems with the TMS (may not be needed
;;anymore) 
(Inference-Rule MACHINE-NOT-AVAILABLE
 (mode eager)
 (params <machine>)
 (preconds
  ((<machine> Machine)
   (<other-part> Part))
  (on-table <machine> <other-part>))
 (effects
  ()
  ((del (is-available-machine <machine>)))))

#| replaced by the next rule as did for PART-AVAILABLE
;;doesn't subgoal to make the tool-holder available
(Inference-Rule TOOL-HOLDER-AVAILABLE
 (params <machine>)
 (preconds
  ((<machine> Machine))
  (~ (exists ((<tool> Tool))
	     (holding-tool <machine> <tool>))))
 (effects
  ()
  ((add (is-available-tool-holder <machine>)))))
|#

(Inference-Rule TOOL-HOLDER-AVAILABLE
 (params <machine>)
 (preconds
  ((<machine> Machine))
  (forall ((<tool> Tool))
	  (~ (holding-tool <machine> <tool>))))
 (effects
  ()
  ((add (is-available-tool-holder <machine>)))))

#| replaced by the next rule as for PART-AVAILABLE
;;doesn't subgoal to make the tool available
(Inference-Rule TOOL-AVAILABLE
 (params <tool>)
 (preconds
  ((<tool> Tool))
  (~ (exists ((<machine> Machine))
	     (holding-tool <machine> <tool>))))
 (effects () ((add (is-available-tool <tool>)))))
|#

(Inference-Rule TOOL-AVAILABLE
 (params <tool>)
 (preconds
  ((<tool> Tool))
  (forall ((<machine> Machine))
	  (~(holding-tool <machine> <tool>))))
 (effects () ((add (is-available-tool <tool>)))))

;;added for p4
(Inference-Rule TOOL-AND-TOOL-HOLDER-NOT-AVAILABLE
 (mode eager)
 (params <machine>)
 (preconds
  ((<machine> Machine)
   (<tool> Tool))
  (holding-tool <machine> <tool>))
 (effects
  ()
  ((del (is-available-tool-holder <machine>))
   (del (is-available-tool <tool>)))))

(Inference-Rule TABLE-AVAILABLE1
 (params <machine>)
 (preconds
  ((<machine> Machine)
   (<holding-device> TOE-CLAMP))
  (always-true))
 (effects
  ()
  ((add (is-available-table <machine> <holding-device>)))))

(Inference-Rule TABLE-AVAILABLE2
 (params <machine>)
 (preconds
  ((<machine> Machine)
   (<holding-device> Holding-Device))
  (forall ((<another-holding-device> Holding-device))
	  (~ (has-device <machine> <another-holding-device>))))
 (effects
  ()
  ((add (is-available-table <machine> <holding-device>)))))

#| replaced by the next rule as for PART-AVAILABLE
;;doesn't subgoal to make the holding-device available
(Inference-Rule HOLDING-DEVICE-AVAILABLE
 (params <holding-device>)
 (preconds
  ((<holding-device> Holding-device))
  (~ (exists ((<machine> Machine))
	     (has-device <machine> <holding-device>))))
 (effects
  ()
  ((add (is-available-holding-device <holding-device>)))))
|#

(Inference-Rule HOLDING-DEVICE-AVAILABLE
 (params <holding-device>)
 (preconds
  ((<holding-device> Holding-device))
  (forall ((<machine> Machine))
	  (~(has-device <machine> <holding-device>))))
 (effects
  ()
  ((add (is-available-holding-device <holding-device>)))))

;added for p4
(Inference-Rule TABLE-AND-HOLDING-DEVICE-NOT-AVAILABLE
 (mode eager)
 (params <machine>)
 (preconds
  ((<machine> Machine)
   (<another-holding-device> Holding-device))
  (has-device <machine> <another-holding-device>))
 (effects
  ;;if the holding device is a Toe-Clamp, the table is available
  ((<holding-device>
    (and (comp Holding-Device TOE-CLAMP)
	 (diff <holding-device> <another-holding-device>))))
  ((del (is-available-table <machine> <holding-device>))
   (del (is-available-holding-device <another-holding-device>)))))

#|
;; doesn't subgoal to make the part available; doesn't delete
;; is-available-part when the precondition becomes false
(Inference-Rule PART-AVAILABLE
 (params <part>)
 (preconds
  ((<part> Part))
  (and
   (~ (exists
       ((<machine> Machine)
	(<holding-device> Holding-device)
	(<side> Side))
       (holding-weakly <machine> <holding-device> <part> <side>)))
   (~ (exists
       ((<machine> Machine)
	(<another-holding-device> Holding-device)
	(<side> Side))
       (holding <machine> <another-holding-device> <part> <side>)))))
 (effects
  ()
  ((add (is-available-part <part>)))))
|#


;;This rule also works in eager mode, but that is more  expensive (as
;;the forall in the inference rule precondition is tested at each
;;state change if we mark the rule as eager)
;;see sc-rules.lisp for how this affects the control rules. 

(Inference-Rule PART-AVAILABLE
 ;;set mode eager as a test April 15 93. It works.
 ;(mode eager) 
 (params <part>)
 (preconds
  ((<part> Part))
  (forall
   ((<machine> Machine)
    (<holding-device> Holding-device)
    (<side> Side)
    (<side-pair> ;;Side-Pair
     ;(and Side-Pair (compute-side-pair <side> <side-pair>)) ;;slower 
     (and Side-Pair (gen-from-pred (sides-for-holding-device <side> <side-pair>)))))
   (and
    (~(holding-weakly <machine> <holding-device> <part> <side> <side-pair>))
    (~(holding <machine> <holding-device> <part> <side> <side-pair>)))))
 (effects
  ()
  ((add (is-available-part <part>)))))

#| Prodigy breaks: Error in function PRODIGY4::OR-MATCH.
OR-MATCH: has unbound vars in expr 
(Inference-Rule PART-AVAILABLE
 (params <part>)
 (preconds
  ((<part> Part))
  (~ (exists
       ((<machine> Machine)
	(<holding-device> Holding-device)
	(<side> Side))
       (or
	(holding-weakly <machine> <holding-device> <part> <side>)
	(holding <machine> <holding-device> <part> <side>)))))
 (effects
  ()
  ((add (is-available-part <part>)))))
|#
#|
;;added for p4
(Inference-Rule PART-NOT-AVAILABLE
 (mode eager)		
 (params <part>)
 (preconds
  ((<part> Part)
   (<machine> Machine)
   (<holding-device> Holding-device)
   (<side> Side))
  (or (holding-weakly <machine> <holding-device> <part> <side>)
      (holding <machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((del (is-available-part <part>)))))
|#

;;added for p4; replaced previous rule
(Inference-Rule PART-NOT-AVAILABLE-AND-HOLDING-DEVICE-NOT-EMPTY-AND-MACHINE-NOT-AVAILABLE
 (mode eager)		
 (params <part>)
 (preconds
  ((<part> Part)
   (<machine> Machine)
   (<holding-device> Holding-device)
   (<side> Side) (<side-pair> Side-Pair))
  (or (holding-weakly <machine> <holding-device> <part> <side> <side-pair>)
      (holding <machine> <holding-device> <part> <side> <side-pair>)))
 (effects
  ()
  ((del (is-available-part <part>))
   (del (is-empty-holding-device <holding-device> <machine>))
   (del (is-available-machine <machine>)))))

#|
(Inference-Rule HOLDING-DEVICE-EMPTY
 (params <machine> <holding-device>)
 (preconds
  ((<holding-device> Holding-device)
   (<machine> Machine))
  (and
   (~ (exists
       ((<part> Part)
	(<side> Side))
       (holding-weakly <machine> <holding-device> <part> <side>)))
   (~ (exists
       ((<another-part> Part)
	(<side> Side))
       (holding <machine> <holding-device> <another-part> <side>)))))
 (effects
  ()
  ((add (is-empty-holding-device <holding-device> <machine>)))))
|#

;;new version copied from PART-AVAILABLE

(Inference-Rule HOLDING-DEVICE-EMPTY
 (params <machine> <holding-device>)
 (preconds
  ((<holding-device> Holding-device)
   (<machine> Machine))
  (forall
   ((<part> Part)
    (<side> Side)
    (<side-pair> 
     (and Side-Pair (gen-from-pred (sides-for-holding-device <side> <side-pair>)))))
   (and
    (~ (holding-weakly <machine> <holding-device> <part> <side> <side-pair>))
    (~ (holding <machine> <holding-device> <part> <side> <side-pair>)))))
 (effects
  ()
  ((add (is-empty-holding-device <holding-device> <machine>)))))




;;;************************************************************
; inference rules for shape

(Inference-Rule IS-RECTANGULAR
 (params <part>)
 (preconds
  ((<part> Part)
   (<l> (and Size (gen-from-pred (size-of <part> LENGTH <l>))))
   (<w> (and Size (gen-from-pred (size-of <part> WIDTH <w>))))
   (<h> (and Size (gen-from-pred (size-of <part> HEIGHT <h>)))))
  (always-true))
 (effects
  ()
  ((add (shape-of <part> RECTANGULAR)))))

(Inference-Rule IS-CYLINDRICAL
 (params <part>)
 (preconds
  ((<part> Part)
   (<l> (and Size (gen-from-pred (size-of <part> LENGTH <l>))))
   (<d> (and Hole-Diameter
	     (gen-from-pred (size-of <part> DIAMETER <d>)))))
  (always-true))
 (effects
  ()
  ((add (shape-of <part> CYLINDRICAL)))))


(Inference-Rule ARE-SIDES-OF-RECTANGULAR-PART
 (params <part>)
 (preconds
  ((<part> Part))
  (shape-of <part> RECTANGULAR))
 (effects
  ()
  ((add (side-of <part> SIDE1))
  (add (side-of <part> SIDE2))
  (add (side-of <part> SIDE3))
  (add (side-of <part> SIDE4))
  (add (side-of <part> SIDE5))
  (add (side-of <part> SIDE6)))))


(Inference-Rule ARE-SIDES-OF-CYLINDRICAL-PART
 (params <part>)
 (preconds
  ((<part> Part))
  (shape-of <part> CYLINDRICAL))
 (effects
  ()
  ((add (side-of <part> SIDE0))
   (add (side-of <part> SIDE3))
   (add (side-of <part> SIDE6)))))


;;;************************************************************
;;; Properties of part materials:
;;; ALLOYS:
;;; - non-ferrous
;;;    - brass
;;;    - copper
;;;    - bronze
;;; - ferrous
;;;    - steel
;;;    - iron
;;; HARDNESS:
;;; - soft
;;;    - aluminum
;;;    - non-ferrous
;;; - hard
;;;    - ferrous
;;; HIGH-MELTING-POINT:
;;; - tungsten
;;; - molybdenum

(Inference-Rule MATERIAL-FERROUS
; (mode eager)
 (params <part>)
 (preconds
  ((<part> Part))
  (or
   (material-of <part> STEEL)
   (material-of <part> IRON)))
 (effects
  ()
  ((add (alloy-of <part> FERROUS)))))

(Inference-Rule MATERIAL-NON-FERROUS                
; (mode eager)
 (params <part>)
 (preconds
  ((<part> Part))
  (or
   (material-of <part> BRASS)
   (material-of <part> COPPER)
   (material-of <part> BRONZE)))
 (effects
  ()
  ((add (alloy-of <part> NON-FERROUS)))))

#| Not subgoaling on alloy-of!!

(Inference-Rule HARDNESS-OF-MATERIAL-SOFT
; (mode eager)
 (params <part>)
 (preconds
  ((<part> Part))
  (or
   (material-of <part> ALUMINUM)
   (alloy-of <part> NON-FERROUS)))
 (effects
  ()
  ((add (hardness-of <part> SOFT)))))

|#

;;changing the order of preconds works
(Inference-Rule HARDNESS-OF-MATERIAL-SOFT
; (mode eager)
 (params <part>)
 (preconds
  ((<part> Part))
  (or
   (alloy-of <part> NON-FERROUS)
   (material-of <part> ALUMINUM)))
 (effects
  ()
  ((add (hardness-of <part> SOFT)))))

(Inference-Rule HARDNESS-OF-MATERIAL-HARD
; (mode eager)
 (params <part>)
 (preconds
  ((<part> Part))
  (alloy-of <part> FERROUS))
 (effects
  ()
  ((add (hardness-of <part> HARD)))))

(Inference-Rule HIGH-MELTING-POINT
; (mode eager)
 (params <wire>)
 (preconds
  ((<wire> WIRE))
  (or 
   (material-of <wire> TUNGSTEN)
   (material-of <wire> MOLYBDENUM)))
 (effects
  ()
  ((add (has-high-melting-point <wire>)))))


#|
(load "/afs/cs/project/prodigy-aperez/domains4.0/hd-machining/sc-rules")

(load "/afs/cs/project/prodigy-aperez/domains4.0/hd-machining/eff-rules")
;(load "/afs/cs/project/prodigy-aperez/domains4.0/hd-machining/expand-main-goals-rule")


(let* ((possible-rules
	'((eff-rules "sc-rules.lisp" "eff-rules.lisp")
	  (anycost   "sc-rules.lisp" "expand-main-goals-rule.lisp")))
       (val
 	(if (boundp '*which-rules*)
	    *which-rules*
	  (do ((val (progn
		      (format t "Which rule set ~A? "
			      (mapcar #'car possible-rules))
		      (read))
		    (read)))
	      ((assoc val possible-rules) val)
	    (format t
		    "Invalid name of rule set: ~A. The possible values are:~%~
                      ~S~%~%~
               Enter new name now: " val (mapcar #'car possible-rules))))))
  (let ((files (cdr (assoc val possible-rules))))
    (if files
	(mapcar #'(lambda (f)
		    (load (concatenate
			   'string
			   "/afs/cs/project/prodigy-aperez/domains4.0/hd-machining/" f)))
		files)
      (format t "Invalid value of *which-rules*. The possible values are:~%~
                 ~S~%~
               Set its value and call domain again."
	      (mapcar #'car possible-rules)))))
|#


(load "/afs/cs/project/prodigy-aperez/domains4.0/hd-machining/sc-rules")

;;these are the rules that control the knowledge acquisition
;(if (fboundp 'in-acq-phase-p) 
;    (load "/afs/cs/project/prodigy-aperez/qual/control-rules"))

(setf PRODIGY4::*CHECK-EFFECT-CONSTANTS-FOR-RELEVANT-OPS* t)
(setf p4::*rule-relative-weights* nil)

;(load "/afs/cs/project/prodigy-aperez/domains4.0/hd-machining/eval-fns/compute-cost")
;(load
; "/afs/cs/project/prodigy-aperez/domains4.0/hd-machining/eval-fns/cost-diff-ops")
;(load "/afs/cs/project/prodigy-aperez/domains4.0/hd-machining/gen-probs")

(cond
  ((fboundp 'generate-signature)
   (generate-signature)
   (format t "~% Computed signature table.~%"))
  (t nil))
