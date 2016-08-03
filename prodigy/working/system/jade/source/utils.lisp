(in-package "FRONT-END")

(export '(f-compile f-compile-all print-messages))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;	   Generalized utilities for the PRODIGY-Analogy/ForMAT TIE
;;;;
;;;;




;;;
;;; Function f-compile is used to compile a PRODIGY/ForMAT Front-end file.
;;; 
(defun f-compile (file)
  (compile-file
   (concatenate 'string 
		*format-directory* 
		file 
		#+GCL 
		".lisp")
   :output-file
   (concatenate 'string 
		*format-directory* 
		file 
		"." 
		user::*binary-extension*)))



;;;
;;; Function f-compile-all has the side-effect of compiling all of the files in
;;; the PRODIGY/ForMAT system.
;;;
(defun f-compile-all (&optional 
		      (file-names *front-end-files*))
  (declare (special *front-end-files*))
  (mapc #'f-compile file-names)
  )



;;;
;;; Function get-current-goals returns the goals of the current problem in the
;;; current problem space. 
;;;
(defun get-current-goals (&aux 
			  (goal-expr
			   (second
			    (p4::problem-goal 
			     (p4::current-problem)
			     ))))
  "Return the goals of the current problem."
  (cond ((eq (first goal-expr) 'and)
	 (rest goal-expr))
	(t (list goal-expr)))
  )



;;;
;;; Function print-messages is a utility designed to show the programmer what 
;;; the value of message objects is. Can be used to print intermediate results
;;; without having to run the watchdog.
;;;
(defun print-messages (message-list)
  (dolist (each-message message-list)
	  (format t
		  " (:MESSAGE ~D ~S ~S)~%" 
		  (id each-message) 
		  (title each-message)
		  (args each-message)))
  )



;;;
;;; Function return-file-strings takes a string naming a particular directory 
;;; and returns a list of strings naming the files in that directory. The 
;;; directory call returns a list of LISP pathname structures; whereas, the
;;; mapcar returns a list of corresponding name strings by using the LISP 
;;; pathname-name function.
;;;
(defun return-file-strings (dir-string)
  "Return a list of strings that name the files in dir-string."
 (mapcar #'pathname-name 
	 (directory dir-string))
 )


;;; 
;;; Function  symbol-2-integer  takes a symbol such  as '|13| (that  might come
;;; from a FORCE-QUANTITY or AC-QUANTITY attribute in a goal specification from
;;; ForMAT, and transforms  it  into  an integer (e.g.,  13).  The symbol first
;;; must be coerced into a string  representation because it cannot be directly
;;; converted into the  integer  itself.  The function  parse-integer  performs
;;; more specific error checking than if using read-from-string.
;;; 
(defun symbol-2-integer (symbol)
  (parse-integer 
   (string symbol))
  )


;;;
;;; Function make-var generates a unique variable identifier, given 
;;; some input symbol. If the symbol is x, the the function returns
;;; the variable <x.#>, where # is a unique number.
;;;
(defun make-var (symbol)
  "Generate a unique variable from input symbol."
  (intern 
   (format nil
	   "<~s>" 
	   (gentemp 
	    (string-upcase
	     (format nil 
		     "~S." 
		     symbol)))))
  )


;;;
;;; Function compute-index returns the number of the letter specified by the 
;;; parameter element within the parameter symbol. If occurrence is passed to 
;;; the function, then the number of that occurrence is returned. Therefore, the
;;; call (compute-index 'send-military-police 2) returns 13 (note that the
;;; numbering starts with zero).
;;;
(defun compute-index (symbol 
		     &optional
		     (occurrence 1)
		     (starting-index 0)
		     (element #\-)
		     (str-equivalent (string symbol)))
  (cond ((eq 0 (length str-equivalent))
	 nil)
	((eq occurrence 0)
	 (1- starting-index))
	(t
	 (let ((location-index
		(position element str-equivalent :start starting-index)))
	   (if (null location-index)
	       nil
	     (compute-index symbol 
			    (1- occurrence) 
			    (1+ location-index) 
			    element 
			    str-equivalent)))))
  )



;;;
;;; Function grab-segment takes a symbol such as 'send-hawk-unit and returns
;;; the part of the symbol before the indicated occurrence of delimiter (whose 
;;; default value is the dash character). That is, 'send-hawk is returned given
;;;  occurrence = 2.
;;;
(defun grab-segment (symbol
		     &optional 
		     (occurrence 1)
		     (delimiter #\-)
		     (str-equivalent (string symbol)))
  (intern
   (subseq str-equivalent
	   0 (compute-index 
	      symbol occurrence 0 
	      delimiter str-equivalent)))
  )



;;;
;;; Function delete-segment takes a symbol such as 'send-hawk-unit and returns
;;; the part of the symbol after the indicated occurrence of delimiter (whose 
;;; default value is the dash character). That is, 'unit is returned given
;;;  occurrence = 2. 
;;; 
;;; If occurrence is greater than the number of actual occurences of the 
;;; delimiter in the symbol, then nil is returned.
;;;
(defun delete-segment (symbol
		       &optional 
		       (occurrence 1)
		       (delimiter #\-)
		       (str-equivalent (string symbol))
		       &aux
		       (index (compute-index 
			       symbol occurrence 0 delimiter str-equivalent)))
  (if (null index)
      nil
    (intern
     (subseq str-equivalent
	     (1+ index)
	     (length str-equivalent))))
  )



;;;
;;; Function grab-last-segment returns the last segment of a delimited symbol.
;;; For instance, (grab-last-segment 'secure-airport) returns airport. If 
;;; delimiter is not present, then the entire symbol is returned.
;;;
(defun grab-last-segment (symbol &optional (delimiter #\-))
  (intern
   (reverse 
    (string
     (grab-segment 
      symbol 1 delimiter (reverse (string symbol))))))
  )


  
;;;
;;; Function filter takes a list and a predicate, returning a subset of the
;;; list consisting of those items passing the predicate's test. Use of this
;;; function must be cautious because the mapcan function is destructive and 
;;; therefore can modify components of alist as a side-effect.
;;;
(defun filter (alist predicate &optional recursive?)
  "Filter all items from alist not passing predicate."
  (mapcan #'(lambda (each-item)
              (let ((argument 
                      (if (and recursive?
                               (listp each-item))
                          (filter each-item predicate recursive?)
                          each-item)))
                (if
                  (funcall predicate argument)
                  (list argument))))
          alist)
  )


