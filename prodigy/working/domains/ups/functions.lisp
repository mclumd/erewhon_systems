
;;; ************************************************
;;; ************************************************
;;;           UPS Domain - Version 0, January 1992
;;; ************************************************
;;; ************************************************


(defun get-link-time (hub-from hub-to link-time)
  (cond 
   ((or (p4::strong-is-var-p hub-from)
	(p4::strong-is-var-p hub-to))
    nil)
   (t (let ((link-hash
	     (gethash 'link (p4::problem-space-assertion-hash
			     *current-problem-space*)))
	    (res nil))
	(if (p4::strong-is-var-p link-time)
	    (and link-hash
		 (maphash #'(lambda (key val)
			      (declare (ignore val))
			      (if (and (equal (first key) hub-from)
				       (equal (second key) hub-to))
				  (setf res (list (third key)))))
			  link-hash))
	    (let ((lit (gethash (list hub-from hub-to link-time)
				link-hash)))
	      (if  (p4::literal-state-p lit)
		   (setf res (list link-time)))))
	res))))

				 
	 
;;; ************************************************

;; It binds new-deadline-time.
;; If pac is not at hub-from
;;  then it binds new-deadline-time to (- deadline-time link-time)
;;  otherwise it binds it to nil
;; It binds to nil also if new-deadline-time becomes negative.

(defun compute-new-deadline (new-deadline-time pac hub-from deadline-time link-time)
  (let ((proposed-new-deadline (- deadline-time link-time)))
    (if (and (>= proposed-new-deadline 0)
	     (not (or (p4::strong-is-var-p pac)
		      (p4::strong-is-var-p hub-from)
		      (p4::strong-is-var-p deadline-time)
		      (p4::strong-is-var-p link-time))))
	(let* ((effectively-at-hash
		(gethash 'effectively-at
			 (p4::problem-space-assertion-hash *current-problem-space*)))
	       (res nil))
	  (maphash #'(lambda (key val)
		       (declare (ignore val))
		       (if (eq (first key) pac)
			   (let ((hub-pac (second key)))
			     (cond
			       ((eq hub-from hub-pac) nil)
			       ((p4::strong-is-var-p new-deadline-time)
				(setf res (list proposed-new-deadline)))
			       (t (setf res
					(and (eql new-deadline-time
						  proposed-new-deadline)
					     new-deadline-time)))))))
		   effectively-at-hash)
	  res))))


;;; ************************************************

;; It binds initial-time.
;; If pac is at hub-from and satisfies deadline
;;  then it binds initial-time to the real time
;;  otherwise it binds it to nil

(defun compute-initial-time (initial-time pac hub-from deadline-time link-time)
  (let ((proposed-new-deadline (- deadline-time link-time)))
    (if (and (>= proposed-new-deadline 0)
	     (not (or (p4::strong-is-var-p pac)
		      (p4::strong-is-var-p hub-from)
		      (p4::strong-is-var-p deadline-time)
		      (p4::strong-is-var-p link-time))))
	(let* ((effectively-at-hash
		(gethash 'effectively-at
			 (p4::problem-space-assertion-hash *current-problem-space*)))
	       (res nil))
	  (maphash #'(lambda (key val)
		       (declare (ignore val))
		       (if (eq (first key) pac)
			   (let ((hub-pac (second key))
				 (time-pac (third key)))
			     (cond
			       ((not (eq hub-from hub-pac)) nil)
			       ((p4::strong-is-var-p initial-time)
				(setf res (list time-pac)))
			       (t (if (eql initial-time time-pac)
				      (setf res initial-time)))))))
		   effectively-at-hash)
	  res))))
				      

;;; ************************************************

;; Adds the effective time at hub-from to the real link-time

(defun compute-new-effective-time (arrival-time pac hub-from link-time)
  (if (not (or (p4::strong-is-var-p pac)
	       (p4::strong-is-var-p hub-from)
	       (p4::strong-is-var-p link-time)))
      (let* ((effectively-at-hash
	      (gethash 'effectively-at
		       (p4::problem-space-assertion-hash *current-problem-space*)))
	     (res nil))
	(maphash #'(lambda (key val)
		     (declare (ignore val))
		     (if (and  (eq (first key) pac)
			       (eq (second key) hub-from))
			 (let ((time-at-hub-from (third key)))
			   (if (p4::strong-is-var-p arrival-time)
			       (setf res
				     (list (+ time-at-hub-from link-time)))
			       (setf res
				     (and (eql arrival-time (+ time-at-hub-from link-time))))))))
		 effectively-at-hash)
	res)))
			 


;;; ************************************************

;; Just shows the efective route for a package

(defun show-route (pac)
  (declare (special *current-problem-space*))
  (format t "~% Effective route for package ~S:" pac)
  (let* ((effectively-at-hash
	  (gethash 'effectively-at
		   (p4::problem-space-assertion-hash *current-problem-space*)))
	 (ppac (p4::object-name-to-object pac *current-problem-space*))
	 (res nil)
	 (route (maphash #'(lambda (key val)
			      (declare (ignore val))
			      (if (equal (first key) ppac)
				  (push key res)))
			  effectively-at-hash))
	 (sorted-route (sort res #'< :key #'third)))
    (dolist (route sorted-route)
      (format t "~%       At ~S at time ~S."
	      (nth 1 route) (nth 2 route)))))

;;; ************************************************

