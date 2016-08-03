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
;;; - The welding operators don't work yet as there is not
;;; capability to create new objects.
;;; - (always-true) should be in the initial state (for the rules 
;;; with no (other) preconditions to fire
;;;************************************************************
;;;
;;; RULES: total of 117
;;;
;;; OPERATORS: total of 73
;;;            38 machining operations
;;;            35 operators for setups
;;;
;;; INFERENCE RULES: total of 44
;;;************************************************************

(create-problem-space 'machining :current t)

(setf (getf (p4::problem-space-plist *current-problem-space*)
	    :depth-bound) 400)

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

;;;Holes
(ptype-of Hole :Top-Type)
(ptype-of Center-Hole Hole)
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
;;; Tool has to be of type Drill-bit

; operators for making holes


(Operator DRILL-WITH-SPOT-DRILL
 (params <machine> <drill-bit> <holding-device>
	 <part> <hole> <side>)
 (preconds
  ((<machine> Drill)
   (<drill-bit> Spot-Drill)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP))
   (<part> Part)
   (<side> Side)
   (<hole> Hole)
   (<loc-x> (and Hole-Location (x-location-of <part> <loc-x>)))
   (<loc-y> (and Hole-Location (y-location-of <part> <loc-y>))))
  (and 
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (add (has-spot <part> <hole> <side> <loc-x> <loc-y>)))))

(Operator DRILL-WITH-TWIST-DRILL
 (params <machine> <drill-bit> <holding-device>
	 <part> <hole> <side> <hole-depth> <hole-diameter>)
 (preconds
  ((<machine> Drill)
   (<drill-bit> Twist-Drill)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP))
   (<hole> Hole)
   (<drill-bit-diameter>
    (and Hole-Diameter
	 (gen-from-pred (diameter-of-drill-bit <drill-bit> <drill-bit-diameter>))))
   (<hole-diameter> (and Hole-Diameter (same <hole-diameter> <drill-bit-diameter>)))
   (<side> Side)
   (<part> Part)
   (<loc-x> (and Hole-Location (x-location-of <part> <loc-x>)))
   (<loc-y> (and Hole-Location (y-location-of <part> <loc-y>)))
   (<hole-depth> Hole-Depth))
  (and 
   (has-spot <part> <hole> <side> <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side>)))
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
 (params <machine> <drill-bit> <holding-device>
          <part> <hole> <side> <hole-depth> <hole-diameter>)
 (preconds
  ((<machine> Drill)
   (<drill-bit> High-Helix-Drill)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP))
   (<fluid> Fluid)
   (<part> Part)
   (<side> Side)
   (<hole> Hole)
   (<loc-x> (and Hole-Location (x-location-of <part> <loc-x>)))
   (<loc-y> (and Hole-Location (y-location-of <part> <loc-y>)))
   (<hole-depth> Hole-Depth)
   (<hole-diameter>
    (and Hole-Diameter
	 (gen-from-pred (diameter-of-drill-bit <drill-bit> <hole-diameter>)))))
  (and
   (has-fluid <machine> <fluid> <part>)
   (has-spot <part> <hole> <side> <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
;   (del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
   (add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
                  <loc-x> <loc-y>)))))

 
(Operator DRILL-WITH-STRAIGHT-FLUTED-DRILL
 (params <machine> <drill-bit> <holding-device>
          <part> <hole> <side> <hole-depth> <hole-diameter>)
 (preconds 
  ((<machine> DRILL)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP))
   (<drill-bit> STRAIGHT-FLUTED-DRILL)
   (<part> Part)
   (<side> Side)
   (<hole> Hole)
   (<loc-x> Hole-Location)
   (<loc-y> Hole-Location)
   (<drill-bit-diameter>
    (and Hole-Diameter
	 (gen-from-pred
	  (diameter-of-drill-bit <drill-bit> <drill-bit-diameter>))))
   (<hole-diameter>
    (and Hole-Diameter (same <drill-bit-diameter> <hole-diameter>)))
   (<hole-depth> (and Hole-Depth (smaller <hole-depth> 2))))
  (and
   (material-of <part> BRASS)
   (has-spot <part> <hole> <side> <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
;   (del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
   (add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
                  <loc-x> <loc-y>)))))


(Operator DRILL-WITH-OIL-HOLE-DRILL
 (params <machine> <drill-bit> <holding-device>
          <part> <hole> <side> <hole-depth> <hole-diameter>)
 (preconds
  ((<machine> DRILL)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP))
   (<drill-bit> OIL-HOLE-DRILL)
   (<part> Part)
   (<side> Side)
   (<hole> Hole)
   (<fluid> FLUID)
   (<drill-bit-diameter>
    (and Hole-Diameter
	 (gen-from-pred
	  (diameter-of-drill-bit <drill-bit> <drill-bit-diameter>))))
   (<hole-diameter>
    (and Hole-Diameter (same <drill-bit-diameter> <hole-diameter>)))
   (<hole-depth> (and Hole-Depth (smaller <hole-depth> 20)))
   (<loc-x> Hole-Location)
   (<loc-y> Hole-Location))
  (and 	   
   (has-fluid <machine> <fluid> <part>)
   (has-spot <part> <hole> <side> <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
;   (del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
   (add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
                  <loc-x> <loc-y>)))))

(Operator DRILL-WITH-GUN-DRILL 
 (params <machine> <drill-bit> <holding-device>
          <part> <hole> <side> <hole-depth> <hole-diameter>)
 (preconds
  ((<machine> DRILL)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP))
   (<drill-bit> GUN-DRILL)
   (<fluid> FLUID)
   (<part> Part)
   (<side> Side)
   (<hole> Hole)
   (<drill-bit-diameter>
    (and Hole-Diameter (gen-from-pred
	       (diameter-of-drill-bit <drill-bit> <drill-bit-diameter>))))
   (<hole-diameter> (and Hole-Diameter (same <drill-bit-diameter> <hole-diameter>)))
   (<hole-depth> Hole-Depth)
   (<loc-x> Hole-Location)
   (<loc-y> Hole-Location))
  (and 
   (has-fluid <machine> <fluid> <part>)
   (has-spot <part> <hole> <side> <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
;   (del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
   (add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
                  <loc-x> <loc-y>)))))

(Operator DRILL-WITH-CENTER-DRILL
 (params <machine> <drill-bit> <holding-device>
          <part> <hole> <side> <drill-bit-diameter> <loc-x> <loc-y>)
 (preconds
  ((<machine> DRILL)
   (<drill-bit> CENTER-DRILL)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP))
   (<hole> Hole)
   (<drill-bit-diameter>
    (and Hole-Diameter
	 (gen-from-pred (diameter-of-drill-bit <drill-bit> <drill-bit-diameter>))))
   (<hole-diameter> (and Hole-Diameter (same <hole-diameter> <drill-bit-diameter>)))
   (<side> Side)
   (<part> Part)
   (<loc-x> (and Hole-Location (x-location-of <part> <loc-x>)))
   (<loc-y> (and Hole-Location (y-location-of <part> <loc-y>))))
  (and 
   (has-spot <part> <hole> <side> <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
;   (del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
   (add (has-hole <part> <hole> <side> 1/8 <hole-diameter> 
                  <loc-x> <loc-y>))
   (add (has-center-hole <part> <hole> <side> <loc-x> <loc-y>)))))


;; operators for finishing holes

(Operator TAP 
 (params <machine> <drill-bit> <holding-device> <part> <hole>)
 (preconds
  ((<machine> DRILL)
   (<drill-bit> TAP)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP))
   (<part> PART)
   (<hole> HOLE)
   (<side> Side)
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
   (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
             <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> <side>)))
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
 (params <machine> <drill-bit> <holding-device> <part> <hole>)
 (preconds
  ((<machine> DRILL)
   (<drill-bit> COUNTERSINK)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP))
   (<part> PART)
   (<hole> Hole)
   (<side> Side)
   (<hole-depth> Hole-Depth)
   (<hole-diameter> Hole-Diameter)
   (<loc-x> (and Hole-Location (x-location-of <part> <loc-x>)))
   (<loc-y> (and Hole-Location (y-location-of <part> <loc-y>)))
   (<angle>
    (and Angle (gen-from-pred (angle-of-drill-bit <drill-bit> <angle>)))))
  (and
   (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
             <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (add (is-countersinked <part> <hole> <side> <hole-depth> <hole-diameter> 
                          <loc-x> <loc-y> <angle>)))))

 
(Operator COUNTERBORE 
 (params <machine> <drill-bit> <holding-device> <part> <hole>)
 (preconds
  ((<machine> DRILL)
   (<drill-bit> COUNTERBORE)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP))
   (<part> Part)
   (<hole> Hole)
   (<side> Side)
   (<counterbore-size>
    (and Hole-Diameter (gen-from-pred
	       (size-of-drill-bit <drill-bit> <counterbore-size>))))
   (<hole-depth> Hole-Depth)
   (<hole-diameter> Hole-Diameter)
   (<loc-x> Hole-Location)
   (<loc-y> Hole-Location))
  (and
   (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
             <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (add (is-counterbored <part> <hole> <side> <hole-depth> <hole-diameter>
                         <loc-x> <loc-y> <counterbore-size>)))))

(Operator REAM 
 (params <machine> <drill-bit> <holding-device> <part> <hole> 
	 <side> <hole-depth> <hole-diameter>)
 (preconds
  ((<machine> DRILL)
   (<drill-bit> REAMER)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE TOE-CLAMP))
   (<part> PART)
   (<hole> HOLE)
   (<side> SIDE)
   (<fluid> FLUID)
   (<hole-depth> (and Hole-Depth (smaller <hole-depth> 2)))
   (<loc-x> Hole-Location)
   (<loc-y> Hole-Location)
   (<hole-diameter>
    (and Hole-Diameter
	 (gen-from-pred
	  (diameter-of-drill-bit <drill-bit> <drill-bit-diameter>)))))
  (and 
   (has-fluid <machine> <fluid> <part>)
   (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
             <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> <side>)))
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
;;; Tools can be:
;;; - Milling-Cutter Drill-bit

(Operator SIDE-MILL
 (params <machine> <part> <milling-cutter> <holding-device> 
          <side> <dim> <value>)
 (preconds 
  ((<machine> MILLING-MACHINE)
   (<part> Part)
   (<milling-cutter> MILLING-CUTTER)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE COLLET-CHUCK TOE-CLAMP))
   (<dim> (and  Dimension  (one-of <dim> '(WIDTH LENGTH))))
   (<side> Side)
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (smaller <value> <value-old>)
		  (smaller-than-2in <value-old> <value>))))
  (and
   (side-up-for-machining <dim> <side>)
   (holding-tool <machine> <milling-cutter>)
   (holding <machine> <holding-device> <part> <side>)))
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

(Operator FACE-MILL
 (params <machine> <part> <milling-cutter> <holding-device> 
          <side> <dim> <value>)
 (preconds
  ((<machine> MILLING-MACHINE)
   (<milling-cutter> MILLING-CUTTER)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE COLLET-CHUCK TOE-CLAMP))
   (<part> Part)
   (<dim> (and Dimension (same <dim> 'HEIGHT)))
   (<side> Side)
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (smaller <value> <value-old>))))
  (and 
   (side-up-for-machining <dim> <side>)
   (holding-tool <machine> <milling-cutter>)
   (holding <machine> <holding-device> <part> <side>)))
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

(Operator DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE
 (params <machine> <drill-bit> <holding-device> <part> <hole> <side>)
 (preconds
  ((<machine> MILLING-MACHINE)
   (<drill-bit> SPOT-DRILL)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE COLLET-CHUCK TOE-CLAMP))
   (<part> Part)
   (<side> Side)
   (<loc-x> Hole-Location)
   (<loc-y> Hole-Location)
   (<hole> Hole))
  (and
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (add (has-spot <part> <hole> <side> <loc-x> <loc-y>)))))

(Operator DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE
 (params <machine> <drill-bit> <holding-device> 
          <part> <hole> <side> <hole-depth> <hole-diameter>)
 (preconds
  ((<machine> MILLING-MACHINE)
   (<drill-bit> TWIST-DRILL)
   (<holding-device> (or 4-JAW-CHUCK V-BLOCK VISE COLLET-CHUCK TOE-CLAMP))
   (<part> Part)
   (<side> Side)
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
   (has-spot <part> <hole> <side> <loc-x> <loc-y>)
   (holding-tool <machine> <drill-bit>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((del (is-clean <part>))
   (add (has-burrs <part>))
;   (del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
   (add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
                  <loc-x> <loc-y>)))))

;;;************************************************************
;;; MACHINE: LATHE
;;;
;;; only these devices can be used on a lathe  (see
;;; PUT-HOLDING-DEVICE-IN-lathe)
;;; - CENTERS 4-JAW-CHUCK COLLET-CHUCK
;;; Tools have to be of class Lathe-Toolbit

(Operator ROUGH-TURN-RECTANGULAR-PART
 (params <machine> <part> <toolbit> <holding-device> <diameter-new>)
 (preconds
  ((<machine> LATHE)
   (<toolbit> ROUGH-TOOLBIT)
   (<part> PART)
   (<holding-device> (or CENTERS 4-JAW-CHUCK COLLET-CHUCK))
   (<h> (and Size (gen-from-pred (size-of <part> HEIGHT <h>))))
   (<w> (and Size (gen-from-pred (size-of <part> WIDTH <w>))))
   (<side> Side)
   (<diameter-new> (and Hole-Diameter (smaller <diameter-new> <h>)
			(smaller <diameter-new> <w>))))
  (and
   (shape-of <part> RECTANGULAR)
   (holding-tool <machine> <toolbit>)
   (side-up-for-machining DIAMETER <side>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ((<surface-coating> SURFACE-COATING)
   (<sf1> SURFACE-FINISH)
   (<sf2> SURFACE-FINISH)
   (<sf4> SURFACE-FINISH)
   (<sf5> SURFACE-FINISH))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (size-of <part> HEIGHT <h>))
   (del (size-of <part> WIDTH <w>))
   (add (size-of <part> DIAMETER <diameter-new>))
   (del (surface-coating-side <part> SIDE1 <surface-coating>))
   (del (surface-coating-side <part> SIDE2 <surface-coating>))
   (del (surface-coating-side <part> SIDE4 <surface-coating>))
   (del (surface-coating-side <part> SIDE5 <surface-coating>))
   (del (surface-coating-side <part> SIDE0 <surface-coating>))
   (del (surface-finish-side <part> SIDE1 <sf1>))
   (del (surface-finish-side <part> SIDE2 <sf2>))
   (del (surface-finish-side <part> SIDE4 <sf4>))
   (del (surface-finish-side <part> SIDE5 <sf5>))
   (add (surface-finish-side <part> SIDE0 ROUGH-TURN)))))


(Operator ROUGH-TURN-CYLINDRICAL-PART
 (params <machine> <part> <toolbit> <holding-device> <diameter-new>)
 (preconds
   ((<machine> LATHE)
    (<toolbit> ROUGH-TOOLBIT)
    (<part> PART)
    (<holding-device> (or CENTERS 4-JAW-CHUCK COLLET-CHUCK))
    (<side> Side)
    (<diameter>
     (and Hole-Diameter (gen-from-pred (size-of <part> DIAMETER <diameter>))))
    (<diameter-new> (and Hole-Diameter (smaller <diameter-new> <diameter>))))
   (and
    (shape-of <part> CYLINDRICAL)
    (holding-tool <machine> <toolbit>)
    (side-up-for-machining DIAMETER <side>)
    (holding <machine> <holding-device> <part> <side>)))
 (effects
  ((<surface-coating> SURFACE-COATING)
   (<sf> SURFACE-FINISH))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (size-of <part> DIAMETER <diameter>))
   (add (size-of <part> DIAMETER <diameter-new>))
   (del (surface-coating-side <part> SIDE0 <surface-coating>))
   (del (surface-finish-side <part> SIDE0 <sf>))
   (add (surface-finish-side <part> SIDE0 ROUGH-TURN)))))

(Operator FINISH-TURN
 (params <machine> <part> <toolbit> <holding-device> <diameter-new>)
 (preconds
  ((<machine> LATHE)
   (<toolbit> FINISH-TOOLBIT)
   (<holding-device> (or CENTERS 4-JAW-CHUCK COLLET-CHUCK))
   (<part> Part)
   (<diameter>
    (and Hole-Diameter (gen-from-pred (size-of <part> DIAMETER <diameter>))))
   (<diameter-new> (and Hole-Diameter (finishing-size <diameter> <diameter-new>))))
  (and
   (shape-of <part> CYLINDRICAL)
   (holding-tool <machine> <toolbit>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> SIDE0)))
 (effects
  ((<surface-coating> SURFACE-COATING)
   (<sf> SURFACE-FINISH))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (size-of <part> DIAMETER <diameter>))
   (add (size-of <part> DIAMETER <diameter-new>))
   (del (surface-coating-side <part> SIDE0 <surface-coating>))
   (del (surface-finish-side <part> SIDE0 <sf>))
   (add (surface-finish-side <part> SIDE0 FINISH-TURN)))))

(Operator MAKE-THREAD-WITH-LATHE
 (params <machine> <part> <holding-device> <side>)
 (preconds
  ((<machine> LATHE)
   (<toolbit> V-THREAD)
   (<holding-device> (or CENTERS 4-JAW-CHUCK COLLET-CHUCK))
   (<part> Part)
   ;;this is so the params list makes sense
   (<side> (and Side (same <side> 'SIDE0))))
  (and
   (shape-of <part> CYLINDRICAL)
   (holding-tool <machine> <toolbit>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> SIDE0)))
 (effects
  ((<surface-coating> SURFACE-COATING)
   (<sf> SURFACE-FINISH))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> SIDE0 <surface-coating>))
   (del (surface-finish-side <part> SIDE0 <sf>))
   (add (surface-finish-side <part> SIDE0 TAPPED)))))

(Operator MAKE-KNURL-WITH-LATHE
 (params <machine> <part> <holding-device> <side>)
 (preconds
  ((<machine> LATHE)
   (<toolbit> KNURL)
   (<holding-device> (or CENTERS 4-JAW-CHUCK COLLET-CHUCK))
   (<part> Part)
   ;;this is so the params list makes sense
   (<side> (and Side (same <side> 'SIDE0))))
  (and
   (shape-of <part> CYLINDRICAL)
   (holding-tool <machine> <toolbit>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> SIDE0)))
 (effects
  ((<surface-coating> SURFACE-COATING)
   (<sf> SURFACE-FINISH))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> SIDE0 <surface-coating>))
   (del (surface-finish-side <part> SIDE0 <sf>))
   (add (surface-finish-side <part> SIDE0 KNURLED)))))

(Operator FILE-WITH-LATHE
 (params <machine> <part> <holding-device> <toolbit> <diameter-new>) 
 (preconds
  ((<machine> LATHE)
   (<toolbit> LATHE-FILE)
   (<holding-device> (or CENTERS 4-JAW-CHUCK COLLET-CHUCK))
   (<part> Part)
   (<diameter>
    (and Hole-Diameter (gen-from-pred (size-of <part> DIAMETER <diameter>))))
   (<diameter-new>
    (and Hole-Diameter (finishing-size <diameter> <diameter-new>))))
  (and
   (shape-of <part> CYLINDRICAL)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> SIDE0)))
 (effects
  ((<surface-coating> SURFACE-COATING)
   (<sf> SURFACE-FINISH))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (size-of <part> DIAMETER <diameter>))
   (add (size-of <part> DIAMETER <diameter-new>))
   (del (surface-coating-side <part> SIDE0 <surface-coating>))
   (del (surface-finish-side <part> SIDE0 <sf>))
   (add (surface-finish-side <part> SIDE0 ROUGH-GRIND)))))

(Operator POLISH-WITH-LATHE
 (params <machine> <part> <holding-device> <cloth>)
 (preconds
  ((<machine> LATHE)
   (<cloth> ABRASIVE-CLOTH)
   (<holding-device> (or CENTERS 4-JAW-CHUCK COLLET-CHUCK))
   (<part> Part))
  (and 
   (material-of-abrasive-cloth <cloth> EMERY)
   (shape-of <part> CYLINDRICAL)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> SIDE0)))
 (effects
  ((<surface-coating> SURFACE-COATING)
   (<sf> SURFACE-FINISH))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> SIDE0 <surface-coating>))
   (del (surface-finish-side <part> SIDE0 <sf>))
   (add (surface-finish-side <part> SIDE0 POLISHED)))))

;;;************************************************************
;;; MACHINE: SHAPER
;;;
;;;aperez:
;;; only these devices can be used on a shaper 
;;; - VISE

(Operator ROUGH-SHAPE
 (params <machine> <part> <cutting-tool> <holding-device> 
          <side> <dim> <value>)
 (preconds
  ((<machine> SHAPER)
   (<cutting-tool> ROUGHING-CUTTING-TOOL)
   (<holding-device> VISE)
   (<part> Part)
   ;;this is necessary, ow the op is used to make parts cylindrical 
   (<dim> (and Dimension (diff <dim> 'DIAMETER)))
   (<side> Side)
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (smaller <value> <value-old>))))
  (and
   (side-up-for-machining <dim> <side>)
   (holding-tool <machine> <cutting-tool>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<surface-finish> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <surface-finish>))
   (add (surface-finish-side <part> <side> ROUGH-SHAPED))
   (add (size-of <part> <dim> <value>))
   (del (size-of <part> <dim> <value-old>)))))
    
(Operator FINISH-SHAPE
 (params <machine> <part> <cutting-tool> <holding-device> 
          <side> <dim> <value>)
 (preconds 
  ((<machine> SHAPER)
   (<cutting-tool> FINISHING-CUTTING-TOOL)
   (<holding-device> VISE)
   (<part> Part)
   ;;this is necessary, ow the op is used to make parts cylindrical 
   (<dim> (and Dimension (diff <dim> 'DIAMETER)))
   (<side> Side)
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (finishing-size <value-old> <value>)
		 (smaller <value> <value-old>))))
  (and    
   (side-up-for-machining <dim> <side>)
   (holding-tool <machine> <cutting-tool>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<surface-finish> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <surface-finish>))
   (add (surface-finish-side <part> <side> FINISH-SHAPED))
   (add (size-of <part> <dim> <value>))
   (del (size-of <part> <dim> <value-old>)))))

;;;************************************************************
;;; MACHINE: PLANER
;;;
;;;aperez:
;;; only these devices can be used on a planer
;;; - TOE-CLAMP

(Operator ROUGH-SHAPE-WITH-PLANER
 (params <machine> <part> <cutting-tool> <holding-device> 
          <side> <dim> <value>)
 (preconds
  ((<machine> PLANER)
   (<cutting-tool> ROUGHING-CUTTING-TOOL)
   (<holding-device> TOE-CLAMP)
   (<fluid> FLUID)
   (<part> Part)
   (<side> Side)
   ;; this is necessary, ow the op is used to make parts cylindrical 
   (<dim> (and Dimension (diff <dim> 'DIAMETER)))
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (smaller <value> <value-old>))))
  (and
   (side-up-for-machining <dim> <side>)
   (holding-tool <machine> <cutting-tool>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<sf> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <sf>))
   (add (surface-finish-side <part> <side> ROUGH-PLANED))
   (add (size-of <part> <dim> <value>))
   (del (size-of <part> <dim> <value-old>)))))

(Operator FINISH-SHAPE-WITH-PLANER
 (params <machine> <part> <cutting-tool> <holding-device> 
          <side> <dim> <value>)
 (preconds
  ((<machine> PLANER)
   (<cutting-tool> FINISHING-CUTTING-TOOL)
   (<holding-device> TOE-CLAMP)
   (<fluid> FLUID)
   (<part> Part)
   (<side> Side)
   ;; this is necessary, ow the op is used to make parts cylindrical 
   (<dim> (and Dimension (diff <dim> 'DIAMETER)))
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (finishing-size <value> <value-old>))))
  (and
   (side-up-for-machining <dim> <side>)
   (holding-tool <machine> <cutting-tool>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<sf> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <sf>))
   (add (surface-finish-side <part> <side> FINISH-PLANED))
   (add (size-of <part> <dim> <value>))
   (del (size-of <part> <dim> <value-old>)))))

;;;************************************************************
;;; MACHINE: GRINDER
;;;
;;;aperez:
;;; only these devices can be used on a grinder
;;; - MAGNETIC-CHUCK V-BLOCK VISE

(Operator ROUGH-GRIND-WITH-HARD-WHEEL
 (params <machine> <part> <wheel> <holding-device> 
          <side> <dim> <value>)
 (preconds
  ((<machine> GRINDER)
   (<wheel> GRINDING-WHEEL)
   (<holding-device> (or MAGNETIC-CHUCK V-BLOCK VISE))
   (<fluid> FLUID)
   (<part> Part)
   (<side> Side)
   ;; this is necessary, ow the op is used to make parts cylindrical 
   (<dim> (and Dimension (diff <dim> 'DIAMETER)))
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (smaller <value> <value-old>))))
  (and   
   (has-fluid <machine> <fluid> <part>)
   (hardness-of-wheel <wheel> HARD)
   (hardness-of <part> SOFT)
   ;;note that the next two constrain the material to brass or aluminum
   (~ (material-of <part> BRONZE))
   (~ (material-of <part> COPPER))
   (grit-of-wheel <wheel> COARSE-GRIT)
   (side-up-for-machining <dim> <side>)
   (holding-tool <machine> <wheel>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<sf> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <sf>))
   (add (surface-finish-side <part> <side> ROUGH-GRIND))
   (add (size-of <part> <dim> <value>))
   (del (size-of <part> <dim> <value-old>)))))

(Operator ROUGH-GRIND-WITH-SOFT-WHEEL
 (params <machine> <part> <wheel> <holding-device> 
	 <side> <dim> <value>)
 (preconds
  ((<machine> GRINDER)
   (<wheel> GRINDING-WHEEL)
   (<holding-device> (or MAGNETIC-CHUCK V-BLOCK VISE))
   (<fluid> FLUID)
   (<part> Part)
   (<side> Side)
   ;; this is necessary, ow the op is used to make parts cylindrical 
   (<dim> (and Dimension (diff <dim> 'DIAMETER)))
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (smaller <value> <value-old>))))
  (and
   (has-fluid <machine> <fluid> <part>)
   (hardness-of-wheel <wheel> SOFT)
   (hardness-of <part> HARD)
   (grit-of-wheel <wheel> COARSE-GRIT)
   (side-up-for-machining <dim> <side>)
   (holding-tool <machine> <wheel>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<sf> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <sf>))
   (add (surface-finish-side <part> <side> ROUGH-GRIND))
   (add (size-of <part> <dim> <value>))
   (del (size-of <part> <dim> <value-old>)))))

(Operator FINISH-GRIND-WITH-HARD-WHEEL
 (params <machine> <part> <wheel> <holding-device> 
          <side> <dim> <value>)
 (preconds
  ((<machine> GRINDER)
   (<wheel> GRINDING-WHEEL)
   (<holding-device> (or MAGNETIC-CHUCK V-BLOCK VISE))
   (<fluid> FLUID)
   (<part> Part)
   (<side> Side)
   ;; this is necessary, ow the op is used to make parts cylindrical 
   (<dim> (and Dimension (diff <dim> 'DIAMETER)))
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (finishing-size <value-old> <value>))))
  (and
   (has-fluid <machine> <fluid> <part>)
   (hardness-of-wheel <wheel> HARD)
   (hardness-of <part> SOFT)
   (~ (material-of <part> BRONZE))
   (~ (material-of <part> COPPER))
   (grit-of-wheel <wheel> FINE-GRIT)
   (side-up-for-machining <dim> <side>)
   (holding-tool <machine> <wheel>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<sf> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <sf>))
   (add (surface-finish-side <part> <side> FINISH-GRIND))
   (add (size-of <part> <dim> <value>))
   (del (size-of <part> <dim> <value-old>)))))

(Operator FINISH-GRIND-WITH-SOFT-WHEEL
 (params <machine> <part> <wheel> <holding-device> 
          <side> <dim> <value>)
 (preconds
  ((<machine> GRINDER)
   (<wheel> GRINDING-WHEEL)
   (<holding-device> (or MAGNETIC-CHUCK V-BLOCK VISE))
   (<fluid> FLUID)
   (<part> Part)
   (<side> Side)
   ;; this is necessary, ow the op is used to make parts cylindrical 
   (<dim> (and Dimension (diff <dim> 'DIAMETER)))
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (finishing-size <value-old> <value>))))
  (and
   (has-fluid <machine> <fluid> <part>)
   (hardness-of-wheel <wheel> SOFT)
   (hardness-of <part> HARD)
   (grit-of-wheel <wheel> FINE-GRIT)
   (side-up-for-machining <dim> <side>)
   (holding-tool <machine> <wheel>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (holding <machine> <holding-device> <part> <side>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<sf> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <sf>))
   (add (surface-finish-side <part> <side> FINISH-GRIND))
   (add (size-of <part> <dim> <value>))
   (del (size-of <part> <dim> <value-old>)))))

;;;************************************************************
;;; MACHINE: CIRCULAR-SAW
;;;
;;;aperez:
;;; only these devices can be used on a circular-saw
;;; - VISE V-BLOCK

(Operator CUT-WITH-CIRCULAR-COLD-SAW
 (params <machine> <part> <attachment> <holding-device> <dim> <value>)
 (preconds
  ((<machine> CIRCULAR-SAW)
   (<attachment> COLD-SAW)
   (<holding-device> (or VISE V-BLOCK))
   (<part> Part)
   (<side> Side)
   ;; this is necessary, ow the op is used to make parts cylindrical 
   (<dim> (and Dimension (diff <dim> 'DIAMETER)))
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (smaller <value> <value-old>))))  
  (and 
    (side-up-for-machining <dim> <side>)
    (holding-tool <machine> <attachment>)
    (holding <machine> <holding-device> <part> <side>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<sf> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <sf>))
   (add (surface-finish-side <part> <side> FINISH-MILL))
   (del (size-of <part> <dim> <value-old>))
   (add (size-of <part> <dim> <value>)))))

(Operator CUT-WITH-CIRCULAR-FRICTION-SAW
 (params <machine> <part> <attachment> <holding-device> <dim> <value>)
 (preconds
  ((<machine> CIRCULAR-SAW)
   (<attachment> FRICTION-SAW)
   (<fluid> FLUID)
   (<holding-device> (or VISE V-BLOCK))
   (<part> Part)
   (<side> Side)
   ;; this is necessary, ow the op is used to make parts cylindrical 
   (<dim> (and Dimension (diff <dim> 'DIAMETER)))
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (smaller <value> <value-old>))))  
  (and 
    (has-fluid <machine> <fluid> <part>)
    (side-up-for-machining <dim> <side>)
    (holding-tool <machine> <attachment>)
    (holding <machine> <holding-device> <part> <side>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<sf> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <sf>))
   (add (surface-finish-side <part> <side> ROUGH-MILL))
   (del (size-of <part> <dim> <value-old>))
   (add (size-of <part> <dim> <value>)))))

;;;************************************************************
;;; MACHINE: BAND-SAW
;;;
;;; only these devices can be used on a band-saw
;;; - band-saws don't use holding-devices

(Operator CUT-WITH-BAND-SAW
 (params <machine> <part> <attachment> <dim> <value>)
 (preconds 
  ((<machine> BAND-SAW)
   (<attachment> BAND-FILE)
   (<part> Part)
   (<side> Side)
   ;; this is necessary, ow the op is used to make parts cylindrical 
   (<dim> (and Dimension (diff <dim> 'DIAMETER)))
   (<value-old>
    (and Size (gen-from-pred (size-of <part> <dim> <value-old>))))
   (<value> (and Size (smaller <value> <value-old>))))  
  (and 
   (side-up-for-machining <dim> <side>)
   (holding-tool <machine> <attachment>)
   (~ (has-burrs <part>))
   (is-clean <part>)
   (on-table <machine> <part>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<sf> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <sf>))
   (add (surface-finish-side <part> <side> SAWCUT))
   (del (size-of <part> <dim> <value-old>))
   (add (size-of <part> <dim> <value>)))))

(Operator POLISH-WITH-BAND-SAW
 (params <machine> <part> <attachment> <side>)
 (preconds
  ((<machine> BAND-SAW)   
   (<attachment> SAW-BAND)
   (<part> Part)
   (<side> Side)
   (<dim> Dimension))
  (and
    (side-up-for-machining <dim> <side>)
    (holding-tool <machine> <attachment>)
    (~ (has-burrs <part>))
    (is-clean <part>)
    (on-table <machine> <part>)))
 (effects
  ((<surface-coating> Surface-coating)
   (<old-sf-cond> Surface-finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-coating-side <part> <side> <surface-coating>))
   (del (surface-finish-side <part> <side> <old-sf-cond>))
   (add (surface-finish-side <part> <side> POLISHED)))))

;;;************************************************************
;;; MACHINE: WELDER
;;;
;;;aperez:
;;; only these devices can be used on a welder
;;; - VISE TOE-CLAMP

#|
(Operator WELD-CYLINDERS-METAL-ARC
 (params <machine> <part1> <part2> <part> <electrode>
          <holding-device> <length>)
 (preconds 
  ((<machine> METAL-ARC-WELDER)
   (<electrode> ELECTRODE)
   (<holding-device> (or VISE TOE-CLAMP))
   (<material> MATERIAL)
   (<part1> Part)
   (<part2> (and Part (diff <part1> <part2>)))
   (<part> (and Part (new-part <part> <part1> <part2>)))
   (<diameter1>
    (and Hole-Diameter
	 (gen-from-pred (size-of <part1> DIAMETER <diameter1>))))
   (<diameter2> (and Hole-Diameter (same <diameter2> <diameter1>)))
   (<length1>
    (and Size (gen-from-pred (size-of <part1> LENGTH <length1>))))
   (<length2>
    (and Size (gen-from-pred (size-of <part2> LENGTH <length2>))))
   (<length> (and Size (new-size <length1> <length2> <length>))))
  (and
   (material-of <part1> <material>)
   (material-of <part2> <material>)
   (shape-of <part1> CYLINDRICAL)
   (shape-of <part2> CYLINDRICAL)
   (~ (exists ((<hole> Hole)        (<side> Side)
	       (<depth> Hole-Depth) (<diameter> Hole-Diameter)
	       (<loc-x> Hole-Location)   (<loc-y> Hole-Location))
      (has-hole <part1> <hole> <side> <depth> <diameter> 
		<loc-x> <loc-y>)))
   (~ (exists ((<hole> Hole)        (<side> Side)
	       (<depth> Hole-Depth) (<diameter> Hole-Diameter)
	       (<loc-x> Hole-Location)   (<loc-y> Hole-Location))
      (has-hole <part2> <hole> <side> <depth> <diameter> 
		<loc-x> <loc-y>)))
   (size-of <part2> DIAMETER <diameter2>)
   (holding-tool <machine> <electrode>)
   (holding <machine> <holding-device> <part2> SIDE3)))
 (effects
  ((<sf31> Surface-finish)   (<sf62> Surface-finish)
   (<sidea> Side)   (<sideb> Side)
   (<sidec> Side)   (<sided> Side)
   (<surface-coatinga> surface-coating)
   (<surface-coatingb> surface-coating)
   (<sfc> Surface-Finish)   (<sfd> Surface-Finish))   
  ((add (material-of <part> <material>))
   (add (size-of <part> DIAMETER <diameter1>))
   (add (size-of <part> LENGTH <length>))
   (add (surface-finish-side <part> SIDE0 SAWCUT))
   (if (surface-finish-side <part1> SIDE3 <sf31>)
       ((add (surface-finish-side <part> SIDE3 <sf31>))))
   (if (surface-finish-side <part2> SIDE6 <sf62>)
       ((add (surface-finish-side <part> SIDE6 <sf62>))))
   (del (is-clean <part>))
   (del (holding <machine> <holding-device> <part2> SIDE3))
   (add (holding <machine> <holding-device> <part> SIDE3))
   (del (size-of <part1> DIAMETER <diameter1>))
   (del (size-of <part1> LENGTH <length1>))
   (del (size-of <part2> DIAMETER <diameter2>))
   (del (size-of <part2> LENGTH <length2>))
   (del (material-of <part1> <material>))
   (del (material-of <part2> <material>))
   (del (is-clean <part1>))
   (del (is-clean <part2>))
   (del (surface-coating-side <part1> <sidea> <surface-coatinga>))
   (del (surface-coating-side <part2> <sideb> <surface-coatingb>))
   (del (surface-finish-side <part1> <sidec> <sfc>))
   (del (surface-finish-side <part2> <sided> <sfd>)))))

(Operator WELD-CYLINDERS-GAS
 (params <machine> <part1> <part2> <part> <rod>
          <holding-device> <length>)
 (preconds
  ((<machine> GAS-WELDER)
   (<rod> WELDING-ROD)
   (<holding-device> (or VISE TOE-CLAMP))
   (<material> MATERIAL)
   (<part1> Part)
   (<part2> (and Part (diff <part1> <part2>)))
   (<part> (and Part (new-part <part> <part1> <part2>)))
   (<diameter1>
    (and Hole-Diameter
	 (gen-from-pred (size-of <part1> DIAMETER <diameter1>))))
   (<diameter2> (and Hole-Diameter (same <diameter2> <diameter1>)))
   (<length1>
    (and Size (gen-from-pred (size-of <part1> LENGTH <length1>))))
   (<length2>
    (and Size (gen-from-pred (size-of <part2> LENGTH <length2>))))
   (<length> (and Size (new-size <length1> <length2> <length>))))
  (and
   (material-of <part1> <material>)
   (material-of <part2> <material>)
   (shape-of <part1> CYLINDRICAL)
   (shape-of <part2> CYLINDRICAL)
   (~ (exists ((<hole> Hole)      (<side> Side)
	       (<depth> Hole-Depth)    (<diameter> Hole-Diameter)
	       (<loc-x> Hole-Location) (<loc-y> Hole-Location))
      (has-hole <part1> <hole> <side> <depth> <diameter> 
		<loc-x> <loc-y>)))
   (~ (exists ((<hole> Hole)      (<side> Side)
	       (<depth> Hole-Depth)    (<diameter> Hole-Diameter)
	       (<loc-x> Hole-Location) (<loc-y> Hole-Location))
      (has-hole <part2> <hole> <side> <depth> <diameter> 
		<loc-x> <loc-y>)))
   (size-of <part2> DIAMETER <diameter2>)
   (holding <machine> <holding-device> <part2> SIDE3)))
 (effects
  ((<sf31> Surface-finish)   (<sf62> Surface-finish)
   (<sidea> Side)   (<sideb> Side)
   (<sidec> Side)   (<sided> Side)
   (<surface-coatinga> surface-coating)
   (<surface-coatingb> surface-coating)
   (<sfc> Surface-Finish)   (<sfd> Surface-Finish))   
  ((add (material-of <part> <material>))
   (add (size-of <part> DIAMETER <diameter1>))
   (add (size-of <part> LENGTH <length>))
   (add (surface-finish-side <part> SIDE0 SAWCUT))
   (if (surface-finish-side <part1> SIDE3 <sf31>)
       ((add (surface-finish-side <part> SIDE3 <sf31>))))
   (if (surface-finish-side <part2> SIDE6 <sf62>)
       ((add (surface-finish-side <part> SIDE6 <sf62>))))
   (del (is-clean <part>))
   (del (holding <machine> <holding-device> <part2> SIDE3))
   (add (holding <machine> <holding-device> <part> SIDE3))
   (del (size-of <part1> DIAMETER <diameter1>))
   (del (size-of <part1> LENGTH <length1>))
   (del (size-of <part2> DIAMETER <diameter2>))
   (del (size-of <part2> LENGTH <length2>))
   (del (material-of <part1> <material>))
   (del (material-of <part2> <material>))
   (del (is-clean <part1>))
   (del (is-clean <part2>))
   (del (surface-coating-side <part1> <sidea> <surface-coatinga>))
   (del (surface-coating-side <part2> <sideb> <surface-coatingb>))
   (del (surface-finish-side <part1> <sidec> <sfc>))
   (del (surface-finish-side <part2> <sided> <sfd>)))))
|#

;;;************************************************************
;;; METAL-COATING
;;; <another-machine> cannot be an electric-arc-spray-gun as well
;;; because there is no way to hold the part on it (i.e. to put a
;;; holding device in it)

(Operator METAL-SPRAY-COATING
 (params <machine> <wire> <part> <side> <another-machine> <holding-device>)
 (preconds
  ((<machine> ELECTRIC-ARC-SPRAY-GUN)
   (<another-machine> (comp MACHINE ELECTRIC-ARC-SPRAY-GUN))
   (<wire> SPRAYING-METAL-WIRE)
   (<holding-device>
    (and Holding-Device
	 (device-for-machine <holding-device> <another-machine>)))
   (<part> Part)
   (<side> Side))
  (and
   (~ (material-of <wire> TUNGSTEN))
   (~ (material-of <wire> MOLYBDENUM))
   (is-clean <part>)
   (~ (has-burrs <part>))
   (surface-coating-side <part> <side> FUSED-METAL)
   (holding <another-machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((if (material-of <wire> STAINLESS-STEEL)
       ((add (surface-coating-side <part> <side> CORROSION-RESISTANT))))
   (if (material-of <wire> ZIRCONIUM-OXIDE)
       ((add (surface-coating-side <part> <side> HEAT-RESISTANT))))
   (if (material-of <wire> ALUMINUM-OXIDE)
       ((add (surface-coating-side <part> <side> WEAR-RESISTANT))))
   (del (surface-coating-side <part> <side> FUSED-METAL)))))

(Operator METAL-SPRAY-PREPARE
 (params <machine> <wire> <part> <side> <another-machine> <holding-device>)
 (preconds
  ((<machine> ELECTRIC-ARC-SPRAY-GUN)
   (<wire> SPRAYING-METAL-WIRE)
   (<another-machine> (comp MACHINE ELECTRIC-ARC-SPRAY-GUN))
   (<holding-device>
    (and Holding-Device
	 (device-for-machine <holding-device> <another-machine>)))
   (<part> Part)
   (<side> Side))
  (and
   (is-clean <part>)
   (~ (has-burrs <part>))
   (has-high-melting-point <wire>)
   (holding <another-machine> <holding-device> <part> <side>)))
 (effects
  ()
  ((add (surface-coating-side <part> <side> FUSED-METAL)))))

;;;************************************************************
; OTHER OPERATIONS

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

(Operator PUT-TOOLBIT-IN-LATHE
 (params <machine> <toolbit>)
 (preconds
  ((<machine> LATHE)
   (<toolbit> LATHE-TOOLBIT))
  (and
   (is-available-tool-holder <machine>)
   (is-available-tool <toolbit>)))
 (effects
  ()
  ((add (holding-tool <machine> <toolbit>)))))

(Operator PUT-CUTTING-TOOL-IN-SHAPER-OR-PLANER
 (params <machine> <cutting-tool>)
 (preconds
  ((<machine> (or SHAPER PLANER))
   (<cutting-tool> CUTTING-TOOL))
  (and 
   (is-available-tool-holder <machine>)
   (is-available-tool <cutting-tool>)))
 (effects
  ()
  ((add (holding-tool <machine> <cutting-tool>)))))

(Operator PUT-WHEEL-IN-GRINDER
 (params <machine> <wheel>)
 (preconds
  ((<machine> GRINDER)
   (<wheel> GRINDING-WHEEL))
  (and 
   (is-available-tool-holder <machine>)
   (is-available-tool <wheel>)))
 (effects
  ()
  ((add (holding-tool <machine> <wheel>)))))

(Operator PUT-CIRCULAR-SAW-ATTACHMENT-IN-CIRCULAR-SAW
 (params <machine> <attachment>)
 (preconds
  ((<machine> CIRCULAR-SAW)
   (<attachment> CIRCULAR-SAW-ATTACHMENT))
  (and 
   (is-available-tool-holder <machine>)
   (is-available-tool <attachment>)))
 (effects
  ()
  ((add (holding-tool <machine> <attachment>)))))

(Operator PUT-BAND-SAW-ATTACHMENT-IN-BAND-SAW
 (params <machine> <attachment>)
 (preconds
  ((<machine> BAND-SAW)
   (<attachment> BAND-SAW-ATTACHMENT))
  (and
   (is-available-tool-holder <machine>)
   (is-available-tool <attachment>)))
 (effects
  ()
  ((add (holding-tool <machine> <attachment>)))))

(Operator PUT-ELECTRODE-IN-WELDER
 (params <machine> <electrode>)
 (preconds
  ((<machine> METAL-ARC-WELDER)
   (<electrode> ELECTRODE))
  (and
   (is-available-tool-holder <machine>)
   (is-available-tool <electrode>)))
 (effects
  ()
  ((add (holding-tool <machine> <electrode>)))))

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

(Operator PUT-HOLDING-DEVICE-IN-LATHE
 (params <machine> <holding-device>)
 (preconds
  ((<machine> LATHE)
   (<holding-device> (or CENTERS 4-JAW-CHUCK COLLET-CHUCK)))
  (and
   (is-available-table <machine> <holding-device>)
   (is-available-holding-device <holding-device>)))
 (effects
  ()
  ((add (has-device <machine> <holding-device>)))))

(Operator PUT-HOLDING-DEVICE-IN-SHAPER
 (params <machine> <holding-device>)
 (preconds 
  ((<machine> SHAPER)
   (<holding-device> VISE))
  (and
   (is-available-table <machine> <holding-device>)
   (is-available-holding-device <holding-device>)))
 (effects
  ()
  ((add (has-device <machine> <holding-device>)))))

(Operator PUT-HOLDING-DEVICE-IN-PLANER
 (params <machine> <holding-device>)
 (preconds 
  ((<machine> PLANER)
   (<holding-device> TOE-CLAMP))
  (and
   (is-available-table <machine> <holding-device>)
   (is-available-holding-device <holding-device>)))
 (effects
  ()
  ((add (has-device <machine> <holding-device>)))))

(Operator PUT-HOLDING-DEVICE-IN-GRINDER
 (params <machine> <holding-device>)
 (preconds
  ((<machine> GRINDER)
   (<holding-device> (or MAGNETIC-CHUCK V-BLOCK VISE)))  
  (and
   (is-available-table <machine> <holding-device>)
   (is-available-holding-device <holding-device>)))
 (effects
  ()
  ((add (has-device <machine> <holding-device>)))))

(Operator PUT-HOLDING-DEVICE-IN-CIRCULAR-SAW
 (params <machine> <holding-device>)
 (preconds
  ((<machine> CIRCULAR-SAW)
   (<holding-device> (or VISE V-BLOCK)))
  (and
   (is-available-table <machine> <holding-device>)
   (is-available-holding-device <holding-device>)))
 (effects
  ()
  ((add (has-device <machine> <holding-device>)))))

(Operator PUT-HOLDING-DEVICE-IN-WELDER
 (params <machine> <holding-device>)
 (preconds
  ((<machine> WELDER)
   (<holding-device> (or VISE TOE-CLAMP)))
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

(Operator PUT-ON-SHAPER-TABLE
 (params <machine> <part>)
 (preconds
  ((<machine> SHAPER)
   (<part> Part)
   (<shaper-size>
    (and Size (gen-from-pred (size-of-machine <machine> <shaper-size>))))
   (<part-size>
    (and Size (gen-from-pred (size-of <part> LENGTH <part-size>))
	 (smaller <part-size> <shaper-size>))))
  (and 
   (is-available-part <part>)
   (is-available-machine <machine>)))
 (effects
  ((<another-machine> Machine))
  ((del (on-table <another-machine> <part>))
   (add (on-table <machine> <part>)))))

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

(Operator HOLD-WITH-VISE
 (params <machine> <holding-device> <part> <side>)
 (preconds
  ((<holding-device> VISE)
   (<machine> Machine)
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
   (if (shape-of <part> CYLINDRICAL)
       ((add (holding-weakly <machine> <holding-device> <part> <side>))))
   (if (shape-of <part> RECTANGULAR)
       ((add (holding <machine> <holding-device> <part> <side>)))))))

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
 (params <machine> <holding-device> <part> <side>)
 (preconds
  ((<machine> MACHINE)
   (<holding-device> Holding-device)
   (<part> PART)
   (<side> SIDE))
  (holding <machine> <holding-device> <part> <side>))
 (effects
  ()
  ((del (holding <machine> <holding-device> <part> <side>))
   (add (on-table <machine> <part>)))))

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
   (<x2> (and Size (half-of <x> <x2>)))
   (<y2> (and Size (half-of <y> <y2>))))
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
   (<x2> (and Size (half-of <x> <x2>)))
   (<y2> (and Size (same <y2> <x2>))))
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
   (add (side-up-for-machining DIAMETER SIDE0)))))

   

;;;************************************************************
;;; inference rules for availability

;;; This section is kind of messy. I should spend some time finding
;;; out whether the infer not-available rules are still needed (I
;;; added them because there was a bug in the TMS)

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
  (forall ((<part> Part))
	  (~ (on-table <machine> <part>))))
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
   (del (is-available-tool <machine>)))))

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

;;;added for p4
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


(Inference-Rule PART-AVAILABLE
; (mode eager) ;see sc-rules.lisp for reason for this		
 (params <part>)
 (preconds
  ((<part> Part))
  (forall
   ((<machine> Machine)
    (<holding-device> Holding-device)
    (<side> Side))
   (and
    (~ (holding-weakly <machine> <holding-device> <part> <side>))
    (~ (holding <machine> <holding-device> <part> <side>)))))
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
(Inference-Rule PART-NOT-AVAILABLE-AND-HOLDING-DEVICE-NOT-EMPTY
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
  ((del (is-available-part <part>))
   (del (is-empty-holding-device <holding-device> <machine>)))))

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
    (<side> Side))
   (and 
    (~ (holding-weakly <machine> <holding-device> <part> <side>))
    (~ (holding <machine> <holding-device> <part> <side>)))))
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
; inference rules for surface finish

(Inference-Rule IS-MACHINED-SURFACE-QUALITY
 (params <part> <side>)
 (preconds
  ((<part> Part)
   (<side> Side))
  (or 
   (surface-finish-side <part> <side> ROUGH-MILL)
   (surface-finish-side <part> <side> ROUGH-TURN)
   (surface-finish-side <part> <side> ROUGH-SHAPED)
   (surface-finish-side <part> <side> ROUGH-PLANED)
   (surface-finish-side <part> <side> FINISH-PLANED)
   (surface-finish-side <part> <side> COLD-ROLLED)
   (surface-finish-side <part> <side> FINISH-MILL)
   (surface-finish-side <part> <side> FINISH-TURN)
   (surface-finish-quality-side <part> <side> GROUND)))
 (effects
  ()
  ((add (surface-finish-quality-side <part> <side> MACHINED)))))

(Inference-Rule IS-GROUND-SURFACE-QUALITY
 (params <part> <side>)
 (preconds
  ((<part> Part)
   (<side> Side))
  (or (surface-finish-side <part> <side> ROUGH-GRIND)
      (surface-finish-side <part> <side> FINISH-GRIND)))
 (effects
  ()
  ((add (surface-finish-quality-side <part> <side> GROUND)))))

(Inference-Rule HAS-SURFACE-FINISH-RECTANGULAR-PART
 (params <part> <surface-finish>)
 (preconds
  ((<part> Part)
   (<surface-finish> Surface-Finish))
  (and 
   (shape-of <part> RECTANGULAR)
   (surface-finish-side <part> SIDE1 <surface-finish>)
   (surface-finish-side <part> SIDE2 <surface-finish>)
   (surface-finish-side <part> SIDE3 <surface-finish>)
   (surface-finish-side <part> SIDE4 <surface-finish>)
   (surface-finish-side <part> SIDE5 <surface-finish>)
   (surface-finish-side <part> SIDE6 <surface-finish>)))
 (effects
  ()
  ((add (surface-finish <part> <surface-finish>)))))

(Inference-Rule HAS-SURFACE-FINISH-CYLINDRICAL-PART
 (params <part> <surface-finish>)
 (preconds
  ((<part> Part)
   (<surface-finish> Surface-Finish))
  (and 
   (shape-of <part> CYLINDRICAL)
   (surface-finish-side <part> SIDE0 <surface-finish>)
   (surface-finish-side <part> SIDE3 <surface-finish>)
   (surface-finish-side <part> SIDE6 <surface-finish>)))
 (effects
  ()
  ((add (surface-finish <part> <surface-finish>)))))

(Inference-Rule HAVE-SURFACE-FINISH-RECTANGULAR-PART-SIDES
 (params <part> <surface-finish>)
 (preconds
  ((<part> Part)
   (<surface-finish> Surface-Finish))
  (and 
   (shape-of <part> RECTANGULAR)
   (surface-finish <part> <surface-finish>)))
 (effects
  ()
  ((add (surface-finish-side <part> SIDE1 <surface-finish>))
   (add (surface-finish-side <part> SIDE2 <surface-finish>))
   (add (surface-finish-side <part> SIDE3 <surface-finish>))
   (add (surface-finish-side <part> SIDE4 <surface-finish>))
   (add (surface-finish-side <part> SIDE5 <surface-finish>))
   (add (surface-finish-side <part> SIDE6 <surface-finish>)))))

(Inference-Rule HAVE-SURFACE-FINISH-CYLINDRICAL-PART-SIDES
 (params <part> <surface-finish>)
 (preconds
  ((<part> Part)
   (<surface-finish> Surface-Finish))
  (and 
   (shape-of <part> CYLINDRICAL)
   (surface-finish <part> <surface-finish>)))
 (effects
  ()
  ((add (surface-finish-side <part> SIDE0 <surface-finish>))
   (add (surface-finish-side <part> SIDE3 <surface-finish>))
   (add (surface-finish-side <part> SIDE6 <surface-finish>)))))

;;;************************************************************
;  inference rules for surface-coating

(Inference-Rule HAS-SURFACE-COATING-RECTANGULAR-PART
 (params <part> <surface-coating>)
 (preconds
  ((<part> Part)
   (<surface-coating> Surface-coating))
  (and 
   (shape-of <part> RECTANGULAR)
   (surface-coating-side <part> SIDE1 <surface-coating>)
   (surface-coating-side <part> SIDE2 <surface-coating>)
   (surface-coating-side <part> SIDE3 <surface-coating>)
   (surface-coating-side <part> SIDE4 <surface-coating>)
   (surface-coating-side <part> SIDE5 <surface-coating>)
   (surface-coating-side <part> SIDE6 <surface-coating>)))
 (effects
  ()
  ((add (surface-coating <part> <surface-coating>)))))

(Inference-Rule HAS-SURFACE-COATING-CYLINDRICAL-PART
 (params <part> <surface-coating>)
 (preconds
  ((<part> Part)
   (<surface-coating> Surface-coating))
  (and 
   (shape-of <part> CYLINDRICAL)
   (surface-coating-side <part> SIDE0 <surface-coating>)
   (surface-coating-side <part> SIDE3 <surface-coating>)
   (surface-coating-side <part> SIDE6 <surface-coating>)))
 (effects
  ()
  ((add (surface-coating <part> <surface-coating>)))))


(Inference-Rule HAVE-SURFACE-COATING-RECTANGULAR-PART-SIDES
 (params <part> <surface-coating>)
 (preconds
  ((<part> Part)
   (<surface-coating> Surface-coating))   
  (and 
   (shape-of <part> RECTANGULAR)
   (surface-coating <part> <surface-coating>)))
 (effects
  ()
  ((add (surface-coating-side <part> SIDE1 <surface-coating>))
   (add (surface-coating-side <part> SIDE2 <surface-coating>))
   (add (surface-coating-side <part> SIDE3 <surface-coating>))
   (add (surface-coating-side <part> SIDE4 <surface-coating>))
   (add (surface-coating-side <part> SIDE5 <surface-coating>))
   (add (surface-coating-side <part> SIDE6 <surface-coating>)))))

(Inference-Rule HAVE-SURFACE-COATING-CYLINDRICAL-PART-SIDES
 (params <part> <surface-coating>)
 (preconds
  ((<part> Part)
   (<surface-coating> Surface-coating))   
  (and 
   (shape-of <part> CYLINDRICAL)
   (surface-coating <part> <surface-coating>)))
 (effects
  ()
  ((add (surface-coating-side <part> SIDE0 <surface-coating>))
   (add (surface-coating-side <part> SIDE3 <surface-coating>))
   (add (surface-coating-side <part> SIDE6 <surface-coating>)))))

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
 (mode eager)
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
 (mode eager)
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

(Inference-Rule HARDNESS-OF-MATERIAL-SOFT
 (mode eager)
 (params <part>)
 (preconds
  ((<part> Part))
  (or
   (material-of <part> ALUMINUM)
   (alloy-of <part> NON-FERROUS)))
 (effects
  ()
  ((add (hardness-of <part> SOFT)))))

(Inference-Rule HARDNESS-OF-MATERIAL-HARD
 (mode eager)
 (params <part>)
 (preconds
  ((<part> Part))
  (alloy-of <part> FERROUS))
 (effects
  ()
  ((add (hardness-of <part> HARD)))))

(Inference-Rule HIGH-MELTING-POINT
 (mode eager)
 (params <wire>)
 (preconds
  ((<wire> WIRE))
  (or 
   (material-of <wire> TUNGSTEN)
   (material-of <wire> MOLYBDENUM)))
 (effects
  ()
  ((add (has-high-melting-point <wire>)))))


(load "/afs/cs/project/prodigy/version4.0/domains/machining/sc-rules")

