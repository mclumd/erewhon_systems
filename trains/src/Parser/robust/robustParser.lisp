(in-package parser)

;;
;; robustParser.lisp
;;
 
;;  This file contains the code for the ROBUST PARSER. It provides interface functions
;;  to the KQML interface, and contains the code that extracts speech acts from the 
;;  Chart.

(defparameter *num-interps* 1
  "The maximum number of (not neccesarily distinct) interpretations that
we will output.  Currently, this number probably needs to be at least twice
the number of distinct speech acts you wactually want output.")

;;  reliability threshold management - interpreations below this number
;;  will be suppressed.

(let ((reliability-limit 10))
  
  (defun set-reliability-threshold (x)
    (setq reliability-limit x))
  
  (defun reliability-threshold nil
    reliability-limit)
  
  ) ;;  end reliability threshold management
  

;;================
;;  TOP-LEVEL FUNCTIONS

(defun startNewUtterance (input)
  (reset-current-ldc)
 
  ;; 11/21/94 BWM allow for input to be in wrong package.
  (start-BU-parse 
	(cons '(start-of-utterance :start 0 :end 1)
	      ;; (mapcar #'(lambda (x) 
	      ;;(if (numberp x) x (intern x (find-package 'parser)))))
                      input))
  T)

;;   GETANALYSIS
;;   interprets the chart and trace from monitors to construct a speech act
;;   interpretation of the input. The MODE is :speech or :text, inidctaing what
;;   modality was used for th input

(defun getAnalysis (mode)
  
  (if *NEW-SA-FORMAT* (newgetAnalysis mode)
    (oldgetAnalysis mode)))

(defun oldgetAnalysis (mode)
  ;;  puts the partial analyses together into speech acts
  ;;          For structures, see /u/trains/95/speechacts/InterfaceTypes

  ;; the 'car' stuck in for now so we just get 1 interpretation.
  (car
   (remove-duplicates
    (let
	((end (get-max-position)))
      (mapcar 
       #'(lambda (fsa-result)
	   (let*
	       ((speechActs (cadr fsa-result))
		(goodness (car fsa-result))
		(interps
		 (remove-if #'null
			    (mapcar 
			     #'(lambda (saentry)
				 (let* ((e (car saEntry))
					(start (second saEntry))
					(end (third saEntry))
					(unknowns (filter-objects (get-unknown-words) start end)))
				   (if (entry-p e)
				       (let*
					   ((utt (entry-constit e))
					    (words (get-input-seq-from-entry e))
					    (sa (get-value utt 'sa))
					    (disc-function (get-value utt 'disc-function))
					    (filter-obLF (keywordifyList (get-value utt 'lf)))
					    (sa-var (if (constit-p filter-obLF) (get-value filter-obLF 'var)))
					    (setting (get-value utt 'setting))
					    (subject (get-value utt 'subjvar))
					    (object (get-value utt 'dobjvar))
					    (newsa (combineSAs sa
							       (filter-objects (get-sa-flags) start end)))
					    (obj-paths-focus (get-actual-values e)))
					 ;;  use information extracted from chart to build speech act
					 (make-speech-act newsa 
							  (third obj-paths-focus) ;; focus
							  (first obj-paths-focus) ;; objects
							  (second obj-paths-focus) ;; paths
							  (remove-if #'(lambda (x) (eq (get-value  x 'var) sa-var))
								     (fourth obj-paths-focus)) ;; actions
							  filter-obLF
							  unknowns
							  disc-function
							  ;;reliability measure modified by unknown words
							  ;;  we include start-of-utterance punc as well, but no
							  ;;  penalty is given if not present. If the utt includes
							  ;;  it, the score may be over 100, so we trim is back to the max.
							  (min 100
							       (round (/ goodness
									 (+ 1 (/ (length unknowns) 2)))))
							  mode  ;; mode
							  setting ;; setting
							  subject
							  object
							  words
							  ))
				     ;;  use information colected by monitors to guess at speech act
				     (make-speech-act (combineSAs nil (filter-objects (get-sa-flags) start end))
						      (car (last (filter-objects (get-focus) start end)))
						      (filter-objects 
						       (sortNPsForReference
							(get-objects-mentioned)) start end)
						      (filter-objects (get-paths-mentioned) start end)
						      (filter-objects (get-actions-mentioned) start end)
						      nil
						      unknowns
						      nil  ;; disc function
						      (round (/ (* 2 goodness) (max 2 (length e)))) ;; reliability reduced  by number of fragments found
						      mode   ;; mode
						      nil ;; setting
						      nil ;; subject
						      nil ;;object
						      '(not-available)
						      ))))
			     speechActs))))
	     ;;  reset the mouse focus for next utterance
	     (set-mouse-focus nil)
	    
	     ;; now, return the appropriate speech act constructions
	     (let 
		 ((noise  (filter-objects (get-unknown-words) 0 end)))
	       (case (length interps)
		 (0 
		  (list 'speech-act :reliability 0 :mode mode 
			:noise noise))
		 (1 (replace-noise (car interps) noise))
		 (otherwise 
		  (list 'compound-communications-act
			:acts interps :reliability goodness :mode mode
			:noise noise)))
	       )))
       (find-speech-acts 0 end))
      )
    :test #'(lambda (x y) (equal (remove-rel x) (remove-rel y)))
    :from-end t))
)

(defun replace-noise (act noise)
  "replaces the :noise value in the act with the indicated argument"
  (cond 
   ((null act) nil)
   ((eq (car act) :noise)
    (cons :noise (cons noise (cddr act))))
   (t (cons (car act) (replace-noise (cdr act) noise)))))
	
;; given a list structure of a CCA or a single SA (what the parser output
;; looks like), remove ":RELIABILITY XX" from wherever it appears in the
;; list structure.
(defun remove-rel (s)
  (if (consp s)
      (if (atom (car s))
	  (if (eql (car s) :RELIABILITY)
	      (remove-rel (cddr s))
	    (cons (car s)
		  (remove-rel (cdr s))))
	(cons (remove-rel (car s))
	      (remove-rel (cdr s))))
    s))

    
;;  SHOW-ANALYSIS - prints out the chart entries producing the
;;   interpretations

;; problem right now is that we have duplicates.  we should figure out how
;; to have 'find-speech-acts' eliminate them, if possible.
(defun ShowAnalysis nil
  (let
      ((end (get-max-position)))
    (mapcar 
     #'(lambda (fsa-result)
	 (format t "~%~%***INTERPRETATION FOUND:~%")
	 (let 
	     ((speechActs (cadr fsa-result)))
	   (mapcar
	    #'(lambda (x)
		(Format t "~%~%SPEECH ACT FOUND:~%")
		(if (entry-p (car x))
		    (print-tree 1 (car x) nil)
		  (mapcar #'(lambda (y)
			      (FORMAT t "~%")
			      (print-tree 1 y nil))
			  (car x))))
	    speechActs))
	 (values))
     (find-speech-acts 0 end))))

;;    SHOW-SPEECH ACTS
;;   This combines getAnalysis and showAnalysis and returns a
;;   string for demo display purposes.

(defun show-speech-acts (&optional features)
  (if (null features ) (setq features '(LF SEM LEX)))
   (let*
       ((end (get-max-position))
	(speechActs (getAnalysis :display))
	(fsa-result (find-speech-acts 0 end))
	(parseTrees (cadr fsa-result)))
     (Format t "~%~%SPEECH ACT FOUND:~%")
     (print-nicely speechActs)
     (Format t "~%from parse trees:~%")
    (mapcar
     #'(lambda (TREE)
	
	 (if (entry-p (car TREE))
	     (print-abbrev-tree features 0 (car TREE) nil)
	   (mapcar #'(lambda (y)
		       (FORMAT t "~%")
		       (print-abbrev-tree features 0 y nil))
		   (car TREE))))
     parseTrees))
   (values))

;;=====================================================================================
;;  returns a list of utt constituents corresponding to speech acts,
;;   or a list of non-utt constituents if no utt found.

;;  finds best sequences of UTTs by exhaustive search through all UTTs found

(defun Find-UTT-speech-acts (start end)
  (let 
      ((utts (get-CAT-constits-between 'UTT start end))) 
    ;;  assumes UTTS are sorted by their start-position
    (if utts
	(let* ((min-utt-end (entry-end (car (sort (copy-list utts)
						  #'(lambda (x y)
						      (< (entry-end x) (entry-end y)))))))
	       (start-utts (remove-if #'(lambda (x) (>= (entry-start x) min-utt-end)) utts))
	       (remaining-utts (nthcdr (list-length start-utts) utts))
	       (ans (find-remaining-seqs start-utts remaining-utts)))
	  (choose-best ans *num-interps*))
      ;;  no interps found, return "null" SA over entire input
      (list nil)
      )))
     
(defun find-utt-seqs (prefix utts)
    (if (null utts)
	(list (list prefix))
      (let* ((min-utt-end  
	      (entry-end (car (sort (copy-list utts)
				    #'(lambda (x y)
					(< (entry-end x) (entry-end y)))))))
	     (start-utts (remove-if #'(lambda (x) (>= (entry-start x) min-utt-end)) utts))
	     (remaining-utts (nthcdr (list-length start-utts) utts))
	     (remaining-seqs (find-remaining-seqs start-utts remaining-utts))
	     (ans (if (null remaining-seqs) (list (list prefix))
		    (mapcar #'(lambda (x) (cons prefix x)) remaining-seqs))))
	      ans
      )))

(defun find-remaining-seqs (start-utts remaining-utts)
  (collapse-list-of-lists
   (delete-if  #'NULL
	       (mapcar #'(lambda (u) 
			   (let ((end (entry-end u)))
			     (find-utt-seqs u 
					    (remove-if #'(lambda (x) (< (entry-start x) end))
						       remaining-utts))))
		       start-utts))))

;; detructive collapsing of a list of lists of answers to form one
;; list of answers
(defun collapse-list-of-lists (list-of-lists)
  (if (null list-of-lists) nil
    (nconc (car list-of-lists) (collapse-list-of-lists (cdr list-of-lists)))))

(defun choose-best (solutions &optional (n 1))
  (trace-msg "~%~%Choosing between:~%" solutions)
  (let* 
      ;; we're doing a radix-type sort, so do the last distinction first

      ;; by probability is least important
      ((solutions-ordered-by-probability
	(mapcar 'cdr
		(sort (mapcar #'(lambda (x)
				  (cons (get-prob-score x) x))
			      solutions)
		      #'> :key #'car)))

       ;; next, by fewest # of utts
       (solutions-ordered-by-length
	(mapcar 'cdr
		(stable-sort (mapcar #'(lambda (x)
					 (cons (length x) x))
				     solutions-ordered-by-probability)
			     #'< :key #'car)))

       ;; the most important criteria is coverage
       (solutions-ordered-by-coverage
	(mapcar 'cdr
		(stable-sort (mapcar #'(lambda (x) 
					 (cons (add-up-utt-lengths x) x))
				     solutions-ordered-by-length)
			     #'> :key #'car)))
       )

    ;; return the n-best solns
    (subseq solutions-ordered-by-coverage 0 n)))

;;  this takes a sorted list of solutions of form (score solution)
;;   and returns the list  of solutions with the highest score
(defun get-best-prefix (solutions)
  (let ((best (caar solutions)))
    (delete-if #'(lambda (x) (/= (car x) best))
	       solutions)))

(defun add-up-utt-lengths (uttlist)
   (if (null uttlist) 0
     (let* ((utt (car uttlist))
	    (uttstart (max (entry-start utt) 1)))
       (+ (- (entry-end utt) uttstart)
	  (add-up-utt-lengths (cdr uttlist))))))

;;  this returns the product of the probabilities of a list of constituents
(defun get-prob-score (uttlist)
  (if (null uttlist) 1
    (* (entry-prob (car uttlist))
       (get-prob-score (cdr uttlist)))))

(defun get-prob-score-min (uttlist)
  (if (null uttlist) 1
    (min (entry-prob (car uttlist))
	 (get-prob-score-min (cdr uttlist)))))

;;=================================================================================

;;   finds the best sequence of UTTS and returns a list 
;;    consisting of the score based on amount of utterance covered
;;    plus the utt sequence.  ** SCORING FORMULA **

(defun find-speech-acts (start end)
  (mapcar #'(lambda (utt-SAs)
	      (let*
		  ((final-utts (Fill-in-gaps 0 end utt-SAs))
		   (number-generic-acts (count-if-not #'(lambda (x) (entry-p (car x))) final-utts))
		   (score (* 1
			   ;; factor based on perentage of words covered
			   (round (/ (* 100 (add-up-utt-lengths utt-SAs))
				     (max 1 (- (- end start) 1))))
			   ;; factor based on parser score
			   (- 1 (- .5 (* .5 (get-prob-score-min utt-SAs))))
		 
			   ;; factor based on number of generic acts
			   (/ 1 (max number-generic-acts 1))
		 
			   ;; factor for total number of acts
			   (/ 1 (if (< (length final-utts) 4)
				    1
				  (- (length final-utts) 2))))))
		(list score final-utts)))
	  (find-utt-speech-acts start end)))

;; this takes a list of UTT speech acts, and builds dummy
;;  speech acts to cover parts of the utterance not covered.
;;  UTT list is sorted by entry-start.

(defun Fill-in-gaps (start end utts)
 
  (cond  
   ;;  no more input
   ((>= start end) nil)
   ;;  no more UTTS by input remains
   ((null utts)
    (let ((acts  (make-list-of-acts (find-best start end))))
      (if acts
	  (list (build-dummy-utt acts)))))

   ;;  usual case
   (t
    (let* ((first-utt (car utts))
	   (uttstart (entry-start first-utt))
	   (first-entry (list first-utt uttstart (entry-end first-utt))))
	  
      (if
       ;; first UTT is next in input
	  (or (= start uttstart) (and (= start 0) (= uttstart 1)))
	  (cons first-entry
		(Fill-in-gaps (entry-end first-utt) end (cdr utts)))
	;;  first UTT is not next, but there is another UTT, need to fill in gap before it
     	(let* ((constits (find-best start uttstart))
	       (dummy-utt (build-dummy-utt (make-list-of-acts constits))))
	  (if dummy-utt
	      (cons dummy-utt
		    (Fill-in-gaps uttstart end utts))
	    (Fill-in-gaps uttstart end utts)))
      
      )))))

;;   BUILD DUMMY ACT
;;  Takes a list of constituent fragments and builds a utt entry

(defun build-dummy-utt (entries)
  (when (consp entries)
    (if (> (length entries) 1)
	(list entries (entry-start (car entries)) (entry-end (car (last entries))))
      (list (car entries) (entry-start (car entries)) (entry-end (car (last entries)))))
    ))

;;  MAKE-LIST-OF-ACTS 
;;    This takes the output of find-best, and returns single list
;;    of constituents covering the input: preferring UTT constituents whenever
;;    possible, and otherwise simply picking the first one when there are multiple
;;    entries.
(defun make-list-of-acts (best)
  (if best
    (let*
      ((first (car best))
       (start (entry-start first))
       (candidates (remove-if-not #'(lambda (x) (eq (entry-start x) start)) best))
       (utts (remove-if-not #'(lambda (x) (eq (constit-cat (entry-constit x)) 'utt)) candidates))
       (rest (nthcdr (length candidates) best)))
      (if utts
        (cons (car utts) (make-list-of-acts rest))
        ;;  no utt found
        (cons first (make-list-of-acts rest))))))

(defun make-speech-act (newsa focus objects paths defs lf unknown-words disc-function reliability mode setting subject object words)
  (if (and (eq newsa 'NULL) (null unknown-words))
      (list 'sa-null :reliability 100)
    (if (and (not (and (eq newsa 'SPEECH-ACT)
		     (null objects)
		     (null paths)
		     (null lf)))
	   (> reliability (reliability-threshold)))
	(let nil
	  ;;  if NULL act got through, there are unknown words - convert to a SPEECH-ACT
	  (if (eq newsa 'NULL) (setq newsa 'SPEECH-ACT))
	(trace-msg "-Speech Act Found: ~s~%" newsa)
 
	(list
	 (if (eq newsa 'SPEECH-ACT) 
	     newsa
	   (read-from-string (format nil "SA-~A" newsa)))
	 :focus (KeywordifyList focus)
	 :objects (keywordifyList (undo-constits  objects))
	 :paths (KeywordifyList (undo-constits  paths))
	 :defs (KeywordifyList (undo-constits defs))
	 :semantics (if (not (member lf '(- :-))) (KeywordifyList (undo-constit lf)))
	 :noise unknown-words
	 :social-context (if (not (eq disc-function '-)) (KeywordifyList disc-function))
	 :reliability reliability
	 :mode mode
	 :syntax (list (cons :subject (if (not (member subject '(- :-))) (KeywordifyList subject)))
		       (cons :object (if (not (member object '(- :-))) (KeywordifyList object))))
	 :setting (if (and setting (not (eq setting '-))) (KeywordifyList setting))
	 :input (remove-if #'(lambda (x) (member x '(START-OF-UTTERANCE END-OF-UTTERANCE))) words))
	)))
  )
   
(defun undo-constits (vals)
  (if (listp vals)
   (mapcar #'(lambda (constit) 
	       (cond
		((constit-p constit)
		   (list* (constit-cat constit)
			  (mapcar #'(lambda (fv)
				      (list (car fv) (undo-constits (cadr fv))))
				  (constit-feats constit))))
		((consp constit)
		   (undo-constits constit))
		(t  constit)))
	   vals)
   (undo-constit vals)))
  

(defun undo-constit (c)
  (if (constit-p c)
      (list* (constit-cat c) (undo-constits (constit-feats c)))
    c))

;;  finds an entry with constit of cat UTT between the start and end position
;;  If there are several, this just returns the first for now.
(defun get-utt-entry (start end)
  (find-if #'(lambda (x)
	       (eql (entry-end x) end))
	   (get-entries-by-position 'utt start)))

;; =======================================================================
;;  OLD Traversal Code: used only if *NEW-SA-FORMAT* is nil.

;;  This traverses an entry and finds
;;  1. the logical forms of all NPs found, except those
;;     which are head subconstituents of a larger NP
;;  2. all maximal paths found


(let ((actual-paths nil)
      (actual-objects nil)
      (actual-focus nil)
      (actual-actions nil))
      
      (defun actuals nil
	(list actual-paths actual-objects actual-focus actual-actions))
      
      (defun get-actual-values (entry)
	(setq actual-paths nil)
	(setq actual-objects nil)
	(setq actual-focus nil)
	(setq actual-actions nil)
	(let
	    ((lf (get-value (entry-constit entry) 'lf)))
	  (find-vals-in-constit-tree (build-constit-tree entry nil) 
				nil nil nil 
				(if (constit-p lf) (list (get-value lf 'var)))))
	(list (reverse actual-objects)
	      (reverse actual-paths) 
	      actual-focus
	      (reverse actual-actions)))

      ;; FIND-VALS-IN-CONSTIT-TREE
      ;;   ENTRY - the entry to check
      ;;   NP-EXCEPT - the variable of the containing NP, we ignore
      ;;        sub-nps with same VAR
      ;;   NO-PATHS - set when we are within a path already, so
      ;;       no subpaths are recorded
      ;;   FOCUS-ALREADY-FOUND - have already found an object to a verb
      ;;       so ignore others in sub-sonstituents for the focus
      ;;   PROP-EXCEPT - the variable of the containing S or VP
     
       (defun find-vals-in-constit-tree (constit-tree np-except no-paths focus-already-found prop-except)
	(let* ((constit (car constit-tree))
	       (cat (constit-cat constit))
               (var (get-value constit 'var))
	       (npvar (if (eq cat 'np) 
                        var
                        np-except))
	       (is-path (eq cat 'path))
	       (new-prop-except (if (and (member cat '(PRED S VP)) (not (member var prop-except)))
				    (cons var prop-except)
				  prop-except))
	       (no-path-for-subs (or no-paths is-path))
	       (focus (check-for-focus cat constit))
		      
	       (focus-found (or focus-already-found focus)))
	  
	  ;; now process all subconstituents
	  (mapcar #'(lambda (c)
		      (find-vals-in-constit-tree
		       c  npvar 
		       no-path-for-subs focus-found new-prop-except))
		  (cdr constit-tree))
	  ;;  now process the current constituent
	  (cond 
	   ((and (member cat '(vp pred s)) (not (member var prop-except)))
	    (let ((lf (get-value constit 'LF)))
	      (if lf
		  (setq actual-actions 
		    (cons lf actual-actions))
		(parser-warn "Found constituent with empty LF: ~S" constit))))
	   ((and (member cat '(np np-pp-word)) (not (eq var np-except)))
	    (setq actual-objects 
	      (cons (get-value constit 'lf) actual-objects)))
	   ((and is-path (null no-paths))
	    (setq actual-paths 
	      (cons (simplifyConstraint (get-value constit 'lf)) actual-paths))))
	  (if (and (not focus-already-found) focus)
	      (setq actual-focus focus))))
           
       ) ;; end scope of ACTUAL-PATHS, ACTUAL-OBJECTS and ACTUAL-FOCUS


;;  This checks for syntactic indicators of focus
;;  suchas the object of the main verb, or object of "there" sentences

(defun check-for-focus (cat constit)
  (let ((foc (get-value constit 'focus)))
    (if (not (member foc (list '- *empty-constit*)))
	foc)))

;;==========================================================================
;;
;; NEW CODE FOR BUILDING THE SPEECH ACT INTERPRETATION

;; must set *NEW-SA-FORMAT* to t to use this code
	       
(let ((temp-symbol-table nil))
 
  (defun add-to-temp-symbol-table (var val)
    (setq temp-symbol-table (cons (cons var val) temp-symbol-table)))
 
  (defun reset-temp-symbol-table nil
    (setq temp-symbol-table nil))
 
  (defun get-temp-symbol-table nil 
    temp-symbol-table)) 

(defun find-objects-in-constit (x)
  (find-objects-in-constit-tree (build-constit-tree (get-entry-by-name x) nil)))

(defun find-objects-in-constit-tree (constit-tree)
  (reset-temp-symbol-table)
  (traverse-tree-for-objects constit-tree)
  (get-temp-symbol-table))

(defun traverse-tree-for-objects (constit-tree)
  (let* ((constit (car constit-tree))
	 (lf (get-value constit 'lf))
	 (var (if (constit-p lf) (get-value lf 'var))))
    (unless (or (null var) (assoc var (get-temp-symbol-table)))
      (add-to-temp-symbol-table var lf))
    (if (cdr constit-tree)
	(mapcar #'traverse-tree-for-objects (cdr constit-tree))
      )))
 
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    

(defun continueUtterance (input)
   (continue-BU-parse 
    
            input)
   T)

(defun backUpWords (numb)
  ;;  backs up the parser n words
  (trace-msg "~%Backing up ~s words" numb)
  (backup numb)
  T)

;;  This returns any values that is in  the interval (start end)

(defun filter-objects (elements start end)
   (mapcar #'(lambda (x)
	      (indexedObject-object  x))
	   (remove-if #'(lambda (e)
			  (or (< (indexedObject-start e) start)
			      (> (indexedObject-end e) end)))
		      elements)))
;;--------
;;  Modifies a basic speech act to another more specific type flagged
;;   by a sa-id.
;;   inserts default sa SPEECH-ACT if there are no acts to merge

(defun combineSAs (basicAct Modacts)
  (let ((act (if (or (null  basicAct) (eq basicAct '-))
		 'speech-act
	       basicAct)))
    (mapcar #'(lambda (a)
		(cond ((subtype 'SEM a act)
		       (setq act a))))		   
	   Modacts)
     act))
	 

;;  Functions to maintain the immediate discourse state

(let ((msg-started 'none) ;;  records whether a message is currently in progress (keyboard or speech)
      (current-speaker nil) ;; who is speaking
      (mouse-focus nil) ;; last object clicked on
      (last-mouse-focus nil)) ;; the second last object clicked on
  
  (defun set-mouse-focus (x)
    (setq last-mouse-focus mouse-focus)
    (setq mouse-focus x))
  
  (defun get-mouse-focus nil
    mouse-focus)
  
  (defun get-last-mouse-focus nil
	  last-mouse-focus)
  
  (defun init-mouse-focus nil
    (setq mouse-focus nil)
    (setq last-mouse-focus nil))
  
  (defun get-msg-started     nil 
    msg-started)
  
  (defun set-msg-started (x)
    (setq msg-started x))
  
  (defun get-current-speaker nil
    current-speaker)
  
  (defun set-current-speaker (x)
    (setq current-speaker x))

  (defun get-current-hearer nil
    (if (eq current-speaker :system) :user :system))
 
  
  ) ;; end scope of MSG-STARTED, CURRENT-SPEAKER, MOUSE-FOCUS, and LAST-MOUSE-FOCUS


;;  PARSE handles input from different sources - keyboard, speech and mouse
;;    and manages when to return information. Generally, it waits until an
;;    end-of-line in text, or explicit end signal from speech before it 
;;    returns an analysis. Mouse actions done in isolation are treated as 
;;    an single act and an analysis is returned.

;;   It has two speech input modes, and ignores :SPEECH-IN inputs if
;;    :SPEECHPP inputs are coming in. It has one "text" mode, :DISPLAY.
;;   The output modes are SPEECH and TEXT.

(defun parse (speaker mode content)
  "Parse CONTENT from SPEAKER in MODE.
If SPEAKER is not :user, this does nothing but update the current speaker.
The MODE should be 'speech-in or 'speech-npp for speech, or display for text"
  (let ((oldmode (get-msg-started))) 
    (set-current-speaker speaker)
    (if (not (eq speaker :user))
	(return-from parse nil))
    (case oldmode
      ;;  oldmode = NONE. We must be starting an utterance
      ;;  if given an END, we return an empty speech act
      (none 
       (case (car content) 
	 ((word text :word :text)
	  (startNewUtterance (prepare-input-for-parser content mode))
	  (set-msg-started mode))
	 ((start :start)
	  (set-msg-started mode)
	  (startNewUtterance nil))
	 ((end :end)
	  (list 'sa-null :reliability 100 :mode (convert-mode mode)))
	 (otherwise
	  (process-content content (convert-mode mode)))
       ))
      ;; Oldmode = SPEECH-IN or DISPLAY, if mode changed, we flush and restart
      ((speech-in :speech-in display :display)
       (if (eq mode oldmode)
	   (process-content content (convert-mode mode))
	 ;; otherwise, we have changed modes - flush and restart
	 (let nil
	   (set-msg-started mode)
	   (flush-and-restart  content oldmode))))
      ;; Oldmode = SPEECH-PP, ignore SPEECH-IN messages
      ((speech-pp :speech-pp)
       (case mode
	 ((speech-in :speech-in) nil)
	 ((speech-pp :speech-pp) (process-content content 'speech))
	 ;; switching modes, flush and restart
	 (otherwise 
	  (let nil
	   (set-msg-started mode)
	   (flush-and-restart content (convert-mode oldmode))))))
      ;; Otherwise, we have other modes
      (otherwise
       (process-content content mode))
      )))

(defun convert-mode (mode)
  "This converts information sources into official modes"
  (case mode
    ((speech-in speech-pp :speech-in :speech-pp) 'speech)
    ((display) 'text)
    (otherwise mode)))
    

(defun flush-and-restart (content oldmode)
  "Mode changed without proper signals. We flush output and restart. If 
    message was an :END, howver, we return the old input"
  (case (car content)
    ((start :start) (startNewUtterance nil))
    ((text word :text :word)
     (startNewUtterance (prepare-input-for-parser content oldmode)))
    ((end :end)
     (getAnalysis (convert-mode oldmode)))
  ))

(defun process-content (content output-mode)
  "Process-content processes input in cases where there is no input-mode change"
  (case (car content)
    ((word text :word :text)
     (continueUtterance (prepare-input-for-parser content output-mode)))
    ((start :start)
     (startNewUtterance nil))
    ((end return :end :return)
     (continueUtterance `((end-of-utterance :start ,(get-max-position))))
     (set-msg-started 'none)
     (getanalysis output-mode))
    ((backto :backto)
     (let ((index (find-value (cdr content) :index)))
       (if (numberp index)
	   (backUpToPosition index)
	 (parser-warn "~%Bad index to backto: ~S" index)))
     (values))
    ;;  the old format - backup one word
    ((backword :backword)
     (backupwords 1))
    ((mouse :mouse)
     (process-mouse-action (cdr content)))
    ((confirm :confirm)
     (set-msg-started 'none)
     (process-confirm-action (cdr content)))
    ((menu :menu)
     (set-msg-started 'none)
     (process-menu-action (cdr content)))
    ((input-end :input-end) ;; button was released but we don't care as word may still come
     )
    (otherwise 
     (parser-warn "parse: can't parse content: ~S" content)
     nil)))


;;  This prepares kqml parse requests into the input format for the parser
;;  e.g., it takes a list of the form
;;   (word "dog's" :num (3 5) ...)
;;   and produces
;;    ((DOG :start 3 :end 4) (^S :start 4 :end 5))
;;  it also installs default values 
;;     If :num is a single number it is taken as the start and end is computed
;;     If :num is absent, it uses the parser defaults (treat as next word after last seen)
;; we also spell check kbd input

(defun prepare-input-for-parser (in mode)
  (let* ((new-tokens (tokenize (second in)))
	 (new-tokens (if (eql mode 'text)
			 (spell-check new-tokens)
		       new-tokens))
	 (number-of-tokens (length new-tokens))
	 (indices (find-value in :index))
	 (start (if indices (if (numberp indices) indices (car indices))))
	 (end (if (and indices (consp indices)) (second indices)))
	 (span-length (if end (- end start))))
    ;; We process differently depending on whether the END index was specifie
    (if end
      (cond 
       ;;  ERROR condition: more tokens that can fit between indices
       ;;    we ignore the end index after generatingan error message
       ((< span-length number-of-tokens)
        (parser-warn (Format nil "Bad Args to parser: number of tokens not consistent with indices:~A, ~A" 
                                  new-tokens indices))
        (generate-standard-sequence new-tokens start))
       ;;  Standard case, number of tokens 
       ((= span-length number-of-tokens)
        (generate-standard-sequence new-tokens start))
       ;;  Span length is greater than number of tokens.
       ;;   It not clear what to do here if the number of tokens is > 1
       (t 
        (if (= number-of-tokens 1)
          `((,(car new-tokens) :start ,start :end ,end))
          ;; put all the extra span on first word. This is good for compounds like
          ;;  possessives e.g., (DOG ^S), but questionable otherwise.
          (let ((first-end (+ 2 (- span-length number-of-tokens))))
            (cons `((,(car new-tokens) :start ,start :end ,first-end))
                  (generate-standard-sequence (cdr new-tokens) first-end))))))
      ;;  END is NIL
      (if (numberp start)
        (generate-standard-sequence new-tokens start) 
        ;;  no indices specified. Use parser defaults
        new-tokens))))

(defun generate-standard-sequence (tokens start)
  "generates the standard sequence of sequentially indexed tokens"
  (if tokens
    (cons `(,(car tokens) :start ,start :end ,(+ start 1))
          (generate-standard-sequence (cdr tokens) (+ start 1)))))

;;;
;;;  FUNCTIONS FOR TESTING

(defun p (x)
  (parse :user 'display '(start))
  (parse :user 'display (list 'word x))
  (print-nicely (parse :user 'display '(return))))

(defun start-test (x)
  (parse :user 'display '(start))
  (parse :user 'display (list 'word x)))

(defun end-test (x)
  (parse :user 'display (list 'word x))
  (parse :user 'display '(return)))

(defun print-nicely (x)
  (format t "~&~S" (car x))
  (print-pairs (cdr x)))

(defun print-pairs (x)
  (when x
    (Format t "~%~T~S ~S" (first x) (second x))
    (print-pairs (cddr x))))


