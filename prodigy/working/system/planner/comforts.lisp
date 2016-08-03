;;; Just a few creature comforts for my fingers.

;;; $Revision: 1.7 $
;;; $Date: 1995/10/12 14:22:59 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: comforts.lisp,v $
;;; Revision 1.7  1995/10/12  14:22:59  jblythe
;;; Added protection nodes as a node type and search strategy, turned on with
;;; the variable *use-protection* (off by default). Also added the "event"
;;; macro which accepts similar syntax to operators. The new file "protect.lisp"
;;; has the protection code.
;;;
;;; Revision 1.6  1995/04/20  20:10:53  khaigh
;;; Added code to allow objects to stay the same between runs.
;;; Based on Alicia's run-same-objects2
;;;
;;; Revision 1.5  1995/03/15  18:51:26  khaigh
;;; fixed but in comforts
;;;
;;; Revision 1.4  1995/03/14  17:17:45  khaigh
;;; Integrated SABA into main version of prodigy.
;;; Call (set-running-mode 'saba) and
;;;      (set-running-mode 'savta)
;;;
;;; Also integrated apply-op control rules:
;;; ;;    (control-rule RULE
;;; ;;         (if...)
;;; ;;         (then select/reject applied-op <a>))
;;; ;; OR:
;;; ;;    (control-rule RULE
;;; ;;         (if (and (candidate-applicable-op (NAME <v1> <v2>...) )
;;; ;;                  (candidate-applicable-op (NAME <v1-prime> <v2-prime>...) )
;;; ;;                  (somehow-better <v1> <v1-prime>)))
;;; ;;         (then select/reject applied-op (NAME <v1> <v2> ...)))
;;; (candidate-applicable-op is in meta-predicates.lisp)
;;;
;;; Revision 1.3  1994/05/30  20:55:39  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:29:51  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(defvar *analogical-replay* nil)

;;; The *world-path* is now defined in prodigy.system.

(defvar *problem-path* nil
  "The path to look for files defining problems")

(defun path (&optional name)
  (let ((*print-case* :downcase))
    (if name
	(setf *world-path* name)
	*world-path*)))

(defun large-wobbly-control-rule (&rest args)
  (declare (ignore args)))

(defun domain (&optional name
			 &key (path *world-path*) (load-domain t) (compile nil)
			 (control t)
			 ;; I changed the default to source until we fix
			 ;; domains to have compiled files for more
			 ;; than one platform.
			 (function :source))
  (declare (special *world-path* *directory-separator* *current-problem-space*))
  (cond (name
	 (let ((*print-case* :downcase)
	       (old-control-rule (macro-function 'control-rule)))
	   (setf *problem-path*
		 (cleanup-string
		  (format nil "~A~C~S~C"
			  path *directory-separator* name *directory-separator*)))
	   ;; If function loading is specified, check the file exists
	   ;; and load if so.
	   (when function
	     ;; I commented this out because it is confusing when
	     ;; there is no functions file.
	     ;; (format t "Loading the functions file.~%")
	     (load (cleanup-string
		    (format nil "~A~C~A~Cfunctions~A"
			    *world-path* *directory-separator* name
			    *directory-separator*
			    (if (eq function :source)
				#-DOS ".lisp" #+DOS ".lsp"
				"")))
		   :verbose t
		   :if-does-not-exist nil))
	   (unless control
	     (setf (macro-function 'control-rule)
		   #'large-wobbly-control-rule))
	   (load (cleanup-string
		  (format nil "~A~Cdomain.lisp"
			  *problem-path* *directory-separator*)))
	   (setf (macro-function 'control-rule) old-control-rule)
	   (when load-domain
	     (format t "Running load-domain.~%")
	     (let ((time (load-domain :compile compile)))
	       (if (eq p4::*running-mode* 'p4::saba)
		   (let ((var (p4::create-control-rule
			       '(SUBGOAL-ALWAYS-BEFORE-APPLY
				 (if (candidate-goal <g>))
				 (then sub-goal)))))
		     (p4::add-rule-new
		      var (p4::problem-space-apply-or-subgoal
			   *current-problem-space*))))
	       time))))
	;; If no name is specified, provide a listing of the current path.
	(t
	 #-(and dos clisp)
	 (unless (char= (elt path (1- (length path)))
			*directory-separator*)
	   (setf path
		 (concatenate 'string path
			      (string *directory-separator*))))
	 (format t "~%Possible domains with the path ~S~%" path)
	 #-(and dos clisp)
	 (pprint (mapcar #'file-namestring (directory path)))
	 #+(and dos clisp)
	 (pprint (file-names path)))))

(defun problem (&optional name)
  (declare (special *problem-path*))
  (if (eq nil *problem-path*)
      (format t "Please select a domain first.~%")
    (cond (name
	   (let ((*print-case* :downcase))
	     (load (cleanup-string
		    (format nil "~A~Cprobs~C~S.lisp"
			    *problem-path* *directory-separator*
			    *directory-separator* name)))))
	  (t
	   (format t "~%Possible problems are:~%")
	   #+(and clisp dos)
	   (pprint (file-names 
		    (concatenate 'string *problem-path* "probs"
				 (string *directory-separator*))
		    "*.*"))
	   #-(and clisp dos)
	   (dolist (file (directory (concatenate 'string *problem-path*
						 "probs"
						 (string *directory-separator*))))
	     (print (file-namestring file)))))))

;;; Function to get the files I want from Dos under clisp.
#+(and clisp dos)
(defun file-names (path &optional (type "*/"))
  "Takes a string specifying a path and returns a list of file names in
that path. The behaviour of \"directory\" is implementation-dependent. 
This is the dos version."
  (unless (and (char= (elt path (1- (length path))) #\/)
	       (char= (elt path (- (length path) 2)) #\*))
    (if (char= (elt path (1- (length path))) #\/)
	(setf path (concatenate 'string path type))
      (setf path (concatenate 'string path "/" type))))
  (mapcar #'(lambda (x) 
	      (if (pathname-name x)
		  (concatenate 'string 
			       (pathname-name x) "." (pathname-type x))
		(caar (last (pathname-directory x)))))
	  (directory path)))

;;; Displaying data. I find this really handy, but the describe
;;; function 

(defun pshow (type &optional name)
  (case type
    ((operator rule) (showop name))
    ((node) (describe (find-node name)))
    ((literal lit assertion)
     (describe (p4::instantiate-consed-literal name)))
    ((object) (describe (p4::object-name-to-object
			 name *current-problem-space*)))
    ((type) (describe (p4::type-name-to-type name *current-problem-space*)))
    ((problem) (describe (current-problem)))
    ((initial) (p4::problem-state (current-problem)))
    ((goal) (p4::problem-goal (current-problem)))
    ((current) (format t "~%;;; The current state is:~%")
     (show-state))
    (t (format t "~%Not a recognised prodigy object - ~%
try operator, rule, object, type, node, problem, literal, current, ~%
initial or goal."))))

(defun showop (name)
  "Describe the operator, given the name"
  (declare (special *current-problem-space*))
  (describe (p4::rule-name-to-rule name *current-problem-space*)))

(defun printop (name)
  (p4::pprint-rule (p4::rule-name-to-rule name *current-problem-space*)))

(defun boundary ()
  "Count up how many nodes in the last tree failed because of the
depth bound."
  (bound-r (find-node 1)))

(defun bound-r (node)
  (if (eq (getf (p4::nexus-plist node) :termination-reason)
	  :depth-exceeded)
      1
      (let ((ttl 0))
	(dolist (child (p4::nexus-children node))
	  (incf ttl (bound-r child)))
	ttl)))

;;; This ugly function gets rid of duplicate "/" or ":" things,
;;; because the mess up some lisps.
(defun cleanup-string (s)
  (do ((done nil))
      (done s)
    (do ((i 0 (1+ i)))
	((= i (1- (length s))) (setf done t))
      (when (and (char= (elt s i) *directory-separator*)
	       (char= (elt s (1+ i)) *directory-separator*))
	  (setf s (delete *directory-separator* s :start i :end (1+ i)))
	  (return)))))

;;; Even lazier on the old keys..
(setf (macro-function 'pspace-prop) (macro-function 'problem-space-property))

(defun pset (field value)
  (setf (problem-space-property field) value))


;;; (trace-state) adds a daemon to print out state changes. (untrace-state)
;;; removes it. They both lose whatever state daemon may be there.

;;; Print the state change for one literal, in the same way as a goal
;;; is printed out in the trace. 
(defun print-state-daemon (literal pspace)
  (if (or (null (getf (p4::problem-space-plist pspace) :*output-level*))
	  (>= (getf (p4::problem-space-plist pspace) :*output-level*) 2))
      (let ((*print-case* :downcase))
	(terpri)
	(princ "    (") (princ (p4::literal-name literal))
	(dotimes (elt (length (p4::literal-arguments literal)))
	  (princ #\Space)
	  (p4::print-literal-arg (elt (p4::literal-arguments literal) elt)))
	(princ ") -> ")
	(princ (p4::literal-state-p literal)))))

(defun trace-state (&optional (pspace *current-problem-space*))
  "Add tracing for state changes."
  (setf (getf (p4::problem-space-plist pspace) :state-daemon)
	#'print-state-daemon))

(defun untrace-state (&optional (pspace *current-problem-space*))
  "See trace-state. This undoes it."
  (setf (getf (p4::problem-space-plist pspace) :state-daemon) nil))


#|
Author: Alicia Perez

Description: 
  functions to get the current state: returns a list of the literals
  true in the state. The optional argument is a list of predicate
  names. If used, the function returns only the true literals
  corresponding to those predicates

How it works: 
  adapted from print-true-literals (in search.lisp) which prints the
  literals and returns nil.

Example: (sorry for the awful example> I will change it...)

<cl>  (p4::give-me-nice-state)
(#<SPACE-LEFT AI2 3> #<SPACE-LEFT AI1 1> #<SPACE-LEFT A1 5> #<SPACE-LEFT A2 5> #<SPACE-LEFT A3 5>
 #<SPACE-LEFT A4 5> #<SPACE-LEFT A5 5> #<LOC-AT C1-A C1> #<LOC-AT C2-A C2> #<LOC-AT C3-A C3>
 #<LOC-AT C4-A C4> #<LOC-AT C5-A C5> #<LOC-AT I1-A I1> #<LOC-AT I2-A I2> #<LOC-AT DEST-A DEST>
 #<LOC-AT C1-PO C1> #<LOC-AT C2-PO C2> #<LOC-AT C3-PO C3> #<LOC-AT C4-PO C4> #<LOC-AT C5-PO C5>
 #<LOC-AT I1-PO I1> #<LOC-AT I2-PO I2> #<LOC-AT DEST-PO DEST> #<INSIDE-AIRPLANE O5 AI1>
 #<AT-AIRPLANE A2 C2-A> #<AT-AIRPLANE A3 C3-A> #<AT-AIRPLANE A4 C4-A> #<AT-AIRPLANE A5 C5-A>
 #<AT-AIRPLANE A1 I1-A> #<AT-AIRPLANE AI2 I1-A> #<AT-AIRPLANE AI1 C4-A> #<INTERMEDIATE-AIRPORT I1-A>
 #<INTERMEDIATE-AIRPORT I2-A> #<SAME-CITY C1-A C1-PO> #<SAME-CITY C1-PO C1-A> #<SAME-CITY C2-A C2-PO>
 #<SAME-CITY C2-PO C2-A> #<SAME-CITY C3-A C3-PO> #<SAME-CITY C3-PO C3-A> #<SAME-CITY C4-A C4-PO>
 #<SAME-CITY C4-PO C4-A> #<SAME-CITY C5-A C5-PO> #<SAME-CITY C5-PO C5-A> #<SAME-CITY I1-A I1-PO>
 #<SAME-CITY I1-PO I1-A> #<SAME-CITY I2-A I2-PO> #<SAME-CITY I2-PO I2-A> #<SAME-CITY DEST-A DEST-PO>
 #<SAME-CITY DEST-PO DEST-A> #<AT-OBJ O1 C1-A> #<AT-OBJ O2 C2-A> #<AT-OBJ O3 C3-A> #<AT-OBJ O4 C4-A>) 
<cl> (p4::give-me-nice-state '(at-obj))
(#<AT-OBJ O1 C1-A> #<AT-OBJ O2 C2-A> #<AT-OBJ O3 C3-A> #<AT-OBJ O4 C4-A>) 

Version History:
   April 92: created
|#

(defun show-state ()
  (p4::give-me-nice-state))

;;; I did it this rather ugly way because we wanted give-me-nice-state
;;; to be in this file but in the PRODIGY4 package, and some lisps
;;; ignored (in-package) in the middle of files and some didn't have
;;; (defpackage). - Jim

(defun p4::give-me-nice-state (&optional (literals nil))
  (let* ((assertion-hash
	  (p4::problem-space-assertion-hash *current-problem-space*))
	 (lit-hash-tables
	  (if literals
	      (mapcar #'(lambda (lit) (gethash lit assertion-hash))
		      literals)
	    (let (temp)
	      (maphash #'(lambda (k v) (push v temp)) assertion-hash)
	      temp))))
    (mapcan #'(lambda (hash-table)
		(let (temp)
		  (maphash #'(lambda (k v)
			       (if (p4::literal-state-p v) (push v temp)))
			   hash-table)
		  temp))
	    lit-hash-tables)))


;;; This function makes it easier to load in files from the contrib
;;; directory.
(defun contrib-load (&optional file)
  (let ((contrib-path
	 (format nil "~A~A~C" *system-directory* "contrib"
		 *directory-separator*)))
    (cond (file
	   (load (format nil "~A~A" contrib-path file)))
	  (t
	   (format t "~%Possible contrib files:~%")
	   (pprint (mapcar #'file-namestring
			   (directory contrib-path)))))))

;; This function sets the flags and control rules to force
;; prodigy to use SABA or SAVTA(default) running modes
(defun set-running-mode (mode)
  (declare (special *current-problem-space*))
  (cond ((eq mode 'saba)
	 (setf p4::*running-mode* 'p4::saba)
	 (setf p4::*smart-apply-p* t)
	 (format t "~%Subgoal behaviour: SUBGOAL-ALWAYS-BEFORE-APPLY")
	 (when (and (boundp '*current-problem-space*)
		    *current-problem-space*)
	   (let ((var (p4::create-control-rule
		       '(SUBGOAL-ALWAYS-BEFORE-APPLY
			 (if (candidate-goal <g>))
			 (then sub-goal)))))
	     (p4::add-rule-new var (p4::problem-space-apply-or-subgoal *current-problem-space*)))
	   (format t "~%Apply/Subgoal control rules:")
	   (p4::problem-space-apply-or-subgoal *current-problem-space*)))
	((eq mode 'savta)
	 (setf p4::*running-mode* 'p4::savta)
	 (setf p4::*smart-apply-p* nil)
	 (format t "~%Subgoal behaviour: SUBGOAL-AFTER-EVERY-TRY-TO-APPLY (default)")
	 (when (and (boundp '*current-problem-space*)
		    *current-problem-space*)
	   (setf (p4::problem-space-apply-or-subgoal *current-problem-space*)
		 (remove 'SUBGOAL-ALWAYS-BEFORE-APPLY
			 (p4::problem-space-apply-or-subgoal *current-problem-space*)
			 :key #'p4::rule-name))
	   (format t "~%Apply/Subgoal control rules:")
	   (p4::problem-space-apply-or-subgoal *current-problem-space*)
	   ))
	(t
	 (format t "~%Valid modes:")
	 (format t "~%    'saba")
	 (format t "~%    'savta"))))
