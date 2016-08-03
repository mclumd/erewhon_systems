;;;
;;; printing.lisp : Printing Parser data structures
;;;
;;; Author:  James Allen <james@cs.rochester.edu>
;;;
;;; Time-stamp: <96/06/20 11:24:17 ringger>
;;;
;;; History:
;;;   94 ??? ??  james   - Created.
;;;   96 May 29  ringger - Added functions for putting parse-trees into lists.
;;;


(in-package parser)

;;************************************************************************
;;
;;   PRINTING FUNCTIONS
;;

;;************************************************************************
;;
;;   PRINTING OUT THE CHART
;;
;;  USER INTERFACE FUNCTIONS

(defun show-chart (&optional features start end)
  (format t "~%")
  (if (consp features) 
    (mapcar #'(lambda (x) (show-abbrev-entry-with-name x features))
            (get-constits-from-chart start end))
    (mapcar #'(lambda (x) (show-entry-with-name x))
          (get-constits-from-chart start end)))
  (values))

;;------------------------
;; show-best
;;
;; print just those constituents that span the input
;;
(defun show-best (&optional features start end)
  (let ((start (if start start 0))
        (end (if end end (get-max-position))))
    (format t "~%")
    (if (consp features)
      (mapcar #'(lambda (x)
                  (show-abbrev-entry-with-name x features))
                  (find-best start end))
      (mapcar #'show-entry-with-name (find-best start end)))
    (values))
  )

;;------------------------
;; get-best
;;
;; like (show-best), but return best for parse-tree viewer.
;;
(defun get-best (&optional features start end)
  (let ((start (if start start 0))
        (end (if end end (get-max-position))))
    (if (consp features)
      (mapcar #'(lambda (x)
                  (get-abbrev-entry-with-name x features))
                  (find-best start end))
      (mapcar #'get-entry-with-name (find-best start end))
      )))

;;------------------------
;; show-answers
;;
;; Print out the complete structure of the best parse
;;
(defun show-answers (&optional features start end)
  (let ((start (if start start 0))
        (end (if end end (get-max-position))))
    (Format t "~%~% THE BEST PARSES FOUND~%")
    (if (consp features)
      (mapcar #'(lambda (x)
                  (print-abbrev-tree features 0 x nil))
              (find-best start end))
      (mapcar #'(lambda (x)
                  (print-tree 0 x nil))
              (find-best start end)))
    (values)))

;;------------------------
;; get-answers
;;
;; Like (show-answers), but put parse into a list
;;
(defun get-answers (&optional features start end)
  (let ((start (if start start 0))
        (end (if end end (get-max-position))))
    (if (consp features)
	(mapcar #'(lambda (x) (get-abbrev-tree features x nil))
		(find-best start end))
      (mapcar #'(lambda (x) (get-tree x nil))
	      (find-best start end) ))))

;;------------------------
;; get-pview-tree
;;
;; Put the best parse into a flat list.
;;
(defun get-pview-tree ()
  (list 'parse-tree
	(flatten (get-answers '(LEX 1 2 3 4 5 6 7 8 9))) ))    

(defun flatten (lis)
  (if lis
      (if (listp (car lis))
	  (append (flatten (car lis)) (flatten (cdr lis)))
	(cons (car lis) (flatten (cdr lis))) )
    nil ))
    
;;------------------------
;; show-constit
;;
;; printing the parse tree rooted at the indicated constituent
;;
(defun show-constit (C &optional features)
  (let ((entry (get-entry-by-name C)))
    (if (entry-p entry)
      (if (consp features)
        (print-abbrev-tree features 0 entry nil)
        (print-tree 0 entry nil))
      (Format t "%Warning: ~S is not a defined constituent in the chart" C)))
  (values))


;;  UTILITY FUNCTIONS

(defun get-input-sequence (constit-name)
  "finds the word sequence that produce the constituent"
  (let ((entry (get-entry-by-name constit-name)))
    (if (entry-p entry)
	(get-input-seq-from-entry entry)
      (Format t "%Warning: ~S is not a defined constituent in the chart" constit-name))))

(defun get-input-seq-from-entry (entry)
  "Actually find the words with guarantee that constit is OK"
  (let* ((constit (entry-constit entry))
	 (subconstitnames (getsubconstitnames 1 constit))
         (subentries (mapcar #'get-entry-by-name
                              subconstitnames)))
    (if subentries
	(mapcan #'get-input-seq-from-entry subentries)
      (list (get-value constit 'LEX)))))

(defun get-constits-from-chart (start end)
  (if (null end)
    (setq end (get-max-position)))
  (cond 
   ((null start)
    ;;  if start is not defined, neither is end.. We get constit names directly.
    (mapcar #'cadr (get-constits-by-name)))
   ((and (numberp start) (numberp end) (<= start end))
    (gather-names start end))
   (t (Format t "Bad positions in chart specified")
      nil)))

(defun gather-names (start end)
  (cond ((= start end)
         (aref (get-constits-by-position) start))
        ((< start end)
         (append (aref (get-constits-by-position) start)
                 (gather-names (+ 1 start) end)))
        (t nil)))

(defun show-entry-with-name (entry)
    (Format t "~s:~S from ~S to ~S from rule ~s" (entry-name entry) (entry-constit entry)
            (entry-start entry) (entry-end entry) (entry-rule-id entry))
    (if (is-prob-parse)
      (Format t ", Prob = ~s" (entry-prob entry)))
    (Format t "~%")
    )

;;------------------------
;; get-entry-with-name
;;
;; like (show-entry-with-name), but no printing.
;;
(defun get-entry-with-name (entry)
  (list (entry-name entry) (entry-constit entry)
	(entry-start entry) (entry-end entry) (entry-rule-id entry)
	))

;;------------------------
;; short-show-abbrev-entry-with-name
;;
;; printing  abbreviated form: just indicate subconstituents and lexical items
;;
(defun short-abbrev-entry-with-name (entry features)
  (Format t "~a: ~S"
	  (symbol-name (entry-name entry))
	  (reduce-constit features (entry-constit entry)) )
  (Format t "~%") )

;;------------------------
;; show-abbrev-entry-with-name
;;
;; printing  abbreviated form: just indicate subconstituents and lexical items
;;
(defun show-abbrev-entry-with-name (entry features)
    (Format t "~a: ~S, ~S-~S (~S)" (symbol-name (entry-name entry)) (reduce-constit features (entry-constit entry))
            (entry-start entry) (entry-end entry) (entry-rule-id entry))
    (if (is-prob-parse)
      (Format t ", P=~s" (entry-prob entry)))
    (Format t "~%")
    )

;;------------------------
;; get-abbrev-entry-with-name
;;
;; like (show-abbrev-entry-with-name), but no printing
;;
(defun get-abbrev-entry-with-name (entry features)
    (list (symbol-name (entry-name entry))
	  (reduce-constit features (entry-constit entry))
	  ))

;;------------------------
;; reduce-constit
;;
;; this takes a consituent and builds a list consisting of the CAT and 
;; the subconstituent features and LEX feature - for concise printing
;;
(defun reduce-constit (features c)
  (cons (constit-cat c)
	(remove-if-not #'(lambda (fv)
			   (member (car fv) features))
		       (constit-feats c))))

;; Prints out a constituent, instantiating the variables in its subconstituents 
;;  and prints them with appropriate indentation

(defun print-tree (prefix entry bindings)
  (let* ((subconstitnames (getsubconstitnames 1 (entry-constit entry)))
         (subentries (mapcar #'get-entry-by-name
                              subconstitnames))
         (subconstits (mapcar #'entry-constit subentries))
         (bndgs (merge-lists 
                 (cons bindings (mapcar #'constit-match (entry-rhs entry) subconstits)))))
  (print-blanks prefix)
  (show-entry-with-name entry)
  (mapcar #'(lambda (e) (print-tree (1+ prefix) e bndgs))
          (mapcar #'(lambda (e) (subst-in e bndgs)) subentries))))

;;------------------------
;; get-tree
;;
;; Like print-tree, but no printint
;;
(defun get-tree (entry bindings)
  (let* ((subconstitnames (getsubconstitnames 1 (entry-constit entry)))
         (subentries (mapcar #'get-entry-by-name subconstitnames))
         (subconstits (mapcar #'entry-constit subentries))
         (bndgs (merge-lists 
                 (cons bindings (mapcar #'constit-match
					(entry-rhs entry) subconstits)))))
    (cons
     (get-entry-with-name entry)
     (mapcar #'(lambda (e) (get-tree e bndgs))
	     (mapcar #'(lambda (e) (subst-in e bndgs)) subentries)
	     ))))


;;------------------------
;; print-abbrev-tree
;;
;; Prints out an abbreviated constituent, indicating just the category,
;;   subconsituents and the lexical items
;;
(defun print-abbrev-tree (features prefix entry bindings)
  (let* ((subconstitnames (getsubconstitnames 1 (entry-constit entry)))
         (subentries (mapcar #'get-entry-by-name subconstitnames))
         (subconstits (mapcar #'entry-constit subentries))
         (bndgs (merge-lists 
                 (cons bindings (mapcar #'constit-match (entry-rhs entry) subconstits)))))
  (print-blanks prefix)
  (show-abbrev-entry-with-name entry features)
  (mapcar #'(lambda (e) (print-abbrev-tree features (1+ prefix) e bndgs))
          (mapcar #'(lambda (e) (subst-in e bndgs)) subentries))))
         
;;------------------------
;; get-abbrev-tree
;;
;; like print-abbrev-tree, but no printing.
;;      
(defun get-abbrev-tree (features entry bindings)
  (let* ((subconstitnames (getsubconstitnames 1 (entry-constit entry)))
         (subentries (mapcar #'get-entry-by-name subconstitnames))
         (subconstits (mapcar #'entry-constit subentries))
         (bndgs (merge-lists 
                 (cons bindings (mapcar #'constit-match
					(entry-rhs entry) subconstits)))))
    (cons
     (get-abbrev-entry-with-name entry features)
     (mapcar #'(lambda (e) (get-abbrev-tree features e bndgs))
	     (mapcar #'(lambda (e) (subst-in e bndgs)) subentries)
	     ))))
         
         
(defun getsubconstitnames (n constit)
  (let ((sub (get-value constit n)))
    (if sub (cons sub (getsubconstitnames (1+ n) constit))
        nil)))

(defun print-blanks (n)
 (dotimes (i n)
   (format t "  ")))

;;------------------------
;;  BUILD-CONSTIT-TREE
;;  Given an entry and set of bindings, this builds
;;  a parse tree rooted at the entry

(defun build-constit-tree (entry bindings)
   (let* ((subconstitnames (getsubconstitnames 1 (entry-constit entry)))
         (subentries (mapcar #'get-entry-by-name
                              subconstitnames))
         (subconstits (mapcar #'entry-constit subentries))
         (bndgs (merge-lists 
                 (cons bindings (mapcar #'constit-match (entry-rhs entry) subconstits)))))
  (cons (entry-constit entry)
	(mapcar #'(lambda (e) 
		    (build-constit-tree e bndgs))
		(mapcar #'(lambda (e) 
			    (subst-in e bndgs)) 
			subentries)))))
              

;;------------------------
;; RULE-TREE
;;
;; returns list of following form (category rule-id <list of rule-tree return values>)
;;  or (category rule-id) if best-entry-name is a lexical constituent
;;
;; this returns the parse tree for the entry, best-entry-name
;; category is best-entry-name's category. rule-id is the id of rule used
;; to form best-entry-name.  The list of return values correspond to
;; running this function on the subconstituent(s) of this entry.
;;
(defun rule-tree (best-entry-name)
  (let* ((best-entry (get-entry-by-name best-entry-name))
	 (constit (entry-constit best-entry))
	 (category (constit-cat (entry-constit best-entry)))
	 (subconstits (getsubconstitnames 1 constit)))
    (if subconstits
	(list category
	      (entry-rule-id best-entry)
	      (mapcar #'rule-tree subconstits))
      (list category
	    (entry-rule-id best-entry)))))


;; *************************************
;; ************ find-best
;; ***************************************
;;

;;   Note- only constits without gaps are considered.
;;


(defun order-entries (entries)
  (sort entries
	#'<
	:key #'(lambda (x) (entry-start x))))


(defun find-best (start end)
  ;;  this starts from the longest constituent anywhere, and then
  ;;   recursively fills in the constits before and after the best one.
  ;;   if prefers longer constituents over probabilities (if used)
  ;;   but uses probability to select between equal length constituents
  (let ((constits (order-entries (find-longest-constits start end))))
    (if constits
	(let* (
	       (best-start (entry-start (car constits)))
	       (best-end (entry-end (car constits)))
	       ;;  now grab all ones that go between best-start and best-end
	       (best (grab-top-rated 
		      (sort 
		       (remove-subconstits
			(remove-if #'(lambda (x)
				       (not (and (= best-start (entry-start x))
						 (= best-end (entry-end x)))))
				   constits))
		       '> :key #'entry-prob)))
	       (prebest (if (< start best-start)
			    (find-best start best-start)))
	       (postbest (if (< best-end end)
			     (find-best best-end end))))
	  (order-entries (append prebest best postbest))))))


;;  Given a list of entries, all with same start and end, this
;;   removes any that are subconstituents of other consituents on the list.

(defun remove-subconstits (entries)
  (if (or (null entries)
	  (eql (length entries) 1)) entries
    (let ((subconstit-names (getAllsubconstitnames entries)))
      (remove-if #'null
		 (mapcar #'(lambda (e)
			     (if (not (member (entry-name e) subconstit-names))
				 e))
			 entries)))))

(defun getAllsubconstitnames (entries)
  (if (null entries) nil
    (append (getsubconstitnames 1 (entry-constit (car entries)))
	    (getAllsubconstitnames (cdr entries)))))
    

;;   find the longest constituent between start and end (excluding +GAP constits)

(defun find-longest-constits (start end)
  (let ((longest-list nil)
        (longest-length 0))
    (mapcar #'(lambda (entry)
                (when (no-gap (entry-constit entry))
                  (let* ((len (- (entry-end entry) (entry-start entry))))
                    (cond ((> len longest-length)
                           (setq longest-length len)
                           (setq longest-list (list entry)))
                          ((= len longest-length)
                           (setq longest-list (cons entry longest-list)))))))
            (get-constits-between start end))
    (remove-if #'null  longest-list)))

;;   get the constituents between start and end

(defun get-constits-between (start end)
  (if (>= start end) nil
      (append 
       (remove-if #'(lambda (x) (> (entry-end x) end))
                 (aref (get-constits-by-position) start))
       (get-constits-between (+ start 1) end))))

(defun get-CAT-constits-between (cat start end)
  (if (>= start end) nil
      (append 
       (remove-if #'(lambda (x) (or (> (entry-end x) end) (not (eq (constit-cat (entry-constit x)) cat))))
                 (aref (get-constits-by-position) start))
       (get-CAT-constits-between cat (+ start 1) end))))

;;  returns a list of all constits with highest prob, starting
;;  from a sorted list

(defun grab-top-rated (constits)
  (let ((max (entry-prob (car constits))))
    (remove-if #'(lambda (x)
		   (< (entry-prob x) max)) constits)))

;; given a feature list returns t if GAP feature is absent or '-
(defun no-gap (constit)
  (let ((temp (get-value constit 'GAP)))
    (or (null temp)
        (equal temp '-))))

;;------------------------
;; print-list
;;
;; Print given list row by row.
;;
(defun print-list (s lis indent)
  "Prints arbitrary lists, one element per row, indented."
  (dolist (item lis)
    (progn (dotimes (i indent) (princ " " s))
	   (format s "~S~%" item) ))
    (values) )

(defun worddef (w)
  (mapcar #'(lambda (x) (Format t "~%~S" (entry-constit x)))
	  (lookupword w 1)))
	  
