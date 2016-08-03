(in-package "PRODIGY4")



;;;;;; HISTORY
;;;
;;; 22jul98 Moved the code back to original locations in front-end.lisp and
;;;         ratio-rep.lisp. History comments moved with them. [cox]




;;; The following used to be in file prodigy-suggestions.lisp. It is more
;;; appropriate for a patch file, however. [17jun98 cox]
;;;

;;;
;;; The following is a modification of a routine in the file treeprint.lisp in 
;;; the PRODIGY planner subdirectory (off the system dir). It is called after a
;;; successful solution is obtained by the planner.
;;;
(defun announce-solution (node depth)
  (let ((plevel (or (problem-space-property :*output-level*) 2)))
    (when (> plevel 1)
      (announce-node node node depth)
      (terpri)
      ;; mcox added the next 2 calls 18may96. Old step is commented out.
      (princ "Achieved the following top-level goals:")
      (format t "~%~s" (fe::get-current-goals))
;      (princ "Achieved top-level goals.")
      (unless (zerop (nexus-abs-level node))
	(princ " (Abstraction level ")
	(princ (nexus-abs-level node))
	(princ ") ")))))
