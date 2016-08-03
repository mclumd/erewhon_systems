(in-package parser)

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
;;
;;  A SERIAL BU PARSER FOR USE IN SPEECH APPLICATIONS, WHERE WORDS
;;   appear incrementally and sentence boundaries are not explicit.

;;  Notes on the basic BU parsing algorithm.
;;    This uses the left corner algorithm to build a chart "bottom-up"
;;    To run the parser, you must have made a lexicon and grammar "active" using the
;;    functions make-grammar and make-lexicon. (see file "GrammarandLexicon" for code)
;;
;;  e.g.,  Here is a sample session, assuming *lexicon1* and *grammar1* are
;;              appropriately defined
;;          (make-lexicon *lexicon1*)
;;          (make-grammar *grammar1*)
;;

;;  There are two functions to invoke the parser.

;;  START-BU-PARSE initializes the chart and then runs the parser on
;;      the words that it is passed. e.g. (start-BU-parse '(the train))

;;  CONTINUE-BU-PARSE continues the parse with additional words,
;;     e.g., (continue-BU-parse '(went to Dansville))

;; 


;;==================================================================================
;;
;;  MANAGING THE NUMBER OF WORDS

(let ((word-count 0)
      (max-position-found 0))
 
  (defun word-count ()
    word-count)
  
  (defun reset-word-count ()
    (setq word-count 0)
    (setq max-position-found 0))
  
  (defun up-word-count ()
    (let ((x word-count))
      (setq word-count (+ 1 word-count))
      (if (> word-count max-position-found)
	  (setq max-position-found word-count))
      x)
    )
  
  (defun get-max-position nil
    max-position-found)
  
  (defun up-max-position nil
    (let ((x max-position-found))
      (setq max-position-found (+ 1 max-position-found))
      x)
    )
  
  (defun update-max-position-found (n)
    (if (> n max-position-found)
	(setq max-position-found n)))
  
  (defun reset-max-position (n)
    (setq max-position-found n))
	   
  
  ;;  word count is only decreased if the parser has to back up because of
  ;;   backspacing in the input
  (defun decrease-Word-Count (N)
    (setq word-count (- word-count N))
    (if (< word-count 0) (setq word-count 0))
    (setq max-position-found word-count))

    
  
  )  ;; end scope of variables STOPPING-CONDITION

;;==================================================================================
;;    Options for probabilistic parsing
;;

;;  This handles three modes:
;;        Non-probabilistic parsing: every constituent is assigned probability 1
;;        context-free probabilistic parsing: uses static rule probabilities
;;        context-dependent prob. parsing: uses rule probs conditioned on category of first word

(let ((probabilistic 'CF))
 
  (defun use-CF-probabilities ()
    (setq probabilistic 'CF))
 
  (defun use-CS-probabilities ()
    ;; (setq probabilistic 'CS)
    (Warn "CS probabilities not suppported in this version"))
  
  (defun no-probabilities ()
    (setq probabilistic nil))

  (defun is-prob-parse ()
    probabilistic)
) ;; end scope of variable PROBABILISTIC


(defun add-default-rules (&optional x)
  x
  (format t "Warning: Default-rules is no longer supported.~%   Specify the probabilities in the rule entries~%")
  nil)
 

;;==================================================================================
;;THE AGENDA
;;   The agenda is a simple stack for the basic parser, but a prioritized list
;;   for the probabilistic parser. These functions all
;;    use the variable AGENDA

(let ((agenda nil)
      (input-buffer nil))
     

  (defun add-to-agenda (entry)
     (if entry
       (if (is-prob-parse)
         (setq agenda (insert-in-agenda entry (entry-prob entry) agenda))
         (setq agenda (cons entry agenda)))))

  (defun get-next-entry nil
    (let ((k (car agenda)))
      (setq agenda (cdr agenda))
      k))
  
  (defun peek-agenda nil
    (car agenda))
  
  ;;  INIT-AGENDAS - takes a word sequence and sets the input buffer
  ;;  and then processes the first lexical unit.
  
  (defun init-agenda (words)
    (setq input-buffer words)
    ;; (init-unknown-words)
    (reset-word-count)
    (setq agenda (if input-buffer
		     (gen-entries-from-input))))
      
  
  (defun add-new-input (words)
    (when words
      (setq input-buffer (append input-buffer words))
      (if (null agenda)
	  (setq agenda (gen-entries-from-input)))))

  (defun empty-agenda nil
    (null agenda))
  
  (defun agenda-item-pending nil
    agenda)
  
  (defun reset-agenda (entries)
    (setq agenda entries))
  
  (defun empty-input-buffer nil
    (null input-buffer))
  
  (defun input-item-pending nil
    input-buffer)
  
  (defun get-next-input nil
    (pop input-buffer))


  ;;  GEN-ENTRIES-FROM-BUFFER - calculates all possible lexical
  ;;   entries from the start of the input buffer. Generally, this involves
  ;;  just the first word, but might also include multi-word entries
  
  (defun gen-entries-from-input nil
    (let ((item (pop input-buffer))
	  (new-entries nil))
      (if (listp item)
	  ;; next-entry is a complex input specification of form
	  ;; (word :start <start> :end <end> :prob <prob> :filter <filter>)
	  (let* ((word (car item))
		 (args (cdr item))
		 (start (find-value args :start))
		 (end (find-value args :end))
		 (prob (find-value args :prob))
		 (filter (find-value args :filter)))
	    ;; If filter is specified, build the constituent
	    (if filter
		(setq filter
		  (if (listp filter) 
		    (make-constit :cat (car filter) :feats (cdr filter))
		  (make-constit :cat filter))))
	    ;; If start is not specified, update the current position
	    (if (null start) (setq start (up-max-position)))
	    (if (null end) (setq end (+ start 1)))
	    (update-max-position-found end)
	    (setq new-entries (find-lex-entries word 
						start
						end
						(if prob prob 1.0)
						filter)))
	;;  next-entry is a simple atom
	(let ((start (up-max-position)))
	  (setq new-entries (find-lex-entries item 
					      start
					      (+ start 1) 
					      1.0 
					      nil))))
      new-entries))
  
  (defun find-value (fvlist f)
    (cond ((null fvlist) nil)
	  ((eq (car fvlist) f)
	   (cadr fvlist))
	  (t (find-value (cddr fvlist) f))))
	  
  ;;  BACKING UP the parser
  (defun backup (NumbWords)
    (if (> numbWords 0)
	 ;; check if there is input that hasn't been processed yet
	 (if (input-item-pending)
	     (if (> (length input-buffer) NumbWords)
		 (setq input-buffer 
		   (reverse (nthcdr NumbWords (reverse input-buffer))))
	       (let ((N (length input-buffer)))
		 (setq input-buffer nil)
		 (backup (- NumbWords N))))
	   ;;  Nothing in the input buffer
	   (let nil
	     (decrease-word-count NumbWords)
	     (ClearChartAfter (word-count))
	     (Clear-CurrentLDC-After (word-count))))))
  
  ;;  BACKING UP PARSING USING SPECIFIC INDEX
  (defun backUpToPosition (index)
    (if (and (>= index 0) (< index (get-max-position)))
	(let nil
	  ;; First remove any words aftering this position in the buffer
	  (setq input-buffer 
	    (remove-if #'(lambda (w)
			   (let ((end (find-value (cdr w) :end)))
			     (and end
				  (> end index))))
		       input-buffer))
	  ;;  update max position found
	  (reset-max-position index)
	  ;; clear the charts from index on
	  (ClearChartAfter index)
	  (Clear-CurrentLDC-After index))
      (parser-warn "~%Illegal index for backing up: ~S" index)))
	      
  )  ;; end of scope for variable agenda and input-buffer

;; FIND-LEX-ENTRIES checks the first word in a word list and returns
;; all single entries found in the lexicon. The second
;; argument gives the entry position in the chart. If no
;; pattern found, it returns an *unknown-word* entry.

(defun find-lex-entries (word start end prob filter)
  (let ((entries nil))
    (mapcar #'(lambda (lex-entry) 
		 (let ((id (lex-entry-id lex-entry)))
		   (setq entries (cons (build-entry 
					(instantiateVAR (lex-entry-constit lex-entry))
					start end  nil 
					id
					prob)
				       entries))))
	    (apply-filter (retrieve-from-lex word)
			  filter))
    (when (null entries)
	(parser-warn "*****Warning****** Unknown word ~s"
		     word)
	(add-to-unknown-words word start end)
	(setq entries (list (build-entry (build-constit 'UNKNOWN nil nil)
					 start end  nil 'UNK 1))))
    entries))

;;  removes all entries that do not match the filter constraints

(defun apply-filter (lex-entries filter-constit)
  (if filter-constit
      (remove-if-not #'(lambda (x)
			 (constit-match filter-constit (lex-entry-constit x)))
		     lex-entries)
    lex-entries))
		 

;;  Inserts entry into agenda based on its probability

(defun insert-in-agenda (arc prob agenda)
  (cond ((null agenda) (list arc))
        ((>= prob (entry-prob (car agenda)))
         (cons arc agenda))
        (t (cons (car agenda) 
                 (insert-in-agenda arc prob (cdr agenda))))))



;;===========================================================================
;;   The PARSER
;;   This parser accepts words incrementally until it is reset
;;  Start-BU-parse initiaties a new chart and
;;  Continue-BU-parse extends the chart with new words

(let ((StopFlag nil)) ;; StopFlag is used to allow attachments to suspend the parse
  
  (defun start-BU-parse (words)
    (init-agenda words)
    (make-chart (getmaxChartSize))
    (setq StopFlag nil)
    (BU-parse))
  
  (defun continue-BU-parse (words)
    (add-new-input words)
    (setq StopFlag nil)
    (BU-parse))

  (defun BU-parse nil
    (loop 
      (cond
       (StopFlag (return nil))
       ((agenda-item-pending)
	(add-entry-to-chart (get-next-entry)))
       ((input-item-pending)
	(reset-agenda (gen-entries-from-input)))
       ;;   parse is not finished but there's nothing to do right now
       (t (return nil)))))
  
  (defun suspendParse nil
    (setq StopFlag t))

  ) ;; end scope of StopFlag
		

           
;; ADD-ENTRY-TO-CHART first invokes any procedural filters, and then
;;    inserts the resulting entry into the chart, adding any new
;;    active arcs introduced by grammar rules that can start with the
;;    constituent, and extending any existing arcs that can be extended by
;;    the consituent. If the procedure downgardes the probabilty, however,
;;    the entry may be reinstated onto the agenda.

(defun add-entry-to-chart (entry)
  (let* ((next-constit (peek-agenda))
	 (next-prob (if next-constit (entry-prob next-constit) 0)))
    (trace-entry entry)
    (setq entry (procedural-filter entry))
    ;;  check stopping condition
    (let ((sc (get-stopping-condition)))
      (if (and sc 
	       (constit-match sc (entry-constit entry)))
	  (suspendParse)))
    (if entry 
      ;; check if it is still the highest probability constituent
	(if (or (not (is-prob-parse)) (>= (entry-prob entry) next-prob))
	    (when (put-in-chart entry)
	      (Make-New-BU-Active-Arcs entry (entry-name entry))
	      (Chart-Extend entry (entry-name entry)))
	  ;;  if not highest prob, add back onto agenda
	  (add-to-agenda entry)))
    ))

;; CHART-EXTEND tries to extend arcs in the chart with the new constituent

(defun chart-extend (entry name)
     (mapcar #'(lambda (x) (extend-arc entry name x)) 
             (get-arcs (entry-start entry))))


