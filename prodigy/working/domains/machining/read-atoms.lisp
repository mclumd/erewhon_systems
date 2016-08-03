;;; ******************************************************************
;;; Functions from Prodigy2 interface.lisp

(defun read-atoms ()
; return the input line as a single list of atoms. 
  (let ((ins ""))
    (loop 
      (setq ins (concatenate 'string ins " " (read-line)))
      (and (evenp (double-quote-count ins))
	   (<= (paren-count ins) 0)
	   (return (string-intern ins))))))


(defun double-quote-count (s)
; counts the number of double quote characters in a string.
  (let ((c 0))
    (dotimes (i (length s) c)
      (cond ((char-equal #\" (aref s i)) (incf c))))))


(defun paren-count (s)
; counts the levels of open parentheses in a string, making sure
; to ignore any parentheses inside a string literal (double quote).
  (let ((c 0) (lit nil))
    (dotimes (i (length s) c)
      (if lit 
	  (cond ((char-equal #\" (aref s i)) (setq lit nil)))
	  (cond ((char-equal #\" (aref s i)) (setq lit t))
		((char-equal #\( (aref s i)) (incf c))
		((and (char-equal #\) (aref s i)) (> c 0))
		 (setq c (1- c))))))))



(defun string-intern (s)
; given a string {s}, this routine will return a list containing 
; the objects within  the string.

  (cond ((null-string s) nil)
	((null-string (cdr-string s)) (values (list (car-string s))))
	(t (append (list (car-string s)) 
		   (string-intern (cdr-string s))))))


(defun null-string (s)
; this tests for an empty string.
  (and (stringp s) 
       (setq s (string-trim '(#\space #\tab #\newline) s))
       (= 0 (length s))
       s))


(defun car-string (s)
; given a string {s}, this function returns the first list or 
; word as a lisp object (atom or list).
  (let ((obj nil) (len 0))
    (unless (null-string s)
      (setq s (string-trim '(#\space #\tab #\newline #\\ #\|) s))
      (multiple-value-setq (obj len)
	(read-from-string s nil "")))
    (values obj s len)))



(defun cdr-string (s)
; given an input string {s}, it removes the first word/list
; and returns the remainder of the string.

  (and (stringp s)
       (let ((c nil)(lc nil))
	 (multiple-value-setq (c s lc)
	   (car-string s))
	 (subseq s lc))))

