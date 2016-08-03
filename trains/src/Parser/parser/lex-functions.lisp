(in-package parser)

(defvar *show-forms* nil)

;;  This File contains the code that implements the hierarchical lexicon
;;  format.

;;  EXPAND
;;  The main interface function. This takes a tree of lexical entries and
;;  converts it into a series of calls to build the lexical entries.
;;  It builds the feature specification using a simple inheritance scheme
;;  and generates some simple morphological variants.

(defun expand (cat node)
  (expand-node cat nil node))

(defun expand-node (cat feats node) 
  (if (consp node)
    (let ((type (car node)))
      (case type
        (:node
         (let 
           ((newfeats (second node))
            (subnodes (third node)))
           (if (feats-OK newfeats)
             (process-subnodes subnodes (augment-feats feats newfeats) cat)
             (parser-warn "~% Error: bad feature specification in ~S" node))
           ))
         
        (:leaf 
         (let
           ((word (second node))
            (newfeats (cddr node)))
           (if (feats-OK newfeats)
             (process-leaf word (Augment-feats feats newfeats) cat)
             (parser-warn "~% Error: bad feature specification in ~S" node))))
          
        (otherwise
         (parser-warn "~%*** Bad lexical node: ~S~%" node))))
    (parser-warn "~% Bad node detected, ~S" node))
 )

;;  PROCESS-SUBNODES maps over the subnodes and appends the
;;  answers together (as each may return more than one entry)

(defun process-subnodes (nodes feats cat)
  (if (null nodes) nil
      (append (expand-node cat feats (car nodes) )
              (process-subnodes (cdr nodes) feats cat))))


;;  PROCESS-LEAF builds a word entry using the inherited features and any leaf options
;;   which may specific additional MORPH features and an LF value

(defun process-leaf (word feats cat)
  (if (and (eq cat 'V) (member '-vb (get-fvalue feats 'morph)))
    (process-verb word feats cat (get-verb-exception-list word))
    (cons (list word (cons cat feats))
	  (gen-morph-variants word feats (get-fvalue feats 'morph) cat))))

;; AUGMENT-FEATS merges two feature lists, replacing old feature values with new when
;;    they both exist

(defun augment-feats (oldfeats newfeats)
  (let  ((feats oldfeats)
         (new (insert-vars-in-embedded-constits newfeats)))
    (mapcar #'(lambda (x)
                (setq feats (replace-feat feats (car x) (cadr x))))
            new)
    feats))

;;   this inserts a VAR, SEM and GAP feature into any embedded constits
;;   if not already present. 

(defun insert-vars-in-embedded-constits (feats)
  (mapcar #'(lambda (fv)
              (let ((feat (car fv))
                    (val (cadr fv))
		    (new-feats nil))
                (if (and (consp val) (eq (car val) '%) (not (eq (cadr val) '-)))
		    (let ((var (assoc 'var (cddr val)))
			  (gap (assoc 'gap (cddr val)))
			  (sem (assoc 'sem (cddr val))))
		      (if (null var)
			  (setq new-feats (list (list  'VAR (gen-symbol '?var)))))
		      (if (null gap)
			  (setq new-feats (cons (list  'GAP (gen-symbol '?gap))
						new-feats)))
		      (if (null sem)
			  (setq new-feats (cons (list  'SEM (gen-symbol '?sem))
						new-feats)))
		      (if (null new-feats)
			  fv
			(list feat
			      (cons '% 
				    (cons (cadr val) 
					  (append new-feats (cddr val)))))))
                  fv)))
          feats))
        

;;=================
;;
;;    VERB FORMS
;;
;;; Processes the shorthand for verb forms.  If some of the forms are
;;; the same, tries to avoid making more lexical entries than
;;; necessary, using constrained variables as feature values.


;;  Maintaining the table of exceptions

(let ((verb-exception-table nil))

  (defun init-verb-exception-table (&optional vals)
    (setq verb-exception-table vals))
  (defun add-verb-exceptions (vals)
    (setq verb-exception-table (append verb-exception-table vals)))

  (defun verb-exception-table nil
    verb-exception-table)

  (defun get-verb-exception-list (vb)
    (cdr (assoc vb verb-exception-table)))
)

;; PROCESS-VERB
;;   This adds the regular verb forms unless exceptions are noted 
;;    and then passes everything on to generate the entries

(defun process-verb (base feats cat exceptions)
  (let ((3s (get-exceptions exceptions :3s))
        (ing (get-exceptions exceptions :ing))
        (past (get-exceptions exceptions :past))
        (pastpart (get-exceptions exceptions :pastpart)))
  ;;  Create the standard values as defaults
  (when (null 3s)
    (setq 3s (add-suffix base "S"))
    (if *show-forms*
	(format t "he ~s; " 3s)))
  (when (null ing)
    (setq ing (add-suffix base "ING"))
    (if *show-forms*
	(format t "I am ~s; " ing)))
  (when (null past)
    (setq past (add-suffix base "ED"))
    (if *show-forms*
	(format t "I ~s; " past)))
  (when (null pastpart)
    (setq pastpart past)
    (if *show-forms*
	(format t "I have ~s; " pastpart)))
  (generate-verb-entries feats base cat 3s ing past pastpart)))

;;  get value of feature from list (F1 V1 F2 V2 ...)
(defun get-exceptions (feat-val-list feat)
  (cond ((null feat-val-list) nil)
        ((eq (car feat-val-list) feat) (second feat-val-list))
        (t (get-exceptions (cddr feat-val-list) feat))))
  

;;  GENERATE-VERB-ENTRIES
;;    This generates the lexical entries for the verb forms

(defun generate-verb-entries (feats base cat 3s ing past pastpart)
  ;; the base and pastpart forms shouldn't really have agr features,
  ;; but it doesn't hurt anything and it makes the chart a little more
  ;; tidy when the base is the same as the present, or the pastpart is
  ;; the same as the past.

  (let ((forms nil)
	(feats (cons (list 'lex base)
		     (remove 'cat
		       feats
		       :test #'(lambda (feat pair)
				 (eq feat (car pair)))))))
    ;; The BASE and simple PRES forms
    (let ((newfeats
	   (append feats
		   (list (list 'vform
			       (build-var 'x
					  '(base pres)))
			 (list 'agr
			       (build-var 'y
					  '(1s 2s 1p 2p 3p)))
			 ))))
     (setq forms (list (list base (cons cat newfeats)))))
    ;; The 3s form
    (let ((newfeats
	   (append feats
		   (list (list 'vform
			       (build-var 'x
					  '(pres)))
			 '(agr 3s)
			 ))))
     (setq forms (cons (list 3s  (cons cat newfeats)) forms)))
    
    ;;  The ING form
    (let ((newfeats (append feats
			    (list '(vform ing)
				 ))))
       (setq forms (cons (list ing  (cons cat newfeats)) forms)))
   
    ;;  The past (and possibly pastpart) form
    (if (eq pastpart past)
      ;; PAST and PASTPART are the same
      (let ((newfeats
	       (append feats
		       (list (list 'vform
				   (build-var 'x '(past pastpart)))
			     (list 'agr (build-var 'agr '(1s 2s 3s 1p 2p 3p)))
			     ))))
        (setq forms (cons (list past  (cons cat newfeats)) forms)))
   
      ;;  PAST and PASTPART differ
      (let ((pastpartfeats (append feats
				   (list '(vform pastpart)
					 )))
	    (pastfeats (append feats
			       (list '(vform past)
				     (list 'agr (build-var 'agr '(1s 2s 3s 1p 2p 3p)))
				     ))))
	(append (list (list  pastpart (cons cat pastpartfeats))
	              (list  past (cons cat pastfeats)))
                forms)))
      ))

		

;;===========================================================================================
;;
;;   MORPHOLOGICAL VARIANTS
;;
;;

;;  GEN-MORPH-VARIANTS
;;  Takes a leaf node, the features specified for it, and generates a 
;;   set of additional entries based on the value of the MORPH feature.

(defun gen-morph-variants (leaf feats morphs cat)
  (if (not (assoc 'lex feats))
      (setq feats (cons (list 'lex leaf) feats)))
  (cond ((null morphs) nil)
        ((consp  morphs)
         (append
          (case (car morphs)
            
            ;;    CAR -> CARS,  CITY -> CITIES
            (-S-3p
             (list
              (list (add-suffix leaf "S")
                    (cons cat (replace-feat feats 'agr '3p)))))

	    ;;   SHORT -> SHORTER, SHORTEST
            (-er
             (add-er-suffix leaf feats cat))
            
	    ;;  FAT -> FATTER, FATTEST
            (-erDouble
             (add-er-suffix (double-last-consonant leaf) feats cat))
	    
	    ;; QUICK -> QUICKLY
	    (-ly
	     (add-ly-suffix leaf feats cat))
            
            ;;   TRUCK -> TRUCKLOAD & TRUCKLOADS
            (-load
             (list 
              (list (add-suffix leaf "LOAD")
                    (cons cat (replace-feat 
                               (replace-feat 
				(replace-feat feats 'sem 'STUFF)
				'sort 'unit)
                               'agr '3s)))
              (list (add-suffix leaf "LOADS")
                    (cons cat  (replace-feat 
				(replace-feat 
				 (replace-feat feats 'sem 'STUFF)
				 'sort 'unit)
				'agr '3s)))))
            (otherwise (parser-warn "~%IGNORING MORPH FEATURE: ~S~%" (car morphs))
                       nil))
          (gen-morph-variants leaf feats (cdr morphs) cat)))
        (t (parser-warn "~% WARNING: Bad entry ~S. MORPH features must be a list"
                        (list leaf feats)))
        ))

;;  GENERATING THE MORPHOLOGICAL VARIANTS

;;  ER-SUFFIX
(defun add-er-suffix (word feats cat)
  (let ((lf (get-fvalue feats 'lf))
	(op (get-fvalue feats 'comp-op))
	(scale (get-fvalue feats 'sem)))
    (if (null lf) (setq lf (get-fvalue feats 'lex)))
    (list
     (list (add-suffix word "ER")
           (append (list cat '(COMPARATIVE +))
		   (if op (replace-feat feats 'lf (list op scale))
		     (replace-feat feats 'lf (list 'ER lf)))))
     (list (add-suffix word "EST")
           (cons cat 
		 (cons '(COMPARATIVE SUPERL)
		       (if op (replace-feat feats 'lf (list (case op
							    (LESS 'MIN) (MORE 'MAX) (otherwise op))
							  scale))
		       (replace-feat feats 'lf (list 'EST lf)))))))))

;; -LY SUFFIX
(defun add-ly-suffix (word feats cat)
  (if (eq cat 'ADJ)
      (let ((lf (get-fvalue feats 'lf))
	    (op (get-fvalue feats 'comp-op))
	    (scale (get-fvalue feats 'sem))
	    (reduced-feats (remove-if #'(lambda (x)
					  (member (car x) '(SORT ATYPE ARGSEM ARGSORT SUBCATSEM SUBCATSORT SUBCAT SEM)))
				      feats)))
	
	(if (null lf) (setq lf (get-fvalue feats 'lex)))
	(list
	 (list (add-suffix word "LY")
	       (cons 'ADV
		     (append
		      (if op (replace-feat reduced-feats 'lf (list op scale))
			(replace-feat reduced-feats 'lf (list 'ER lf)))
		      `((SORT MANNER) 
			(ATYPE (? a PRE POSTVP)) 
			(ARGSEM EVENT)
			(ARGSORT ?argsort)
			(SUBCATSEM ?ss)
			(SUBCATSORT ?ss2)
			(SUBCAT -)
			(SEM ,scale))))))
	)))
 

;;  "S" and "E..." SUFFIXES
(defun add-suffix (word suffix)
  (let* ((wordstring (symbol-name word))
         (rev-letters (reverse (coerce wordstring 'list)))
         (last-letter (car rev-letters))
         (second-last-letter (second rev-letters))
         (all-but-last (coerce (reverse (cdr rev-letters)) 'string))
         (first-suffix-letter (car (coerce suffix 'list))))
    (intern
     (case last-letter
       ;;  switch "Y" to "I" when needed
      (#\Y
       (if (vowel second-last-letter)
         (concatenate 'string wordstring suffix)                 ;; e.g., joys
         ;;  word ends consonant "y"
         (case first-suffix-letter 
           (#\S (concatenate 'string all-but-last "IE" suffix))  ;; e.g.,   carries
           (#\I (concatenate 'string wordstring suffix))        ;; e.g., carrying
           (otherwise (concatenate 'string all-but-last "I" suffix)))))   ;; e.g.,   carried
      ;;  Drop final "E" when suffix begins with "E" or "I"
      (#\E
       (case first-suffix-letter 
         ((#\E #\I) (concatenate 'string all-but-last suffix)) ;; e.g., cared, caring
         (otherwise
          (concatenate 'string wordstring suffix))))            ;; e.g., cases
      ;;  Change "S" to "ES" after "H", "S" or "X"
      ((#\H #\S #\X)
       (if (eql first-suffix-letter #\S)
         (concatenate 'string wordstring "ES")                 ;; e.g., kisses
         (concatenate 'string wordstring suffix)))             ;; e.g., kissed
      ;;  Double final "B", "G", "P" when suffix begins with "E" 
      ;;  and fial letter was preceded by a vowel
      ((#\B #\G)
       (if (and (vowel second-last-letter)
                (member first-suffix-letter '(#\I #\E)))
         (concatenate 'string wordstring (coerce (list last-letter) 'string)
                      suffix)  ;; e.g., bagged
         (concatenate 'string wordstring suffix)))            ;; e.g., bags
      (otherwise
       (concatenate 'string wordstring suffix))
      ))
    ))

(defun vowel (letter)
  (member letter  (list  #\A #\E #\I #\O #\U)))

(defun double-last-consonant (word)
  (let* ((wordstring (coerce (symbol-name word) 'list))
         (last-letter (car (reverse wordstring))))
    (intern (concatenate 'string wordstring (list last-letter)))))



;;=========================================================================================
;;
;; Other miscellaneous Functions
;;    

;;  FUNCTION for defining entries for numbers

(defun define-numbers nil
  (mapcar #'(lambda (x)
	      (let ((word (car x))
		     (val (second x)))
		 (list word
		       (list 'number
			     (list 'ntype (make-var :name 'N
						   :values (classify-n val)))
			     (list 'agr '3p) ;; NB: AGR 3p is for use as quant. As a noun, these are 3s
			     (list 'lf val)))))
	  '((two 2) (three 3) (four 4) (five 5) (six 6) (seven 7) (eight 8)
	    (nine 9) (ten 10) (eleven 11) (twelve 12) (thirteen 13) (fourteen 14) (fifteen 15) (sixteen 16) (seventeen 17) (eighteen 18) (nineteen 19)
	    (twenty 20) (thirty 30) (forty 40) (fifty 50) (sixty 60)
	    (seventy 70) (eighty 80) (ninety 90))))
   
         
;;  dummys


(defun feats-OK (feats)
  (if (null feats)
    T
    (if (consp feats)
      (every #'(lambda (x)
                 (eql (length x) 2))
             feats))))


