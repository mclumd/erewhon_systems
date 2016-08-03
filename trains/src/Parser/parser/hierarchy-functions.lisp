(in-package parser)

;; UNIFICATION IN A TYPE HIERARCHY - JR 7/5/94

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; Role: "compiles" a type hierarchy for efficient unification

;; Interface functions:
;; 1. initialization (init-type-hierarchy)
;; 2. inclusion of a new "compiled" hierarchy into the global type 
;;    hierarchy represented as a hash table:
;;    (compile-hierarchy new-hierarchy)
;;    External representation of the new type hierarchy 
;;    new-hierarchy (noun/verb/preposition):
;;    - a nonleaf subtree is a list (node-label [child1 child2 ...])
;;    - a leaf is a list (leaf-label)
;;    E.g. (ANYTHING (PHYS-PHENOM) (MENTAL-PHENOM))
;;
;; 3. subtype unification:
;;    (subtype feat type1 type2)
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;                                 Global Variables
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(defvar *type-hash-table* nil "hash table that comprises type hierarchies")
(defvar *max-no-types* 1 "no. of distinct classes in all the hierarchies compiled")
(defvar *trap-bad-hash-entries* nil)
(defvar *hierarchical-features* nil)
(defvar *ontology-list* nil)


(defun init-type-hierarchy ()
  (setq *type-hash-table* (make-hash-table)))

(defun Declare-hierarchical-features (ll)
  (setq *hierarchical-features* ll))

;; features are assumed to be non-hierarchical unless
;;  explicitly declared.

(defun hierarchical-feature-p (feat)
  (member feat *hierarchical-features*))
	
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;                              Hierarchy access functions
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(defun h-root-class (h)
  "root name of subhierarchy h"
  (car h))

(defun h-sons (h)
  "list of children subhierarchies"
  (cdr h))

(defun b-min (h-element)
  "left value of bracket interval (min)"
  (car h-element))

(defun b-max (h-element)
  "right value of bracket interval (max)"
  (cadr h-element))


;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;                             Build Internal Rep
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(defun dress-up-hierarchy (h)
  "dresses up each node in one supplementary list"
  (cond ((atom h) (list h))
	(t (cons (list (car h))
		 (mapcar #'dress-up-hierarchy (cdr h))))))


(defun set-bracket (list n)
  "sets the number brackets for the current element in a hierarchy, list"
  (nconc list (cons n nil))
  n)
  
	     
(defun bracket-hierarchy (h n)
  "sets the number brackets for a hierarchy"
  (cond ((null (h-sons h))
	 (set-bracket (h-root-class h) n)
	 (set-bracket (h-root-class h) n))
	(t (set-bracket (h-root-class h) n)
	   (dolist (son (h-sons h) (set-bracket (h-root-class h) (- n 1)))
	     (setq n (+ (bracket-hierarchy son n) 1))))))

(defun expand-hash-hierarchy (h)
  "add to *type-hash-table* entries representing type hierarchy h"
  (cond ((null h))
	(t (if (gethash (car (h-root-class h)) *type-hash-table*)
	       (parser-warn "WARNING: type-hash-table already contains ~A~%" 
		       (car (h-root-class h))))
	   (setf (gethash (car (h-root-class h)) *type-hash-table*) 
		 (cdr (h-root-class h)))
	   (if (h-sons h)
	       (mapc #'expand-hash-hierarchy (h-sons h))))))


(defun compile-hierarchy (h)
  "transforms the hierarchy in a hash table"
  ;; external format -> internal format -> brackets -> hash table rep
  (let ((hierarchy (dress-up-hierarchy h)))
    (setq *max-no-types* (+ (bracket-hierarchy hierarchy *max-no-types*) 1))
    (expand-hash-hierarchy hierarchy)))


;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;                             Search/Unification
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 (setq *trap-bad-hash-entries* nil)
(defun h-search (element type-hash)
  "search for element in hash table type-hash"
   (let ((elem (gethash element type-hash)))
    (when (null elem)
      (parser-warn "WARNING: type-hash-table doesn't contain ~A~%" element)
      (if *trap-bad-hash-entries* (break))
      )
    elem))


(defun more-general (h-p1 h-p2)
  "determines the more general, if any, of two hierarchy predicates"
  (if (and (<= (b-min h-p1) (b-min h-p2))
	   (<= (b-max h-p2) (b-max h-p1))
	   )
      t
    nil))


(defun subtype (feat sub super)
  "If the feature is one that was declared to be hierarchical, check
type compatibility and return the most specific or nil.  Otherwise,
compare the two values with eq and return nil or their shared value."
  ;; Note: sub, super may come from different hierarchies
  (if (hierarchical-feature-p feat)
      (let ((psub (h-search sub *type-hash-table*))
	    (psuper (h-search super *type-hash-table*)))
	(cond ((or (null psub) (null psuper)) nil)
	      ((more-general psuper psub) sub)
	      (t nil)))
    (if (eq sub super)
	sub)))


	    


;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;                                       Tests
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#+:nil
(progn 
  (init-type-hierarchy)
  (compile-hierarchy *ontology-list*)
  (subtype 'phys-phenom 'mental-phenom)
  (subtype 'anything 'warehouse)
  (subtype 'container 'boxcar)

  (setq h1 (dress-up-hierarchy *ontology-list*))
  (bracket-hierarchy h1 1)
  (compile-hierarchy h1)
)

;; returns nodes in hierarchy "hierarch" starting below the root
;; and on the path to "item" (but not including item)
;; "wherefrom" is the path followed so far
;; to get the current "hierarch".  
;; 
;; *ontology-list* is in the correct format for "hierarch"
;; hierarch should be a nested list where the first element
;; is a parent name and the following elements should be
;; hierarchies themselves (i.e. first element is a node
;; name and the rest are hierarchies or nil) -Mark
;; 
(defun path (item hierarch wherefrom)
  (if (atom (first hierarch))

      ;; check if parent is equal to item
      (if (equal (first hierarch) item) 
	  wherefrom
	
	;; category does not equal item so search its children
	(if (cdr hierarch)
	    (do* ((t_hierarch (cdr hierarch) (cdr t_hierarch))
		  (path-list (path item (first t_hierarch)
				   (append (list (first hierarch)) wherefrom ))
			     (path item (first t_hierarch)
				   (append (list (first hierarch)) wherefrom))))
		((or (null t_hierarch) path-list) path-list))))
    
    ;; investigating child of some parent. children are lists
    (do* ((t_hierarch hierarch (cdr hierarch))
	  (path-list (path item (first t_hierarch) wherefrom)
		     (path item (first t_hierarch) wherefrom)))
	((or (null t_hierarch) path-list) path-list))))
		     
;; returns the most specific ancestor of SEM1 and SEM2 in *ontology-list*
;; or returns ANY-SEM if they are disjoint. -Mark
;;
(defun intersect (SEM1 SEM2)
  (let ((path1 (path SEM1 *ontology-list* '()))
	(path2 (path SEM2 *ontology-list* '())))

    ;; try to find most specific node on path1 that is in path2
    (do* ((path-list1 path1 (cdr path-list1))
	  (element (first path-list1) (first path-list1)))
	((or (null element) (find element path2))
	 (if element element 'ANY-SEM)))))
