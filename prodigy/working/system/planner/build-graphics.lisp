;;; $Revision: 1.3 $
;;; $Date: 1994/05/30 20:55:35 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: build-graphics.lisp,v $
;;; Revision 1.3  1994/05/30  20:55:35  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:29:47  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")

;; This graphics module is divided into several parts, each displays
;; graphical information in a different manner.

;; The first part displays the search tree.  Each node in the seach
;; tree represents a decision point in the problem solving session.
;; The children of a node are the choices tried.

(defun display-tree (&optional (p-space *current-problem-space*))
  (declare (type problem-space p-space))
  "Top level command for displaying a search tree.  It takes a
problem-space as an argument."
	     
  (if (getf (problem-space-plist p-space) :node-window)
      (opal:destroy p-space))

    (let* ((root (getf (problem-space-plist *current-problem-space*) :root))
	   (title (format nil "PS: ~S" (problem-space-name p-space)))
	   (node-window (kr:create-instance nil inter:interactor-window
					    (:title title)))
	   (window-agg (kr:create-instance nil opal:aggregate))
;	   (graph-agg (kr:create-instance nil opal:aggregate))
	   (control-panel (graph-control-panel node-window))
	   (my-graph (kr:create-instance nil opal:aggregraph
			  (:top (kr:formula `(+ (kr:gv ',control-panel :top)
					        (kr:gv ',control-panel :height))))
			  (:source-roots (list root))
			  (:children-function #'(lambda (x y)
						  (declare (ignore y)
							   (type nexus x))
						  (p4::nexus-children x)))
			  (:info-function #'(lambda (x)
					      (declare (type nexus x))
					      (nexus-data-string x)))
			  (:node-prototype
			   (kr:create-instance nil prodigy-node-prototype
					       (:window node-window)
					       (:window-title title)
					       )))))
      ;; :window-title holds the name for all the windows in this space
      (setf (getf (problem-space-plist p-space) :window-title) title)
      (setf (getf (problem-space-plist p-space) :node-window) node-window)
  
;      (format t "~S" my-graph)
;       (opal:add-component graph-agg my-graph)
       (opal:add-components window-agg control-panel my-graph)
       (kr:s-value node-window :aggregate window-agg)
       (opal:update node-window)))

(defun nexus-data-string (node)
  (concatenate 'string
	       (etypecase node
		 (goal-node "G")
		 (operator-node "OP")
		 (binding-node "B")
		 (applied-op-node "A"))
	       (princ-to-string (nexus-name node))))

(kr:create-instance 'prodigy-node-prototype opal::aggregraph-node-prototype
 (:window-title "not set")
 (:extra-data-window nil)		    
 (:parts
     `((:box :modify
;          (:filling-style ,opal:gray-fill)
          (:top ,(kr:o-formula (kr:gvl :parent :top)))
          (:left ,(kr:o-formula (kr:gvl :parent :left)))
          (:width ,(kr:o-formula (+ (kr:gvl :parent :text-al :width) 8)))
          (:height ,(kr:o-formula (+ (kr:gvl :parent :text-al :height) 8)))
          (:radius 5)
	  (:filling-style ,(kr:o-formula (if (kr:gvl :parent :selected)
					     opal:gray-fill
					     opal:white-fill))))
 	
       (:text-al ,opal:multi-text 
          (:left ,(kr:o-formula (+ (kr:gvl :parent :left) 4)))
          (:top ,(kr:o-formula (+ (kr:gvl :parent :top) 4)))
          (:string ,(kr:o-formula (kr:gvl :parent :info))))))

   (:interactors
    `((:signal ,inter:button-interactor
;       (:continuous nil)
       (:window ,(kr:o-formula (kr:gv-local :self :operates-on :window)))
       (:start-where
	,(kr:o-formula (list :in (kr:gvl :operates-on :box))))
       (:how-set :toggle)
       (:final-function
	,'pop-up-data)))))

(defun graph-control-panel (window)
  (kr:create-instance nil garnet-gadgets:text-button-panel
	     (:shadow-offset 0)
	     (:final-feedback nil)
	     (:left 2)
	     (:top 2)
	     (:gray-width 3)
	     (:items
	      `(("Destroy" 
		 ,#'(lambda (gadget string)
		      (declare (ignore string gadget))
		      (opal:destroy window)))))))
	
#|
(kr:define-method :destroy prodigy-node-prototype (schema something-else)
  (if (kr:g-value schema :extra-data-window)
      (opal:destroy (kr:g-value schema :extra-data-window)))
  (opal:destroy-me schema))|#
      
(defun pop-up-data (inter agg-node)
  (declare (ignore inter))
  "This function creates a window on the screen and displays
information about the source-node of agg-node.  It will generally be
called by clicking on a node in the graph."
  (print agg-node)
  (finish-output)
  (let* ((window (kr:create-instance nil inter:interactor-window
				     (:title (kr:g-value agg-node
							 :parent :window-title))))
	 (node-agg (kr:create-instance nil opal:aggregate))
	 (node (kr:g-value agg-node :parent :source-node))
	 (button (kr:create-instance nil garnet-gadgets:text-button-panel
				     (:shadow-offset 0)
				     (:final-feedback nil)
				     (:left (kr:formula
					     `(- (kr:g-value ',window :width)
					       60
;					       (kr:gv :self :width)
					       2)))
				     (:top 2)
				     (:gray-width 3)
				     (:items
				      `(("Destroy" ;,#'destroy-data-window
					 ,#'(lambda (gadget string)
					      (declare (ignore string gadget))
					      (opal:destroy window))))))))
	 
    (kr:s-value agg-node :extra-data-window window)
    (kr:s-value window :aggregate node-agg)

    (opal:add-component node-agg button)
    (add-nexus-data node node-agg)
    (etypecase node
      (goal-node (add-goal-node node node-agg))
      (operator-node (add-operator-node node node-agg))
      (a-or-b-node (add-a-or-b-node node node-agg)))
    
    (adjust-window window)
    (opal:update window)
    window))

(defun add-nexus-data (node agg)
  (let* ((name-text (kr:create-instance nil opal:text
		      (:left 2) (:top 2)
		      (:string (name-and-\#-string node))))
	 (parent-text (kr:create-instance nil opal:text
		       (:string (format nil "Parent: ~A"
					 (name-and-\#-string (nexus-parent node))))
		       (:left (kr:g-value name-text :left))
		       (:top (+ (kr:g-value name-text :top)
				(kr:g-value name-text :height)
				4))))
	 (children-lbl (kr:create-instance nil opal:text
			(:string "Children:  ")
			(:left (kr:g-value parent-text :left))
			(:top (+ (kr:g-value parent-text :top)
				 (kr:g-value parent-text :height)
				 4))))
	 (children (kr:create-instance nil opal:multi-text
			(:string (format nil (format nil "~~{~~S~C~~}" #\newline)
					 (nexus-children node)
					 ))
			(:left (+ (kr:g-value children-lbl :left)
				  (kr:g-value children-lbl :width)
				  4))
			(:top (kr:g-value children-lbl :top)))))
    (opal:add-components agg name-text
			     parent-text
			     children-lbl
			     children)
      ))

(defun name-and-\#-string (node)
  (format nil "~A ~D" (type-of node) (name-or-nil node)))

(defun adjust-window (window)
  "Function adjust width and height of window so that all components
fit inside of it very nicely."
  (let ((agg (kr:g-value window :aggregate))
	(height 0)
	(width 0))
    (declare (fixnum height width))
    (opal:do-components agg
	#'(lambda (comp)
	    (setf height (max height (+ (kr:g-value comp :top)
				      (kr:g-value comp :height))))
	    (setf width (max width (+ (kr:g-value comp :left)
				      (kr:g-value comp :width))))))
    (setf (kr:g-value window :width) (+ width 2))
    (setf (kr:g-value window :height) (+ height 2))))

(defun name-or-nil (node?)
  "This is used if nexus-parent returns nil, i.e. is the top node in
the tree."
  (if node?
      (nexus-name node?)
      "No Parent"))

(defun add-goal-node (node agg)
  (declare (ignore node agg)))

(defun add-operator-node (node agg)
  (declare (ignore node agg)))

(defun add-a-or-b-node (node agg)
  (declare (ignore node agg)))

(defun extra-nexus-data (&rest x)
  (format t "Here's some extra data: ~S.~%" x))


(defun destroy-tree (&optional (p-space *current-problem-space*))
    (opal:destroy (getf (problem-space-plist p-space) :node-window)))

#|(kr:create-schema 'traced-assertion
		  (:is-a opal:text)
		  (:my-parent nil)
		  (:left (kr:formula `(kr:gvl :my-parent :left)))
		  (:top (kr:formula `(if (kr:gvl :my-parent)
				      (+ (kr:gvl :height)
				       (kr:gvl :my-parent :top))
				      20)))
		  (:assertion nil)
		  (:string (kr:formula
			    `(princ-to-string (kr:gvl :assertion)))))|#

(kr:create-instance 'traced-assertion opal:text
		  (:my-parent nil)
		  (:left (kr:o-formula (kr:gvl :my-parent :left)))
		  (:top (kr:o-formula (if (kr:gvl :my-parent)
				      (+ (kr:gvl :height)
				       (kr:gvl :my-parent :top))
				      20)))
		  (:assertion nil)
		  (:string (kr:o-formula
			    (princ-to-string (kr:gvl :assertion)))))

(defun turn-off-trace ()
  (if (boundp 'trace-window)
      (opal::destroy trace-window))
  (if (boundp 'trace-agg)
      (opal::destroy trace-agg))
  (setf (getf (problem-space-plist *current-problem-space*) :trace-agg)
	nil)
  (setf (getf (problem-space-plist *current-problem-space*) :trace-window)
	nil)
  (setf (getf (problem-space-plist *current-problem-space*) :add-lit-daemon)
	nil)
  (setf (getf (problem-space-plist *current-problem-space*) :delete-goal-daemon)
	nil)
  (setf (getf (problem-space-plist *current-problem-space*) :delete-neg-goal-daemon)
	nil)
  (setf (getf (problem-space-plist *current-problem-space*) :push-goal-daemon)
	nil)
  (setf (getf (problem-space-plist *current-problem-space*) :push-neg-goal-daemon)
	nil)
  (setf (getf (problem-space-plist *current-problem-space*) :state-daemon)
	nil)
  (setf (getf (problem-space-plist *current-problem-space*) :last-obj) nil)
  )
  
(defun turn-on-trace-all ()
  (declare (special *current-problem-space*))
  (kr:create-instance 'trace-window inter:interactor-window
		      (:width 500))
  (kr:create-instance 'trace-agg opal:aggregate)
  (kr:s-value trace-window :aggregate trace-agg)
  (setf (getf (problem-space-plist *current-problem-space*) :trace-agg)
   	trace-agg)
  (setf (getf (problem-space-plist *current-problem-space*) :trace-window)
   	trace-window)
  (setf (getf (problem-space-plist *current-problem-space*) :add-lit-daemon)
   	#'add-lit)
  (setf (getf (problem-space-plist *current-problem-space*) :delete-goal-daemon)
   	#'delete-goal-daemon)
  (setf (getf (problem-space-plist *current-problem-space*) :delete-neg-goal-daemon)
	#'delete-neg-goal-daemon)
  (setf (getf (problem-space-plist *current-problem-space*) :push-goal-daemon)
	#'push-goal-daemon)
  
  (setf (getf (problem-space-plist *current-problem-space*) :push-neg-goal-daemon)
	#'push-neg-goal-daemon)
  
  (setf (getf (problem-space-plist *current-problem-space*) :state-daemon)
	#'state-daemon)
  (setf (getf (problem-space-plist *current-problem-space*) :last-obj) nil)
  (opal:update trace-window)
  )

(defun add-lit (literal p-space)
  (let* ((agg (getf (problem-space-plist p-space) :trace-agg))
	 (window (getf (problem-space-plist p-space) :trace-window))
	 (last-obj (getf (problem-space-plist p-space) :last-obj))
	 (lit-text (kr:create-instance nil traced-assertion
				      (:my-parent last-obj)
				      (:left 20)
				      (:assertion literal))))
;    (format t "~&Before Add-component.~%")
    (opal:add-component agg lit-text)
    (kr:mark-as-changed lit-text :width)

;    (format t "~&This is agg: ~S.~%This is string: ~S~%This is width: ~D.~%" agg
;	    (kr:g-value lit-text :string)
;	    (kr:g-value lit-text :width))
    (opal:update window)

    (setf (getf (literal-plist literal) :graphic-text) lit-text)
    (setf (getf (problem-space-plist p-space) :last-obj) lit-text)))

(defun make-synchronous (window)
  (let ((display (opal::display-info-display
		  (opal::initialize-display
		   (kr:g-value window :display)))))
    (setf (xlib:display-after-function display)
	  #'xlib:display-finish-output)))

(defun delete-goal-daemon (literal p-space)
  (declare (ignore p-space)
	   (type literal literal))
  (touch-lit-text literal))

(defun delete-neg-goal-daemon (literal p-space)
  (declare (ignore p-space)
	   (type literal literal))
  (touch-lit-text literal))

(defun push-goal-daemon (literal p-space)
  (declare (ignore p-space)
  (type literal literal))
  (touch-lit-text literal))

(defun push-neg-goal-daemon (literal p-space)
  (declare (ignore p-space)
	   (type literal literal))
  (touch-lit-text literal))

(defun state-daemon (literal p-space)
  (declare (ignore p-space)
	   (type literal literal))
  (touch-lit-text literal))

(defun touch-lit-text (literal)
   (kr:mark-as-changed
    (getf (literal-plist literal) :graphic-text)
    :assertion))
		
