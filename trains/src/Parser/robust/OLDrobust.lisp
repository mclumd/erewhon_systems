(in-package parser)
;;  WARNING - THIS FILE IS OBSOLETE - CODE WAS SPLIT INTO ROBUSTPARSER.LISP and ATTACHMENTS.LISP

;;
;; robust.lisp
;;
;; Time-stamp: <96/05/28 12:38:21 james>
;;
;; History:
;;   94 ??? ?? james   - Created.
;;   94 Dec 14 ringger - Moved Local Discourse State to reference.lisp .
;;   94 Dec 16 ringger - Included calls to Reference Resolution routines.
;;   94 Dec 19 ringger - Integrated with James's new changes that
;;                       allow backing up.
;;   94 Dec 29 miller  - check to see if arg for intern is a number (if so return it).

;;   95 Jan 12 james   - introduced indexedObject structure to clean up code
;;
;; This file contains attached functions that robustly extract information.
;;


;; Evaluating the whole buffer reintializes and recreates attachments.
;; Very handy for FI C-c C-b .
(eval-when (:load-toplevel :eval)
  (init-attachments)) 

;;  reliability threshold management

(let ((reliability-limit 10))
  
  (defun set-reliability-threshold (x)
    (setq reliability-limit x))
  
  (defun reliability-threshold nil
    reliability-limit)
  
  ) ;;  end reliability threshold management
  
(let ((current-ldc nil))

  (defun reset-current-ldc ()
    (setq current-ldc (make-ldc)))
  
  ;;  used when backing up - remove all entries with end
  ;;    position after n
  (defun Clear-CurrentLDC-after (n)
    (setf (ldc-paths-mentioned current-ldc) 
      (Remove-entries-after (ldc-paths-mentioned current-ldc) n))
    (setf (ldc-focus current-ldc)
       (Remove-entries-after (ldc-focus current-ldc) n))
    (setf (ldc-sa-mentioned current-ldc) 
      (Remove-entries-after (ldc-sa-mentioned current-ldc) n))
    (setf (ldc-sa-flags current-ldc) 
      (Remove-entries-after (ldc-sa-flags current-ldc) n))
    (setf (ldc-actions-mentioned current-ldc) 
      (Remove-entries-after (ldc-actions-mentioned current-ldc) n))
    (setf (ldc-unknown-words current-ldc) 
      (Remove-entries-after (ldc-unknown-words current-ldc) n))
  
    (setf (ldc-objects-mentioned current-ldc) 
      (Remove-entries-after (ldc-objects-mentioned current-ldc) n)))
  
  (defun Remove-entries-after (entries n)
    (remove-if #'(lambda (x) 
		   (> (indexedObject-end x) n))
	       entries))
  
  (defun get-objects-mentioned ()
    (ldc-objects-mentioned current-ldc))
  
  (defun get-paths-mentioned ()
    (ldc-paths-mentioned current-ldc))
  
  (defun get-focus ()
    (ldc-focus current-ldc))
  
  (defun get-sa-mentioned ()
    (ldc-sa-mentioned current-ldc))
  
  (defun get-sa-flags ()
    (ldc-sa-flags current-ldc))
  
  (defun get-actions-mentioned ()
    (ldc-actions-mentioned current-ldc))

  (defun get-unknown-words ()
    (ldc-unknown-words current-ldc))
  
   (defun add-to-unknown-words (word start end)
     (setf (ldc-unknown-words current-ldc)
       (cons (make-indexedObject :object word :start start :end end)
	     (ldc-unknown-words current-ldc))))
   
  ;;---------------
  ;;  FOCUS
  ;; 
  (defun add-to-focus-candidates (object start end)
     (setf (ldc-focus current-ldc)
       (AddToIndexedList object (ldc-focus current-ldc) start end)))
  
  ;;----------------
  ;; PATHS
  ;; Adds a new path to the path focus, removing all those that it
  ;;   subsumes (determined by start and end position)
  ;; note: this must return the entry if it is to be added to the chart
  
  (defun add-to-paths-mentioned (path entry start end)
    (when (not
	   (SubsumedBy (ldc-objects-mentioned current-ldc) start end)) 
      (setf (ldc-paths-mentioned current-ldc)
	(AddToIndexedList path
			  (ldc-paths-mentioned current-ldc) start end)))
    entry)
  
  ;;----------------
  ;; OBJECTS MENTIONED
  
  (defun add-to-objects-mentioned (descr start end)
    (if (constit-p descr)
	(let nil
	  (setf (ldc-objects-mentioned current-ldc)
	    (AddNPToIndexedList descr
				(ldc-objects-mentioned current-ldc) start end))
	  ;; if the object description used a PP modifier that would have
	  ;; been interpreted as a path, that should be deleted as well
	  (setf (ldc-paths-mentioned current-ldc)
	    (removeSubConstits (ldc-paths-mentioned current-ldc) start end)))
      (parser-warn "~%Bad description found: ~S~%" descr)))
  
  ;;----------------
  ;; SPEECH ACTS
  
  (defun add-to-sa-mentioned (sa start end)
    (setf (ldc-sa-mentioned current-ldc)
      (addToIndexedList sa (ldc-sa-mentioned current-ldc) start end)))
  
  (defun add-to-sa-flags (e start end)
    (pushnew (make-indexedObject :object e :start start :end end)
	     (ldc-sa-flags current-ldc)))
  
  ;;----------------
  ;; ACTION-FOCUS
    
  (defun add-to-action-mentioned (act start end)
    (setf (ldc-actions-mentioned current-ldc)
      (AddNPToIndexedList act 
			  (ldc-actions-mentioned current-ldc) start end)))
	  
)   ;; end scope of History List and Current Local Discourse State.




;;================
;;   TRAPPING NPS

(defun npfound (e)
  (trace-msg "-NP found: ~S~%" e)
  (let ((start   (entry-start e))
	(end     (entry-end e))
	(lf (simplify-Description (getFvalue e 'LF))))
    (when (wh-query e)
      (add-to-sa-flags 'WH-QUESTION  start end)
      (add-to-focus-candidates (getFvalue e 'VAR) start end))
 
    (add-to-objects-mentioned lf start end)
    (setFvalue e 'LF lf)
      )
  e)

(announce '(np (gap -) (SORT DESCR)) #'npfound)
(announce '(np-pp-word) #'npfound)

(defun definite (x)
  (member x '(THE THIS THAT)))

(defun wh-query (e)
  (eq (getFvalue e 'WH) 'Q))

;;--------
;; This simplifies DESCRIPTIONS:
;;    transforming the SORT feature 
;;    and flattening the CONSTRAINT feature

(defun simplify-Description (descr)
  (if (and (constit-p descr)
	   (eq (get-value descr 'cat) 'DESCRIPTION))
      (let* 
	  ((feats (constit-feats descr))
	   (constraint (simplifyConstraint (get-fvalue feats 'constraint)))
	   (set-constraint (simplifyConstraint (get-fvalue feats 'set-constraint)))
	   (sort (transform-sort (get-fvalue feats 'sort))))
	 
	
	(case sort
	  ((Individual Stuff Quantity) 
	   (let ((newfeats (remove-if #'(lambda (x)
					  (member (car x) '(SORT CONSTRAINT SET-CONSTRAINT)))
				      feats))
		 (newconstraint (merge-constraints constraint set-constraint)))
	     (make-constit :cat 'DESCRIPTION
			   :feats   (if newconstraint
					(append newfeats
						(list (list 'SORT sort)
						      (list 'CONSTRAINT newconstraint)))
				      (append newfeats (list (list 'SORT sort)))))))
	  (Set
	   (let* ((var (get-fvalue feats 'var))
		 (newvar  (gen-symbol 'elem))
		 (newfeats (remove-if #'(lambda (x)
					  (member (car x) '(SORT CLASS CONSTRAINT SET-CONSTRAINT))) feats))
		  (newconstraint (if (listp constraint)
				     (substitute newvar var constraint)))
		 (newclass `(PRED
			    	(ARG ,newvar)
			       	(CLASS ,(get-fvalue feats 'class)))))
	     ;;   add constraint slot only if filled
	     (if newconstraint
		 (setq newclass 
		   (append newclass (list (list 'CONSTRAINT newconstraint)))))
				
	 
	     (make-constit :cat 'DESCRIPTION
			   :feats (if set-constraint
				      (append newfeats
					  (list (list 'SORT sort)
						(list 'CLASS newclass)
						(list 'CONSTRAINT set-constraint)))
				    (append  newfeats
					  (list (list 'SORT sort)
						(list 'CLASS newclass))))))))
	  
	 )
	   
    descr))

(defun transform-sort (sort)
  (if (listp sort)
      (let ((number (identify-number (car sort)))
	    (mass (cadr sort)))
	(if (eq number 'SING)
	    (if (eq MASS '+) 'Stuff 'Individual)
	  (if (eq MASS '+) 'Quantity 'Set)))
    (if (member sort '(Individual Set Stuff Quantity))
	sort
      (let nil
	(parser-warn "~%Warning: Bad SORT in transform-sort: ~S" sort)
	'Individual))))

(defun identify-number (x)
  (cond
   ((member x '(1s 2s 3s)) 'SING)
   ((member x '(1p 2p 3p)) 'PLUR)
   ((or (eq x '-) (var-p x)) 'SING) ;; SING is the default
   (t (parser-warn "~% Bad number feature found in description: ~S" x)
      'SING)))

(defun merge-constraints (c1 c2)
  ;;  puts two constraints together
  (cond ((eq c1 '-) (if (eq c2 '-) nil c2))
	((eq c2 '-) c1)
	(t (simplifyConstraint (list 'and c1 c2)))))
;;================
;;   TRAPPING PATHS

(defun pathfound (e)
  (trace-msg "-Path found: ~S~%" (entry-constit e))
  (let ((cat (getFvalue e 'cat))
	(lf (getFvalue e 'lf)))
    (cond
     ((eq cat 'path)
      (let 
	  ;; ((newlf (list (car lf) (second lf) (simplifyConstraint (third lf)))) (list (car lf) (second lf) (simplifyConstraint (third lf))))
	  ((newlf (if (constit-p lf)
		      (replace-feature-value lf 'constraint (simplifyConstraint (get-value lf 'constraint)))
		   lf)))
	(setFvalue e 'lf newlf)
	 (add-to-paths-mentioned 
	  newlf e (entry-start e) (entry-end e))))
     ((eq cat 'vp)
      ;;  if cat is a negated VP with verb SEM GO - we need to add a negated
      ;;    path here, which will delete the earlier positive analysis
      (if (and (listp lf) (eq (car lf) 'not)
	       (listp (cadr lf)) (eq (caadr lf) 'GO-BY-PATH))
	  (add-to-paths-mentioned 
	   (simplifyConstraint 
	    (list 'not (findval 'path (cdadr lf)))) 
	   e (entry-start e) (entry-end e))))))
  e)

(defun findval (val vals)
  (cond ((null vals) nil)
	((eq (car vals) val) (cadr vals))
	(t (findval val (cddr vals)))))

;;  This flattens out the ANDS
(defun simplifyConstraint (expr)
  (cond
   ((eq expr '-) nil)
   ((and (listp expr) (eq (car expr) 'AND))
      (let
	  ((ans (delete-if #'(lambda (x) (or (eq x '-) (null x)))
			   (reverse (flattenAnds (cdr expr) nil)))))
	(if (consp ans)
	    (if (eql (list-length ans) 1)
		(car ans) (cons 'and ans))
	  ans)))
    (t expr)))

(defun flattenAnds (in out)
  (if (null in) out
    (let ((elem (car in)))
      (if (and (listp elem) (eq (car elem) 'and))
	  (flattenAnds (cdr in) (append (flattenAnds (cdr elem) nil) out))
	(flattenAnds (cdr in) (cons elem out))))))
      

(announce '(path (lf ?lf)) #'pathfound)

(announce '(vp (neg +) (sem go)) #'pathfound)

;;================
;;  TRAPPING SPEECH ACT SIGNALS

(defun speechActID (e)
  (trace-msg "-Speech Act Id: ~S ~%" (entry-constit e))
  (add-to-sa-flags (getFvalue e 'id) (entry-start e) (entry-end e))
  e)

(announce '(sa-id) #'speechActID)

;;================
;;  HANDLING EVENT/STATES

;;================
;;  TRAPPING VPS  
;;  used to build event structures
;;  we trap VPs for use in partial interpretations

;;   we ignore constituents that have non-filled gaps
(defun vpfound (e)
  (let ((gap (getFvalue e 'gap)))
    (If (or (null gap) (eq gap '-)  (and (constit-p gap) (eq (get-value gap 'cat) '-)))
	   (process-vp e))
	  (verbose-msg "-Ignoring Event/State with gap:~S~%" (entry-constit e)))
    e)

(defun process-vp (e)
  (trace-msg "-Event/State identified as ~S~%" (entry-constit e))
  (let* ((cat (getFvalue e 'cat)))
    (if (eq cat 'vp)
	(let ((constraint  (simplifyconstraint 
		    (fix-args (getFvalue e 'constraint)))))
	  (setFvalue e 'constraint constraint)
	  (setFvalue e 'lf (make-constit :cat 'prop
					 :feats `((var ,(getFvalue e 'var))
						  (class ,(getFvalue e 'class))
						  (constraint ,constraint)))))
		  
      (let ((lf (simplify-pred (getFvalue e 'lf))))
	(setFvalue e 'LF lf)
	(if (constit-p lf)
		 (add-to-action-mentioned lf (entry-start e) (entry-end e)))
	    ))))
   
(announce '(vp) #'vpfound)

(announce '(s) #'vpfound)


;;  this removes constraints with null values, replaces
;;  full constituents with their var, and then flattens the ANDS

(defun simplify-pred (lf)
  (if (constit-p lf)
    (replace-feature-value lf 'constraint
                           (simplifyConstraint (fix-args (get-value lf 'constraint))))))

(defun fix-args (cs)
  (if (consp cs)
    (let ((firstc (car cs)))
      (cond
       ((eq firstc '-) (fix-args (cdr cs)))
       ((not (and (consp firstc) (eql (length firstc) 3)))
	(cons firstc (fix-args (cdr cs))))
       (t ;; we have a binary constraint - ignore if thrid arg is
	           ;;      -, a variable, or null constit
	(let ((val (third firstc)))
	  (if (or (eq val '-)
		  (and (constit-p val) 
		       (eq (get-value val 'cat) '-)))
	      (fix-args (cdr cs))
	    (cons firstc (fix-args (cdr cs))))))))
    cs))
   	   
;;================
;;  TRAPPING S-based speech act signals

(defun processUtterance (e)
  (trace-msg "-Sentence Found ~S~%" (entry-constit e))
  (let ((start (entry-start e))
	(end (entry-end e)))
    (add-to-sa-mentioned (list (getFvalue e 'sa) (getFvalue e 'lf)) start end))
    e)

(announce '(utt) #'processUtterance)


;; ringger: Moved local discourse state functions and state to
;;          new file:  reference.lisp


;;================
;; MANAGING INDEXED LISTS
;; Element in Indexed lists are of the form (<value> <start> <end>)
;; This function adds a new element to an indexed list unless there
;; is a value that already contains the interval (<start> <end>). 
;; It also deletes any values already on the list that are contained
;; in the new interval.

(defun AddToIndexedList (val ll start end)
  (if (not (subsumedBy ll start end))
      (insertInIndexedList ll val start end)
       ll))

;;   This function checks for identical VAR features as well

(defun AddNPToIndexedList (val ll start end)
  (let ((var (get-value val 'var)))
  (if (not (NPsubsumedBy var ll start end))
      (insertInList val start end
		    (remove-if #'(lambda (x)
				   (and (eq (get-value
					     (indexedObject-object x) 'var) 
					    var)
					(<= start (indexedObject-start x)) 
					(>= end (indexedObject-end x))))
			       ll))
    ll)))
				   
;;--------
;;   remove values that fall between start and end and insert in list
;;   ordered by starting position
(defun insertInIndexedList (constits val start end)
  (insertInList val start end
		(removeSubConstits constits start end)))

;;  insert in list ordered by start position
(defun insertInList (val start end ll)
  (if (null ll)
      (list (make-indexedObject :object val :start start :end end))
    (if (< (indexedObject-start (car ll)) start)
	(cons (car ll) (insertInList val start end (cdr ll)))
      (cons (make-indexedObject :object val :start start :end end)
	    ll))))
	
(defun removeSubConstits (constits start end)
  (remove-if  #'(lambda (x)
		  (and (<= start (indexedObject-start x)) 
		       (>= end (indexedObject-end x))))
	      constits))

;;  sorts a list of indexed constituents so that objects are
;;  seen before they are referenced. Basically its left to
;;  right order except that subconstituents are before superconstituents
(defun sortNPsForReference (ll)
  (sort (copy-list ll)
	#'(lambda (x y)
	    (or (< (indexedObject-end x) (indexedObject-end y))
		(and (<= (indexedObject-end x) 
			 (indexedObject-end y))
		     (> (indexedObject-start x) (indexedObject-start y)))
		(and (= (indexedObject-start x) (indexedObject-start y))
		     (< (indexedObject-end x) (indexedObject-end y)))))))
	
  

;;--------
;; Checks a list of positioned objects and returns T if one of
;;   them would contain a constit with the new start and end positions
(defun subsumedby (objects start end)
  (some #'(lambda (x)
	    (and (<= (indexedObject-start x) start) 
		 (>= (indexedObject-end x) end)))
	objects))

;; this version also checks that the VAR are equal, so NPs
;;   within NPs are allowed.

(defun NPsubsumedby (var objects start end)
  (some #'(lambda (x)
	    (and (eq (get-value (indexedObject-object x) 'var) var)
		 (or (and (< (indexedObject-start x) start) 
			  (>= (indexedObject-end x) end))
		     (and (<= (indexedObject-start x) start) 
			  (> (indexedObject-end x) end)))))
	objects))


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
  ;;  puts the partial analyses together into speech acts
  ;;          For structures, see /u/trains/95/speechacts/InterfaceTypes
  (let*
      ((end (get-max-position))
       (fsa-result (find-speech-acts 0 end))
       (speechActs (cadr fsa-result))
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
      (list 'sa-tell :reliability 0 :mode mode 
	    :noise noise))
     (1 (replace-noise (car interps) noise))
     (otherwise 
      (list 'compound-communications-act
	    :acts interps :reliability goodness :mode mode
	    :noise noise)))
     )
   )) 
(defun replace-noise (act noise)
  "replaces the :noise value in the act with the indicated argument"
  (cond 
   ((null act) nil)
   ((eq (car act) :noise)
    (cons :noise (cons noise (cddr act))))
   (t (cons (car act) (replace-noise (cdr act) noise)))))
	
    
  

;;  SHOW-ANALYSIS - prints out the chart entries producing the
;;   interpretations

(defun ShowAnalysis nil

  (let*
      ((end (get-max-position))
       (fsa-result (find-speech-acts 0 end))
       (speechActs (cadr fsa-result)))
      
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
;;   other a list of non-utt constituents if no utt found.

;;  finds best sequences of UTTs by exhaustive search through all UTTs found

(defun Find-UTT-speech-acts (start end)
  (let 
      ((utts (get-CAT-constits-between 'UTT start end))) 
    ;;  assumes UTTS are sorted by there start-position
    (if utts
	(let* ((min-utt-end (entry-end (car (sort (copy-list utts)
						  #'(lambda (x y)
						      (< (entry-end x) (entry-end y)))))))
	       (start-utts (remove-if #'(lambda (x) (>= (entry-start x) min-utt-end)) utts))
	       (remaining-utts (nthcdr (list-length start-utts) utts))
	       (ans (find-remaining-seqs start-utts remaining-utts)))
	  (choose-best ans))
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

(defun choose-best (solutions)
  (trace-msg "~%~%Choosing between:~%" solutions)
   (let* 
      ;;  first filter by amount of utterance covered
      ((solutions-ordered-by-coverage
	(sort (mapcar #'(lambda (x) (cons (add-up-utt-lengths x) x))
		      solutions)
	      #'> :key #'car))
       (best-solutions-by-coverage (mapcar #'cdr (get-best-prefix solutions-ordered-by-coverage)))
       ;;  then pick those with the minimum number of UTTS
       (solutions-ordered-by-length
	(sort (mapcar #'(lambda (x)
			  (cons (length x) x))
		      best-solutions-by-coverage)
	      #'< :key #'car))
       ;;  then sort the best by their UTT probabilities
       (solutions-ordered-by-probability
	(sort (mapcar #'(lambda (x)
			  (cons (get-prob-score (cdr x)) (cdr x)))
		      (get-best-prefix solutions-ordered-by-length))
		      #'> :key #'car))
       (best-solutions-by-probability (get-best-prefix solutions-ordered-by-probability)))
       
    ;;   JUST return the first one of the best for now
       (cdar best-solutions-by-probability))) 

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
  
    

;;=================================================================================

;;   finds the best sequence of UTTS and returns a list 
;;    consisting of the score bvased on amount of utterance covered
;;    plus the utt sequence.

(defun find-speech-acts (start end)
    (let*
      ((utt-SAs (find-utt-speech-acts start end))
       (score (* (round (/ (* 100 (add-up-utt-lengths utt-SAs))
			   (max 1 (- (- end start) 1))))
		 (get-prob-score utt-SAs))))

    (list score (Fill-in-gaps 0 end utt-SAs))))

;; this takes a list of UTT speech acts, and builds dummy
;;  speech acts to cover parts of the utterance not covered.
;;  UTT list is sorted by entry-start.

(defun Fill-in-gaps (start end utts)
 
  (cond  
   ;;  no more input
   ((>= start end) nil)
   ;;  no more UTTS by input remains
   ((null utts)
    (list (build-dummy-utt (make-list-of-acts (find-best start end)))))

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
	  (cons dummy-utt
		(Fill-in-gaps uttstart end utts))))
      
      ))))

;;   BUILD DUMMY ACT
;;  Takes a list of constituent fragments and builds a utt entry

(defun build-dummy-utt (entries)
  (if (> (length entries) 1)
      (list entries (entry-start (car entries)) (entry-end (car (last entries))))
    (list (car entries) (entry-start (car entries)) (entry-end (car (last entries))))))

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
    (if (and (not (and (eq newsa 'TELL)
		     (null objects)
		     (null paths)
		     (null lf)))
	   (> reliability (reliability-threshold)))
	(let nil
	  ;;  if NULL act got through, there are unknown words - convert to a TELL
	  (if (eq newsa 'NULL) (setq newsa 'TELL))
	(trace-msg "-Speech Act Found: ~s~%" newsa)
 
	(list
	 (read-from-string (format nil "SA-~A" newsa))
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
;;   inserts default sa TELL if there are no acts to merge

(defun combineSAs (basicAct Modacts)
  (let ((act (if (or (null  basicAct) (eq basicAct '-))
		 'speech-act
	       basicAct)))
    (mapcar #'(lambda (a)
		(cond ((subtype 'SEM a act)
		       (setq act a))))		   
	   Modacts)
    (if (eq act 'speech-act) 'tell act)))
	 

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
	  (startNewUtterance (prepare-input-for-parser content))
	  (set-msg-started mode))
	 ((start :start)
	  (set-msg-started mode)
	  (startNewUtterance nil))
	 ((end :end)
	  (list 'sa-null :reliability 100))
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
	   (flush-and-restart content oldmode)))))
      ;; Otherwise, we have other modes
      (otherwise
       (process-content content mode))
      )))

(defun convert-mode (mode)
  "This converts information sources into official modes"
  (case mode
    ((speech-in speech-pp) 'speech)
    ((display) 'text)
    (otherwise mode)))
    

(defun flush-and-restart (content oldmode)
  "Mode changed without proper signals. We flush output and restart. If 
    message was an :END, howver, we return the old input"
  (case (car content)
    ((start :start) (startNewUtterance nil))
    ((text word :text :word)
     (startNewUtterance (prepare-input-for-parser content)))
    ((end :end)
     (getAnalysis (convert-mode oldmode)))
  ))

(defun process-content (content output-mode)
  "Process-content processes input in cases where there is no input-mode change"
  (case (car content)
    ((word text :word :text)
     (continueUtterance (prepare-input-for-parser content)))
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


(defun prepare-input-for-parser (in)
  (let* ((new-tokens (tokenize (second in)))
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


