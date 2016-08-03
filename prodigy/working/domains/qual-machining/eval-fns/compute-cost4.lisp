(defvar *machining-ops* nil)
(defvar *cleaning-ops* nil)
(defvar *tool-ops* nil)
(defvar *mach-hd-ops* nil)
(defvar *oil-ops* nil)

      
(setf *machining-ops*
  '(DRILL-SPOT-DRILL-PRESS
    DRILL-HOLE-DRILL-PRESS
    DRILL-WITH-HIGH-HELIX-DRILL
    TAP 
    COUNTERSINK 
    COUNTERBORE 
    REAM 
    FACE-MILL
    SIDE-MILL
    DRILL-SPOT-MILLING-MACHINE
    DRILL-HOLE-MILLING-MACHINE))

(setf *cleaning-ops*
  '(CLEAN
    REMOVE-BURRS))

(setf *tool-ops*
  '(PUT-TOOL-ON-MILLING-MACHINE
    PUT-IN-DRILL-SPINDLE
    REMOVE-TOOL-FROM-MACHINE))

(setf *mach-hd-ops*
  ;;machine and holding device set-ups
  '(PUT-HOLDING-DEVICE-IN-MILLING-MACHINE
    PUT-HOLDING-DEVICE-IN-DRILL
    REMOVE-HOLDING-DEVICE-FROM-MACHINE
    PUT-ON-MACHINE-TABLE
    HOLD-WITH-VISE
;;    HOLD-WITH-V-BLOCK
;;    HOLD-WITH-TOE-CLAMP
;;    HOLD-WITH-TOE-CLAMP1
;;    HOLD-WITH-TOE-CLAMP2
;;    SECURE-WITH-TOE-CLAMP
;;    HOLD-WITH-CENTERS
;;    HOLD-WITH-4-JAW-CHUCK
;;    HOLD-WITH-COLLET-CHUCK
;;    HOLD-WITH-MAGNETIC-CHUCK
    REMOVE-FROM-MACHINE-TABLE
    RELEASE-FROM-HOLDING-DEVICE
;;    RELEASE-FROM-HOLDING-DEVICE-WEAK
    ))

(setf *oil-ops*
  '(ADD-SOLUBLE-OIL
    ADD-MINERAL-OIL
    ADD-ANY-CUTTING-FLUID))


(defun compute-cost (plan)
  (declare (list plan))
  ;;plan is (cdr (run))
  (apply #'+ (mapcar #'op-cost plan)))

(defun op-cost (instop)
  (declare (type p4::instantiated-op instop))
  (let* ((op (p4::instantiated-op-op instop))
	 (op-name (p4::operator-name op)))
    (if (p4::inference-rule-p op) 0 (one-cost op-name))))

(defun one-cost (op-name)
  (cond
    ((member op-name *machining-ops*) 1) ;2
    ((member op-name *tool-ops*) 1)	;1
    ((member op-name *mach-hd-ops*) 8)	;2
    ((member op-name *cleaning-ops*) 6)	;2
    ((member op-name *oil-ops*) 3)	;1
    (t 0)))


;;when operators are lists of op-name and arg names.

(defun compute-cost-text (plan)
  (declare (list plan))
  (apply #'+ (mapcar #'op-list-cost plan)))

(defun op-list-cost (op)
  (declare (list op))
  (one-cost (car op)))

(defun default-op-cost (lit)
  (declare (special *default-op-costs*))
  (or 
   (gethash (p4::literal-name lit) *default-op-costs*)
   (break "no default-cost for ~A~%" lit)))

(defvar *default-op-costs*
  (make-hash-table :test #'equal))

  (setf (gethash 'holding-tool *default-op-costs*) 1)
  (setf (gethash 'holding *default-op-costs*) 8)
  (setf (gethash 'has-device *default-op-costs*) 8)
  (setf (gethash 'on-table *default-op-costs*) 8)

  (setf (gethash 'has-burrs *default-op-costs*) 6)
  (setf (gethash 'is-clean *default-op-costs*) 6)

  (setf (gethash 'shape-of *default-op-costs*) 0)
  (setf (gethash 'is-available-part *default-op-costs*) 0)
  (setf (gethash 'is-available-tool-holder *default-op-costs*) 0)
  (setf (gethash 'is-available-tool *default-op-costs*) 0)
  (setf (gethash 'is-empty-holding-device *default-op-costs*) 0)

  (setf (gethash 'has-hole *default-op-costs*) 1)
  (setf (gethash 'has-spot *default-op-costs*) 1)
  (setf (gethash 'is-tapped *default-op-costs*) 1)
  (setf (gethash 'is-counterbored *default-op-costs*) 1)
  
  
		 

(setf p4::*eval-function* (symbol-function 'compute-cost))
