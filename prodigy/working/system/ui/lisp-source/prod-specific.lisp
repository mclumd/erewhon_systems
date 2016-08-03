;;; Specific lisp for the prodigy-tcl interaction

;;; History
;;;
;;; 16apr96 Modified compute-coordinates to use *node-width* and *node-height* 
;;;         and to be more flexible in the coordinate computation for drawing 
;;;         goal tree nodes.
;;;
;;;   mar97 Wrote code that begins to develop a novice mode. The code starts 
;;;         the infix representation for node labels in the goal tree.
;;;
;;; 23apr97 Reconciled the code with Jim's UI version that uses the latest
;;;         Tcl/Tk [cox] 
;;; 
;;; 16jun97 Modified opt-send-final to handle failed planning episode. [cox] 
;;;
;;;  3sep97 Fixed delete-from-goal-tree so that it rightly deleted from the 
;;;         plan display applied operators that included inference rules.
;;;
;;; 17oct97 Modified instop-print to indicate those applied ops that were
;;;         executed. [cox]
;;;
;;; 24dec97 Modified opt-send-final to handle plans that achieve only some of the
;;;         top level goals when resource bounds (e.g., time bounds) are exceeded.
;;;         This is necessary when using the partial-satisfaction.lisp extension 
;;;         in *system-directory*/contrib. [cox]
;;;


(in-package "USER")


;;; The next two variables were added 16apr96.
(defvar *node-width* 50)     ;; Width of a node in the tree
(defvar *node-height* 50)    ;; Height of a node in the tree.

(defvar *xmargin* 10)        ;; Margin off the left window edge.
(defvar *ymargin* 100)
;;; These are being phased out
(defvar *width*  100)        ;; Distance between siblings in the tree
(defvar *height*  75)        ;; Distance between generations (levels) in the tree

(defvar *inter-x-margin* *width*
  "Gap between siblings in the tree")

(defvar *inter-y-margin* *height*
  "Gap between generations in the tree")

(defvar *used-slots* nil
  "Assoc list showing the slots used in each level of the goal tree
drawing. Each slot includes the rectangle coordinates")

(defvar *pre-empted* nil
  "If this is a node, it was sent to the goal tree canvas early by the
menu query system, so send-node-and-wait should not send it. It is
re-set by send-node-and-wait so if some intervening node is sent
before another query we delete this node as normal.")


;;; This is a callback that gives tcl info on the search tree as it
;;; unfolds. Make it a prodigy interrupt handler for :always.
(defparameter *seen* nil)


;;;
;;; Macro return-val is a utility used by Tcl to read LISP variables without 
;;; crashing if the variable has no value. If no binding, return-val returns 
;;; nil, otherwise, it returns the variable value. Because it is a macro, the 
;;; caller need not quote the variable identifier. See utils.tcl.
;;;
(defmacro return-val (var)
  (if (boundp var)
      var)
  )

      

(defmacro gt-level (node) `(getf (p4::nexus-plist ,node) :gt-level))
(defmacro gt-xnum  (node) `(getf (p4::nexus-plist ,node) :gt-num))


(defun send-node-and-wait (signal)
  (declare (ignore signal))
  (when (and (boundp '*current-node*)
	     (= (p4::nexus-name *current-node*) 4))
	(setf *seen* nil)
	(setf (gt-level *current-node*) 0)
	(setf *used-slots* nil))
  (when (and (boundp '*current-node*)
	     (not (= (p4::nexus-name *current-node*) 4))
	     (or (not (p4::operator-node-p *current-node*))
		 (and (= (p4::nexus-name *current-node*) 3)
		      (p4::applied-op-node-applied (find-node 1)))))
	;; Use node 3 as an excuse to send the application node 1 if
	;; it has some eager inference rules.
	(if (= (p4::nexus-name *current-node*) 3)
	    (send-to-tcl
	     (format nil "1 & Initial eager inference rules & 4 & A ~{~5D~}"
		     ;; coordinates
		     (list 0 0 0 0)))
	  (main-send-node *current-node*))
	(setf *pre-empted* nil)
	;; Wait for a signal to carry on from the tcl system (which checks
	;; if the user pushed the "break" button)
	(let ((response (string-right-trim '(#\newline #\return)
					   (read-line *tcl-send*))))
	  (cond ((string= response ":abort")
		 (list :stop :tcl-aborted))
		((not (string= response ":cont"))
		 (format t "Entering subserver~%")
		 (sub-server))))))

(defun main-send-node (node &optional ending)
  (cond ((eq *pre-empted* node)		; don't send it twice.
	 (send-to-tcl " & & & "))
	;; recursively delete all children in the search tree if we're
	;; backtracking
	((member (p4::nexus-name node) *seen*)
	 (dolist (kid (p4::nexus-children node))
	   (send-delete-children kid))
	 ;; This line is recognised by tcl as a request to continue
	 ;;(if (p4::nexus-children node) (send-to-tcl " & & & "))
	 (send-to-tcl " & & & "))
	;; don't print weird and wonderful nodes for now.
	((or (p4::goal-node-p node) (p4::operator-node-p node)
	     (p4::binding-node-p node) (p4::applied-op-node-p node))
	 ;; recursively draw the parent if it's not there and we need
	 ;; it. (This allows us to cope with strange shifts of current
	 ;; node).
	 (let ((parent  (goal-tree-parent node)))
	   (unless (or (null parent)
		       (< (p4::nexus-name parent) 5)
		       (member (p4::nexus-name parent) *seen*))
	     (main-send-node (goal-tree-parent node))
	     (read-line *tcl-send*)))
	 (push (p4::nexus-name node) *seen*)
	 ;; recursively delete all the siblings if we're not
	 (dolist (sibling (remove node (p4::nexus-children
					(p4::nexus-parent node))))
	   (send-delete-children sibling))
	 ;; Also delete an operator node parent
	 (if (and (p4::binding-node-p node)
		  (member (p4::nexus-name (p4::nexus-parent node))
			  *seen*))
	     (delete-from-goal-tree (p4::nexus-parent node)))
	 (send-to-tcl
	  (format nil "~S & ~A & ~S & ~A ~{~5D~} ~A"
		  (p4::nexus-name node)
		  (prod-node-print node)
		  (p4::nexus-name (goal-tree-parent node))
		  (cond ((p4::goal-node-p node)     "G")
			((p4::operator-node-p node) "B") ; cheating
			((and (p4::binding-node-p node)
			      (p4::inference-rule-p
			       (p4::instantiated-op-op
				(p4::binding-node-instantiated-op node))))
			 "I")		; differentiate inference rules.
			((p4::binding-node-p node)  "B")
			((and (p4::applied-op-node-p node)
			      (> (length (p4::applied-op-node-applied
					  node)) 1))
			 "M")		; multiple applications (ie inf rules)
			((p4::applied-op-node-p node) "A"))
		  ;; coordinates
		  (if (p4::applied-op-node-p node)
		      (list 0 0 0 0)
		    (compute-coordinates node))
		  (if ending "E" ""))))
	(t 	 
	 (send-to-tcl " & & & "))))

(defun goal-tree-parent (node)
  (cond ((p4::binding-node-p node)
	 (p4::nexus-parent (p4::nexus-parent node)))
	((p4::goal-node-p node)
	 (car (p4::goal-node-introducing-operators
	       node)))
	((p4::operator-node-p node)
	 (p4::nexus-parent node))
	;; Right now applied op nodes don't appear in the graph, but
	;; the parent is annotated to show the application.
	((p4::applied-op-node-p node)
	 (p4::instantiated-op-binding-node-back-pointer
	  (p4::applied-op-node-instantiated-op node)))))

(defun send-delete-children (node)
  (dolist (kid (p4::nexus-children node))
    (send-delete-children kid))
  (when (member (p4::nexus-name node) *seen*)
    (delete-from-goal-tree node)))

(defun delete-from-goal-tree (node)
  (setf *seen* (delete (p4::nexus-name node) *seen*))
  (free-slot node)
  (send-to-tcl (format nil
		       (if (p4::applied-op-node-p node)
			   "delete A ~S"
			 "delete ~S")
		       (p4::nexus-name node)))
  ;; This is the case where we are deleting an applied node that represents
  ;; inference rule applications as well; that is, the so call multi-node.
  ;; Thus, we have to delete a second widget from the appliedops canvas. 
  ;; [cox 3sep97]
  ;;
  ;; Changed to the "AA" format to signal to tcl that it should not delete
  ;; another application mark in the goal canvas. [17oct97 cox]
  (if (and (p4::applied-op-node-p node)
	   (> (length (p4::applied-op-node-applied
		       node)) 1))
      (send-to-tcl (format nil "delete AA ~S" (p4::nexus-name node))))
  )

;;; This sends the final application node on success, to make sure
;;; that the whole plan gets across. 
(defun opt-send-final (&optional (string "Ended successfully"))
  (let ((result (prodigy-result-interrupt *prodigy-result*)))
    (if (and (not (eq result :FAIL))
	     (p4::applied-op-node-p (cdr result)))
	(main-send-node (cdr result) t)
      (send-to-tcl "E"))
    ;; Send a string of data representing the end result
    (cond ((eq result :FAIL)
	   (send-to-tcl "Ended with no plan"))
	  ((and (listp (car result)) (eq (cdar result) :achieve))
	   (send-to-tcl string))
	  ((and (eq (car result) :stop))
	   (send-to-tcl (format nil "Ended with (~{~S~})" (cdr result))))
	  ;;This clause handles plans that achieve some of the top level goals
	  ;;when using partial-satisfaction.lisp from contrib. [24dec97 cox]
	  ((and (consp (first result))
		(eq (first (first result)) :partial-achieve))
	   (send-to-tcl (format nil "Achieved ~s goals. Ended with (~{~S~})" 
				(length (third (first result)))
				(rest (first (second result)))))))
    t))

;;; This function makes sure the handler is defined, once, in the
;; current handlers.
(defun add-drawing-handler ()
  (unless (member (symbol-function 'send-node-and-wait)
		  (cdr (assoc :always p4::*prodigy-handlers*)))
    (define-prod-handler :always (symbol-function
				  'send-node-and-wait))))

;;; This gets rid of it again at the end. Otherwise, run hangs if
;;; called from lisp after it was called from the UI.
(defun remove-drawing-handler ()
  (remove-prod-handler
   :always (symbol-function 'send-node-and-wait)))

;;;=======================================
;;; Drawing other hierarchies
;;;=======================================

;;; This calls up dot with a specification of the tree specified by
;;; the child function and list of roots, and leaves the file where
;;; specified.

(defun call-dot (roots child-function id-fn name-fn shape-fn
		       &optional filename
		       &key (graph-name "lisp") (top-down t)
		       (outfile "/tmp/dodot")
		       (x-size 6) (y-size 6)
		       (run-dot nil))
  (with-open-file (out outfile :direction :output
		       :if-exists :rename-and-delete)
    (let ((done nil))
      (format out "digraph ~A {~%size = \"~S,~S\";~%"
	      graph-name x-size y-size)
      (unless top-down
	(format out "rankdir = LR~%"))
      (dolist (root roots)
	(setf done
	      (append done
		      (dfs-write-dot
		       root child-function id-fn name-fn shape-fn
		       out)))))
    (format out "}~%"))
  (if run-dot
      (excl:run-shell-command
       (format nil "dot -Tplain ~A >! ~S" outfile filename)))
  t)

;;; child-fn should take a node and return a list of children.
;;; id-fn gives the internal name. Should take a node return a symbol
;;; or string.
;;; name-fn gives the label. Should take a node return a symbol or string.
;;; shape-fn gives the shape - "Ellipse" and "Box" both work in tcl.
;;; Note that the color field is set to the id-fn. This is so that the
;;; id shows up in the PIC output so tcl can know it. When I want to
;;; control colours later, I'll have to have both id and colour in the
;;; color field.
(defun call-dag (roots child-fn id-fn name-fn shape-fn filename
		       &key (top-down t) (ui t))
  (with-open-file (out "/tmp/tmp.dag"
		       :direction :output
		       :if-exists :rename-and-delete)
    (if top-down
	(format out ".GS ~%")
      (format out ".GR ~%"))
    (let ((done nil))
      (dolist (root roots)
	(setf done
	      (append done (dfs-write-dag root child-fn id-fn name-fn
					  shape-fn out done ui)))))
    (format out ".GE ~%"))
  (excl:run-shell-command
   (format nil "~A/dagshell /tmp/tmp.dag /tmp/tmp.pic" *prod-ui-home*)))


;;; name-fn should return a string.
(defun dfs-write-dag (node child-fn id-fn name-fn shape-fn out done ui)
  (unless (member node done)
    (let ((kids (apply child-fn (list node))))
      (format out
	      ;; only mention a strange colour if using the ui -
	      ;; otherwise postscript will barf on it.
	      (if ui
		  "draw ~S label ~S as ~A color ~S;~%"
		"draw ~S label ~S as ~A;~%")
	      (apply id-fn (list node))
	      (apply name-fn (list node))
	      (apply shape-fn (list node))
	      (apply id-fn (list node)))
      (push node done)
      (dolist (n (cons node kids))
	(format out "~S " (apply id-fn (list n))))
      (format out ";~%")
      (dolist (n kids)
	(setf done (dfs-write-dag n child-fn id-fn name-fn shape-fn
				  out done ui)))))
  done)

;;; Currently just quickly written before a talk. Not thoroughly tested.
(defun dfs-write-dot (node child-fn id-fn name-fn shape-fn out)
  (let ((kids (apply child-fn (list node))))
    (format out "~S [label=~S, shape=~S];~%"
	    (apply id-fn (list node))
	    (apply name-fn (list node))
	    (apply shape-fn (list node)))
    ;; ok, so it's really bfs.
    (dolist (n kids)
      (format out "~S -> ~S;~%"
	      (apply id-fn (list node)) (apply id-fn (list n))))
    (dolist (n kids)
      (dfs-write-dot n child-fn id-fn name-fn shape-fn out))))


;;; This should put a search tree up
(defun dag-search-tree (file)
  (call-dag (list (p4::find-node 0)) #'p4::nexus-children
	    #'p4::nexus-name #'prod-node-print
	    #'prod-node-shape
	    file))

;;; These definitions make it convenient to use dag for type
;;; hierarchies. It builds a tree of the types, and writes the
;;; instances in as part of the nodes.

(defun type-children (symbol)
  (let ((type-obj
	 (p4::type-name-to-type symbol *current-problem-space*)))
    (if (p4::type-p type-obj)
	(nreverse (mapcar #'p4::type-name (p4::type-sub type-obj))))))

(defun ellipse (node)
  (declare (ignore node)) 
  "Ellipse")

;;; Can't just use the name, because a type like "COLOR" is illegal in
;;; dag.
(defun make-type-id-name (type-name)
  (if (eq type-name :top-type)
      'TOPTYPE
    (intern (substitute #\_ #\- (format nil "PT-~S" type-name)))))

(defun make-type-label (type-name)
  (string-downcase (symbol-name type-name)))

(defun type-dag (file &key (ui t))
  (call-dag (list :top-type) #'type-children
	    #'make-type-id-name #'make-type-label
	    #'ellipse file
	    :top-down nil
	    :ui ui))

(defun type-dot (file &key (ui t))
  (call-dot (list :top-type) #'type-children
	    #'make-type-id-name #'make-type-label
	    #'ellipse file
	    :top-down nil))

;;; Assuming Alicia's files for generating and printing a partial
;;; order are loaded, this calls up dag, which is faster than psgraph
;;; and does a better job. make-po is designed to be called from the
;;; interface and is supposed to be robust.

(defun make-po (dagfile picfile &key (ui t))
  (when (not (boundp '*prodigy-result*))
    (format t
	    "You need to run a problem before displaying the partial order")
    (return-from make-po nil))
  (when (not (fboundp 'p4::build-partial))
    (dolist (file '("access-fns-pro4" "my-release-partial"
		    "process-preconds" "footprint" "print-partial"))
      (load (concatenate 'string *prod-ui-home* "/order/" file))))
  (dag-po (p4::build-partial
	   (p4::prepare-plan-for-partial-order)
	   (p4::get-initial-state))
	  dagfile :ui ui))

(defun dag-po (po file &key (ui t))
  (let ((ops-only
	 (remove-if #'(lambda (o)
			(p4::inference-rule-p
			 (p4::instantiated-op-op o)))
		    (prodigy-result-solution *prodigy-result*)))
	(roots nil))
    (dotimes (i (array-dimension po 0))
      (if (dotimes (j (array-dimension po 0) t)
	    (if (= (aref po j i) 1)
		(return nil)))
	  (push i roots)))
    (call-dag roots
	      #'(lambda (n) (p4::get-successors n po))
	      #'(lambda (n) n)
	      #'(lambda (n)
		  (cond ((zerop n) "Root")
			((> n (length ops-only)) "Sink")
			(t (instop-print (elt ops-only (1- n))))))
	      #'(lambda (n)
		  (if (or (zerop n) (> n (length ops-only)))
		      "Ellipse"
		    "Box"))
	      file
	      :ui ui)))

;;; These printing routines were basically borrowed from
;;; treeprint.lisp
;;; BUGS: negated goals not printed as such.

(defun prod-node-shape (node)
  (if (typep node 'p4::applied-op-node)
      "Box"
    "Ellipse"))


;;;
;;; This version of the function was used to generate the infix predicate
;;;  representation for the Cox & Veloso ICCBR paper. 
;;;
(defun prod-node-print (node)
  (cond ((typep node 'p4::goal-node)
	 (let* ((goal (p4::goal-node-goal node))
		(string (format nil (if (and (p4::literal-state-p goal)
					     (p4::literal-neg-goal-p goal))
					"not ~S" "~S")
				(p4::literal-name goal))))
	   (if (equal string "AT")
	       (setf string 
		     (concatenate 'string
				  (let ((val (elt (p4::literal-arguments goal) 0)))
				    (format nil " ~S"
					    (if (p4::prodigy-object-p val)
						(p4::prodigy-object-name val)
					      val))) 
				  " is-at"
				  (let ((val (elt (p4::literal-arguments goal) 1)))
				    (format nil " ~S"
					    (if (p4::prodigy-object-p val)
						(p4::prodigy-object-name val)
					      val)))
				  ))
	     (dotimes (i (length (p4::literal-arguments goal)))
	       (let ((val (elt (p4::literal-arguments goal) i)))
		 (setf string
		       (concatenate 'string string
				    (format nil " ~S"
					    (if (p4::prodigy-object-p val)
						(p4::prodigy-object-name val)
					      val)))))))
	   (string-downcase string)))
	((typep node 'p4::a-or-b-node)
	 (instop-print  (p4::a-or-b-node-instantiated-op node)))
	((typep node 'p4::operator-node)
	 (string-downcase
	  (format nil "~S" (p4::rule-name
			   (p4::operator-node-operator node)))))))



(defun prod-node-print (node)
  (cond ((typep node 'p4::goal-node)
	 (let* ((goal (p4::goal-node-goal node))
		(string (format nil (if (and (p4::literal-state-p goal)
					     (p4::literal-neg-goal-p goal))
					"not ~S" "~S")
				(p4::literal-name goal))))
	   (dotimes (i (length (p4::literal-arguments goal)))
	     (let ((val (elt (p4::literal-arguments goal) i)))
	       (setf string
		     (concatenate 'string string
		       (format nil " ~S"
			       (if (p4::prodigy-object-p val)
				   (p4::prodigy-object-name val)
				 val))))))
	   (string-downcase string)))
	((typep node 'p4::a-or-b-node)
	 (instop-print  (p4::a-or-b-node-instantiated-op node)))
	((typep node 'p4::operator-node)
	 (string-downcase
	  (format nil "~S" (p4::rule-name
			   (p4::operator-node-operator node)))))))

;;;
;;; This function was used to generate the infix predicate
;;;  representation for the Cox & Veloso ICCBR paper. 
;;;
(defun conv (instop op index)
  "Convert item to string"
  (let ((val (elt (p4::instantiated-op-values instop)
		      (position (nth index (p4::rule-params op))
				(p4::rule-vars op)))))
    (format nil "~S"
	    (if (p4::prodigy-object-p val)
		(p4::prodigy-object-name val)
	      val))
    ))

;;;
;;; This version of the function was used to generate the infix predicate
;;;  representation for the Cox & Veloso ICCBR paper. 
#|
(defun instop-print (instop)
  (let* ((op (if instop (p4::instantiated-op-op instop)))
	 (string (if op (format nil "~S" (p4::operator-name op))
		   "")))
    (if (equal string "UNLOAD-ROCKET")
	(setf string
	      (concatenate 'string "UNLOAD-" 
			   (conv instop op 1)
			   " FROM-ROCKET-"
			   (conv instop op 3)
			   " AT-LOCATION-"
			   (conv instop op 2)
			   ))
    (dolist (var (if op (cdr (p4::rule-params op))))
      (let ((val (elt (p4::instantiated-op-values instop)
		      (position var (p4::rule-vars op)))))
	(setf string
	      (concatenate 'string string
			   (format nil " ~S"
				   (if (p4::prodigy-object-p val)
				       (p4::prodigy-object-name val)
				     val)))))))
    (string-downcase string)))
|#

(defun instop-print (instop)
  (let* ((op (if instop (p4::instantiated-op-op instop)))
	 (string (if op (format nil "~S" (p4::operator-name op))
		   "")))
    (dolist (var (if op (cdr (p4::rule-params op))))
	    (let ((val (elt (p4::instantiated-op-values instop)
			    (position var (p4::rule-vars op)))))
	      (setf string
		    (concatenate 'string string
				 (format nil " ~S"
					 (if (p4::prodigy-object-p val)
					     (p4::prodigy-object-name val)
					   val))))))
    ;; Added to indicate those applied op having been executed. [17oct97 cox]
    (if (and (boundp '*loaded-execute*)
	     *loaded-execute*
	     (p4::has-been-executed? 
	      (p4::instantiated-op-binding-node-back-pointer
	       instop)))
	(setf string
	      (concatenate 'string string
			   " (executed)")))
    (string-downcase string)))

;;; This command is called by the search tree window when a node is
;;; clicked on.
(defun clicked-node (node))


;;; Stepper routines ===========================================

#|
This was a first pass based on the idea of stopping a run completely
and restarting it using this top-level lisp command. This has the
disadvantage that you have to recover lots of state, which you can't
look at while you've stopped. So I'm going for a different strategy
where the send-node-and-wait function recursively starts talking to
tcl (starts off its own tcl-server function) if the break button is
pushed. This can't get to a recursive depth of greater than one,
because tcl will make sure the run is aborted if the user hits "run"
again. That part of this scheme is in the tcl code. This recursive
read loop is defined as "sub-server" below.
;;;
;;; Need to recover the last node. This is left behind by the
;;; stepper break caused by the "send-node-and-wait" signal handler
;;; above. 

(defun prodigy-restart
  (&optional (depth-bound (or (pspace-prop :depth-bound) 30)))
  (let* ((interrupt (prodigy-result-interrupt *prodigy-result*))
	 (last-node (if (eq (second interrupt) :restartable)
			(third interrupt)))
	 (next-node
	  (p4::choose-node last-node (p4::generate-nodes last-node)))
	 (current-depth
	  (p4::maintain-state-and-goals last-node next-node)))
    (cond ((not last-node)
	   (format t "~%This is not a restartable break~%"))
	  ((not next-node)
	   (format
	    t "~%Cannot restart because the search space is exhausted~%"))
	  ;; fudging depth bound for now.
	  (t (p4::main-search next-node last-node current-depth 30)))))
|#

;;; Enters a dialog loop with tcl as a subroutine from the main one,
;;; while running is suspended. This is how stepping is done. Since
;;; the return value of this is returned by the send-node-and-wait
;;; interrupt handler, the return value of (:stop ...) causes the run
;;; to halt.
(defun sub-server ()
  (do ((input_line (string-right-trim '(#\newline #\return)
 				      (read-line *tcl-send* nil "(quit)"))
 		   (string-right-trim '(#\newline #\return)
 				      (read-line *tcl-send* nil "(quit)"))))
      ((or (string= input_line "(quit)")
	   (string= input_line ":cont")
	   (string= input_line ":abort"))
       (when (string= input_line ":abort")
	 (format t "~%Planning aborted from UI~%")
	 (list :stop :tcl-aborted)))
    (if *jim-trace*
	(format t "~%Sub-server gets: ~A~%" input_line))
    (eval-for-tcl input_line)))

;;; ========================================
;;; Goal tree layout routines
;;;

;;; Real simple scheme: put the node in the next "open slot" below the
;;; parent. Note that deleting the node frees up slots. For each level
;;; we maintain a list of used positions. The levels and positions are
;;; ordinal and are multiplied up by variables to get the coordinates.


(defvar *tcl-char-width* 10)
(defvar *tcl-char-height* 19)

(defun compute-coordinates (node)
  (let* ((parent-level (gt-level (goal-tree-parent node)))
	 (node-level (1+ parent-level))
	 ;; The slot computes the starting x and y coordinates.
	 (xslot (first-free-slot node-level))
	 (xnum (car xslot)))
    (setf (gt-level node) node-level)
    (setf (gt-xnum node) xnum)
    (setf (elt xslot 3)			; high x coordinate
	  (+ (elt xslot 1)
	     (cond ((and (p4::binding-node-p node)
			 (p4::instantiated-op-p
			  (p4::a-or-b-node-instantiated-op node)))
		    (let* ((iop (p4::a-or-b-node-instantiated-op node))
			   (values (p4::instantiated-op-values iop))
			   (op (p4::instantiated-op-op iop))
			   (vars (p4::rule-vars op)))
		      (* *tcl-char-width*
			 (apply 
			  #'max 
			  (mapcar 
			   #'(lambda (symbol) (length (string symbol)))
			   (cons (p4::operator-name
				  (p4::instantiated-op-op
				   (p4::a-or-b-node-instantiated-op node)))
				 (mapcar
				  #'(lambda (var)
				      (let ((val (elt values
						      (position var vars))))
					(if (p4::prodigy-object-p val)
					    (p4::prodigy-object-name val)
					  (format nil "~S" val))))
				  (cdr (p4::rule-params op)))))))))
		   ((and (p4::goal-node-p node)
			 (p4::literal-p (p4::goal-node-goal node)))
		    (let* ((literal (p4::goal-node-goal node))
			   (width
			    (length (string (p4::literal-name literal))))
			   (args (p4::literal-arguments literal)))
		      (dotimes (i (length args))
			       (let* ((elt (elt args i))
				      (sym (if (p4::prodigy-object-p elt)
					       (p4::prodigy-object-name elt)
					     (format nil "~S" elt)))
				      (length (length (string sym))))
				 (if (> length width) (setf width length))))
		      (* *tcl-char-width* width)))
		   (t
		    *node-width*))))
    (setf (elt xslot 4)			; high y coordinate
	  (+ (elt xslot 2)
	     (cond ((and (p4::goal-node-p node)
			 (p4::literal-p (p4::goal-node-goal node)))
		    (* *tcl-char-height*
		       (+ 1 (length (p4::literal-arguments
				     (p4::goal-node-goal node))))))
		   ((and (p4::binding-node-p node)
			 (p4::instantiated-op-p
			  (p4::a-or-b-node-instantiated-op node)))
		    (* *tcl-char-height*
		       (length (p4::rule-params
				(p4::instantiated-op-op
				 (p4::a-or-b-node-instantiated-op
				  node))))))
		   (t *node-height*))))
    ;; coordinates are now stored here.
    (cdr xslot)))


;;; *used-slots* is an assoc list of sorted used slots. This function
;;; inserts the value it returns so subsequent calls give different
;;; values. It also computes the starting x and y position based on
;;; the other slot members.

(defun first-free-slot (level)
  (let ((used-level (assoc level *used-slots*)))
    (cond (used-level
	   (do ((i 1 (1+ i))
		(list used-level (cdr list))
		(start-y 0)
		(start-x 0))
	       ;; assumes the slots are sorted in ascending order
	       ((or (not (cadr list)) (not (= (caadr list) i)))
		(car (setf (cdr list)
			   (cons (list i (+ start-x *inter-x-margin*)
				       start-y 0 0)
				 (cdr list)))))
	       ;; Set the start-x to be the max-x of the previous slots
	       (if (> (elt (cadr list) 3) start-x)
		   (setf start-x (elt (cadr list) 3)))
	       (setf start-y (elt (cadr list) 2))))
	  (t				; no other slot at this level.
	   ;; Look for the maximum height of nodes at the level above
	   (let* ((start-y
		   (let ((max-y (- *ymargin* *inter-y-margin*)))
		     (dolist (slot (cdr (assoc (- level 1) *used-slots*)))
			     (if (> (elt slot 4) max-y)
				 (setf max-y (elt slot 4))))
		     (+ max-y *inter-y-margin*)))
		  (res (list 1 *xmargin* start-y 0 0)))
	     (push (list level res) *used-slots*)
	     res)))))

;;; This is called when a node is removed from the goal tree drawing.
;;; It is assumed that the node is currently in the slot list,
;;; otherwise some other node that shares the x number will be deleted.
(defun free-slot (node)
  (let* ((level (gt-level node))
	 (xnum  (gt-xnum  node))
	 (used-list (assoc level *used-slots*)))
    ;; Shouldn't really happen, but sometimes we try to free a slot
    ;; for a node that doesn't have one and then this can happen.
    (when used-list
	  (setf (cdr used-list)
		(delete xnum (cdr used-list) :key #'car))
	  ;; remove an empty list, because first-free-slot above uses
	  ;; the test that there is no list to decide if it's empty.
	  (if (null (cdr used-list))
	      (setf *used-slots* (delete used-list *used-slots*))))))


;;;=================================================================
;;; Miscellaneous
;;;=================================================================

;;; Based on treeprint-goal, but returns a string
(defun goal-string (literal)
  (format nil "~A(~S~{ ~S~})"
	  (if (and (p4::literal-state-p literal)
		   (p4::literal-neg-goal-p literal))
	      "not " "")
	  (p4::literal-name literal)
	  (mapcar #'(lambda (x)
		      (if (p4::prodigy-object-p x)
			  (p4::prodigy-object-name x)
			x))
		  (coerce (p4::literal-arguments literal) 'list))))

(defun goal-list (literal)
  (let* ((args (mapcar #'(lambda (x)
			   (if (p4::prodigy-object-p x)
			       (p4::prodigy-object-name x)
			     x))
		       (coerce (p4::literal-arguments literal) 'list)))
	 (litlist (cons (p4::literal-name literal) args)))
    (if (and (p4::literal-state-p literal)
	     (p4::literal-neg-goal-p literal))
	(cons 'not litlist)
      litlist)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; The following three functions are used by the view search node function in
;;; the View pull-down menu of the UI.


;;;
;;; Function in-search-tree returns T if current-name is a legitimate name of a
;;; search tree node; otherwsise, it returns the list (<first-node-name> -
;;; <last-node-name>). This latter value is displayed in an error message to
;;; the user as an implied range (since the nodes are numerical) for indicating
;;; a search node to display after the user types an illegitimate identifier.
;;; (A sort has to be done for this range to be correct - Jim)

(defun in-search-tree (current-name 
		       &aux 
		       (node-names (collect-node-names)))
  (if (member current-name node-names)
      T
    (let ((sorted (sort node-names #'<)))
      (list (first sorted) '- (first (last sorted)))))
  )


;;;
;;; Function collect-node-names traverses the Prodigy search tree and collects
;;; a list of valid node names.
;;;
(defun collect-node-names (&optional (s-tree-node (search-tree-root)))
  (cond ((null s-tree-node)
	 nil)
	((listp s-tree-node)
	 (append (collect-node-names (first s-tree-node))
		 (collect-node-names (rest s-tree-node))))
	(t
	 (cons (p4::nexus-name s-tree-node)
	       (collect-node-names (p4::nexus-children s-tree-node)))))
  )


