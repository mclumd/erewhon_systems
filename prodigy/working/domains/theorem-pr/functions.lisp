;;Dec 10 1993  This version actually RUNS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;The really needed structures and functions for theorem proving
;; STRUCTURES for objects TERMs, FORMULAs,SUBSTITUTIONs.
;; Later we could add structures for VARIABLEs and CONSTANTs
;; (functionsymbols>) to store more information
;;ASS-SETs are just lists.
;;functions which are up to now not necessa

;;Input of a formula-variable has to be a list such as (F1)

;;Input of an atom has to be of the form (R (a b)), (R (f(a))), or (= (a) (f(b)))

;;Superstructure Expression for term and formula (for substitution, unification)
(defstruct EXPRESSION
  (symbol nil);maybe could be filled with the input-list
  (top nil) ;leading symbol
  (arguments nil)
  (type nil) ;for terms:var (have only top), func (constants are 0-ary functions)
              ;for formulas: variable, atom, appl (not really necessary).
              ;Formula-CONSTANTS are atoms with arguments=() and top=some symbol
              ;Formula-VARIABLES are type:variable, arguments: (), top: a symbol
  (mark nil))  ;Constants introduced for existential variables (by
	    ;exists-intro) are not nil in term-mark.
              

;;Structure for terms
(defstruct (TERM (:include expression)
		 (:print-function print-term)))


;;Structure for formulas
;;maybe later structures for applications and abstractions. Also later
;;an additional features "BOUND VARIABLE" in a formula
(defstruct (FORMULA (:include expression)
		 (:print-function print-formula)))

(defstruct (SUBST
	     (:print-function print-subst))
  (symbol nil)
  (domain nil)
  (codomain nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; *set-table* is an assoc list that maps symbols (used in
;;; prodigy) to the structures they represent.

(defvar *set-table* nil
  "Assoc list of symbols to their corresponding lists of formula-SYMBOLS")

(defvar *formula-table* nil)
(defvar *term-table* nil)
(defvar *subst-table* nil)


(defvar *f-number*)
(setf *f-number* 0)

;;creates a new formula-variable symbol Fn 
(defun make-new-formula-symbol ()
  (declare (special *f-number*))
  (setf *f-number* (+ 1 *f-number*))
  (let ((*print-case* :upcase))
  (intern(format nil "FORMULA~A" *f-number*))))

(defvar *set-number*)
(setf *set-number* 0)

;;creates a new set symbol setn 
(defun make-new-set-symbol ()
  (declare (special *set-number*))
  (setf *set-number* (+ 1 *set-number*))
  (let ((*print-case* :upcase))
  (intern(format nil "SET~A" *set-number*))))

(defvar *term-number*)
(setf *term-number* 0)

;;creates a new set symbol setn 
(defun make-new-term-symbol ()
  (declare (special *term-number*))
  (setf *term-number* (+ 1 *term-number*))
  (let ((*print-case* :upcase))
  (intern(format nil "TERM~A" *term-number*))))

(defun get-new-variable ()
  (intern (gensym "VAR")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; These are the functions that use the tables above to associate
;;; symbols with structures
;SET-TABLE
;;;;;;;;;
#|
(defun make-new-formula-symbol ()
  (intern (gensym "FORMULA")))


(defun make-new-term-symbol ()
  (intern (gensym "TERM")))


(defun make-new-set-symbol ()
  (intern (gensym "SET")))
|#
;;Bisher ist also jeder eintrag eine liste aus dem set-symbol und
;;FORMULA-SYMBOLS und nicht der Liste der formula-symbols.
;;Auswirkungen auf create-set (HYP-INTRO) wo noch?????

(defun add-to-set-table (symbol structure)
  (push (cons symbol structure) *set-table*))

;;returns a list of formula-SYMBOLS
(defun lookup-set (symbol)
  (cdr (assoc symbol *set-table*)))

(defun find-set-already (set)
  (dolist (entry *set-table* nil)
    (if ;;;(and (= (length set) (length (cdr entry))));;wegen mehrfach-vorkommen
	     (and (null (set-difference set (cdr entry)))
		  (null (set-difference (cdr entry) set)))
	(return (car entry)))))
;;;;;;;;;;;
;FORMULA-TABLE
;;;;;;;;;;;

(defun add-to-formula-table (symbol structure)
  (push (cons symbol structure) *formula-table*))

(defun lookup-formula (symbol)
  (cdr (assoc symbol *formula-table*)))


;;this function gets a formula-structure and returns either a symbol
;;which is associated with this structure in *formula-table* or a new
;;symbol which is then put into the table. It returns this symbol.
(defun find-formula-already (fo)
  (dolist (entry *formula-table* nil)
    (if (formula-equal fo (cdr entry))
	(return (car entry)))))

;;;;;;;;;;
;TERM-TABLE
;;;;;;;;;;;

(defun add-to-term-table (symbol structure)
  (push (cons symbol structure) *term-table*))

(defun lookup-term (symbol)
  (cdr (assoc symbol *term-table*)))


;;;;;;;;;;
;;; This function should return the term symbol for the term, if it
;;; already exists in the term table.
(defun find-term-already (term)
  (dolist (entry *term-table*)
    (if (term-equal term (cdr entry))
	(return-from find-term-already (car entry))))
  nil)

;;;;;;;;;;
;EXPESSIONS
;;;;;;;;;;
    
(defun lookup-expression (symbol)
  (cond ((term-symbol-p symbol) (lookup-term symbol))
	((formula-symbol-p symbol) (lookup-formula symbol))))

(defun find-expression-already (expr)
  (cond ((term-p expr) (find-term-already expr))
	((formula-p expr) (find-formula-already expr))))

;;;;;;;;;;;
;SUBST-TABLE
;;;;;;;;;;;

(defun make-new-subst-symbol ()
  (intern (gensym "SUBST")))

(defun lookup-subst (symbol)
  (cdr (assoc symbol *subst-table*)))

(defun add-to-subst-table (symbol structure)
  (push (cons symbol structure) *subst-table*))


;;; This function should return the subst symbol for the subst, if it
;;; already exists in the subst-table.
(defun find-subst-already (subst)
  (dolist (entry *subst-table*)
    (if (subst-equal subst (cdr entry))
	(return-from find-subst-already (car entry))))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; basic predicates on terms and formulas

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;term-equal does not check the symbol of the term up to now. It treats
;;variables as different from constants. 
(defun term-equal (t1 t2);;;;would just (equalp t1 t2) work as well???
  (and (term-p t1)
       (term-p t2)
       (equal (term-top t1) (term-top t2))
       (equal (term-type t1) (term-type t2))
       (= (length(term-arguments t1)) (length (term-arguments t2)))
       (every #'(lambda (x y) (term-equal x y))
	      (term-arguments t1) (term-arguments t2))))


;;formula-equal does not check the symbol of the formula up to now.
(defun formula-equal (f1 f2);;;;would just (equalp t1 t2) work as well???
  (and (formula-p f1)
       (formula-p f2)
       (equal (formula-top f1) (formula-top f2))
       (equal (formula-type f1) (formula-type f2))
       (= (length(formula-arguments f1)) (length (formula-arguments f2)))
       (every #'(lambda (x y) (expression-equal x y))
	      (formula-arguments f1) (formula-arguments f2))))

;;expression-equal does not check the symbol of the formula up to now.
(defun expression-equal (f1 f2);;;;would just (equalp t1 t2) work as well???
  (and (expression-p f1)
       (expression-p f2)
       (equal (expression-top f1) (expression-top f2))
       (equal (expression-type f1) (expression-type f2))
       (= (length(expression-arguments f1)) (length (expression-arguments f2)))
       (every #'(lambda (x y) (expression-equal x y))
	      (expression-arguments f1) (expression-arguments f2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun subst-equal (t1 t2)
  (let ((result t)
	(res nil)
	(liste1 (mapcar #'(lambda  (x y) (list x y))
				   (subst-domain t1)
				   (subst-codomain t1)))
	(liste2 (mapcar #'(lambda  (x y) (list x y))
				   (subst-domain t2)
				   (subst-codomain t2))))
    (dolist (x liste1)
      (unless (member 'a (mapcar #'(lambda (y)
				     (when (and (term-equal (first x) (first y))
						(term-equal (second x) (second y)))
				       (setf res 'a)))
				 liste2))
		      (setf result nil)))
    (dolist (x liste2)
      (unless (member 'a (mapcar #'(lambda (y)
				     (when (and (term-equal (first x) (first y))
						(term-equal (second x) (second y)))
				       (setf res 'a)))
				 liste1))
		      (setf result nil)))    
    result))

;;;;;;the next predicates are for use in Prodigy. They take symbols as
;;;;;;inputs and return T or nil.

(defun term-var-p (term-sym)
  (let (term)
    (and (symbolp term-sym)
	 (setf term (lookup-term term-sym))
	 (equal (term-type term) 'var))))

(defun term-constant-p (term-sym)
  (let (term)
    (and (symbolp term-sym)
	 (setf term (lookup-term term-sym))
	 (equal 'func (term-type term))
	 (equal () (term-arguments term)))))
;;;;;
(defun is-impl-p (F-sym)
  (let (F)
    (and (symbolp F-sym)
	 (setf F (lookup-formula f-sym))
	 (equal 'implf (formula-top F)))))

;;implication-p is for Prodigy and takes a symbol as input. If this is
;;a variable, then it returns a list of all implications, if it is
;;bound, it returns T or F.

(defun implication-p (F-sym)
  (cond ((p4::strong-is-var-p F-sym)
	 (let ((impllist nil))
	   (dolist (x *formula-table* impllist)
	     (when (is-impl-p (first x))
	       (push (first x) impllist)))))
	(t (is-impl-p F-sym))))
;;;;

;;is-equiv-p takes a symbol as input and returns T or F
(defun is-equiv-p (F-sym)
  (let (F)
    (and (symbolp f-sym)
	 (setf f (lookup-formula f-sym))
	 (equal 'equivf (formula-top F)))))

;;equivalence-p is for Prodigy and takes a symbol as input. If this is
;;a variable, then it returns a list of all equivalences(CHANGE to
;;:equivalences in state), if it is bound, it returns T or F.
(defun equivalence-in-state (F-sym)
  (cond ((p4::strong-is-var-p F-sym)
	 (remove nil (mapcar #'(lambda (lit)
		       (when (is-equiv-p
			      (aref (p4::literal-arguments lit) 1))
			 (aref (p4::literal-arguments lit) 1)))
	 (p4::give-me-nice-state '(follows)))))
	(t (is-equiv-p F-sym))))

 
;;This is not necessary anymore when APPLY-EQUIVoperator is changed
(defun equivalence-p (F-sym)
  (cond ((p4::strong-is-var-p F-sym)
	 (let ((equivlist nil))
	   (dolist (x *formula-table* equivlist)
	     (when (is-equiv-p (first x))
	       (push (first x) equivlist)))))
	(t (is-equiv-p F-sym))))
;;;;

(defun is-conj-p (F-sym)
  (let (F)
    (and (symbolp f-sym)
	 (setf f (lookup-formula f-sym))
	 (equal 'andf (formula-top F)))))

;;conjunction-p is for Prodigy and takes a symbol as input. If this is
;;a variable, then it returns a list of all conjunctions, if it is
;;bound, it returns T or F.

(defun conjunction-p (F-sym)
  (cond ((p4::strong-is-var-p F-sym)
	 (let ((conjlist nil))
	   (dolist (x *formula-table* conjlist)
	     (when (is-conj-p (first x))
	       (push (first x) conjlist)))))
	(t (is-conj-p F-sym))))
;;;;;

(defun is-disj-p (F-sym)
  (let (F)
    (and (symbolp f-sym)
	 (setf f (lookup-formula f-sym))
	 (equal 'orf (formula-top F)))))

;;disjunction-p is for Prodigy and takes a symbol as input. If this is
;;a variable, then it returns a list of all disjunctions, if it is
;;bound, it returns T or F.

(defun disjunction-p (F-sym)
  (cond ((p4::strong-is-var-p F-sym)
	 (let ((disjlist nil))
	   (dolist (x *formula-table* disjlist)
	     (when (is-disj-p (first x))
	       (push (first x) disjlist)))))
	(t (is-disj-p F-sym))))
;;;;;

(defun is-negation-p (F-sym)
  (let (F)
    (and (symbolp f-sym)
	 (setf f (lookup-formula f-sym))
	 (equal 'notf (formula-top F)))))

;;negation-p is for Prodigy and takes a symbol as input. If this is
;;a variable, then it returns a list of all negations, if it is
;;bound, it returns T or F.

(defun negation-p (F-sym)
  (cond ((p4::strong-is-var-p F-sym)
	 (let ((neglist nil))
	   (dolist (x *formula-table* neglist)
	     (when (is-negation-p (first x))
	       (push (first x) neglist)))))
	(t (is-negation-p F-sym))))
;;;;;

(defun is-Aquant-p (F-sym)
  (let (F)
    (when (and (symbolp f-sym)
	       (setf F (lookup-formula f-sym))
	       (listp (formula-top F)))	 
      (equal 'forallf (first (formula-top F))))))

;;Aquantified-p is for Prodigy and takes a symbol as input. If this is
;;a variable, then it returns a list of all Aquantified, if it is
;;bound, it returns T or F.
;;;
(defun Aquantified-p (F-sym)
  (cond ((p4::strong-is-var-p F-sym)
	   (remove nil (mapcar #'(lambda (lit)
		       (when (is-Aquant-p
			      (aref (p4::literal-arguments lit) 1))
			 (aref (p4::literal-arguments lit) 1)))
	 (p4::give-me-nice-state '(follows)))))
	(t (is-Aquant-p F-sym))))
;;;;;;;
;;;;;;;old stuff
;;;;;
;(defun is-Aquant-p (F-sym)
;  (let (F)
;    (when (and (symbolp f-sym)
;	       (setf F (lookup-formula f-sym))
;	       (listp (formula-top F)))	 
;      (equal 'forallf (first (formula-top F))))));
;
;;Aquantified-p is for Prodigy and takes a symbol as input. If this is
;;a variable, then it returns a list of all Aquantified, if it is
;;bound, it returns T or F.
;
;(defun Aquantified-p (F-sym)
;  (cond ((p4::strong-is-var-p F-sym)
;	 (let ((aquantlist nil))
;	   (dolist (x *formula-table* aquantlist);hier muss man durch
;						 ;den state gehen
;	     (when (is-Aquant-p (first x))
;	       (push (first x) aquantlist)))))
;	(t (is-Aquant-p F-sym))))
;;;;;

;;;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;;;I change this because the next predicates returned a structure when
;;;given a symbol instead of just T.

(defun formula-symbol-p (fs)
  (if (lookup-formula fs)
      t
      nil))

(defun term-symbol-p (ts)
  (if (lookup-term ts)
      t
      nil))

(defun expression-symbol-p (es)
  (or (formula-symbol-p es)
      (term-symbol-p es)))

(defun subst-symbol-p (ss)
  (if (lookup-subst ss)
      t
      nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  functions on formulas; tested

;;left-of-conj has a formula symbol as input and returns the LIST made
;;from the formula-symbol of the left conjunct if the input is a symbol of a
;;conjunction, else nil

;(defun left-of-conj (form-sym &aux formula)
;  (cond ((and (setf formula (lookup-formula form-sym))
;	      (equal 'andf (formula-top formula)))
;	 (list (formula-symbol (first (formula-arguments formula)))))
;	(t nil)))

(defun left-of-conj (form-sym &optional formula)
  (let ((conj-formula (lookup-formula form-sym)))
    (cond ((not (equal 'andf (formula-top conj-formula)))
	   nil)
	  ((or (null formula)(p4::strong-is-var-p formula))
	   (list (formula-symbol
		  (first (formula-arguments conj-formula)))))
	  ((equal formula
		  (formula-symbol
		   (first (formula-arguments conj-formula))))))))
;;;;;;;;;;;


;(defun right-of-conj (form-sym &aux formula)
;  (cond ((and (setf formula (lookup-formula form-sym))
;	      (equal 'andf (formula-top formula)))
;	 (list (formula-symbol (second (formula-arguments formula)))))
;	(t nil)))

(defun right-of-conj (form-sym &optional formula)
  (let ((conj-formula (lookup-formula form-sym)))
    (cond ((not (equal 'andf (formula-top conj-formula)))
	   nil)
	  ((or (null formula)(p4::strong-is-var-p formula))
	   (list (formula-symbol
		  (second (formula-arguments conj-formula)))));??
	  ((equal formula
		  (formula-symbol
		   (second (formula-arguments conj-formula))))))))


;(defun left-of-impl (form-sym &aux formula)
;  (cond ((and (setf formula (lookup-formula form-sym))
;	      (equal 'implf (formula-top formula)))
;	 (list (formula-symbol (first (formula-arguments formula)))))
;	(t nil)))

(defun left-of-impl (form-sym &optional formula)
  (let ((impl-formula (lookup-formula form-sym)))
    (cond ((not (equal 'implf (formula-top impl-formula)))
	   nil)
	  ((or (null formula)(p4::strong-is-var-p formula))
	   (list (formula-symbol
		  (first (formula-arguments impl-formula)))))
	  ((equal formula
		  (formula-symbol
		   (first (formula-arguments impl-formula))))))))


;(defun right-of-impl (form-sym &aux formula)
;  (cond ((and (setf formula (lookup-formula form-sym))
;	      (equal 'implf (formula-top formula)))
;	 (list (formula-symbol (second (formula-arguments formula)))))
;	(t nil)))

(defun right-of-impl (form-sym &optional formula)
  (let ((impl-formula (lookup-formula form-sym)))
    (cond ((not (equal 'implf (formula-top impl-formula)))
	   nil)
	  ((or (null formula)(p4::strong-is-var-p formula))
	   (list (formula-symbol
		  (second (formula-arguments impl-formula)))))
	  ((equal formula
		  (formula-symbol
		   (second (formula-arguments impl-formula))))))))


;;;;;;;;;;;;;;;;
;;These functions return a list of bindings if the optional
;;input-symbol is a variable or no optional input. It returns t if the
;;optional input is equal to the left of the equivalence form-sym, else nil 

(defun left-of-equiv (form-sym &optional formula)
  (let ((equiv-formula (lookup-formula form-sym)))
    (cond ((not (equal 'equivf (formula-top equiv-formula)))
	   nil)
	  ((or (null formula)(p4::strong-is-var-p formula))
	   (list (formula-symbol
		  (first (formula-arguments equiv-formula)))))
	  ((equal formula
		  (formula-symbol
		   (first (formula-arguments equiv-formula))))))))

;;;;;correspondingly
(defun right-of-equiv (form-sym &optional formula)
  (let ((equiv-formula (lookup-formula form-sym)))
    (cond ((not (equal 'equivf (formula-top equiv-formula)))
	   nil)
	  ((or (null formula)(p4::strong-is-var-p formula))
	   (list (formula-symbol
		  (second (formula-arguments equiv-formula)))))
	  ((equal formula
		  (formula-symbol
		   (second (formula-arguments equiv-formula))))))))

;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;functions and predicates on SET-symbols

;ass-set-symbol-p is a predicate which is true only if the symbol is
;associated with a set built from formulas

;;; This is one of the only places we assume the assoc list. We can't
;;; use lookup here, because if the set is empty, lookup returns nil
;;; even though the object is there

(defun ass-set-symbol-p (symbol)
  (if (assoc symbol *set-table*)
      t
      nil))

;the function (set-contains set F)is a function on symbols and yields T/F if F is bound.
;If F is not bound, then it provides a list of bindings for F.
;Free occurence of set is not considered yet.
;
(defun set-contains (set F)
  (cond ((p4::strong-is-var-p F) set)
	((member F (lookup-set set)) t)
	(t nil)))



;;conj-in-set gets a set-symbol and provides the list of all symbols
;;for conjunctions (formulas) which are in the set associated with the symbol input
(defun conj-in-set (set); 
  (let ((result nil))
    (dolist (x (lookup-set set))
      (cond ((equal 'andf (formula-top (lookup-formula x)))
	     (push x result))))
    result))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;CREATion of sets

;special assertion set 
(add-to-set-table 'emptyset nil)
(setf emptyset 'emptyset)


;;We do not have a way to make the reverse lookup: from sets to
;;symbols, since sets have no slot for "symbol" ???????????????????????????????????????JIM

;;create-set CREATES a LIST of the symbol for a
;;singleton set {F} when given a symbol for a formula F
(defun create-set (formula)
  (let* ((new-res (list formula))
	 (old-set (find-set-already new-res)))
    (if old-set
	(list old-set)
	(let ((new-sym (make-new-set-symbol)))
	  (add-to-set-table new-sym new-res)
	  (list new-sym)))))

;;;next function CREATES assumption-sets (for the initial state).
;;;returns a list of SYMBOLS OF FORMULAS to change it
;;;:
(defun create-ass-set (list &optional name)
  (let* ((s (mapcar #'(lambda (x) (create-formula x))
		    list))
	(new-sym name)
	(old-sym (find-set-already s)))
  (cond (old-sym
	 (when name (nsubst name old-sym *set-table*)
	       (setf old-sym name))
	 old-sym)
	(t (unless name (setq new-sym (make-new-set-symbol)))
	   (add-to-set-table new-sym s)
	   new-sym))))


;;OLD function CREATES assumption-sets (for the initial state). 
;(defun create-ass-set (list)
;  (let ((s (mapcar #'(lambda (x) (create-formula x)) list)))
;    (or (find-set-already s)
;	(let ((new-sym (make-new-set-symbol)))
;	  (add-to-set-table new-sym s)
;	  new-sym))))

;;;Another version, CREATES assumption-sets only for the initial
;;;state. It does not check whether this set exists already. Maybe
;;;this is sufficient
;(defun create-ass-set (list name)
;  (let ((s (mapcar #'(lambda (x) (create-formula x)) list)))
;	  (add-to-set-table name s)
;	  name))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;print functions
;;;;;;;;;;;;;; 

(defun print-term (x stream depth)
  (cond ((equal (term-type x) 'var) (format t "~S " (term-top x)))
	((and (equal (term-type x) 'func)
	      (equal (term-arguments x) nil))
	 (format t "~S " (term-top x)))
	(t (format t "~S ~S " (term-top x) (term-arguments x)))))

		   
(defun print-formula (x stream depth)
  (cond ((equal (formula-arguments x) nil)
	 (format t "~S" (formula-top x)))
	(t (format t "~S~S" (formula-top x)
		   (formula-arguments x)))))


;(defun print-subst (x stream depth)
;  (format t "subst(~S~S)" (subst-domain x) (subst-codomain x)))
;;;;;;;;;;
;;New printfunction for Prodigy

(defun p4::print-literal-arg (x)
  (princ
   (let ((name 
	  (if (p4::prodigy-object-p x)(p4::prodigy-object-name x) x)))
     (cond ((formula-symbol-p NAME) (lookup-formula NAME))
	   ((ass-set-symbol-p NAME) (lookup-set NAME))
	   ((term-symbol-p NAME) (lookup-term NAME))
	   ((subst-symbol-p NAME) (lookup-subst NAME))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun print-subst (subst stream depth)
  (if (= (length (subst-domain subst)) (length (subst-codomain subst)))
      (mapcar #'(lambda (x y) (format t "~S/~S" x y))
	      (subst-domain subst) (subst-codomain subst))
      (format t "~S no proper substitution" (subst-symbol subst))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;read-in functions that store the symbols of the new structures in
;;;the resp.table


;;Certain syntax-check with atoms: if leading "=" then atom should
;;have 2 sublists, if leading is not "=" then atom should have at most
;;1 sublist. 

(defun syntax-check (atom)
  (cond ((equal '= (first atom))
	     (when (or (not (= 2 (length (rest atom))))
		 (< 3 (length atom)))
	 (error "~% not a well-formed equality ~S" atom)))
	((< 3 (length atom))
	 (error "~% not a well-formed atom ~S" atom))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Creation of terms NOT CHANGED FOR ASSIGNING PARTICULAR NAMES TO TERMS
;;This could be done by the following function
;(defun create-term (termlist geb-var &optional name)
;  (let ((te nil))
;    (cond ((not (listp termlist))
;	   (if (not (member termlist geb-var))
;	       (setq te
;		     (make-term :top termlist
;				:type 'func)) ;constant case
;	       (setq te
;		     (make-term :top termlist ;variable case
;				:type 'var))))
;	  ((and (listp termlist) (equal 1 (length termlist)))
;	   (if (not (member (first termlist) geb-var))
;	       (setq te
;		     (make-term :top (first termlist)
;				:type 'func)) ;constant case
;	       (setq te
;		     (make-term :top (first termlist)
;				:type 'var))));variable case
;	  (t (setq te			;for functions
;		   (make-term :top (first termlist)
;			      :arguments (cond ((or (equal (second (second termlist)) nil)
;						    (not (listp (second
;								 (second termlist)))))
;						(mapcar #'(lambda (x)
;							    (lookup-term
;							     (create-term x geb-var)))
;							(second termlist)))
;					       (t (lookup-term
;						   (create-term (second termlist) geb-var))))
;			      :type 'func))))
;    (let ((old-sym (find-term-already te)))
;    (cond  ((and old-sym (null name))
;	    old-sym)
;	   (old-sym
;	    (nsubst name old-sym *term-table*)
;	    (setf (term-symbol (lookup-term name)) name)

;	    (term-symbol te))
;	   (t (let ((new-sym name))
;		(unless name (setf new-sym (make-new-term-symbol)))
;		(setf (term-symbol te) new-sym)
;	        (add-to-term-table new-sym te)
;	        new-sym))))))


;;the function create-term makes terms from lists to
;;be used for the INITIAL STATE, where the arguments
;;are elements of a argument-list, namely (rest termlist). the
;;function returns the symbol of the term-structure.

(defun create-term (termlist geb-var)
  (let ((te nil))
    (cond ((not (listp termlist))
	   (if (not (member termlist geb-var))
	       (setq te
		     (make-term :top termlist
				:type 'func)) ;constant case
	       (setq te
		     (make-term :top termlist ;variable case
				:type 'var))))
	  ((and (listp termlist) (equal 1 (length termlist)))
	   (if (not (member (first termlist) geb-var))
	       (setq te
		     (make-term :top (first termlist)
				:type 'func)) ;constant case
	       (setq te
		     (make-term :top (first termlist)
				:type 'var))));variable case
	  (t (setq te			;for functions
		   (make-term :top (first termlist)
			      :arguments (mapcar #'(lambda (x)
						     (lookup-term (create-term x geb-var)))
							(second termlist))
			      :type 'func))))
    (cond ((find-term-already te))
	  (t
	   (let ((new-sym (make-new-term-symbol)))
	     (setf (term-symbol te) new-sym)
	     (add-to-term-table new-sym te)
	     new-sym)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;several CREATion of formulas

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;The function is used to build the initial state. It returns the symbol of a
;;built structure, This is a new symbol if the structure has not been in the table -
;;maybe with optional "name"

;;;;;;;;;;;;;NUN OKAY
;;
(defun create-formula (list &optional name geb-var)
  (let ((fo nil))
    (cond ((and (not (member (first list) '(notf andf orf implf equivf)));;the atom case
	        (not (listp (first list))))
	   (syntax-check list)
	   (cond ((= (length list) 1);formula-constant case
		  (setq fo 
			(make-formula :top (first list)
				      :type 'atom)))
	         (t (setq fo;;;;atom with relation
			  (make-formula :top (first list)
					:arguments (mapcar #'(lambda (x)
							       (lookup-term
								(create-term x geb-var)))
							   (second list))
					:type 'atom)))))
	  (t (when (listp (first list))
	       (let ((variable (push (second (first list)) geb-var)))
		 (setf geb-var variable)))
	     (setq fo
		   (make-formula :top (first list)
				 :arguments (mapcar #'(lambda (x)
							(lookup-formula
							 (create-formula x nil geb-var)))
						    (rest list))
				 :type 'appl))))
    (let ((old-sym (find-formula-already fo)))
      (cond  ((and old-sym (null name))
	      old-sym)
	     (old-sym
	      (nsubst name old-sym *formula-table*)
	      (setf (formula-symbol (lookup-formula name)) name)
	      (formula-symbol fo))
	     (t (let ((new-sym name))
		  (unless name (setf new-sym (make-new-formula-symbol)))
		  (setf (formula-symbol fo) new-sym)
		  (add-to-formula-table new-sym fo)
		  new-sym))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;create-formula-var CREATES a new atom-formula structure and puts it
;;together with a new symbol into the formula-table. This is necessary
;;for certain operators which produce goals with formula variables.
(defun create-formula-var ()
  (let ((symbol (make-new-formula-symbol)))
  (add-to-formula-table symbol
			(make-formula :symbol symbol
				      :top symbol
				      :type 'variable))
  symbol))


;;;special formula "false" CREATED
(add-to-formula-table 'false (make-formula :symbol 'false
					   :top 'false
					   :type 'atom))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       
;(defun take-term (term current)
;  (cond ((every #'(lambda (x) (not(term-equal term x))) current)
;	 (setq current (push term current))
;	 term)
;	(t
;	 (find-if #'(lambda (x) (term-equal term x)) current))))

;;Takes two symbols for sets (which are in the set table) as inputs and
;;returns for Prodigy a list of the symbol that is associated with the
;;union of the sets associated with the input symbols. Makes a new
;;entry in set table if necessary

(defun build-union (ass-sym set-sym)
  (cond ((eq ass-sym 'emptyset)
	 (list set-sym))
	((eq set-sym 'emptyset)
	 (list ass-sym))
	(t
	 (let* ((ass (lookup-set ass-sym))
		(set (lookup-set set-sym))
		(new-set (union ass set))
		(old-set-name (find-set-already new-set)))
	   (if old-set-name
	       (list old-set-name)
	       (let ((new-sym (make-new-set-symbol)))
		 (add-to-set-table new-sym new-set)
		 (list new-sym)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Takes two symbols for sets (which are in the set table) as inputs and
;;returns for Prodigy a list of the symbol that is associated with the
;;set-difference of the sets associated with the input symbols. makes a new
;;entry in set table if necessary

(defun build-set-diff (ass-sym set-sym)
  (cond ((eq ass-sym 'emptyset)
	 (list 'emptyset))
	((eq set-sym 'emptyset)
	 (list ass-sym))
	(t
	 (let* ((ass (lookup-set ass-sym))
		(set (lookup-set set-sym))
		(new-set (set-difference ass set))
		(old-set-name (find-set-already new-set)))
	   (if old-set-name
	       (list old-set-name)
	       (let ((new-sym (make-new-set-symbol)))
		 (add-to-set-table new-sym new-set)
		 (list new-sym)))))))
;;;;;;;;;;;;;;;;;;;;;;;;
;;MAYBE NOT NECESSARY ANYMORE
;;Gives a list of all assumptions which are in a follow-literal with
;;second entry (formula)

;(defun assumptions-of (formula)
;  (mapcan #'(lambda (lit)
;	      (if (equal formula
;			 (aref (p4::literal-arguments lit) 1))
;		  (list (aref (p4::literal-arguments lit) 0))))
;	  (p4::give-me-nice-state '(follows))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;returns the term in l2 that is  the image of the
;;l1-element "term". This function is used in get-substitution
;;
(defun co-term (term l1 l2)
  (mapcar #'(lambda (x y)
	      (when (term-equal x term) (return-from co-term y))) l1 l2))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SUBSTITUTION functions
;;;;;;;;;;;;;;;;;;;;;;;;

;;;OCCUR CHECK
(defun occur-check (variable expr)
  (cond ((equal (term-type expr) 'var)
	 (if (term-equal variable expr) T))
	(t (some #'(lambda (x) (occur-check variable x))
		   (term-arguments expr)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;for get-substitution
(defun get-marked-subst (expr dom codom)
  (let ((intermediate
	 (make-term :type 'appl
		    :top (term-top expr)
		    :arguments (mapcar #'(lambda (x) (get-new-marked-constant ))
					(term-arguments expr)))
		    ))
    (get-substitution expr intermediate dom codom)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;before do new-var-formula such that 
;;(forallf x)(R (x y a) can be substituted to (forallf y)(R (y c a)
;;Then constants from expr can be mapped to "marked constants" from
;;expr-subst AND terms from expr can be mapped to "marked constants"
;;from expr-subst by inducing a substitution of the
;;constants and variables in the term.
(defun get-substitution (expr expr-subst &optional dom codom)
  (when (and (expression-p expr) (expression-p expr-subst));NEW
    (cond ((equal (expression-type expr) 'var); expr is variable
	   (cond ((member expr dom)
		  (unless (equal expr-subst (co-term expr dom codom))
		    (return-from get-substitution nil)))
		 (t (cond ((and (not (equal (term-type expr-subst) 'var))
				(occur-check expr expr-subst))
			   (return-from get-substitution nil))
			  (t (push expr dom)
			     (push expr-subst codom))))))
	  ((and (equal (expression-type expr) 'func);expr is constant
		(null (expression-arguments expr)))
	   (cond ((expression-mark expr-subst);changed***
		  (push expr dom)
		  (push expr-subst codom))
		 ((not (term-equal expr expr-subst))
		  (return-from get-substitution nil))))
	  ((not (and (equal (expression-top expr) (expression-top expr-subst))
		     (= (length (expression-arguments expr))
			(length (expression-arguments expr-subst)))))
	   (if (and (term-p expr) (expression-mark expr-subst));;new
	       (let ((result (get-marked-subst expr dom codom)));;new
		 (setf dom (subst-domain result));;new
		 (setf codom (subst-codomain result)));;new
	   (return-from get-substitution nil)))
	  (t (mapcar #'(lambda (x y);;;;;;;;;;;;;;expr is term or formula
			 (let ((result (get-substitution x y dom codom)))
			   (cond ((null result) (return-from get-substitution nil))
				 (t (setf dom (subst-domain result))
				    (setf codom (subst-codomain result))))))
		     (expression-arguments expr)
		     (expression-arguments expr-subst))))
    (let ((subst))
      (setf subst (make-subst :domain dom
			      :codomain codom))
      (put-in-subst-table subst))))

;;;;;;;;;;;;;;;
(defun put-in-subst-table (subst)    
    (cond ((lookup-subst (find-subst-already subst)))
	  (t
	   (let ((new-sym (make-new-subst-symbol)))
	     (setf (subst-symbol subst) new-sym)
	     (add-to-subst-table new-sym subst)
	     subst))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;returns a list of the symbol of the substitution that produces the
;;second input from the first
(defun get-substitution-symbol (e-sym es-sym &optional subst-sym)
  (let* ((f1 (lookup-expression e-sym))
	(f2 (lookup-expression es-sym))
	(d (if (null subst-sym) nil
	       (subst-domain (lookup-subst subst-sym))))
	(co (if (null subst-sym) nil
	       (subst-codomain (lookup-subst subst-sym))))
	(subst (get-substitution f1 f2 d co)))
    (cond ((not subst) nil);changed***
	  ((list (find-subst-already subst)))
	  (t
	    (let  ((new-sym (make-new-subst-symbol)))
	     (setf (subst-symbol subst) new-sym)
	     (add-to-subst-table new-sym subst)
	     (list new-sym))))))
    
;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;
;;this function returns an expression-structure when input a
;;subst-structure which is in the subst-table and an expression-structure
;;Hope, that no confusion with same variables in different quantifier scopes.


(defun get-substitute (sub expr &optional geb-var)
  (let ((se nil)
	(sym nil))      
    (cond ((and (null (subst-domain sub))
		(null (subst-codomain sub)))
	   expr)
	  ((equal (expression-type expr) 'var)
	   (cond ((member (expression-top expr) geb-var) expr)
		 (t
		  (setq se (dolist (x (subst-domain sub))
			     (when (term-equal x expr)
			       (return (co-term x (subst-domain sub) (subst-codomain sub))))))
		  (if (null se) expr se))));;;***neu
	  ((formula-p expr)
	   (when (listp (formula-top expr))
	     (let ((variable (push (second (formula-top expr)) geb-var)))
	       (setf geb-var variable)))
	   (setq se (make-formula :top (formula-top expr)
				  :arguments (mapcar #'(lambda (x)
							 (get-substitute sub x geb-var))
						     (formula-arguments expr))
				  :type (formula-type expr)))
	   (cond ((setf sym (find-formula-already se))
		  (setf (formula-symbol se) sym);;;;***neu
		  se)
		 (t
		  (let ((new-sym (make-new-formula-symbol)))
		    (setf (formula-symbol se) new-sym)
		    (add-to-formula-table new-sym se)
		    se))))
	  ((term-p expr)
	   (setq se (make-term :top (term-top expr)
			       :arguments (mapcar #'(lambda (x)
						      (get-substitute
						       sub x geb-var))
						  (term-arguments expr))
			       :type  (term-type expr)))
	   (cond ((setf sym (find-term-already se))
		  (setf (term-symbol se) sym)
		  se);;;;;***achtung neu
		 (t
		  (let ((new-sym (make-new-term-symbol)))
		    (setf (term-symbol se) new-sym)
		    (add-to-term-table new-sym se)
		    se)))))))
;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;
;;;CORPUS-SYM when input a formula symbol this function returns a list of the
;;;symbol of the formula without the leading forall-quantifiers. When
;;;input two symbols and the second is a variable, then as before. else
;;;it returns T or F.
(defun corpus-sym (form-sym &optional rumpf-sym)
  (let ((z nil)
	(r nil))
  (setf z (lookup-formula form-sym))
  (cond ((or (p4::strong-is-var-p rumpf-sym) (not rumpf-sym))
	 (cond ((not (listp (formula-top z)))
		(list form-sym))
	       ((not (equal 'forallf (first (formula-top z))))
		(list form-sym))
	       (t (corpus-sym (formula-symbol (first (formula-arguments z)))))))
	(t (setf r (lookup-formula rumpf-sym))
	   (formula-equal (corpus z) r)))))


;;;;;is needed for corpus-sym
(defun corpus (form)
  (let ((k nil))
    (setf k (cond ((not (listp (formula-top form))) form)
			 ((not (equal 'forallf (first (formula-top
						       form)))) form)
			 (t (corpus (first (formula-arguments form))))))))
  

;;;;;;;;;;;;;;;;;;;;;
;;ALTES
;;;when input a formula symbol this function returns a list of the
;;;symbol of the formula without the leading forall-quantifiers
;;
;(defun corpus (form-sym &aux z)
;  (setf z (lookup-formula form-sym))
;  (cond ((not (listp (formula-top z)))
;	  (list form-sym))
;	((not (equal 'forallf (first (formula-top z))))
;	 (list form-sym))
;	(t (corpus (formula-symbol (first (formula-arguments z)))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;this function returns a list of the symbol of the substitute produced
;;by the substitution of s-sym and the formula of f-sym and
;;puts the symbol into the formula-table if new when input a
;;subst-symbol and a formula-symbol   
;;
(defun get-substitute-symbol (s-sym f-sym)
  (let ((s (lookup-subst s-sym))
	(f (lookup-expression f-sym)))
    (when (and (subst-p s) (formula-p f))
      (let ((sf (get-substitute s f)))
	(list (find-formula-already sf))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; produce instances of an A-quantified formula
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;returns a formula that is a corpus of the input formula and where
;;the forall-bound variables of the input are replaced by new
;;variables (means "independent constants") TESTED 

(defun create-formula-inst (form &optional subst)
  (when (equal subst nil) (setf subst (make-subst)))
  (cond ((or (not (listp (formula-top form)))
	     (not ( equal 'forallf (first (formula-top form)))))
	 (get-substitute subst form))
	(t (let* ((variable (make-term :type 'var
				       :top (second (formula-top
						     form))));;hier
							     ;;fehlt evtl.
							     ;;noch term-symbol
		  (new-var (make-term :type 'var
				      :top (get-new-variable)
				      :symbol (make-new-term-symbol)))
		  (s (make-subst :domain (push variable (subst-domain subst))
		                :codomain (push new-var (subst-codomain subst)))))
	     (setf subst s)
	     (create-formula-inst (first (formula-arguments form)) subst)))))



;;;;when input the symbol of an formula, the function
;;returns a list of the symbol of the formulae that is an instance of the
;;corpus of F with new variables TESTED
(defun create-formula-inst-sym (form-sym)
  (let* ((fo (lookup-formula form-sym))
	 (new-f (create-formula-inst fo)))
    (cond ((list (find-formula-already new-f)));;;"uberfl"ussig weil
					       ;;;schon in get-substitute
	  (t
	   (let ((new-sym (make-new-formula-symbol)))
	     (setf (formula-symbol new-f) new-sym)
	     (add-to-formula-table new-sym new-f)
	     (list new-sym))))))
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;all-substitute returns the list of symbols of all instantiated expressions of
;;expr which are in a literal in the state if subs-expr-sym is a variable.
;;If both are not variables it returns t (if there is get-substitution) or nil.
;; (this function is used in the inference-rule appl-def-left-rule,
;; generalized-modus-ponens inference-rule, match operator.)
;; not necessary because of get-instance-symbol
;(defun all-substitute-sym (subs-expr-sym expr-sym)
;  (cond ((p4::strong-is-var-p subs-expr-sym)
;	 (remove nil (mapcar #'(lambda (form)
;		     (when (get-substitution-symbol expr-sym form)
;		       form)) (give-conclusion))))
;	((p4::strong-is-var-p expr-sym) nil)
;	((get-substitution-symbol expr-sym subs-expr-sym) t)
;	(t nil)))
;	 
;;gives the list of  all second entries of follow-literals in the state
;;could be generalized with an optional parameter for the first entry.
;;Is needed for all-substitute-sym
;(defun give-conclusion ()
;  (mapcan #'(lambda (lit) (list (aref (p4::literal-arguments lit) 1)))
;	  (p4::give-me-nice-state '(follows))))

;;;;;;;;;;;;;
;;for the operator reduce-assumption/ modus-ponens-op-left
;;yields all subsets of S2  from *set-table* if S1 is a variable, else
;;T or F 
(defun build-subset-sym (S1 S2)
  (cond ((p4::strong-is-var-p S1)
	 (remove nil (mapcar #'(lambda (entry)
		     (when (subsetp (cdr entry) (lookup-set S2))
		       (first entry)))
		 *set-table*)))
	(t (subsetp (lookup-set S1) (lookup-set S2)))))
;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; (get-impl-symbol f1 f2) returns a list of the symbol of the implication of
;; the inputs
;; needed in MODUS-PONENS-op-right

(defun get-impl-symbol (f1 f2)
       (when (and (formula-symbol-p f1)
		  (formula-symbol-p f2))
	 (let ((formel1 (lookup-formula f1))
	       (formel2 (lookup-formula f2))
	       (impl nil)
	       (sym nil))
	   (setf impl (make-formula :top 'implf
				    :arguments (list formel1 formel2)
				    :type 'appl))
	   (cond ((setf sym (find-formula-already impl))
		  (setf (formula-symbol impl) sym)
		  (list sym));;;;;;;;;;;;;;;;;;;;;;;;changed
		 (t
		  (let ((new-sym (make-new-formula-symbol)))
		    (setf (formula-symbol impl) new-sym)
		    (add-to-formula-table new-sym impl)
		    (list new-sym)))))))
	   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Appl-def-left-rule, generalized-modus-ponens-rule
;;;input a formula symbol F, returns a list of symbols of
;;;formulae that are have a substitution with F in the current state .
;;;
(defun get-instance-symbol (F)
  (remove nil (mapcar #'(lambda (formel-sym)
	      (unless (equal (get-substitution-symbol F formel-sym) '(nil)) formel-sym))
		      (list-of-valid))))
  
  
(defun list-of-valid ()
  (remove nil (mapcar #'(lambda (lit) (aref (p4::literal-arguments lit) 1))
	  (p4::give-me-nice-state '(follows)))))

;; for MATCH operator
;;;input a formula symbol F, returns a list of symbols of generalized
;;;formulas in the current state  which F have a substitution with F
;;;
(defun get-generaliz-symbol (F)
  (remove nil (mapcar #'(lambda (formel-sym)
	      (unless (equal (get-substitution-symbol (corpus-sym formel-sym) F)
			     '(nil));change by adding corpus-sym
		formel-sym))
		      (list-of-valid))))
  

;;;;;;;;;;;;;;;;;;;;;
;; if ass1 is in set-table, then
;;get-subst-set-symbol returns a list of the symbol of the ass-set which is the
;;substitution of ass1 by sub
(defun get-subst-set-symbol (sub-sym ass1-sym)
  (let* ((sub (lookup-subst sub-sym))
	 (ass1 (mapcar #'(lambda (x) (lookup-formula x)) (lookup-set ass1-sym)))
	 (new (get-subst-set sub ass1))
	 (new-set (mapcar #'(lambda (x) (formula-symbol x))
			  new))
	 (old-set-name (find-set-already new-set)))
    (if old-set-name
	(list old-set-name)
	(let ((new-sym (make-new-set-symbol)))
	  (add-to-set-table new-sym new-set)
	  (list new-sym)))))


;;get-subst-set  returns the ass-set which is the
;;substitution of ass1 by sub (a list of FORMULA-STRUCTURES)
(defun get-subst-set (sub ass1)
  (mapcar #'(lambda (pre) (get-substitute sub pre)) ass1))
	  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;;;;;;;;;;;;;;;;
;; hack -- not firing eager inference rule backwards
;;(defun not-goal-effect (ass f2c)
;;  (let ((lit (p4::instantiate-consed-literal (list 'follows ass f2c))))
;;    (cond
;;      ((p4::literal-goal-p lit) nil)
;;      (t t))))
;;;;;;;;;;;;;;;;
;;not firing eager inference rule backwards TEMPORARY

;(defun not-goal-effect (ass f2c)
;  (format t "~% show f2c ~S" f2c)
;  (cond
;   ((or (p4::strong-is-var-p ass)
;	(p4::strong-is-var-p f2c))
;    nil)
;   (t t)))
   
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;functions for the UNIFY-operator
;;EVERYTHING NOT NECESSARY ANYMORE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;**TESTED***
;;returns a substitution that substitutes each variable in F by a new one
;;and is an extension of the substitution with dom, codom as slots
(defun var-subst (F &optional dom codom)
       (cond ((equal (expression-type F) 'var)
	      (unless (member (term-top F) dom) 	
		(let* ((new-sym (get-new-variable))
		       (new-var (make-term :symbol new-sym
					   :top new-sym
					   :type 'var)))
		  (add-to-term-table new-sym new-var)
		  (push F dom)
		  (push new-var codom))))      		       
	     (t (dolist (x (expression-arguments F))
		  (let ((result (var-subst x dom codom)))
		    (setf dom (subst-domain result))
		    (setf codom (subst-codomain result))))))
       (let ((subst))
       (setf subst (make-subst :domain dom
			       :codomain codom))))
	       	
;;formula that is built by replacing all variables of F by new ones.
;;returns 		CHANGE THIS
(defun new-var-formula (F &optional dom codom)
  (get-substitute (var-subst F dom codom) F))


  
;;Returns a list of the symbol for the formula that is built by **TESTED***
;;new-var-formula
(defun new-var-formula-sym (form-sym)
  (let* ((form (lookup-formula form-sym))
	 (newform (new-var-formula form)))
    (list (formula-symbol newform))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
; returns the set that results from SET by
;;applying subst and introducing new variables for the variables not ***TESTED***
;;in dom(subst) 
(defun new-var-set (set sub)
  (let ((set1 (get-subst-set sub (mapcar #'(lambda (x) (lookup-formula x)) set))))
    (mapcar #'(lambda (y) (formula-symbol (new-var-formula y (subst-domain sub))))
	    set1)))
    
  

;;;returns a list of the symbol of the set from new-var-set ***TESTED***
(defun new-var-set-symbol (set-sym subst-sym)
  (let* ((set (lookup-set set-sym))
	 (sub (lookup-subst subst-sym))
	 (new-set (new-var-set set sub))
	 (old-set-name (find-set-already new-set)))
    (if old-set-name
	(list old-set-name)
	(let ((new-sym (make-new-set-symbol)))
	  (add-to-set-table new-sym new-set)
	  (list new-sym)))))
	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
  
;;for UNNIFY-op *******TESTED *************
;;To use only after f1 and f2 have no variables in common
;;allow the empty substitution
(defun get-unification (expr expr-subst &optional dom codom)
    (cond ((equal (expression-type expr) 'var); expr is variable
	   (cond ((member expr dom)
		  (unless (equal expr-subst (co-term expr dom codom))
		    (return-from get-unification nil)))
		 (t (cond ((and (not (equal (term-type expr-subst) 'var))
				(occur-check expr expr-subst))
			   (return-from get-unification nil))
			  (t (let* ((sub (make-subst :domain dom;;;;;;;;
						     :codomain codom))
				    (exp (get-substitute sub expr-subst)))
			       (push exp codom)    
			       (push expr dom)))))));;;;;;;;;;;;;;;;;;;;
	  ((equal (expression-type expr-subst) 'var); expr-subst is variable
	   (cond ((member expr-subst dom)
		  (unless (equal expr (co-term expr-subst dom codom))
		    (return-from get-unification nil)))
		 (t (cond ((and (not (equal (term-type expr) 'var))
				(occur-check expr-subst expr))
			   (return-from get-unification nil))
			  (t (let* ((sub (make-subst :domain dom;;;;;;;;
						     :codomain codom))
				    (exp (get-substitute sub expr)))
			       (push exp codom)    
			       (push expr-subst dom)))))));;;;;;;;;;;;;;;;;;;;
	  ((and (equal (expression-type expr) 'func);expr is constant
		(null (expression-arguments expr)))
	   (unless (term-equal expr expr-subst)
	     (return-from get-unification nil)))
	  ((not (and (equal (expression-top expr) (expression-top expr-subst));some returns
		     (= (length (expression-arguments expr))
			(length (expression-arguments expr-subst)))))
	   (return-from get-unification nil))
	  (t (mapcar #'(lambda (x y)
			 (let ((result (get-unification x y dom codom)));;the recursion
			   (cond ((null result) (return-from get-unification nil))
				 (t (setf dom (subst-domain result))
				    (setf codom (subst-codomain result))))))
		     (expression-arguments expr)
		     (expression-arguments expr-subst))))
    (let ((subst nil))
    (setf subst (make-subst :domain dom
			    :codomain codom))
    (put-in-subst-table subst)))
;;;;;;;;;;;;;;;;;;;;;;;;;;**TESTED**???
;; returns a list of the unification-symbol for 2 expression-symbols
;; as input or nil if there is no unification
(defun get-unification-symbol (expr1-sym expr2-sym &optional dom codom)
  (let* ((expr1 (lookup-expression expr1-sym))
	 (expr2 (lookup-expression expr2-sym))
	 (unif (get-unification expr1 expr2 dom codom)))
    (unless (not unif)
    (list (subst-symbol unif)))))

;;;;;;;;;;;;;;;
;; for UNIFY-op, stilll testen
;;;input a formula symbol F, returns a list of symbols of
;;;formulae that are unifyable with F in the current state 
(defun get-UNIFIED-formula-symbol (F)
  (remove nil (mapcar #'(lambda (formel-sym)
	      (unless (equal (get-unification-symbol F formel-sym) '(nil)) formel-sym))
		      (list-of-valid))))


;;returns T  if subset can be unified with a subset of set by a
;;unification extending unific, else nil. still TESTEN
(defun unified-subset-sym (subset-sym set-sym unific-sym)
  (let ((result t)
	(res nil)
	(d (subst-domain (lookup-subst unific-sym)))
	(c (subst-codomain (lookup-subst unific-sym)))
	(subset (lookup-set subset-sym))
	(set (lookup-set set-sym)))
    (dolist (s1 subset)
      (let ((formel1 (lookup-formula s1)))
       (unless (member 'a (dolist (s2 set)
			    (let ((formel2 (lookup-formula s2)))
			    (when (get-unification formel1 formel2 d c)
			      (setf res 'a)))))
	 (setf result nil))))
    result))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;not tested
;;for MATCH operator
;;returns true, if for each formula from subset there is a substitution
;;to a formula from set extending unific , else nil.
(defun general-subset-sym (subset-sym set-sym unific-sym)
  (let ((result t)
	(temp nil)
	(sub nil)
	(d (subst-domain (lookup-subst unific-sym)))
	(c (subst-codomain (lookup-subst unific-sym)))
	(subset (lookup-set subset-sym))
	(set (lookup-set set-sym)))
    (dolist (s1 subset)
      (let ((formel1 (lookup-formula s1)))
       (unless (member 'a (dolist (s2 set)
			    (let ((formel2 (lookup-formula s2)))
			    (when (setf sub (get-substitution formel1 formel2 d c))
			      (setf d (subst-domain sub))
			      (setf c (subst-codomain sub))
			      (setf temp 'a)))))
	 (setf result nil))))
    result))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;not tested NOT NEEDED ANYMORE
;;returns true if for each formula from subset there is a substitution
;;to a formula from set extending unific 
;(defun subst-subset-sym (subset-sym set-sym unific-sym)
;  (let ((result t)
;	(res)
;	(d (subst-domain (lookup-subst unific-sym)))
;	(c (subst-codomain (lookup-subst unific-sym)))
;	(subset (lookup-set subset-sym))
;	(set (lookup-set set-sym)))
;    (dolist (s1 subset)
;      (let ((formel1 (lookup-formula s1)))
;       (unless (member 'a (dolist (s2 set)
;			    (let ((formel2 (lookup-formula s2)))
;			    (when (get-substitution formel1 formel2 d c)
;			      (setf res 'a)))))
;	 (setf result nil))))
;    result))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    for EXISTS_INTRO operator
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;tested
(defun is-existential-p (F-sym)
  (let (F)
    (and (symbolp F-sym)
	 (setf F (lookup-formula f-sym))
	 (listp (formula-top F))
	 (equal 'existsf (first (formula-top F))))))

;;For EXISTS-INTRO operator
;;;;existential-p is for Prodigy and takes a symbol as input. If this is
;;a variable, then it returns a list of all existentially quantified
;;formulas in the state, if it is
;;bound, it returns T or F. CAN BE CHANGED BY NOT VISITING ALL
;;*FORMULA-TABLE* BUT ONLY LITERALS FOLLOWS... IN THE STATE.
(defun existential-p (f-sym)
  (cond ((p4::strong-is-var-p F-sym)
	 (let ((existslist nil))
	   (dolist (x *formula-table* existslist)
	     (when (is-existential-p (first x))
	       (push (first x) existslist)))))
	(t (is-existential-p F-sym))))

;;;;;;;;;
;;For EXISTS-INTRO operator 
;;assumes f-sym to be the symbol of an e-quantified formula
;;returns the list of the symbol of the formula arising from formula
;;by substituting the e-quantified variable by a marked constant.
(defun get-e-instant-sym (f-sym)
  (let* ((formula (lookup-formula f-sym))    
	 (evartop (second (formula-top formula)))
	 (evar (get-var formula evartop))
	 (subst (get-substitution evar (get-new-marked-constant)))
	 (new-formula (get-substitute subst (first (formula-arguments formula)))))
    (list (formula-symbol new-formula))))


(defun get-new-marked-constant ()
  (let* ((sym (make-new-term-symbol))
	 (new-const (make-term :top sym
				   :symbol sym
				   :type 'func
				   :mark 'marked)))
    (add-to-term-table sym new-const)
    new-const))

;;tested
;; returns the variable-term which is denoted by the evartop
;; contained in (exists var) i.e. the top of the existential formula 
(defun get-var (formula evartop &optional result)
  (cond (result)
	(t (cond ((and (equal (expression-type formula) 'var)
		       (equal (expression-top formula) evartop))
		  (setf result formula))
		 ((not (expression-arguments formula)) result)
		 (t 
		  (dolist (x (expression-arguments formula))
		    (let ((res (get-var x evartop result)))
		      (setf result res)
		      (when result (return-from get-var result)))))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
(defun not-gen-from-pred (literal)
 ;  (if (> (count-if #'(lambda (x) (p4::strong-is-var-p x)) literal) 1)
 ;     (error "~% too many unbound var in the predicate generator ~S" literal)
      (let ((res (true-in-state literal)))
	(not (or (eq res t)
	    (mapcar #'(lambda (x) (cdar x)) res)))))))
|#