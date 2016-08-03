;;;  This file contains the definitions of structures used in the munger, and
;;;  functions to convert between these structures and the output of the
;;;  parser proper.

;______________________________________________________________________________
;; Declaration of being in the parser package.

(in-package parser)

;______________________________________________________________________________
;;;  Structure definitions

;; Compound-communications act
(defstruct (CCA
	    (:print-function
	     (lambda (p s k)
	       (format s "Compound Communication Act~%Acts:~%~S~%Reliability ~S~%Mode ~S~%Noise ~S" 
		       (CCA-acts p)
		       (CCA-reliability p)
		       (CCA-mode p)
		       (CCA-noise p)))))
  acts					; a list of at least 2 SAs
  reliability
  mode
  noise
  )

;; Speech act
(defstruct (SA
	    (:print-function
	     (lambda (p s k)
	       (format s "~%~S~%Focus ~S~%Objects~%~S~%Semantics ~S~%~
     			  Noise ~S~%SocialContext ~S~%Reliability ~S~%~
		       	  Mode ~S~%Syntax ~S~%Setting ~S~%Input ~S~%"
		       (SA-type p)
		       (SA-focus p)
		       (SA-objects p)
		       (SA-semantics p)
		       (SA-noise p)
		       (SA-social-context p)
		       (SA-reliability p)
		       (SA-mode p)
		       (SA-syntax p)
		       (SA-setting p)
		       (SA-input p)))))
  type					; a symbol like 'SA-TELL
  focus
  objects				; an a-list of variables and their full descrips
  semantics
  noise
  social-context
  reliability
  mode
  syntax
  setting
  input
  )

;; Template
(defstruct template
  type
  place
  edges
  simplify-conditions
  simplify-actions
  sa-id-conditions
  sa-id-actions  
  )

;; Edge in a template (for parts of a sentence, e.g. object, subject.
(defstruct edge
  type
  node
  score
  )

;______________________________________________________________________________
;;; Functions to operate on these structures for input and output purposes.

;; Read in a template.
(defun parse-template (s)
  (cond 
    ((equal (first s) 'COMMENT) nil)
    ((eq (length s) 7)
     (make-template
      :type (nth 0 s)
      :place (nth 1 s)
      :edges (build-edges (nth 2 s))
      :simplify-conditions (nth 3 s)
      :simplify-actions (nth 4 s)
      :sa-id-conditions (nth 5 s)
      :sa-id-actions (nth 6 s)))
    (t NIL)))

(defun build-edges (l)
  (when l
    (cons (make-edge
	   :type (car l)
	   :node (second l)
	   :score (third l))
	  (build-edges (cdddr l)))))

(defun parse-template-file (fname)
  (let ((result nil))
    (dolist (element (with-open-file (stream fname)
		       (read-in-list stream)) result)
      (let ((temp (parse-template element)))
	(when temp (push temp result))))))

;; Read in output from the parser.
(defun parse-input (input)
  (case (car input)
    ('COMPOUND-COMMUNICATIONS-ACT
     (make-CCA
      :acts (mapcar 'parse-input (third input))
      :reliability (fifth input)
      :mode (seventh input)
      :noise (ninth input)))
    ;; if it's not a compound, it better be a single
    (t
     (setf input (build-sa input))
     (if (not (assoc 'reliability input)) nil
     (make-SA
      :type (rest (assoc 'type input))
      :focus (rest (assoc 'focus input))
      :objects (rest (assoc 'objects input))
      :semantics (rest (assoc 'semantics input))
      :noise (rest (assoc 'noise input))
      :social-context (rest (assoc 'social-context input))
      :reliability (rest (assoc 'reliability input))
      :mode (rest (assoc 'mode input))
      :syntax (rest (assoc 'syntax input))
      :setting (rest (assoc 'setting input))
      :input (rest (assoc 'input input)))))))

(defun settypes (sa-list)
  (let ((result nil))
    (case (first sa-list)
      (nil nil)
      (':focus (cons (cons 'focus (second sa-list)) (settypes (rest (rest sa-list)))))
      (':objects (cons (cons 'objects (apply 'append 
		      (mapcar 'build-alist (list (nth 1 sa-list)
						 (nth 3 sa-list)
						 (nth 5 sa-list))))) (settypes (rest (rest (rest (rest (rest (rest sa-list)))))))))
      (':semantics (cons (cons 'semantics (second sa-list)) (settypes (rest (rest sa-list)))))
      (':noise (cons (cons 'noise(second sa-list)) (settypes (rest (rest sa-list)))))      
      (':social-context (cons (cons 'social-context (second sa-list)) (settypes (rest (rest sa-list)))))
      (':reliability (cons (cons 'reliability (second sa-list)) (settypes (rest (rest sa-list)))))
      (':mode (cons (cons 'mode (second sa-list)) (settypes (rest (rest sa-list)))))
      (':syntax (cons (cons 'syntax (second sa-list)) (settypes (rest (rest sa-list)))))
      (':setting (cons (cons 'setting(second sa-list)) (settypes (rest (rest sa-list)))))
      (':input (cons (cons 'input (second sa-list)) (settypes (rest (rest sa-list)))))
      )))

(defun build-sa (sa-list)
  (let ((result nil))
    (push (cons 'type (first sa-list)) result)
    (append result (settypes (rest sa-list)))))

;; takes an object-list, which is a list of list structures which resemble either
;; a path or an object or a prop from the parser's LF. 
;; returns an alist, keyed by the :VAR
;;
;; we're assuming that the first thing in each object is a keyword, then the rest are
;; lists
(defun build-alist (object-list)
  (when object-list
    (cons
     (cons (second (assoc :VAR (cdr (car object-list))))
	   (car object-list))
     (build-alist (cdr object-list)))))

;; Output in the parser format.
(defun break-CCA (cca)
  (list
   'COMPOUND-COMMUNICATIONS-ACT
   :ACTS
   (mapcar 'break-SA (CCA-acts cca))
   :RELIABILITY
   (CCA-reliability cca)
   :MODE
   (CCA-mode cca)
   :NOISE
   (CCA-noise cca)))

(defun break-SA (sa)
  (let ((objects (mapcar 'cdr (SA-objects sa))))
    (list
     (SA-type sa)
     :FOCUS
     (SA-focus sa)
     :OBJECTS
     (remove-if-not #'(lambda (obj)
			(eq (car obj) :DESCRIPTION))
		    objects)
     :PATHS
     (remove-if-not #'(lambda (obj)
			(eq (car obj) :PATH))
		    objects)
     :DEFS
     (remove-if-not #'(lambda (obj)
			(or (eq (car obj) :PRED)
			    (eq (car obj) :PROP)))
		    objects)
     :SEMANTICS
     (SA-semantics sa)
     :NOISE
     (SA-noise sa)
     :SOCIAL-CONTEXT
     (SA-social-context sa)
     :RELIABILITY
     (SA-reliability sa)
     :MODE
     (SA-mode sa)
     :SYNTAX
     (SA-syntax sa)
     :SETTING
     (SA-setting sa)
     :INPUT
     (SA-input sa))))

;______________________________________________________________________________






