
;;; Here's an example of adding a hook to the start of a run, to get
;;; the problem space property :end-time set up correctly.

(defun get-end-time ()
  (get-val-from-state 'last-time
		      (second (p4::problem-state (current-problem)))))

;;; The end-time signal seems to have disappeared, so the later code
;;; uses get-end-time rather than this property as a work-around.
(defun set-end-time (signal)
  (declare (ignore signal))
  (setf (p4::problem-space-property :end-time)
	(get-end-time)))

;;; This signal is made at the start of every run.
(define-prod-handler :run-start #'set-end-time)

(defun get-val-from-state (symbol tree)
  (declare (symbol symbol))
  (cond ((symbolp tree) nil)
	((eq symbol (car tree)) (second tree))
	((member (car tree) '(and or))
	 (some #'(lambda (subexp) (get-val-from-state symbol subexp))
	       (cdr tree)))))

(defun reasonable-time (time)
  (if (p4::Strong-is-var-p time)
      (get-all-times)
      t))

(defun later (time1 time2)
  (cond ((and (p4::strong-is-var-p time1)
	      (p4::strong-is-var-p time2))
	 (error "Both arguments to later can't be variables."))
	((p4::strong-is-var-p time1)
	 (times-after time2))
	((p4::strong-is-var-p time2)
	 (times-before time1))
	((> time1 time2))))

(defun get-all-times ()
  (declare (special *current-problem-space*))
  (times-before ;;(p4::problem-space-property :end-time)
   (get-end-time)
		))

(defun times-before (last-time)
  (let ((result nil))
    (dotimes (time last-time)
      (push time result))
    result))

(defun times-after (earliest-time)
  (declare (Special *current-problem-space*))
  (let ((result nil))
    (dotimes (incr (- ;;(p4::problem-space-property :end-time)
		    (get-end-time)
		    earliest-time))
      (push (+ earliest-time incr 1) result))
    result))


  
