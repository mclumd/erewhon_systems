;;;
;;; A garnet user interface for Prodigy 4.0, that allows browsing the
;;; problem space, and the search tree and goal tree. You can also
;;; review and set some of the flags.
;;;
;;; Created by Jim Blythe, June 93
;;;

;;; The main ui window is brought up by typing (prodigy-ui) at lisp.
;;; The other buttons correspond to lisp functions as follows:
;;; search tree: (draw-search-tree)
;;; goal tree:   (draw-goal-tree)
;;; info:        (draw-info *current-problem-space*)
;;; settings     (prodigy-settings)
;;;
;;; You can call draw-info with any Prodigy object, eg
;;; (draw-info (find-node 10)).
;;; Each window has a help button, which will tell you what the other
;;; buttons do.

(in-package "USER")

;;; First make sure garnet is loaded - change this for other sites.
(unless (find-package "KR")
  (load "/afs/cs/project/garnet/garnet-loader"))
(use-package (find-package "KR"))

;;; You can change this to change the flags that can be set. Each
;;; element of the list is a boolean flag. The first element is the
;;; description and the second is the name of the flag.  The third
;;; argument says whether the thing is a variable or a problem space
;;; property. 
(defparameter *boolean-flags*
  '(("Apply only in reverse order" p4::*apply-order-p* var)
    ("Compute abstraction hierarchy each run" :compute-abstractions
     property)
    ("Print alternatives in more detail" :print-alts property)
    ("Find multiple solutions" :multiple-sols property)
    ("Find multiple solutions without asking"
     p4::*dont-ask-and-find-all* var)))

;;; The *XXX-help* variables contain the message that comes up when
;;; you click on the help button in the corresponding window.

(defvar *ui-help*
    "The \"done\" button will destroy the window.
The \"settings\" button will bring up a window that allows you to
change the Prodigy variables and flags.
The \"search tree\" button draws the search tree (which has its own help).
The \"goal tree\" will draw the goal tree.
The \"info\" button starts a window with information about the current
problem space, which you can browse.
Click \"Ok\" in this window to make it disappear")

(defvar *settings-help*
    "Clicking on \"Ok\" or \"Apply\" will change the settings in
Prodigy as shown. Click on \"Cancel\" to make the window disappear
without making any changes")

(defvar *vertical-bindings* t)
(defvar *bold-font* (create-instance NIL opal:font (:face :bold)))

(defvar *graph-help*
    "When you set the function to \"move\":
click the left button on a node to bring it to the left of the window,
    shift-left to bring it to the top,
        middle to bring it to the middle (horizontally),
  shift-middle to bring it to the middle (vertically),
         right to bring it to the right, and
   shift-right to bring it to the bottom.

When you set the function to \"info\":
click the left button to draw an information window for the node,
which you can browse, and click the right button to print the
node's name in the lisp window.")

(defparameter *nexus-fields*
  '(parent children abs-level abs-parent abs-children)
  "Fields common to all nodes, missing out the name")

(defparameter *max-string-width* 50
  "Longest length allowed for a string before we cut it")

(defvar *info-help*
    "Click on a line to bring up an info window on the object
referred to in that line.")


;;; Load up the necessary parts of garnet when the file is loaded.
(dolist (gadget '("motif-scrolling-labeled-box-loader"
		  "motif-radio-buttons-loader"
		  "motif-text-buttons-loader"
		  "motif-check-buttons-loader"
		  "motif-scrolling-menu-loader"
		  ;; Will add loading gadgets some day.
		  ;; "save-load-functions"
		  ;; "motif-load-gadget"
		  ))
  (load (merge-pathnames gadget
			 user::Garnet-Gadgets-PathName)))
(load garnet-aggregraphs-loader)


;;; This function brings up a little panel that allows you to get
;;; at all the other things.
(defun prodigy-ui ()
  (let* ((win (create-instance
	       nil inter:interactor-window
	       (:title "Prodigy UI")
	       (:width (o-formula (gvl :aggregate :width)))
	       (:height (o-formula (gvl :aggregate :height)))))
	 (agg (create-instance nil opal:aggregate))
	 (buttons 
	  (create-instance
	   nil garnet-gadgets:motif-text-button-panel
	   (:items `(("done"
		      (lambda (o s)
			       (opal:destroy (g-value o :window))))
		     ("help" 
		      (lambda (e i)
			(help "the top UI window" *ui-help*)))
		     ("settings"
		      (lambda (e i)
			(prodigy-settings)))
		     ("search tree"
		      (lambda (e i)
			(draw-search-tree)))
		     ("goal tree"
		      (lambda (e i)
			(draw-goal-tree)))
		     ("info"
		      (lambda (e i)
			(if (boundp '*current-problem-space*)
			    (draw-info *current-problem-space*)
			  (progn
			    (format t "~%No problem space~%")
			    (force-output))))))))))
    (s-value win :aggregate agg)
    (opal:add-components agg buttons)
    (opal:update win)))

;;; This function fires up a window for the flags and settings.
(defun prodigy-settings ()
  (let* ((win (create-instance nil inter:interactor-window
			       (:width 450) (:height 300)
			       (:title "Prodigy Settings")))
	 (agg (create-instance nil opal:aggregate))
	 (title (create-instance
		 nil opal:aggregadget
		 (:parts
		  `((nil ,opal:multi-text
		     (:left 10) (:top 10)
		     (:font ,(create-instance nil opal:font
					      (:size :large)
					      (:face :italic)
					      (:family :serif)))
		     (:string "Prodigy Settings"))
		    (nil ,opal:line
		     (:x1 10) (:y1 50) (:x2 440) (:y2 50))))))
	 (search-method
	  (create-instance
	   nil garnet-gadgets:motif-radio-button-panel
	   (:left 10) (:top 70)
	   (:items '("Depth first" "Breadth first"))))
	 (flags
	  (create-instance
	   nil garnet-gadgets:motif-check-button-panel
	   (:left 150) (:top 70)
	   (:items (mapcar #'car *boolean-flags*))))
	 (ok-cancel (create-instance
		     nil garnet-gadgets:motif-text-button-panel
		     (:objects (list search-method flags))
		     (:left 150) (:top 10)
		     (:direction :horizontal)
		     (:items '(("OK" set-unmap)
			       ("Apply" settings)
			       ("Cancel" unmap)
			       ("Help" 
				(lambda (e i) 
				  (help "the settings window" *settings-help*))))))))
    (s-value win :aggregate agg)
    ;; Have to access the value first for most gadgets to get the
    ;; dependencies right.
    (g-value search-method :value)
    (s-value search-method :value
	     (if (and (boundp '*current-problem-space*)
		      (eq (pspace-prop :search-default)
			  :breadth-first))
		 "Breadth first"
		 "Depth first"))
    (g-value flags :value)
    (s-value flags :value 
	     (mapcan #'(lambda (flag)
			 (if (case (third flag)
			       (var (eval (second flag)))
			       (property
				(and (boundp '*current-problem-space*)
				     (pspace-prop (second flag)))))
			     (list (car flag))))
		     *boolean-flags*))
    (opal:add-components agg title ok-cancel search-method flags)
    (opal:update win)))

#| Other things to get to: (please mail jblythe@cs.cmu.edu with others)
depth-bound
output-level
abs-level
|#

(defun set-unmap (panel string)
  (settings panel string)
  (unmap panel string))

(defun unmap (object string)
  (declare (ignore string))
  (opal:destroy (g-value object :window)))

;;; This function sets up the flags and variables appropriately when
;;; you hit "Apply" or "Ok".
(defun settings (object string)
  (declare (ignore string))
  (let* ((all (g-value object :objects))
	 (flags-set (g-value (second all) :value))
	 (res nil))
    ;; First the search method. Yeah I know this isn't right.
    (push 
     (if (string= (g-value (first all) :value) "Depth first")
	 '(pset :search-default :depth-first)
	 '(pset :search-default :breadth-first))
     res)
    ;; then the flags
    (dolist (flag *boolean-flags*)
      (push 
       (case (third flag)
	 (var `(setf ,(second flag)
		,(if (member (car flag) flags-set) t nil)))
	 (property `(pset ,(second flag)
		     ,(if (member (car flag) flags-set) t nil))))
       res))
    ;; Print all the settings out nicely and apply them.
    (dolist (setting (reverse res))
      (format t ";;; ~S~%" setting)
      (unless (and (eq (car setting) 'pset)
		   (not (boundp '*current-problem-space*)))
	(eval setting)))
    (force-output)))

;;; This function brings up a help window when you click on any help
;;; button.
(defun help (title-string help-string)
  (let* ((title (format nil "Help for ~A" title-string))
	 (win (create-instance 
	       nil inter:interactor-window
	       (:title title)
	       (:height (o-formula (+ 20 (gvl :aggregate :height))))
	       (:width (o-formula (+ 20 (gvl :aggregate :width))))))
	 (agg (create-instance nil opal:aggregate))
	 (title-text (create-instance nil opal:text
				      (:top 10) (:left 100)
				      (:string title)))
	 (text (create-instance nil opal:multi-text
				(:top 50) (:left 10)
				(:string help-string)))
	 (ok (create-instance
	      nil garnet-gadgets:motif-text-button-panel
	      (:top 10)
	      (:items
	       `(("Ok" (lambda (o s)
			 (opal:destroy (g-value o :window)))))))))
    (s-value win :aggregate agg)
    (opal:add-components agg ok title-text text)
    (opal:update win)))

(create-instance
 'node-proto opal:aggregraph-node-prototype
 (:parts
  `((:box :modify
	  (:filling-style
	   ,(o-formula (if (gvl :parent :interim-selected)
			   opal:black-fill
			 opal:white-fill)))
	  (:draw-function :xor) (:fast-redraw-p t))
    (:text-al :modify
	      (:font ,(o-formula
		       (if (on-path-to-success 
			    (gvl :parent :source-node))
			   *bold-font*
			 opal:default-font)))))))

(create-instance 'func-proto garnet-gadgets:motif-radio-button-panel
		 (:left 90) (:top 10)
		 (:direction :horizontal)
		 ;; If you change these names you must change
		 ;; the node-click-function below!
		 (:items '("move" "info")))

;;; This draws a verbose version of the node.
(defun garnet-info-function (node)
  (string-capitalize
   (cond ((p4::goal-node-p node)
	  (let ((goal (p4::goal-node-goal node)))
	    (format nil "Goal node ~S~%~A~S"
		    (p4::nexus-name node)
		    (if (p4::negated-goal-p goal) " ~ " "")
		    goal)))
	 ((p4::operator-node-p node)
	  (two-lines "Op node" node (p4::operator-node-operator node)))
	 ((p4::binding-node-p node)
	  (two-lines "Binding node" node
		     (if *vertical-bindings*
			 (vertical-inst-op node)
			 (p4::binding-node-instantiated-op node))))
	 ((p4::applied-op-node-p node)
	  (two-lines "Applied op" node
		     (if *vertical-bindings*
			 (vertical-inst-op node)
			 (p4::applied-op-node-instantiated-op node))))
	 ((listp node) (format nil "~S" (car node))))))

(defun two-lines (name node info)
  (format nil "~A ~S~%~S" name (p4::nexus-name node) info))

;;; Puts a newline between each arg
(defun vertical-inst-op (node)
  (declare (type p4::a-or-b-node node))
  (let ((instop (p4::a-or-b-node-instantiated-op node))
	(res ""))
    (map nil
	 #'(lambda (x y)
	     (setf res
		   (concatenate
		    'string res
		    (format nil "~%[~S ~S]" x
			    (cond ((typep y 'p4::prodigy-object)
				   (p4::prodigy-object-name y))
				  ((null y) nil)
				  ((listp y) "(..)")
				  (t y))))))
	 (if instop
	     (p4::operator-vars (p4::instantiated-op-op instop)))
	 (if instop (p4::instantiated-op-values instop)))
    ;; Remove the initial newline:
    (if (> (length res) 0)
	(subseq res 1)
	res)))
    
(defun big-graph-child-function (parent depth)
  (declare (ignore depth))
  (if (p4::nexus-p parent) (p4::nexus-children parent)))

(defun big-graph-info-function (node)
  (format nil "~S"
	  (cond ((p4::nexus-p node) (p4::nexus-name node))
		((listp node) (car node)))))

;;; This determines which nodes to make bold - those on the winning path.
;;; For now can't handle multiple sols
(defun on-path-to-success (node)
  (if (and (p4::nexus-p (find-node 1))
	   (getf (p4::nexus-plist (find-node 1)) :solution-node))
      (and (p4::nexus-p node)
	   (p4::nexus-p (p4::nexus-parent node))
	   (eq node (getf (p4::nexus-plist (p4::nexus-parent node))
			  :winning-child)))
    (progn (set-up-success-pointers)
	   (on-path-to-success node))))

(defun set-up-success-pointers ()
  (let ((succeeder (find-succeeding-node (find-node 1))))
    (if succeeder 
	(progn (draw-back-path-to-root succeeder)
	       (setf (getf (p4::nexus-plist (find-node 1))
			   :solution-node)
		 succeeder))
      (setf (getf (p4::nexus-plist (find-node 1))
		  :solution-node)
	'no-solution))))

(defun find-succeeding-node (node)
  (if (eq (getf (p4::nexus-plist node) :termination-reason)
	  :achieve)
      node
    (some #'find-succeeding-node (p4::nexus-children node))))

(defun draw-back-path-to-root (node)
  (when (p4::nexus-parent node)
    (setf (getf (p4::nexus-plist (p4::nexus-parent node))
		:winning-child)
      node)
    (draw-back-path-to-root (p4::nexus-parent node))))

(defun search-child-function (parent depth)
  (declare (ignore depth))
  (if (p4::nexus-p parent)
      (or (p4::nexus-children parent)
	  (let ((term (getf (p4::nexus-plist parent)
			    :termination-reason)))
	    ;; list so that eq will return nil.
	    (if term (list (list term)))))))

;;; goal-tree children are the nexus-children in goal and operator nodes.
;;; They are the goal nodes with the parent as intro-operator for
;;; binding nodes. Applied op nodes do not appear in the goal tree.
(defun goal-child-function (parent depth)
  (declare (ignore depth))
  "Node children in the goal tree."
  (cond ((or (p4::goal-node-p parent)
	     (p4::operator-node-p parent))
	 (p4::nexus-children parent))
	((p4::binding-node-p parent)
	 (getf (p4::binding-node-plist parent) 'p4::goal-nodes))))

(defun draw-search-tree (&key root info)
  (if (boundp '*current-problem-space*)
      (draw-my-tree (list (or root (find-node 1)))
		    #'search-child-function info)
    (progn (format t "~%No problem space~%")
	   (force-output))))

(defun draw-goal-tree (&key root info)
  (if (boundp '*current-problem-space*)
      (draw-my-tree (list (or root (find-node 2)))
		    #'goal-child-function info)
    (progn (format t "~%No problem space~%")
	   (force-output))))

;;; This function draws a node graph along with the move and info
;;; commands and the help button. Takes a list of root nodes, a
;;; child-bearing function, and a node describing function as input,
;;; so you can customise your graphs.
(defun draw-my-tree (roots childfn info)
  "Put up a garnet window with the search tree"
  (let* ((win (create-instance
	       nil inter:interactor-window
	       (:title "Search Tree")
	       (:height 200)))
	 (agg (create-instance nil opal:aggregate))
	 (graph
	  (create-instance
	   nil opal:aggregraph		; what a silly name
	   (:left 10) (:top 50)
	   (:children-function childfn)
	   (:info-function (or info #'big-graph-info-function))
	   (:source-roots roots)
	   (:test-to-distinguish-source-nodes #'eq)
	   (:node-prototype node-proto)
	   (:interactors
	    `((:press ,inter:menu-interactor
	       (:window ,(o-formula (gvl :operates-on :window)))
	       (:start-where
		,(o-formula (list :element-of
				  (gvl :operates-on :nodes))))
	       (:start-event
		(:leftdown :middledown :rightdown :shift-leftdown
			   :shift-middledown :shift-rightdown))
	       (:final-function ,#'node-click-function))))))
	 (text-panel (create-instance
		      nil garnet-gadgets:motif-text-button-panel
		      (:left 10) (:top 10)
		      (:items
		       `(("done" (lambda (o s)
				   (opal:destroy (g-value o :window))))
			 ("help" (lambda (o s) 
				   (help "the graph window" *graph-help*)))))))
	 (func-panel (create-instance nil func-proto)))
    (s-value win :aggregate agg)
    (s-value agg :my-win win)
    (s-value graph :func-panel func-panel)
    (opal:add-components agg text-panel func-panel graph)
    (opal:update win)))

;;; This function defines what happens when you click on a node in a
;;; graph window. Can redefine to get different behaviour.
(defun node-click-function (inter node)
  (let* ((graph (g-value node :parent :parent))
	 (func (g-value graph :func-panel :value))
	 (prodigy-node (g-value node :source-node))
	 (win (g-value graph :parent :my-win)))
    (cond ((string= func "move")
	   (case (g-value inter :start-char)
	     ;; Move the graph to have this node at the left
	     (:leftdown			; to left
	      (s-value graph :left 
		       (- (g-value graph :left)
			  (g-value node :left))))
	     (:shift-leftdown		; to top
	      (s-value graph :top
		       (- (g-value graph :top)
			  (g-value node :top))))
	     (:middledown		; middle horizontally
	      (s-value graph :left
		       (- (+ (g-value graph :left)
			     (floor (g-value win :width) 2))
			  (g-value node :left))))
	     (:shift-middledown		; middle vertically
	      (s-value graph :top
		       (- (+ (g-value graph :top)
			     (floor (g-value win :height) 2))
			  (g-value node :top))))
	     (:rightdown		; to right
	      (s-value graph :left
		       (+ (g-value graph :left)
			  (- (g-value win :width)
			     (g-value node :width)
			     (g-value node :left)))))
	     (:shift-rightdown		; to bottom
	      (s-value graph :top
		       (+ (g-value graph :top)
			  (- (g-value win :height)
			     (g-value node :height)
			     (g-value node :top))))))
	   (kr-send graph :layout-graph graph))
	  ((string= func "info")
	   (case (g-value inter :start-char)
	     (:leftdown (draw-info prodigy-node))
	     (:rightdown (format t "~%~S~%" prodigy-node)
			 (force-output)))))))


(defun menu-selector (menu item)
  (draw-info
   (elt (elt (g-value menu :items) (g-value item :real-rank)) 2)))

;;; The list has three elements: name-string, value-string and
;;; actual item.
(defun my-item-to-string (vector)
  (cond ((null vector)
	 "null")
	((stringp vector)
	 vector)
	(t
	 (let ((string (format nil "~A:~A" 
			       (elt vector 0)
			       (elt vector 1))))
	   (if (> (length string) *max-string-width*)
	       (subseq string 0 *max-string-width*)
	     string)))))

(defun draw-info (object)
  (let* ((win (create-instance
	       (intern (gensym "WIN")) inter:interactor-window
	       (:title (format nil "Info for ~S" object))
	       (:width (o-formula (+ (gvl :aggregate :width) 10)))))
	 (agg (create-instance nil opal:aggregate))
	 (title (create-instance
		 nil opal:text
		 (:left 100) (:top 10)
		 (:string (princ-to-string object))))
	 (panel (create-instance
		 nil garnet-gadgets:motif-text-button-panel
		 (:left 10) (:top 5)
		 (:direction :horizontal)
		 (:items '(("done" (lambda (o s)
				     (opal:destroy (g-value o :window))))
			   ("help" (lambda (o s) 
				     (help "The info window" *info-help*)))))))
	 (field-menu
	  (create-instance 
	   nil garnet-gadgets:motif-scrolling-menu
	   (:left 5) 
	   (:top 30)
	   ;; To avoid menu stupidity with lists
	   (:items (mapcar #'(lambda (x) (apply #'vector x))
			   (calc-object-items object)))
	   (:item-to-string-function #'my-item-to-string)
	   (:menu-selection-function #'menu-selector)
	   (:num-visible 10)
	   (:multiple-p nil))))
    (s-value win :aggregate agg)
    (opal:add-components agg panel title field-menu)
    (print win)
    (opal:update win)))

;;; The rest is unchanged from info.lisp
(defun calc-object-items (object)
  (cond ((p4::nexus-p object)
	 (cond ((p4::goal-node-p object)
			(node-fields object "GOAL-NODE-"
				     '(goal introducing-operators)))
		       ((p4::operator-node-p object)
			(node-fields object "OPERATOR-NODE-"
				     '(operator)))
		       ((p4::binding-node-p object)
			(node-fields object "BINDING-NODE-"
				     '(instantiated-op pending-goals
				       applied justification-table
				       instantiated-preconds
				       disjunction-path)))
		       ((p4::applied-op-node-p object)
			(node-fields object "APPLIED-OP-NODE-"
				     '(instantiated-op pending-goals
				       applied justification-table)))))
	((p4::literal-p object)
	 (append (struct-fields object "LITERAL-"
				'(name arguments goal-p neg-goal-p
				  state-p abs-level))
		 (plist-fields (p4::literal-plist object))))
	((p4::instantiated-op-p object)
	 (append (struct-fields object "INSTANTIATED-OP-"
				'(op values conditional
				  precond binding-node-back-pointer
				  conspiracy))
		 (plist-fields (p4::instantiated-op-plist object))))
	((p4::type-p object)
	 (struct-fields
	  object "TYPE-"
	  '(name infinitep super sub all-parents real-instances
	    instances permanent-instances)))
	((p4::prodigy-object-p object)
	 (struct-fields object "PRODIGY-OBJECT-" '(name type)))
	((p4::rule-p object)
	 (append
	  (struct-fields
	   object "RULE-"
	   '(name params precond-exp precond-vars vars binding-lambda
	     effects add-list del-list effect-var-map
	     select-bindings-crs reject-bindings-crs simple-tests
	     unary-tests join-tests neg-simple-tests neg-unary-tests
	     neg-join-tests generator))
	  (plist-fields (p4::rule-plist object))))
	((p4::problem-space-p object)
	 (append
	  (struct-fields
	   object "PROBLEM-SPACE-"
	   '(name operators eager-inference-rules lazy-inference-rules
	     select-nodes select-goals select-operators
	     select-bindings reject-nodes reject-goals reject-operators
	     reject-bindings prefer-nodes prefer-goals prefer-operators
	     prefer-bindings apply-or-subgoal refine-or-expand relevance-table
	     flags infinite-type-preds arity-hash all-preds static-preds
	     assertion-hash expandable-nodes expanded-goals))
	  (plist-fields (p4::problem-space-plist object))))
	((p4::control-rule-p object)
	 (append
	  (struct-fields
	   object "CONTROL-RULE-"
	   '(name type if then))
	  (plist-fields (p4::control-rule-plist object))))
	((p4::problem-p object)
	 (append
	  (struct-fields
	   object "PROBLEM-"
	   '(name objects goal state))
	  (plist-fields (p4::problem-plist object))))
	((listp object)
	 (calc-objects-listp object 0))
	((vectorp object)
	 (let ((res nil)
	       (length (length object)))
	   (dotimes (i length)
	     (push (list (format nil "~S" (- length i 1))
			 (format nil "~S" (elt object (- length i 1)))
			 (elt object (- length i 1)))
		   res))
	   res))
	 ))

;;; Do this in case it's not a true list. The last element will be
;;; "nil" if it is.
(defun calc-objects-listp (cons num)
  (if (consp cons)
      (cons (list (format nil "~S" num)
		  (format nil "~S" (car cons))
		  (car cons))
	    (calc-objects-listp (cdr cons) (1+ num)))
    (list (list (format nil "~S" num)
		(format nil "~S" cons)
		cons))))

(defun node-fields (node name fields)
  (append (struct-fields node name
		 (cons 'name
		       (append fields *nexus-fields*)))
	  (plist-fields (p4::nexus-plist node))))

(defun struct-fields (struct name fields)
  (mapcar #'(lambda (field)
	      (let ((value
		     (eval `(,(intern (format nil "~A~S" name field)
			       (find-package "PRODIGY4"))
			     ',struct))))
		(list (string-capitalize (format nil "~S" field))
		      (format nil "~S" value)
		      value)))
	  fields))

(defun plist-fields (plist)
  (do ((list plist (cddr list))
       (res nil))
      ((null list) res)
    (push (list (string-capitalize (format nil "~S" (car list)))
		(format nil "~S" (cadr list))
		(cadr list))
	  res)))





