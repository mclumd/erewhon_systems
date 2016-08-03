;  ref. version2.0/domains/scheworld/functions.lisp/composite-object
;  ref. version4.0/domains/scheworld/functions.lisp/later

;(defvar *new-name-num* 1 "")

;(defun new-object (new-ob)
;  (cond ((is-variable new-ob)
;	 (list (new-name)))
;	(t)))

;(defun new-name ()
;  (intern (concatenate 'string "object"
;		       (princ-to-string (setq *new-name-num*
;					      (1+ *new-name-num*))))))

(defun inc-tr-num (old-num diff new-num)
  (cond ((and (p4::strong-is-var-p new-num)
	      (p4::strong-is-var-p old-num))
	 (error "Too many unboud variables in funciton dec-tr-num"))
	((p4::strong-is-var-p new-num)
	 (list (+ old-num diff)))
	((p4::strong-is-var-p old-num)
	 (unless (< (- new-num diff) 0)
	   (list (- new-num diff))))
	(t (and (= (+ old-num diff) new-num)
		(list new-num)))))

(defun dec-tr-num (old-num diff new-num)
  (cond ((and (p4::strong-is-var-p new-num)
	      (p4::strong-is-var-p old-num))
	 (error "Too many unboud variables in funciton dec-tr-num"))
	((p4::strong-is-var-p new-num)
	 (list (- old-num diff)))
	((p4::strong-is-var-p old-num)
	 (list (+ new-num diff)))
	(t (and (= (- old-num diff) new-num)
		(list new-num)))))
