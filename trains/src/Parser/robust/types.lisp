(in-package parser)

;; if the car of the content field of the KQML msg is one of these words, it's
;; input to the parser.
(defvar *words-of-parser-input* 
    '(MENU MOUSE CONFIRM START-CONVERSATION START INPUT-END BACKTO WORD END))

;;'e' may be a CCA or an SA
;;returns a list of sem fields 
(defun grab-sem (e)
  (cond ((eql (car e) 'COMPOUND-COMMUNICATIONS-ACT)
	 (apply 'append (mapcar 'grab-sem (third e))))
	(t
	 (let ((ans (member :SEMANTICS e)))
	   (when ans
	     (list (second ans)))))))

(defun get-content (e)
  (when (and (eql (car e) 'TELL)
	     (eql (second e) :CONTENT))
    (third e)))

;; accepts a filename (as a string)
;; the file should look like a parser.log file
;; returns a list of all the SAs, with CCA's split up into the 
;; component SAs.
(defun get-SAs (fname)
  (convert-to-single-SAs
   (remove-if #'(lambda (msg)
		  (or (null msg)
		      (member (car msg) *words-of-parser-input*)))
	      (mapcar 'get-content 
		      (with-open-file (s fname)
			(reverse (read-in-list s)))))))

;; given a list of speech acts (as they look in parser log files),
;; return the consp of the SA-type and a semantic form where the
;; vars have been instantiated with the types of the objects.
(defun get-types (sa-list)
  (mapcar #'(lambda (SA-struct)
	      (cons (SA-type SA-struct)
		    (output-type SA-struct)))
	  (mapcar 'parse-input 
		  (remove-if-not 'grab-sem sa-list))))


;; takes a list of SA's, some possibly compound, and splits the CCAs up into 
;; single individual SA's.  returns the new list.
(defun convert-to-single-SAs (l)
  (when l
    (if (eql (caar l) 'COMPOUND-COMMUNICATIONS-ACT)
	(append (third (car l))
		(convert-to-single-SAs (cdr l)))
      (cons (car l) (convert-to-single-SAs (cdr l))))))

(defun equal-mod-vars (g1 g2)
  (cond ((and (null g1) (null g2))
	 t)
	((and (atom g1) (atom g2))
	 (or (equal (dekeywordify g1) (dekeywordify g2))
	     (and (var g1) (var g2))))
	((or (atom g1) (atom g2) (null g1) (null g2))
	 nil)
	(t
	 (and (equal-mod-vars (car g1) (car g2))
	      (equal-mod-vars (cdr g1) (cdr g2))))))

;; the funniness at the bottom is so we can check for nil as an elem of the tree
(defun member-tree (x tree)
    (cond ((atom tree)
	   (eql tree x))
	  (t
	   (or (member-tree x (car tree))
	       (when (cdr tree) (member-tree x (cdr tree)))))))
	 

;; everything but props will be sorted straight alphy.  for props, we will look at the class.
(defun semantics-lessp (s1 s2)
  (if (and (is-prop s1)
	   (is-prop s2)
	   (has-class s1)
	   (has-class s2))
      (string-lessp (princ-to-string (get-root (second (assoc :CLASS (cdr s1)))))
		    (princ-to-string (get-root (second (assoc :CLASS (cdr s2))))))
    (string-lessp (princ-to-string s1)
		  (princ-to-string s2))))

(defun is-prop (obj)
  (and (consp obj)
       (eql (car obj) :PROP)))

(defun has-class (obj)
  (member-tree :CLASS obj))

(defun get-root (class)
  (cond ((null class)
	 nil)
	((atom class)
	 class)
	((null (cdr class))
	 (car class))
	(t
	 (get-root (cadr class)))))
	
;; given a semantic form, call out the undeclared variables
;;
;; in general, given an arb list structure, return a list of all
;; variables (as defined by the 'var' predicate) which are not 
;; 'declared' (with either :VAR or :ARG) before they're used.
(defun find-undeclared (form &optional (declared nil))
  (cond ((null form)
	 nil)
	;; if it's an atom and is either not a var or has been previously
	;; declared, we're okay.  otherwise return the baddie.
	((atom form)
	 (if (or (not (var form))
		 (member form declared))
	     nil
	   (list form)))
	((and (consp form)
	      (member (car form) '(:VAR :ARG)))
	 nil)
	(t
	 (append (find-undeclared (car form) declared)
		 (find-undeclared (cdr form) (append declared
						     (flatten-robust (find-declared (car form)))))))))

;; as long as we have something, and it's a cons pair, if the car of it
;; is :VAR or :ARG then the cdr is a declared variable.  otherwise, recurse
;; in.
(defun find-declared (form)
  (when (and form (consp form))
    (if (member (car form) '(:VAR :ARG))
	(cdr form)
      (append (find-declared (car form))
	      (find-declared (cdr form))))))

;; given the 'infile' of parser.log's and the 'outfile' to put the stuff in,
;; calc all the distinct types and their frequencies and write them to the
;; outfile (and print out as a side effect the references to variables which
;; we couldn't find.)
(defun spit-out-types (infile outfile)
  (write-out-list
   (mark-probs
    (sort 
     (get-frequencies
      (mapcar #'(lambda (sa)
		  (output-type (parse-input sa)))
	      (remove-if-not 'grab-sem (get-SAs infile)))
      :test 'equal-mod-vars)
     'semantics-lessp
     :key 'cddr))
   outfile))

;; for now, stick an **ERROR** on the front of the form only if it has
;; any undeclared variables in it.
(defun mark-probs (l)
  (mapcar #'(lambda (form)
	      (if (find-undeclared form)
		  (cons '**ERROR** form)
		form))
	  l))

;; we abuse here that the only things without :CLASS are preds and paths,
;; and that those preds have a constraint field with a single constraint.
(defun get-class (object)
  (when object
    (cons (car object)
	  (if (eql (car object) :PATH)
	      :PATH
	    (or (second (assoc :CLASS (cdr object)))
		(car (second (assoc :CONSTRAINT (cdr object)))))))))

;; given something of type SA, returns a semantics form (just a list structure)
;; where the vars have been replaced by their 'types'
;;
;; note we don't bother to typify the objects when there is no semantic
;; content associated.  Should this be necessary?  Does it make sense to
;; have null semantics in anything but an SA-NULL??
(defun output-type (SA)
  (cons (SA-type SA)
	(when (SA-semantics SA)
	  (output-type-aux (SA-semantics SA) 
			   (typify-objects 
			    (remove-if 'null (SA-objects SA) :key 'car))))))

(defun output-type-aux (sem obj)
  (cond ((null sem)
	 nil)
	((atom sem)
	 (or (get-class (cdr (assoc sem obj)))
	     sem))
	(t
	 (cons (output-type-aux (car sem) obj)
	       (output-type-aux (cdr sem) obj)))))

;; given a list of objects, some of which may refer to each other,
;; replace the references to variables with types in the order
;; that reflects the dependency.
;;
;; the basic loop is to calc the dependicies, "do" the variable 
;; with no dependencies first, and delete him from every one else's
;; list, then continue until all dependencies have been eliminated.
;;
;; note that this should return nil if an object refers to another
;; which isn't found in the list.
(defun typify-objects (obj-list)
  (typify-object-aux (make-graph (remove-if 'null obj-list :key 'car))
		     (remove-if 'null obj-list :key 'car)))

(defun typify-object-aux (dep-graph objects)
  (if dep-graph
      (let* ((thevar (car (find-if 'null dep-graph :key 'cdr)))
	     (thetype (second (assoc :CLASS (cddr (assoc thevar objects))))))
	(if thevar
	    (typify-object-aux
	     (mapcar #'(lambda (node)
			 (cons (car node) (remove thevar (cdr node))))
		     (remove thevar dep-graph :key 'car))
	     (mapcar #'(lambda (obj)
			 (if (eq (car obj) thevar)
			     obj
			   (subst-value thetype thevar obj)))
		     objects))
	  ;; if there's still graph left, but we were unable
	  ;; to find a leaf var, there must be a problem.
	  (format t "unresolvable link(s): ~S~%objects:~S~%" dep-graph objects)))
    objects))
			       
;; our graph representation will be a list of pairs.  Each pair consists
;; of a node and a list of its outgoing edges (where an edge is denoted
;; by the node on the other side)
;; the nodes in the returned graph are just variables.
(defun make-graph (obj-list)
  (mapcar #'(lambda (obj)
	      (cons (car obj)
		    (find-undeclared (cdr obj))))
	  obj-list))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; utilities

(defun subst-value (new orig list)
  (cond ((null list) nil)
	((equal orig list) new)
	((atom list) list)
	(t (cons (subst-value new orig (car list)) (subst-value new orig (cdr list))))))

(defun rotate (l &optional (n 1))
  (if (eq n 0)
      l
    (rotate
     (append (cdr l) (list (car l)))
     (- n 1))))

;; returns an alist, where the cars are the freq's of the cdr's in
;; the orig list
(defun get-frequencies (l &key (test 'equal) (key 'identity))
  (mapcar #'(lambda (generic)
	      (cons (count generic l :test test :key key)
		    generic))
	  (remove-duplicates l :test test :key key)))

;; realize that this flatten removes nil's from the list.
;; this one turns an atom into a list
(defun flatten-robust (list)
  (cond ((null list) nil)
	((atom list) (list list))
	(t (append (flatten-robust (car list)) 
		   (flatten-robust (cdr list))))))

