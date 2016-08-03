;;;
;;; For each case in *case-cache*, initialize it, then send to tcl the case
;;; name, each node of the case, and then the instruction to mark the first 
;;; node of the case.
;;;
(defun load-cases-tcl (&optional (merge-mode 'saba))
  (setf *merge-mode* merge-mode)
  (dolist (case *case-cache*)
    (fresh-clean-begin-case case)
    (send-to-tcl "Load-case")
    (send-to-tcl (guiding-case-name case))
    (show-case-tcl case)
    (send-to-tcl "Mark-first")
    (send-to-tcl (guiding-case-name case))
    (send-to-tcl 1)
    (send-to-tcl "  ")))


(defun show-case-tcl (case)
  (let ((case-elt (guiding-case-ptr case)))
    (when case-elt
	  (cond ((case-goal-p case-elt)
		 (setf *print-case* :downcase)
		 (send-to-tcl
		  (format nil "~A"
			  (get-case-new-visible-goal 
			   case-elt case))))
		((case-operator-p case-elt)
		 (setf *print-case* :downcase)
		 (send-to-tcl
		  (format nil "~A"
			  (get-case-visible-operator 
			   case-elt))))
		((case-bindings-p case-elt)
		 (setf *print-case* :downcase)
		 (send-to-tcl
		  (format nil "~A"
			  (nth 1 (get-case-new-visible-bindings 
				  case-elt case)))))
		(t
		 (send-to-tcl
		  (get-case-new-visible-inst-op case-elt case))))
	  (setf (guiding-case-ptr case)
		(car (get-case-children-nodes 
		      (guiding-case-ptr case))))
	  ;;(advance-ptr case)
	  (show-case-tcl case))))


;; Limpa tudo (Cleans everything)
(defun unmark-case (case-name)
  (send-to-tcl "Unmark-case")
  (send-to-tcl case-name))


