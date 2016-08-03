;;dec 2 92:
;;I have changed the definition to return nil instead of an error so
;;it does not break at replay time when the location is not bound. I
;;am not sure this will cause problems at regular problem solving time.

;;I have changed them back to an error (dec 11 92)

(defun x-location-of (part loc)
  (cond
   ((p4::strong-is-var-p part)
    (error "<part> is not bound.~%")
;    (format t "<part> is not bound.~%")
    nil)
   ((p4::strong-is-var-p loc)
    (error "<loc> is not bound.~%")
;    (format t "<loc> is not bound.~%")
    nil)
   (t)))

(defun y-location-of (part loc)
  (cond
   ((p4::strong-is-var-p part)
    (error "<part> is not bound.~%")
;    (format t "<part> is not bound.~%")
    nil)
   ((p4::strong-is-var-p loc)
    (error "<loc> is not bound.~%")
;    (format t "<loc> is not bound.~%")
    nil)
   (t)))

(defun diff (x y)
  (cond
   ((p4::strong-is-var-p x)
    (error "~A has to be bound.~%" x))
   ((p4::strong-is-var-p y)
    (error "~A has to be bound.~%" y))
   ((and (p4::prodigy-object-p x)
	 (p4::prodigy-object-p y))
    (not (eq x y)))
   ((p4::prodigy-object-p x)
    (not (equal (p4::prodigy-object-name x) y)))
   ((p4::prodigy-object-p y)
    (not (equal (p4::prodigy-object-name y) x)))
   ((not (equal x y)))))  

(defun same (x y)
  (cond
   ((and (p4::strong-is-var-p x)
	 (p4::strong-is-var-p y))
     (error "one of ~A or ~A has to be bound.~%" x y))
   ((p4::strong-is-var-p x) (list y))
   ((p4::strong-is-var-p y) (list x))
   ((p4::prodigy-object-p x)
    (equal (p4::prodigy-object-name x) y))
   (t (equal x y))))

(defun one-of (x list)
  (cond
   ((not (listp list))
    (error "list has to be a list~%"))
   ((p4::strong-is-var-p x) list)
   ((typep x 'symbol)
    (member x list :test #'equal))
   (t ;;(p4::prodigy-object-p x) or (typep x 'operator)
    (member x list :test #'(lambda (a b)
			     (equal
			      (p4::prodigy-object-name a) b))))))

;;;From 2.0:
;;; if either x or y are vars, then it returns a value a little smaller.
;;; This is because the operators involving the LATHE could be used 
;;;   to solve a goal like (surface-finish part1 SIDE0 ROLLED),
;;; so this function must be able to generate values for size.

;;; aperez March 5 93: we should offer more values for the case when we
;;; are achieving surface-finish and size  is another goal. On the
;;; other hand, producing many alternatives here may cause a lot of
;;; backtracking if the op fails for other reason. 

(defun smaller (x y)
   (cond
    ((and (p4::strong-is-var-p x)
	  (p4::strong-is-var-p y))
     (error "one of ~A or ~A has to be bound.~%" x y))
    ((p4::strong-is-var-p x)
     (if (> (- y .5) 0)
	 (list (- y .5)(- y 1.0)(- y 1.5))))
    ((p4::strong-is-var-p y)
     (list (+ x .5)))
    ((< x y) t )))

#|
(defun smaller (x y)
   (cond
    ((and (p4::strong-is-var-p x)
	  (p4::strong-is-var-p y))
     (error "one of ~A or ~A has to be bound.~%" x y))
    ((p4::strong-is-var-p x)
     (if (> (- y .5) 0)
	 (list (- y .5))))
    ((p4::strong-is-var-p y)
     (list (+ x .5)))
    ((< x y) t )))
|#

(defun smaller-than-2in (x y)
   (cond ((p4::strong-is-var-p x) nil)
         ((p4::strong-is-var-p y) nil)
         (t (<= (- x y) 2))))

(defun half-of (x y)
   (cond
    ((p4::strong-is-var-p x) nil)
    ((p4::strong-is-var-p y) (list (/ x 2)))
    ((= (/ x 2) y) t )))

  
;;; Function used for finish operations.
;;; They make the size of the part be .002 or .003 smaller.
;;; (ditto for function smaller)

(defun finishing-size (x y)
  (cond
   ((and (p4::strong-is-var-p x)(p4::strong-is-var-p y))
    nil)
   ((p4::strong-is-var-p x)
    (list (+ y 0.002)))
   ((p4::strong-is-var-p y) 
    (if (> (- x 0.002) 0)(list (- x 0.002))))
   (t (<= (abs (- x y)) 0.003))))


;;; Functions for generating new values when two parts are welded
;;; together. 

(defun new-size (d1 d2 d)
   (cond ((p4::strong-is-var-p d1) nil)
         ((p4::strong-is-var-p d2) nil)
         ((p4::strong-is-var-p d) (list (+ d1 d2)))
         (t (= d (+ d1 d2)))))

(defun new-part (part part1 part2)
   (cond ((p4::strong-is-var-p part) (list (new-name part1 part2)))
         (t)))

(defun new-material (material material1 material2)
 (if (p4::strong-is-var-p material)
     (cond ((same material1 material2)
	    (list material1))
	   (t (list (new-name material1 material2))))
   t))

(defun new-name (name1 name2)
  (intern (concatenate 
	   'string (symbol-name name1) "-" (symbol-name name2)))) 


;;; pick an appopriate holding device for a given machine in the
;;; metal-spray coating and prepare operators. The machine corresponds
;;; to <another-machine>. This is control knowledge to prune the
;;; search and could be encoded as one (or more) control rules, but I
;;; think this way is easier.

(defun device-for-machine (holding-device machine)
  (if (or (p4::strong-is-var-p machine)
	  (p4::strong-is-var-p holding-device))
      (error "vars should be bound.~%")
    (member
     (p4::type-name (p4::prodigy-object-type holding-device))
     (case (p4::type-name (p4::prodigy-object-type machine))
       (drill '(4-jaw-chuck v-block vise toe-clamp))
       (milling-machine '(4-jaw-chuck v-block vise collet-chuck
				      toe-clamp))
       (lathe '(centers 4-jaw-chuck collet-chuck))
       (shaper '(vise))
       (planer '(toe-clamp))
       (grinder '(magnetic-chuck v-block vise))
       (circular-saw '(vise v-block))
       (band-saw nil)
       (welder '(vise toe-clamp))))))
  
    
   
;;; ************************************************************
;;; 

(defun not-in-side-pair (side side-pair)
  ;;this is not a meta-predicate. Return a list of bindings
  (cond
    ((and (p4::strong-is-var-p side)
	  (p4::strong-is-var-p side-pair))
     (error "One of ~A, ~A has to be bound.~%"
	    side side-pair))
    ((p4::strong-is-var-p side-pair)
     (case (p4::prodigy-object-name side)
       ((side1 side4) '(side2-side5 side3-side6))
       ((side2 side5) '(side1-side4 side3-side6))
       ((side3 side6) '(side1-side4 side2-side5))))
    ((p4::strong-is-var-p side)
     (case (p4::prodigy-object-name side-pair)
       (side1-side4 '(side2 side3 side5 side6)) 
       (side2-side5 '(side1 side3 side4 side6)) 
       (side3-side6 '(side1 side2 side4 side5))))
    ((case (p4::prodigy-object-name side)
       ((side1 side4)
	(case (p4::prodigy-object-name side-pair)
	  ((side2-side5 side3-side6) t)  (t nil)))
       ((side2 side5)
	(case (p4::prodigy-object-name side-pair)
	  ((side1-side4 side3-side6) t)  (t nil)))
       ((side3 side6)
	(case (p4::prodigy-object-name side-pair)
	  ((side2-side5 side1-side4) t)  (t nil)))))))

       
	 
