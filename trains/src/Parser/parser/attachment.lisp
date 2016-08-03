(in-package parser)

;;
;;  This file contains the code for attaching arbitrary procedural
;;  modifications to entries before they are entered into the chart
;;
;;  To attach a procedure, you announce a constituent pattern to the
;;  parser. From then on, every time a constituent that matches the
;;  pattern is about to be added to the chart, your function is called.
;;  Your funciton may then modify the consituent in any way and return
;;  it and it will be  added to the chart. If your function returns nil,
;;  then the constituent never makes it onto the chart

;;   Here is an example, a function that prints out all
;;    complete NPs that it finds, halves its probability, and
;;    sets a new feature SEEN

;; (announce '(np (gap -)) #'test)

;; (defun test (entry)
;;      ;; print out the entry
;;     (Format t "~% Found an np: ~s" entry)
;;     (setf (entry-prob entry) (/ (entry-prob entry) 2))
;;     (setFvalue entry 'SEEN '+)
;;     ;; must return the entry if it is to be added to the chart
;;      entry)




;;  FUNCTIONS THAT MAINTAIN THE ATTACHMENT DATABASE

(let ((attachmentDB))
  
  (defun init-attachments nil
    (setq attachmentDB (make-hash-table :test 'equal :size 10)))
  
  ;;   ANNOUNCE
  
  ;;  PATTERN must be parsable as a constituent pattern (as in grammar rules)
  ;;  FN is a lisp function that takes a chart entry
  ;;  as its one argument and returns a modified entry for further
  ;;  processing by the parser.
  
  (defun announce (pattern call)
    (let*
	((pat (verify-and-build-constit pattern (list pattern call) nil))
	 (cat (constit-cat pat)))
      
      (if pat
	  (setf (gethash cat attachmentDB)
	    (cons (list pat call)
		  (gethash cat attachmentDB))))))
  
  (defun find-functions (constit)
    (let ((calls nil))
      (mapcar #'(lambda (item)
		  (let ((pattern (car item))
			(fn (cadr item)))
		    (if (constit-match pattern constit)
			(setq calls (cons fn calls)))))
	     (gethash (constit-cat constit)  attachmentDB))
    calls))

  (defun patterns nil
    attachmentDB)
  
  ) ;; end scope of ATTACHMENTDB

(init-attachments)

(defun procedural-filter (entry)
  (let*	((results nil))
    (mapcar #'(lambda (fn)
		(let ((res (funcall fn entry)))
		  (if res (setq results (cons res results)))))
	    (find-functions (entry-constit entry)))
    ;;   Just returns first function that produced a non-nil result
    ;;   may want to reconsider this later
    (if results (car results) entry)))

;;
;;--------------

;;   CONVENIENCE FUNCTIONS
;;  This aren't necessary, but make it easier for the novice writing
;;  attached functions.

;; Retrieve a feature value
(defun getFvalue (entry feature)
  (get-value (entry-constit entry) feature))

;; Set/replace a feature value
(defun setFvalue (entry feature value)
  (setf (entry-constit entry)
    (replace-feature-value (entry-constit entry) feature value)))

;; set the probability
(defun setProbValue (entry newprob)
  (setf (entry-prob entry) newprob))


   
		    
		    
