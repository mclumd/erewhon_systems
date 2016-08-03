(in-package parser)

;;
;; Chart.lisp
;;
;; Functions for managing the chart.
;;
;; Time-stamp: <96/10/17 13:56:23 james>
;;
;; Author: James Allen
;; History:
;;   ?? ??? ?? james   - Created.
;;   94 Dec 14 ringger - Moved tracing to trace.lisp
;;

;;;======================================================================
;;; NLP code for use with Natural Language Understanding, 2nd ed.
;;; Copyright (C) 1994 James F. Allen
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 2, or (at your option)
;;; any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program; if not, write to the Free Software
;;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
;;;======================================================================

;; THE CHART DATA STRUCTURE
;;
;;  Throughout, the term "arc" will be used for non-completed active arcs, and
;;    "entry" will be used for completed arcs containing a constituent.
;;
;; The chart is stored in four different variables:
;;     chart-arcs - an array that stores arcs indexed by their ending position
;;     constits-by-name chart-entries - an assoc list all the
;;       completed constituents, allows the code to access consituent
;;       by their unique name.
;;     constits-by-position - an array of the
;;       completed constituents indexed by their beginning
;;       position. This is not by the parser, but is used in analyzing the chart
;;       for finding best answers, etc.

(let  ((chart-arcs nil)
       (constits-by-name nil)
       (maxChartSize 2000) ;; accepts up to 20 sec utterances
       (constits-by-position nil))
  
  (defun setMaxChartSize (n)
    (setq maxChartSize n))
  
  (defun getMaxChartSize nil
    maxChartSize)
       
  ;;  This initializes structures of the appropriate size for a given sentence.
       
  (defun make-chart (size)
    (if (null size) (setq size maxChartSize))
    (setq chart-arcs (make-array (list (1+ size))))
    (setq constits-by-position (make-array (list (1+ size))))
    (setq constits-by-name nil))

  (defun get-chart-arcs nil chart-arcs)
  (defun get-constits-by-position nil constits-by-position)
  (defun get-constits-by-name nil constits-by-name)

       
  ;;  MAINTAINING THE ACTIVE ARCS ON THE CHART
       
  ;;  Adding an arc to the chart 
  (defun add-arc-to-chart (arc)
    (let ((e (arc-end arc)))
      (setf (aref chart-arcs e) (cons arc (aref chart-arcs e)))))
       
  ;; Retrieving all arcs ending at a specified position p
       
  (defun get-arcs (p)
    (aref chart-arcs p))
       
  ;;   PUT-IN-CHART  - adds an entry e identified by symbol name into the
  ;;     chart data structures, unless an identical one is already there
  ;;     or if the constituent is non-empty and has a gap feature of
  ;;     same category (e.g., NP/NP)
  ;;   Returns t is constituent is new 
     
     (defun put-in-chart (newentry)
       (let* ((start (entry-start newentry))
              (name (entry-name newentry)))
         (when (filter-constit start (entry-end newentry) (entry-constit newentry) newentry)
           (Setq constits-by-name (cons (list name newentry) constits-by-name))
           (setf (aref constits-by-position start)
                 (cons newentry (aref constits-by-position start)))
           t)))
     
     ;;   get-entry-by-name retrieves a constituent given its unique identifier
     
     (defun get-entry-by-name (name)
       (cadr (assoc name constits-by-name)))
     
     ;;    get-entries-by-position returns all entries with indicate CAT
     ;;      that start at pos
     
     (defun get-entries-by-position (cat pos)
       (remove-if-not #'(lambda (e)
                          (eq (constit-cat (entry-constit e)) cat))
                      (aref constits-by-position pos)))

     ;;   REMOVING CHART ENTRIES FOR BACKING UP
     ;;   This is only used to support backspacing in the online parser
     
     (defun ClearChartAfter (n)
       ;;    clear the arcs and entries after position n
       (do ((i (+ n 1) (+ i 1)))
	   ((= i maxChartSize))
	 (setf (aref chart-arcs i) nil)
	 (setf (aref constits-by-position i) nil))
       ;;   clear out constituents that end at n or after
       (setq constits-by-name 
	 (remove-if #'(lambda (pair)
			(> (entry-end (cadr pair)) n))
		    constits-by-name))
       (dotimes (i (+ n 1))
	 (setf (aref constits-by-position i)
	   (remove-if #'(lambda (c)
			  (> (entry-end c) n))
		      (aref constits-by-position i))))
       )
       
     )  ;; end scope of chart variables 

;; FILTER-CONSTIT - the constituent filter. Returns t if the constituent should
;;   be added to the chart. Currently this checks three things:
;;      - whether an identical constituent is already on the chart
;;      - whether the constituent has an illegal GAP feature, i.e., 
;;           a non-empty constit of cat C with a gap of cat C
;;      - whether the start position exceeds the chart size


(defun filter-constit (start end constit newentry)
  (let* ((cat (constit-cat constit))
         (feats (constit-feats constit))
         (existing-entries (get-entries-by-position cat start))
         (gapval (get-value constit 'gap)))
    (cond 
     ;;   check for duplicate entry
     ((some #'(lambda (e)
		(and (eql (entry-end e) end)
		     (identical-feats (constit-feats (entry-constit e))
				      feats)))
	    existing-entries)
       (verbose-msg "~% Not adding duplicate entry ~S" newentry)	
       nil)
      ;;  check for non-empty constit of form X/X
      ((and (constit-p gapval) (eq (constit-cat gapval) cat)
              (not (equal (get-value constit 'EMPTY) '+)))
       (trace-msg "~% Not adding X/X entry ~S" newentry)
       nil)
      ((< start (getMaxChartSize)) t)
      (t (parser-warn
          "~%~%****WARNING: CHART SIZE EXCEEDED WITH CONSTITUENT:~%~s~%~%
 Current size is ~s. Use SetMaxChartSize to increase default chart size" constit (getMaxChartSize))
	 nil))))


;;  This returns true if the features are identical up to variable renaming

(defun identical-feats (fl1 fl2)
  (if (eql (list-length fl1) (list-length fl2)) 
       (let ((bndgs (fconstit-match fl1 fl2)))
         ;;  check each binding. Value must be an unconstrained variable
         (if bndgs
           (every #'(lambda (pair)
                    (or (equal pair '(nil nil))
                        (and (var-p (cadr pair))
			     (null (var-values (cadr pair))))))
		  bndgs)))))



;;=========================================================================
;;  MAINTAINING THE ENTRIES (i.e., completed constituents)
;;  Entries are a 7-element list of the form
;;      constit - the constituent
;;      start - the starting position of the constituent
;;      end - the ending position of the constituent
;;      rhs - the instantited rhs of the rule that built the constituent
;;      name - a unique id name
;;      rule-id - the id of the grammar rule that was used to build the entry
;;      prob - the probability score (if used)
;;
;; defining abstract data type for entries

;;  BUILD-ENTRY - this constructs an entry given a constit, start, end and rhs

;; Definition moved to structures.lisp for easier compilation.
;; (defstruct entry
;;  constit start end rhs name rule-id prob)

(defun build-entry (constit start end rhs rule-id prob)
  (let ((name (gen-symbol (constit-cat constit))))
    (if (noSemEnabled)
      (make-entry :constit constit :start start :end end :rhs rhs 
                :name name :rule-id rule-id :prob prob)
      (make-entry-with-sem constit start end rhs name rule-id prob))))
       

;;=========================================================================
;; Maintaining the ACTIVE ARCS

;;  An Active arc is a 7-element list consisting of
;;    mother - the constituent being built
;;    pre - the subconstituents found so far
;;    post - the subconstituents still needed
;;    start - the starting position of the arc
;;    end - the current ending position of the arc
;;    rule-id - the rule used in the grammar to introduce the arc
;;    prob -  the probability score

;; Definition moved to structures.lisp for easier compilation.
;; (defstruct arc
;;  mother pre post start end rule-id prob)

;;    MAKE-ACTIVE-ARC builds an active arc

(defun make-active-arc (mother pre post start end rule-id prob local-vars foot-feats)
  (make-arc :mother mother :pre pre :post post :start start :end end 
            :rule-id rule-id :prob prob :local-vars local-vars :foot-feats foot-feats))

;; MAKE-ARC-FROM-RULE creates an arc from an instantiated rule 
;;        and a specified starting position. It makes copies of all unbound vars
;;        in the rule to make sure they are unique

(defun make-arc-from-rule (rule start bndgs)
  (let* ((copyrule (copy-vars-in-rule rule bndgs))
        (id (rule-id copyrule)))
    (make-active-arc (rule-lhs copyrule)
                     nil (rule-rhs copyrule)
                     start start id (get-rule-prob rule start) 
		     (get-var-list) nil)))

;;   This computes the rule probability using one of three methods
;;    for context independent probs (CF), context dependent pobs (CS),
;;    or non-probabilistic parsing (every constituent prob defaults to 1)

(defun get-rule-prob (rule position)
  (case (is-prob-parse)
    (CF
     (rule-prob rule))
    (CS
     (getCSruleProb rule (get-word-by-position position)))
    (otherwise 1)))


;; EXTEND-ARC matches a constituent with the specified name
;;     against the next constituent needed for the active arc,
;;     so that a new extended arc can be created if they match. 
;;
;;  Also, this skips over unknown words and filled pauses
;;  if the *ignore-unknown-words* flag is t

(defun extend-arc (entry name arc)
  (if *ignore-unknown-words*
      (if (member (get-value (entry-constit entry) 'cat) '(unknown fp))
	  (extend-arc-end-position arc)
	;; otherwise match constit to RHS of rule
	  (let ((bndgs (constit-match
			   (car (arc-post arc))
			   (entry-constit entry))))
	    (if bndgs
		(extend-arc-with-constit entry name arc bndgs))))))

;;  EXTEND-ARC-WITH-CONSTIT builds a new active arc by extending an existing arc
;;   with a constituent. The constituent is added to the mother as a subconstituent
;;   feature: 1 for the first, 2 for the second, and so on. It also instantiates
;;   any variables indicated in the binding list bndgs, and any
;;   variables which should be bound as a result of skipping over null
;;   constituents (this happens when the GAP value of the null constit
;;   is a variable: null constits can't have GAP +).
(defun extend-arc-with-constit (entry name arc bndgs)
  (multiple-value-bind (rest new-bndgs)
      (remove-null-constits (subst-in (cdr (arc-post arc)) bndgs)
			    bndgs)
    (let* ((mother (subst-in (arc-mother arc) new-bndgs))
	   (pre (subst-in (arc-pre arc) new-bndgs))
	   (post (cons (subst-in (car (arc-post arc)) new-bndgs)
		       rest))
	   (start (arc-start arc))
	   (end (entry-end  entry))
	   (id (arc-rule-id arc))
	   (prob (* (arc-prob arc) (entry-prob (get-entry-by-name name))))
	   (local-vars (arc-local-vars arc))
	   (foot-feats (augment-foot-feats entry (car post) (arc-foot-feats arc))))
      (cond 
       ;; arc is completed, build a new constituent if possible
       ((endp rest)
	(multiple-value-bind (new-constit bndgs)
	    (Merge-feature-values mother (cons (list (+ (list-length pre) 1) name) foot-feats))
	  (if new-constit
	      (if bndgs
		  (Add-to-agenda 
		   (subst-in (build-entry 
				  new-constit
				  start end (append pre post) id prob) bndgs))
		 (Add-to-agenda (build-entry 
				  new-constit
				  start end (append pre post) id prob))))))
       ;; add a new active arc by extending the current one
       (t (Add-arc (make-active-arc (Add-feature-value mother (+ (list-length pre) 1) name)
				    (append pre (list (car post)))
				    rest
				    start end
				    (arc-rule-id arc)
				    prob
				    local-vars foot-feats)))))))


;; Checks the foot features of the new subcontituent
;;  and records any values in the foot-feats slot of the arc
;;  If the foot feature is specified on the subconstituent in the rule, however,
;;  it is not propagated up to the mother

(defun augment-foot-feats (entry pattern foot-feats)
  (let ((new-foot-feats foot-feats))
    (mapcar #'(lambda (ff)
		(let ((newval (get-value (entry-constit entry) ff))
		      (specified-in-subconstituent-in-rule (get-value pattern ff))
		      (currentval (get-fvalue new-foot-feats ff)))
		  (cond 
		   ((or (null newval) (eq newval '-) (eq newval currentval)) nil)
		   ;;  If foot-feat not found so far, add it
		   ((and (null currentval) (not specified-in-subconstituent-in-rule))
			 (setq new-foot-feats (cons (list ff newval) new-foot-feats)))
		   ;;  If foot-feat is a variable, try to bind it
		   ((var-p currentval) 
		    (let ((bndgs (match-vals ff currentval newval)))
		      (if bndgs (setq new-foot-feats (subst-in new-foot-feats bndgs))))))))
	    (get-foot-features))
    new-foot-feats))
		   
		   
		  

;; this simply creates a new arc with the end position increased
;;  by one. It is used to skip over unknown words and filled pauses

(defun extend-arc-end-position (arc)
  (add-arc (make-active-arc (arc-mother arc)
			    (arc-pre arc)
			    (arc-post arc)
			    (arc-start arc)
			    (+ (arc-end arc) 1)
			    (arc-rule-id arc)
			    (arc-prob arc)
			    (arc-local-vars arc)
			    (arc-foot-feats arc))))
  
;; given a list of constituents, returns the list after skipping any
;; leading null constituents, i.e. elements of the list whose cat is
;; '- and whose GAP is not constrained to be '+.
;;   Also skips elements that are simply EQ to '-
;;  Finally, it checks for the special UNIFY construct that unifies two expressions.
(defun remove-null-constits (cl bndgs)
  (if cl
      (if (not (eq (car cl) '-))
	  (let ((new-bndgs (match-for-skip (car cl))))
			   
	    (cond ((equal new-bndgs *success*)
		   (remove-null-constits (cdr cl) bndgs))
		  (new-bndgs
		   (remove-null-constits (cdr cl)
					 (append bndgs new-bndgs)))
		  (t
		   (values cl bndgs))))
	(remove-null-constits (cdr cl) bndgs))
    (values nil bndgs)))


(defun match-for-skip (constit)
  (when (constit-p constit)
    (case (constit-cat constit)
      (- (constit-match constit *empty-constit*)) ;;(build-constit '-  '((gap -)) nil)))
      (UNIFY (let ((feats (constit-feats constit)))
	       (match-vals nil (cadr (second feats)) (cadr (first feats)))
	       ))
	       
      )))


;;   ADD-ARC  Adds a non-completed arc to the chart, and looks to extend it with gaps
;;     or entries already on the chart

(defun add-arc (arc)
  (trace-arc arc)
  (add-arc-to-chart arc)
  (when (GapsEnabled) 
    ;;  generate any gaps that could extend the arc
    (generate-gaps arc))
  ;;  check existing entries on the chart to see if they extend the arc
  (let ((nextc (car (arc-post arc))))
    (if (constit-p nextc)
	(mapcar #'(lambda (entry)
		    (extend-arc entry (entry-name entry) arc))
		(get-entries-by-position (constit-cat nextc)
                                   (arc-end arc))))))

;;  Special trace function for tracing entries

(defun trace-entry (entry)
  (let ((id (entry-rule-id entry))
        (trace-feats (get-trace-features))
        (constit (entry-constit entry)))
    
    (cond ((> (tracelevel) 0)
	   (format t "-Entering constituent ~s from ~s to ~s" 
		   (entry-name entry)
		   (entry-start entry) 
		   (entry-end  entry))
	   (if (is-prob-parse) 
             (Format t ", prob = ~s~%" (entry-prob entry))
	     (Format t "~%"))
	   (when (or (> (tracelevel) 1) (member id (rules-to-trace)))
                (format t "     ~S~%" (get-printable-constit constit trace-feats))))
	  ((member id (rules-to-trace))
	   (format t "-Entering constituent ~s from ~s to ~s" 
		   (entry-name entry)
		   (entry-start entry) 
		   (entry-end  entry))
	   (if (is-prob-parse) (Format t ", prob = ~s, from rule ~S~%" (entry-prob entry) id)
	     (Format t "~%"))
	    (Format t "     ~S~%" (get-printable-constit constit trace-feats))
            ))))
	   

;; Special trace function for tracing arcs

(defun trace-arc (arc)
  (let ((trace-feats (get-trace-features)))
    (if (or (and (> (tracelevel) 1)
	         (nonLexicalConstit (arc-mother arc)))
	    (member (arc-rule-id arc) (rules-to-trace)))
      (Format t "Adding active arc: ~%~s ~%    ~s ~%        ~s ~%        *~%         ~s from ~s to ~s~%"
              (get-printable-constit (arc-mother arc) trace-feats)
              (arc-rule-id arc) 
              (mapcar #'(lambda (x) (get-printable-constit x trace-feats))
                      (arc-pre arc))
              (mapcar #'(lambda (x) (get-printable-constit x trace-feats))
                      (arc-post arc))
              (arc-start arc) (arc-end arc))))
  )
