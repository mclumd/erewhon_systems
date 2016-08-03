(in-package parser)
;; Time-stamp: <96/05/01 19:45:35 james>

;;;; This file contains functions converting string input
;;;; into a list of word symbols

;;  TOKENIZE
;;
;;  maps a string into a list of symbols

(defun tokenize (inputt)
  (let ((*package* (find-package 'parser)))
    (convert-to-symbols
     (convert-to-words 
      (remove-if #'(lambda (c)
                     (member c '(:punc-semicolon :punc-silence))) ;; ignore these for now
                 (map-to-safe-chars
                  (coerce (string-upcase inputt) 'list)))))))


;; replaces ' with ^, and other punctuation marks with explicit keywords 

(let ((punc-list '((#\. :PUNC-PERIOD) (#\, :PUNC-COMMA) (#\: :punc-colon) (#\; :punc-semicolon) (#\? :punc-question-mark) (#\! :punc-exclamation-mark) (#\* :punc-silence ))))
  
(defun map-to-safe-chars (clist)
  (if (null clist) nil
    (let ((c (car clist))
	  (map nil))
      (cond ((eql c #\')
	     (cons #\^ (map-to-safe-chars (cdr clist))))
	    ((eql c #\_)
	     (cons #\space (map-to-safe-chars (cdr clist))))
	    ((setq map (assoc c punc-list))
	     (cons #\space (cons (cadr map)
				 (cons #\space (map-to-safe-chars (cdr clist))))))
	    (t (cons c (map-to-safe-chars (cdr clist))))))))

) ;; end scope of PUNC-LIST
	    
 ;; ******* from '93 parser
;;; Accepts strings and/or characters and forms a symbol out of them.
;;; If there are any lower case characters involved, the symbol will be
;;; surrounded by |'s.  [janet]
;;; the arguments have to be strings. (marc)
;;; Not any more.  [janet jun23]
;;; Changed to put everything in uppercase for simplicity.  jmh 07/22/90


(defun implode-to-string (x)
  ;; gives string from char.list, string list, or atom list
  (if (null x) nil
    (if (characterp (car x))
	(coerce x 'string)
      (if (stringp (car x))
	  (eval (cons 'concatenate (cons ''string x)))
	(if (atom (car x))
	    (eval (cons 'concatenate
			(cons ''string (mapcar 'string x)) )))))))



;; convert-to-words is from '93 parser
(defun convert-to-words (charlist)
       ;; Break a "safe" character list (containing no reserved char's)
       ;; at blanks and convert the sublists between blanks to symbols
       ;; (in upper case).
       ;;
  (if charlist
      (do ((chars charlist) (i 0) (prefix nil))
	  ((null chars))
	;; trim leading blanks
	(do () ((not (eql (car chars) #\Space))) (pop chars))
	(if (null chars) (return nil))
	(setq i (position #\Space chars)) ; locate next blank, if any
	;; copy prefix preceding next blank or end of input
	(if i (setq prefix (butlast chars (- (length chars) i)))
	  (setq prefix chars))
	(if i (setq chars (nthcdr i chars)) ; trim prefix off chars
	  (setq chars nil))
           ;; make upper case symbol out of prefix, make this symbol the
           ;; first element of the list of words, & finish recursively
	(return (cons (implode-to-string prefix) (convert-to-words chars))) )
    nil)) ;; end of convert-to-words


;; ********* chop-last ************
;;
;; number must be 1,2, or 3
;; if number is 1, chop-last returns clist minus its last item
;; if number is 2, chop-last returns clist minus its last 2 items
;; if number is 3, chop-last returns clist minus its last 3 items
;;
(defun chop-last (number clist)
  (if (or (> number 3) 
	  (< number 1))
	  (progn (format t "Illegal option to chop-last~%")
		 '())
    (if (equal number 1)
	(reverse (cdr (reverse clist)))
      (if (equal number 2)
	  (reverse (cddr (reverse clist)))
	(if (equal number 3)
	    (reverse (cdddr (reverse clist))))))))

;; ********** safe-read-from-string
;;
;; same as read-from-string but echos nil strings
;;  instead of giving an error
;;
(defun safe-read-from-string (sstring)
  (if (null sstring) nil (read-from-string sstring nil)))


;; **********************************
;; ********expand-contractions-and-possessives - Mark Core and Aaron Kaplan
;; ***********************************
;;
;; argument: c-list, list of characters representing a word
;; return value: the same c-list with ^ (mapped from  ') removed,
;; and all known contractions except for ^s expanded.  ^s is not expanded
;; because it is not always a contraction, and it is ambiguous between
;; different contractions ("let's go" vs. "the boxcar's on time"
;; vs. "the boxcar's taken the wrong route" vs. "the boxcar's door").
;; Instead, ^s is just separated into its own word, as is ^ at the end
;; of a word (possessive of a word ending in s).  Words containing
;; ^ that are not known contractions or possessives are just left alone.
;;
;;
;; EXTENSION: now also recognizes contractions typed without the "'"
;;    e.g. Im instead of I'm      JFA 12/94

(defun expand-contractions-and-possessives (c-list)
  (if (find #\^ c-list)

	;; apostrophe found 
      ;;  first check for exceptions, then use regaulr expansion rules
      (cond ((equal c-list '(#\I #\^ #\M))
	     '(#\I #\space #\A #\M))
	    ((equal c-list '(#\L #\E #\T #\^ #\S))
	     '(#\L #\E #\T #\space #\U #\S))
	    ((equal c-list `(#\C #\A #\N #\^ #\T))
	     '(#\C #\A #\N #\space #\N #\O #\T))
	    ((equal c-list `(#\S #\H #\A #\N #\^ #\T))
	     '(#\S #\H #\A #\L #\L #\space #\N #\O #\T))
	    ((equal c-list `(#\W #\O #\N #\^ #\T))
	     '(#\W #\I #\L #\L #\space #\N #\O #\T))
	    (t (expand^ c-list)))
    c-list))


(defun expand^ (c-list)
   (if (null c-list) nil
    (let* ((first (car c-list))
	   (rest (cdr c-list))
	   (second (car rest))
	   (third (cadr rest)))
      (cond 
       ;;     's, 'll, etc
       ((equal first #\^) 
	(cond 
	 ;;  regular possessives
	 ((eq second #\S)
	  '(#\space #\^ #\S))
	 ;;   e.g., I'll
	 ((equal rest '(#\L #\L))
	  '(#\space #\W #\I #\L #\L))
	 ((eq second #\D)
	  '(#\space #\W #\O #\U #\L #\D))
	 ((equal rest '(#\R #\E))
	  '(#\space #\A #\R #\E))
	 ((equal rest '(#\V #\E))
	  '(#\space #\H #\A #\V #\E))
	 (t  c-list)))
       ;;  n't
       ((and (eq first #\N) (eq second #\^) (eq third #\T))
	'(#\space #\N #\O #\T))
       ;; plural possesive
       ;; e.g. the boxcars' doors
       ((and (eq first #\S) (eq second #\^))
	'(#\S #\space #\^))
       ;; e.g. o'clock
       ((and (eq first #\O) (equal rest '(#\^ #\C #\L #\O #\C #\K)))
	'(#\O #\^  #\space #\C #\L #\O #\C #\K))
       (second (cons first (expand^ rest)))))))
          
       
;;************SPLIT-NUMBERS
;; in phrases like "engine E1" and "8am", numbers are sometimes
;; crunched together with other words.  This separates numbers from
;; letters with spaces.
;;

(defun split-numbers (clist)
  (if (cdr clist)
      (if (or (and (alpha-char-p (car clist))
		   (digit-char-p (cadr clist)))
	      (and (digit-char-p (car clist))
		   (alpha-char-p (cadr clist))))
	  (cons (car clist)
		(cons #\space
		      (split-numbers (cdr clist))))
	(cons (car clist)
	      (split-numbers (cdr clist))))
    clist))



;;********************************
;;* FIX_UP - Mark Core **********
;;******************************
;; argument: a string (one word)
;; return value: a list of strings (one or more words)
;; 
;;   FIX_UP makes a separate word out of
;;   every maximal group of digits, and removes apostrophes by
;;   expanding contractions
;; 
(defun FIX_UP (str)
  (convert-to-words
   (expand-contractions-and-possessives
    (split-numbers
     (coerce str 'list)))))

    

;; coerces a string into a list of characters with no lowercase.
(defun str-to-cap-chars (str)
  (mapcar #'char-upcase (coerce str 'list)))

;; ***********************************************************
;; convert-to-symbols - Mark Core ****************************
;; ***********************************************************
;; arguments: w-list, a list of strings 
;;
;; return value - a list of symbols, after fix_up has worked on all
;; of the words.
;;

(defun convert-to-symbols (w-list)
  (mapcar #'safe-read-from-string
	  (apply #'append (mapcar #'fix_up w-list))))


;; returns names of longests constits
;;
(defun longest-constits nil

  ;; return the names from that list
        (mapcar #'car (find-best 0 (word-count)))
	)
