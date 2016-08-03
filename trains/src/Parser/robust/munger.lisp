;;;  Other packages/files needed:  types.lisp, parse.lisp, templates.txt, 
;;;  parser package.

;;;  This file contains functions to take a compound communications act and
;;;  combine its component speech acts in various ways.  

;______________________________________________________________________________
;;;  Package and global variable definitions.

;; Declaration of being in the parser package.

(in-package parser)

(defun init-munger ()
 (setf *templates* (parse-template-file *template-file*)))

;;  Where to find verb-class (and other) templates.
 
(defvar *template-file* "robust/templates.lisp")


;;  Global variable for the lookup table.

(defvar *table*)

;______________________________________________________________________________
;;;  Top-level functions

;;  Returns "parser-like" output for best output only.

(defun check (lfs &key (simplify 'simplify) (munge 'munge) (speech-act-id 'sa-id))
  (let ((temp 
	  (fix-cca 
	   (mapcar #'parse-input lfs) :simplify simplify :munge munge :speech-act-id speech-act-id)))
    (let ((result nil))
      (dolist (element temp result)
      (if (CCA-p element)
	  (setf result (append result (list (break-CCA element))))
	(setf result (append result (list (break-SA element)))))))))

;; Fix-cca takes as input a list of (hopefully, related) compound communcation
;; acts.  It sets up the templates, finds all possible combinations of the
;; speech-acts within each CCA, and then sorts the result and takes the best 
;; five.  Currently the only measure of "best" is the number of speech acts.
;; The options allow you to chose which robust processes you wish to perform:
;;     s - simplification
;;     m - munging
;;     i - speech-act identification

(defun fix-cca (ccas &key (simplify 'simplify) (munge 'munge) (speech-act-id 'sa-id))
  (let* ((simplified (if simplify (simplification ccas) ccas))
	 (temp1 (remove-if-not #'cca-p simplified))
	 (temp (mapcar #'(lambda (x) (cons '(0) x)) temp1))
	 (munged (if munge (find-combinations temp) temp))
         (sorted (best-measure munged))
	 (remove-dups (remove-duplicates sorted :test #'CCA-equal))
         (right-type (find-right-type remove-dups))
	 (sa-idd (if speech-act-id (sa-id-all (append (remove-if #'cca-p simplified) right-type))
		       (append (remove-if #'cca-p simplified) right-type))))
    (subseq sa-idd 0 5)))

;______________________________________________________________________________
;;;  Simplification functions

(defun simplification (ccas)
  (dolist (element ccas)
    (cond ((cca-p element)
	   (dolist (item (CCA-acts element))
	     (simplify item *templates*)))
	  ((sa-p element)
	   (simplify element *templates*))
	  (t (error "Not parser output"))))
  ccas)
	     
;; Simplify takes a speech-act and tries to simplify it using the patterns.

(defun simplify (sa patterns)
  (if patterns
      (let ((temp (apply-pattern sa (first patterns))))
	(cond  ((and temp (sem-equal temp sa))
		(simplify temp (rest patterns)))
	       ((and temp (not (sem-equal temp sa)))
		(simplify temp patterns))
	       (t (simplify sa (rest patterns)))))
    sa))

;; Apply-pattern takes a speech-act and a rule.  If the simplify-conditions 
;; are met, the simplify-actions are performed.
(defun apply-pattern (thing rule)
  (if (template-type rule)
      ; There is a verb-class - make sure the speech-act's verb matches 
      ; and the simplify-conditions are met.
      (when (and (propp (SA-semantics thing))
		 (match-verb 
		  (template-type rule)
		 (rest (find-cl (apply (template-place rule) (list thing))))) 
		 (true (template-simplify-conditions rule) thing))
	(dolist (element (template-simplify-actions rule))
	  (apply-fun element thing))
	thing)
    ; There is no verb class - make sure the simplify-conditions are met.
    (when (true (template-simplify-conditions rule) thing)
      (dolist (element (template-simplify-actions rule))
	(apply-fun element thing))
      thing)))

;_____________________________________________________________________________
;;;  "Munging" functions

;;;  Algorithm:
;;;  for (each CCA in a list of CCAs)  			*find-combinations
;;;   for (each SA in that CCA)  			*find-combinations
;;;    if (semantics of SA is a proposition)  		*munge
;;;       for (each template matching SA)		*munge
;;;        if (there are unfilled slots in the SA)	*munge
;;;           if (there is another SA in the CCA matching the unfilled slot)
;;;              combine the SA and the other SA	*fill-in
;;;           if (there is another SA in the CCA of the same verb class as SA)
;;;              try to combine the SA and the other SA	*fill-in
;;;   fix the other slots in each CCA			*fill-in/adjust
;;;  Note that two propositions in the same verb class will not be combined
;;;  unless one (or both) are missing parts and one fills in one of the missing
;;;  parts of the other.
;;;  Note that there is no ordering imposed on combinations.  
;;;  Note that there is currently no attempt made to link a "no-semantics" 
;;;  speech-act with any other speech-act.

 
;; Given a list of possible compound communications acts, this passes each 
;; speech-act in each act in turn to "munge".  The process continues until 
;; no more changes can be made.

(defun find-combinations (list-of-possibles)
  (let ((result nil))
    (dolist (element list-of-possibles result) 	;for each CCA
      (dolist (item (CCA-acts (rest element)))	;for each SA in that CCA
	(make-lookup-table (list item))
	(setf result (append (munge item element) result)))) ;try to munge it.
    (if result					;continue until no more changes
						;are possible.
        (append list-of-possibles (find-combinations result))
      list-of-possibles)))

;; Given a speech-act, munge finds all possible templates matching the semantic
;; form of the act.  Then it passes each edge in that template which is not
;; realized in the speech-act to fill-in.

(defun munge (speech-act ccact)
  (let ((sem (SA-semantics speech-act)) (result nil))
     (when (and (listp sem) (equal (first sem) ':PROP))
	    ;when the semantic form is a proposition
       (dolist (element (find-templates sem) result)
	 (when (match element speech-act)
	 (dolist (item (template-edges element))
		 (let ((current (assoc (edge-type item) (find-edges sem))))
		   (when (or (not current) (not (third current)))
	       (setf result (append (fill-in item current speech-act ccact) result))))))))))

;; "Fill-in" takes a template-requirement, a speech-act and a compound-
;; communications-act (not containing the speech-act).  It looks around in the
;; later speech acts for something matching the template-requirement.  For 
;; each matching node it finds, it combines those two speech-acts.  If we
;; replace remove-till with remove in the first dolist it will combine with 
;; any other speech-act.

(defun fill-in (template-edge sa-edge speech-act ccact)
  (let ((result nil) (newsem nil) (n 1))
    (dolist (element (remove speech-act (CCA-acts (rest ccact))) result)
      (setf n (+ n 1))
	 ; if the element's semantic form is a variable, and the variable
	 ; fills the "hole" in the speech act, combine the element with
	 ; the speech-act.    
      (cond ((and (var (SA-semantics element))
		  (or (not sa-edge) (not (third sa-edge))))
		     (make-lookup-table (list speech-act element))
	     (let ((cl1 (find-cl (SA-semantics element)))
		   (cl2 (edge-node template-edge)))
	       (when (and (equal (first cl1) (first cl2))
			  (or 
			   (PARSER::subtype 'sem 
					    (dekeywordify (rest cl1)) 
					    (dekeywordify (rest cl2)))
			   (equal ':PROP (first cl1))))
	       (setf newsem (alter-edge (SA-semantics element) (edge-type template-edge) (SA-semantics speech-act)))
			       
	       (push (adjust (make-new-cca element speech-act newsem ccact) n) result))))

	 ; if the element's semantic form is a proposition, if the proposition
	 ; has the same verb class (may want to alter this later) than the
         ; speech-act, and if the constraints don't clash, then combine
	 ; the element with the speech-act.  This only happens if the element
	 ; fills a "hole" in the proposition.
	    ((and (propp (SA-semantics element)) 
		  (or (not sa-edge) (not (third sa-edge)))
		  (assoc (edge-type template-edge) (find-edges (SA-semantics element))))
		   (make-lookup-table (list speech-act element))
		   (setf newsem (match-props (SA-semantics speech-act) (SA-semantics element)))
		   (if newsem
		       (push (adjust (make-new-cca element speech-act newsem ccact) n) result)))
	    (t nil)))))

;______________________________________________________________________________
;;;  Speech-act identification functions

;; *templates* is created at the startup of the parser.

(defun sa-id-all (ccas)
  (dolist (element ccas)
    (cond ((cca-p element)
	   (dolist (item (CCA-acts element))
	     (sa-id item *templates*)))
	  ((sa-p element)
	   (sa-id element *templates*))
	  (t (error "Not parser output"))))
  ccas)
	     
;; Simplify takes a speech-act and tries to simplify it using the patterns.

(defun sa-id (sa patterns)
  (if patterns
      (let ((temp (apply-sa-id-pattern sa (first patterns))))
	(cond  ((and temp (sem-equal temp sa))
		(sa-id temp (rest patterns)))
	       ((and temp (not (sem-equal temp sa)))
		(sa-id temp patterns))
	       (t (sa-id sa (rest patterns)))))
    sa))

;; Apply-rule takes a speech-act and a rule.  If the conditions are met,
;; the actions are performed.
(defun apply-sa-id-pattern (thing rule)
  (if (template-type rule)
      ; There is a verb-class - make sure the speech-act's verb matches 
      ; and the conditions are met.
      (when (and (propp (SA-semantics thing))
		 (match-verb 
		  (rest (find-cl (SA-semantics thing))) 
		  (template-type rule))
		 (true-here (template-sa-id-conditions rule) thing))
	(dolist (element (template-sa-id-actions rule))
	  (apply-fun element thing))
	thing)
    ; There is no verb class - make sure the conditions are met.
    (when (true-here (template-sa-id-conditions rule) thing)
      (dolist (element (template-sa-id-actions rule))
	(apply-fun element thing))
      thing)))

;______________________________________________________________________________
;;;  Lookup table functions 


;; Insert puts an identifier-object pair into a "symbol table".

(defun insert (list)
  (cond ((not (assoc (first list) *table*)) ;if not in table
         (push list *table*))
	 ; if variable is now associated with a different object.
        ((not (equal (second (assoc (first list) *table*)) (second list)))
	 (setf *table* (swap list (assoc (first list) *table*) *table*)))
	(t nil)))
      
;; Remove-table takes something out of a table and returns what it took out.

(defun remove-table (var)
  (let ((temp (assoc var *table*)))
    (setf *table* (remove temp *table*))
    (if (var (second temp))
	(remove-table (second temp))
        temp)))

;; Lookup looks an item up in a table, given a variable.  If the variable it 
;; is given is associated with another variable, it looks that variable up.

(defun lookup (var)
  (let ((temp (assoc var *table*)))
    (if (var (second temp)) (lookup (second temp)) temp)))

;; Update is for when paths and defs are combined.  It alters all old 
;; references to "point to" newitem, and then inserts newitem in the table.
	
(defun update (list-of-vars newitem)
  (dolist (element list-of-vars)
    (setf *table* (swap (list element (first newitem)) (assoc element *table*) *table*))) 
  (insert newitem))

;; Make-lookup-table initializes a lookup table.  The assumption is made that
;; at this stage the same variable does not point to two different objects.

(defun make-lookup-table (list-of-acts)
  (setf *table* nil)
  (dolist (element list-of-acts)
    (dolist (item (SA-objects element))
      (insert item))))

;______________________________________________________________________________
;;;  Combining speech-acts functions


;; Given two speech-acts to combine, this combines them and makes a new
;; compound communications act.

(defun make-new-cca (speech-act1 speech-act2 newsem oldcca)
  (let ((new (copy-CCA (rest oldcca))))
    (if (equal (first-one speech-act1 speech-act2 (CCA-acts (rest oldcca))) speech-act1)
	  (setf (CCA-acts new) 
	    (swap (combine-acts speech-act2 speech-act1 newsem)
		  speech-act1 
		  (remove speech-act2 (CCA-acts (rest oldcca)) :test #'equal)))
          (setf (CCA-acts new)
	    (swap (combine-acts speech-act1 speech-act2 newsem)
		  speech-act2
		 (remove speech-act1 (CCA-acts (rest oldcca)) :test #'equal)))) 
	
  (cons (first oldcca) new)))

;; If two speech acts are supposed to be combined, this does it. It takes the
;; two speech acts, and their combined semantic form, and returns a new 
;; speech act.

(defun combine-acts (act1 act2 newsem)
  (let ((newact (make-SA)))
	(setf (SA-semantics newact) newsem)
	(combine-acttype act1 act2 newact)
	(combine-focus act1 act2 newact)
        (combine-objects act1 act2 newact)
	(combine-noise act1 act2 newact)
	(combine-social-context act1 act2 newact)
	(combine-reliability act1 act2 newact)
	(combine-mode act1 act2 newact)
	(combine-syntax act1 act2 newact)
        (combine-setting act1 act2 newact)
	(combine-input act1 act2 newact)
	newact))

;; Combine-acttype currently uses a simplified hierarchy (see the variable
;; *acttypes*) to determine which act-type to choose.  We may use the 
;; hierarchy in the parser, or make one of our own.

(defun remove-sa (acttype)
  (if (equal acttype 'SPEECH-ACT)
      (read-from-string (string acttype))
      (read-from-string (string-left-trim "SA-" (string acttype)))))

(defun combine-acttype (act1 act2 newact)
  (let* ((temp1 (remove-sa (SA-type act1))) 
	 (temp2 (remove-sa (SA-type act2)))
	 (temp (PARSER::compat 'sem temp1 temp2)))
    (cond ((equal temp temp1)
	   (setf (SA-type newact) (SA-type act1)))
	  ((equal temp temp2)
	   (setf (SA-type newact) (SA-type act2)))
	  (t (setf (SA-type newact) (SA-type act1))))))

;; Currently, combine-focus takes the new focus to be the focus of the munged
;; speech-act which has highest priority.

(defun combine-focus (act1 act2 newact)
  (cond ((equal (SA-focus act1) NIL)	
	 (setf (SA-focus newact) (first (lookup (SA-focus act2))))) 
	((equal (SA-focus act2) NIL)		   
	 (setf (SA-focus newact) (first (lookup (SA-focus act2))))) 
	((equal (SA-type newact) (SA-type act1))   
	 (setf (SA-focus newact) (first (lookup (SA-focus act1))))) 
	(t (setf (SA-focus newact) (first (lookup (SA-focus act2))))))) 

;; Combine-objects removes any "pointer to" items in the lookup table and 
;; assigns the result to (SA-objects newact).

(defun combine-objects (act1 act2 newact)
  (let ((result nil))
    (dolist (element *table* result)
      (if (not (var (second element)))
        (push element result)))
    (setf (SA-objects newact) result)))

;;  To combine noise, make a list of noise words.

(defun combine-noise (act1 act2 newact)
  (setf (SA-noise newact) (append (SA-noise act1) (SA-noise act2))))

;; Combine social-context just puts in all of the social contexts for now; 
;; this should perhaps eventually be not quite so inclusive. 

(defun combine-social-context (act1 act2 newact)
  (let ((sc1 (SA-social-context act1)) (sc2 (SA-social-context act2)))
	(cond ((not sc1)
	       (setf (SA-social-context newact) sc2))
	      ((not sc2)
	       (setf (SA-social-context newact) sc1))
	      (t (setf (SA-social-context newact) (list sc1 sc2))))))
 
;; Currently, combine-reliability takes the average of the reliabilities of the
;; two munged speech-acts.

(defun combine-reliability (act1 act2 newact)
  (setf (SA-reliability newact) (float (/ (+ (SA-reliability act1) (SA-reliability act2)) 2))))

;; Currently, combine-mode simply takes the mode of the first act, because 
;; it is assumed that each turn is only made in one mode.
 
(defun combine-mode (act1 act2 newact)
  (setf (SA-mode newact) (SA-mode act1)))

;; This fails silently if there is a clash between the fillers of two semantic
;; slots, e.g. if SUBJECT(1) <> SUBJECT(2).  That's because I'm not sure which
;; one to choose in that case.

(defun combine-syntax (act1 act2 newact)
  (let ((result (SA-syntax act2)))
    (dolist (element (SA-syntax act1) result) 
      (let ((temp (assoc (first element) result)))
	       ;if some syntactic item is not in the result, put it in.
	(cond ((not temp) (append (list element) result))
	       ;if some syntactic slot in the result is unfilled and 
	       ;we can fill it, do so.
	      ((not (rest temp)) (setf result (swap element temp result)))
	       ;if some syntactic slot has a variable, then make sure its the
	       ;right variable and that there is no "clash".
	      ((var (rest temp)) 
 		 (when (var (rest element))
		   (when (equal (lookup (rest element)) (lookup (rest temp)))                       (setf result (swap (cons (first temp) (first (lookup (rest temp)))) temp result))))) ; fail silently - not sure what to do here! 
	       ;otherwise, do nothing.
	      (t nil))))   
    (setf (SA-syntax newact) result)))
	    
;; Currently, combine-setting simply takes all the settings.

(defun combine-setting (act1 act2 newact)
  (let ((sc1 (SA-setting act1)) (sc2 (SA-setting act2)))
	(cond ((not sc1)
	       (setf (SA-setting newact) sc2))
	      ((not sc2)
	       (setf (SA-setting newact) sc1))
	      (t (setf (SA-setting newact) (list sc1 sc2))))))

;; Combine-input makes a list of the inputs of the two combined speech acts.

(defun combine-input (act1 act2 newact)
  (cond ((equal '(NOT-AVAILABLE) (SA-input act1))
	 (setf (SA-input newact) (SA-input act2)))
	((equal '(NOT-AVAILABLE) (SA-input act2))
	 (setf (SA-input newact) (SA-input act1)))
	(t (setf (SA-input newact) (append (SA-input act2) (SA-input act1))))))

;______________________________________________________________________________
