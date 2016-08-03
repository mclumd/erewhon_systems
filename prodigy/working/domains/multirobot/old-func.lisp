;; functions to write: get-coord, diff, get-door-coord,
;; get-initial-location, inside,

(defun diff (x y)
  (not (eq x y)))

(defun inside (x-coord-p val room)
  (declare (special *current-problem-space*))
  (if (p4::strong-is-var-p room)
      (error "~% <room> has to be bound in generator inside")
      (let* ((lower-corner-hash
	      (gethash 'lower-corner
		       (p4::problem-space-assertion-hash *current-problem-space*)))
	     (lower-corner
	      (find room lower-corner-hash
		    :key #'(lambda (x) (elt (p4::literal-arguments x) 0))))
	     (upper-corner-hash
	      (gethash 'upper-corner
		       (p4::problem-space-assertion-hash *current-problem-space*)))
	     (upper-corner
	      (find room upper-corner-hash
		    :key #'(lambda (x) (elt (p4::literal-arguments x) 0)))))
;	(format t "~% lower-corner ~S upper-corner ~S" lower-corner upper-corner)
	(if (and lower-corner upper-corner)
	    (if (p4::strong-is-var-p val)
		(if x-coord-p
		    (all-values-list
		     (elt (p4::literal-arguments lower-corner) 1)
		     (elt (p4::literal-arguments upper-corner) 1))
		    (all-values-list
		     (elt (p4::literal-arguments lower-corner) 2)
		     (elt (p4::literal-arguments upper-corner) 2)))
		(if x-coord-p
		    (and
		     (in-limits
		      val
		      (elt (p4::literal-arguments lower-corner) 1)
		      (elt (p4::literal-arguments upper-corner) 1))
		     (list val))
		    (and
		     (in-limits
		      val
		      (elt (p4::literal-arguments lower-corner) 2)
		      (elt (p4::literal-arguments upper-corner) 2))
		     (list val))))))))


(defun in-limits (x lx ux)
  (and (>= x lx) (<= x ux)))


(defun all-values-list (l u)
  (unless (< u l)
    (do* ((count u (1- count))
	  (all-vals (list u) (cons count all-vals)))
	 ((eq count l) all-vals))))


(defun get-initial-location (robot x y room)
;robot, room and x have to be bound; returns bindings for y
; if in same room, get loc of robot;
;otherwise get door locations in room
  (cond 
   ((or (p4::strong-is-var-p robot)
	(p4::strong-is-var-p x)
	(p4::strong-is-var-p room))
    (error "~% generator GET-INITIAL-LOCATION called with too many unbound vars"))
   ((in-same-room robot room)
    (if (get-coord t robot x)
	(get-coord nil robot y)))
   (t (let ((doors-in-room (find-doors-in-room room)))
	(if (p4::strong-is-var-p y)
	    (mapcan #'(lambda (y)
			(if (eq (elt (p4::literal-arguments y) 2) x)
			    (list (elt (p4::literal-arguments y) 3))))
		    doors-in-room)
	    (mapcar #'(lambda (ass)
			(if (and (eq (elt (p4::literal-arguments ass) 2) x)
				 (eq (elt (p4::literal-arguments ass) 3) y))
			    y))
		    doors-in-room))))))

#|
   ((member (list 'in-room robot room) (give-me-nice-state) :test #'equal)
   (t (let ((doors-in-room (find-doors-in-room room)))
	(if (is-variable-p y)
	    (mapcar #'(lambda (one-y) (list y one-y))
		    (mapcan
		     #'(lambda (pair) (if (eq x (car pair))
					  (cdr pair)))
		     doors-in-room))
	    (if (member (list x y) doors-in-room :test #'equal) t)))))))
|#

(defun in-same-room (robot room)
  (let ((res nil))
    (maphash #'(lambda (key val)
		 (if (and (eq (first key) robot)
			  (eq (second key) room)
			  (p4::literal-state-p val))
		     (setf res t)))
	     (gethash 'in-room (p4::problem-space-assertion-hash
				*current-problem-space*)))
    res))
  


(defun find-doors-in-room (room)
;returns list of doors (in the room)
  (mapcan #'(lambda (assertion)
	      (if (and (p4::literal-state-p assertion)
		       (equal (elt (p4::literal-arguments assertion) 1) room))
		  (list assertion)))
	  (gethash 'loc-next-to-door (p4::problem-space-assertion-hash
				      *current-problem-space*))))


(defun get-coord (x-coord-p obj val)
;binds (checks) val to the x/y coord of obj. Obj has to be bound.
  (declare (special *current-problem-space*))

  (if (p4::strong-is-var-p obj)
      (error "~% <obj> should be bounded in generator get-coord")
      (let ((at-hash (gethash 'at (p4::problem-space-assertion-hash
				  *current-problem-space*)))
	    (res nil)
	    (x-or-y (if x-coord-p 1 2)))
	
	(maphash #'(lambda (key lit)
		     (if (and (p4::literal-state-p lit)
			      (eq (elt key 0)
				  obj))
			 (setf res
			       (if (p4::strong-is-var-p val)
				   (list (elt key x-or-y))
				   (and (eq val (elt key x-or-y))
					(list val))))))
		 at-hash)
	res)))


(defun get-door-coord (x-coord-p door room val)
;binds (checks) val to the x/y coord of door in room. 
;Room and door have to be bound.

  (cond 
   ((or (p4::strong-is-var-p door)
	(p4::strong-is-var-p room))
    (error "~% generator GET-DOOR-COORD called with too many unbound vars"))

   (t
    (let ((static (gethash 'loc-next-to-door
			   (p4::problem-space-assertion-hash
			    *current-problem-space*)))
	  (x-or-y (if x-coord-p 2 3)))
;      (format t "~% ~S" static)
      (if static
	  (let ((res nil))
	    (do ((lits static (cdr lits)))
		((or res (endp lits))
		 res)
	      (let* ((lit (car lits))
		     (arg (p4::literal-arguments lit)))
		(if (and (p4::literal-state-p lit)
			 (eq (elt arg 0) door)
			 (eq (elt arg 1) room))
		    (if (p4::strong-is-var-p val)
			(setf res (list (elt arg x-or-y)))
			(setf res
			      (and (= (elt arg x-or-y) val) (list val)))))))))))))

