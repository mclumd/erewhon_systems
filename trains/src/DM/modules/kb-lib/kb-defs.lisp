;; Time-stamp: <Mon Jan 20 14:26:40 EST 1997 ferguson>

(when (not (find-package :demo-kb-lib))
  (load "kb-lib-def"))
(in-package demo-kb-lib)

;; general scenerio objects for all kbs.

(defparameter *demo-kb-lib-pkg* (find-package 'demo-kb-lib))

(defclass-x point ()
  ((x :type fixnum :initform 0 :initarg :x :reader point-x) ; note that these points need not be acutally related
   (y :type fixnum :initform 0 :initarg :y :reader point-y))) ; to the display, just general map info, e.g. for
                                        ; determining "above".

(defmethod make-load-form ((p point) &optional environment)
  (declare (ignore environment))
  `(make-point :x ,(point-x p) :y ,(point-y p)))

(defmethod print-object ((p point) stream)
  (if *print-readably*
      (with-standard-io-syntax
        (format stream "#.~S" (make-load-form p)))
    (print-unreadable-object (p stream :type t) 
      (format stream "(~D,~D)" (point-x p) (point-y p)))))

(defflags basic
  for-reference
  congested) ;; only applicable to some types, but this keeps flag from being reused.

(defclass-x basic-kb-object (kb-object)
  ((name :initform 't :type symbol :initarg :name :accessor basic-name)
   (predicates :initform nil :type list :initarg :predicates :accessor basic-predicates) ; reference objects may have associated predicates.
   (noise :initform nil :initarg :noise :accessor basic-noise)
   (flags :initform +basic-for-reference+ :type fixnum :initarg :flags :accessor basic-flags)
   (color :initform :black :type symbol :initarg :color :accessor color))) ; only used in display

(defmethod print-object ((o basic-kb-object) stream)
  (cond
   (*print-readably*
    (format stream "#.~S" (make-load-form o)))
   (*print-for-kqml*
    (let ((*print-circle* nil))
      (cond
       ((and (eq (basic-name o) 't)
             (basic-predicates o)
             (null (cdr (basic-predicates o)))
             (predicate-prop-p (car (basic-predicates o)))
             (eq (name (predicate (car (basic-predicates o)))) :member))
        (print-object (terms o)))
       (t
        (format stream "~W" (fix-pkg (basic-name o)))))))
   (t
    (print-unreadable-object (o stream :type t) 
      (princ (basic-name o) stream)
      (when (basic-for-reference-p o)
        (format stream "~%Predicates: ~S~%Noise: ~S" (basic-predicates o) (basic-noise o)))))))

(defclass-x fixed-object (basic-kb-object)
  ((congestion-reason :initform nil :initarg :congestion-reason :accessor congestion-reason)))

(defclass-x basic-container (basic-kb-object)
  ((contents :initform nil :type list :initarg :contents :accessor basic-contents)))

(defclass-x map-object (fixed-object)
  ((position :initform nil :type (or null point) :initarg :position :accessor mo-position)
   (connections :initform nil :type list :initarg :connections :accessor mo-connections)
   (contained-in :initform nil
                 :type (or null basic-container)
                 :initarg :contained-in 
                 :accessor mo-contained-in)))

(defclass-x map-container (map-object basic-container)
  ())

(defclass-x mobile-object (basic-kb-object)
  ((at :initform nil :type (or null map-object) :initarg :at :accessor mobile-at)
   (orientation :initform 'hack::east :type symbol :initarg :orientation :accessor mobile-orientation )))

(defmethod print-object ((o mobile-object) stream)
  (cond
   (*print-readably*
    (format stream "#.~S" (make-load-form o)))
   (*print-for-kqml*
    (format stream "~S" (fix-pkg (basic-name o))))
   (t
    (print-unreadable-object (o stream :type t) 
      (princ (basic-name o) stream)
      (when (basic-for-reference-p o)
        (format stream "~%Predicates: ~S~%At: ~S~%Noise: ~S" (basic-predicates o) (mobile-at o) (basic-noise o)))))))

(defclass-x mobile-container (mobile-object basic-container)
  ())

(defclass-x connected-object (fixed-object)
  ((loc-1 :initform nil :type (or null map-object) :initarg :loc-1 :accessor co-loc-1)
   (loc-2 :initform nil :type (or null map-object) :initarg :loc-2 :accessor co-loc-2)
   (distance :initform 1 :type number :initarg :distance :accessor co-distance)
   (cost :initform 1 :type number :initarg :cost :accessor co-cost)))

;;; basic items in the scenario

(defclass-x city (map-container)
  ())

(defclass-x track (connected-object)
  ())

(defclass-x dtrack (track)              ; directional track, goes from loc-1 to loc-2.
  ())

(defclass-x engine (mobile-container)
  ())

;; here so we can reason about them (get them from a query to to display-kb).
(defclass-x route (connected-object)
  ((engine :initform nil :initarg :engine :accessor engine)
   (segment-list :initform nil :initarg :segment-list :accessor segment-list)
   (path :initform nil :initarg :path :accessor path)
   (plan :initform nil :initarg :plan :accessor plan) ; the plan associated with this route (for display)
   ))

(defmethod print-object ((o route) stream)
  (cond
   (*print-readably*
    (call-next-method))
   (kqml:*print-for-kqml*
    (format stream "(:ROUTE ~A" (basic-name o))
    (if (path o)
        (format stream " (:PATH ~W)" (path o)))
    (format stream ")"))
   (t
    (print-unreadable-object (o stream :type t) 
      (princ (basic-name o) stream)
      (format stream " ~W ~%Predicates: ~S~%Noise: ~S Color: ~S (plan: ~S)" 
              (path o)
              (basic-predicates o)
              (basic-noise o) (color o) (plan o))))))

