	
;;; Copied from Alicia's version in codep4 so that references to
;;; psgraph could be commented out, so I didn't have to create that
;;; package. The ui currently uses dag to do this, and will probably
;;; switch to dot later.

;;; The partial order graph is expressed as a matrix *expert-partial-order*
;;; root-node-name is node 0

(in-package "PRODIGY4")
(export 'print-partial-order)

#|
(defun print-expert-partial-order (&key (shrink t))
  (with-open-file (*standard-output* "/usr/aperez/g.ps"
		      :direction :output
		      :if-exists :supersede)
    (psgraph:psgraph
     0                         ;root-node-name
     #'child-function
     #'info-function
     shrink                    ;&optional (shrink nil)
     nil                       ;&optional (insert nil)
     #'eq                      ;&optional (test #'equal)
     )))


Shrink is a boolean.  It defaults to nil, and in this case the graph
prints on as many pages as are needed to show the whole thing.  If shrink
is t then the entire graph is squashed appropriately to fit on one page
of output.

Insert is a boolean.  It defaults to nil, and in this case the generated
Postscript file contains commands to print the output.  If insert is t
then the output file is always shrunk (shrink is t) and no commands are
generated to print the page.  This means the resulting file can be included
in Scribe files, for example, and Scribe can decide when to print the page.

Test is a function that return whether two nodes are the same.
|#

;;Child-function takes a node name and returns a list of node names.

(defun child-function (node)
  (declare (special *expert-partial-order*))
  (get-successors node *expert-partial-order*))
    
    
;;from version5-new/multiagent/insert-split-join-nodes5.lisp

(defun get-successors (node graph)
  (let ((dim1 (1- (array-dimension graph 0))))
    (do* ((i 0 (1+ i))
	  (suc-list nil (if (eq (aref graph node i) 1)
			    (cons i suc-list)
			    suc-list)))
	 ((eq i dim1) suc-list))))



;;Info-function takes a node name and returns a list of strings.  Each string
;;shows up as one line in the printed form of the node, with the first string
;;displayed in one font (determined by variables *fontname*, *fontsize*) and the
;;others in another font (determined by variables *second-fontname*,
;;*second-fontsize*).  Typically the first string is just the name of the node,
;;eg, (string node-name).

#|
(defun info-function (n)
  (list (format nil "~A" n)))
|#

(defun info-function (node)
  (declare (special *expert-plan-steps*))
  (if (zerop node)
      (list (string "s"))
      (get-info-from-plan-step-ir
       (nth (1- node) *expert-plan-steps*))))


(defun get-info-from-plan-step-ir (plan-step)
  (declare (type plan-step plan-step)
	   (special *current-problem-space*))
  ;;print name of ops only
  (let ((op-exp (plan-step-name plan-step)))
    (cond
      ((find (car op-exp)
	     (problem-space-operators *current-problem-space*)
	     :key #'operator-name)
       (list (string (car op-exp))))
      ((find (car op-exp)
	     (problem-space-lazy-inference-rules *current-problem-space*)
	     :key #'rule-name)
       (list "lz"))
      (t (list "ea")))))


(defun get-info-from-plan-step (plan-step)
  (declare (type plan-step plan-step))
  ;;print name of ops only
  (let ((op-exp (plan-step-name plan-step)))
    (if (find (car op-exp)
	      (problem-space-operators *current-problem-space*)
	      :key #'operator-name)
	(list (string (car op-exp)))
	(list ""))))
	      
#|
;;;*******************************************************
;;; with eager rules too
(defun print-all-partial-order (&key (shrink t))
  (with-open-file (*standard-output* "/usr/aperez/g-all.ps"
		      :direction :output
		      :if-exists :supersede)
    (psgraph:psgraph
     0                         ;root-node-name
     #'all-child-function
     #'all-info-function
     shrink                    ;&optional (shrink nil)
     nil                       ;&optional (insert nil)
     #'eq                      ;&optional (test #'equal)
     )))


(defun all-child-function (node)
  (declare (special *all-expert-partial-order*))
  (get-successors node *all-expert-partial-order*))

(defun all-info-function (node)
  (declare (special *all-expert-plan-steps*))
  (if (zerop node)
      (list (string "s"))
      (get-info-from-plan-step-ir
       (nth (1- node) *all-expert-plan-steps*))))
|#

#|
;;; *****************************************************************
;;; Print partial order with op numbers as node labels

(defun print-partial-order-n
    (partial-order filename &key (shrink nil)(insert nil))
  (declare (array partial-order)
	   (string filename))
  (let ((*po* partial-order))
    (declare (special *po*))
    (with-open-file  (*standard-output* filename
		      :direction :output
		      :if-exists :supersede)
      (psgraph:psgraph
       0                         ;root-node-name
       #'generic-child-function
       #'(lambda (n)
	   (list (format nil "~a" n)))  ;info function
       shrink
       insert
       #'eq                      ;&optional (test #'equal)
       ))))


;;; *****************************************************************
;;; Functions to print a given partial order in a given file (both
;;; passed as arguments) 

(defun print-partial-order (partial-order plan-steps filename)
  (declare (array partial-order)
	   (string filename))
  (let ((*po* partial-order)
	(*po-plan-steps* plan-steps))
    (declare (special *po-plan-steps* *po*))
    (with-open-file  (*standard-output* filename
		      :direction :output
		      :if-exists :supersede)
      (psgraph:psgraph
       0                         ;root-node-name
       #'generic-child-function
       #'generic-info-function
       nil                       ;&optional (shrink nil)
       nil                       ;&optional (insert nil)
       #'eq                      ;&optional (test #'equal)
       ))))
|#

(defun generic-info-function (node)
  (declare (special *po* *po-plan-steps*))
  (if (zerop node)
      (list (string "s"))
      (get-info-from-plan-step
       (nth (1- node) *po-plan-steps*))))


(defun generic-child-function (node)
  (declare (special *po*))
  (get-successors node *po*))
  

  