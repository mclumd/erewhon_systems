(in-package parser)

;;
;; structures.lisp
;;
;; Time-stamp: <96/10/17 15:32:19 james>
;;
;; History:
;;   94???? miller  - These definitions all used to be in other files,
;;                    but since the files all used each other's
;;                    structures, it made for some difficult
;;                    compilation dependencies.  All the comments
;;                    remain in the orginal files.
;;   941215 ringger - Added structure for Local Discourse Context
;;


;;; For Local Discourse Context

(defstruct (ldc
	    (:print-function print-ldc))
  objects-mentioned  ; all objects mentioned
  paths-mentioned    ; the paths mentioned in the current utterance 
  focus	             ; the focus (object of verb)
  sa-mentioned	     ; the speech acts signalled by S patterns
  sa-flags	     ; speech act indicators (e.g., please)
  actions-mentioned  ; the actions mentioned
  unknown-words   ; the syntax of the current utterance
  )

(defun print-ldc (p s k)
  (declare (ignore k))
  (progn 
    (format s "~%+Objects Mentioned:~%")
    (print-list s (ldc-objects-mentioned p) 2)
    (format s "+Paths Mentioned:~%")
    (print-list s (ldc-paths-mentioned p) 2)
    (format s "+Focus:~S~%+SA Mentioned:~S~%+SA Flags:~S~%+Actions Mentioned:~S~%+Syntactic Structure:~S~%"
	    (ldc-focus p)
	    (ldc-sa-mentioned p)
	    (ldc-sa-flags p)
	    (ldc-actions-mentioned p)
	    (ldc-syntactic-struct p)
	    )))

;;  structure for position indexed objects

(defstruct indexedObject
  object start end)

;;; From Chart.lisp

(defstruct entry
  constit start end rhs name rule-id prob)

(defstruct arc
  mother pre post start end rule-id prob local-vars foot-feats)

;;; From GrammarandLexicon.lisp

(defstruct lex-entry constit id)

(defstruct (rule
            (:print-function
	     (lambda (p s k)
	       (declare (ignore k))
	       (Format s "~%<~S~%   ~S ~S :prob=~S>"
		       (rule-lhs p) (rule-id p) (rule-rhs p)
		       (rule-prob p))
	       (if (rule-*-flag p) (Format s "*-flag-enabled")))))
  lhs id rhs prob var-list *-flag)

;;; From FeatureHandling.lisp

(defstruct constit ;; make unreadable 2/14/95 bwm.
  cat feats head)

(defmethod print-object ((o constit) stream)
  (if *print-readably*
      (call-next-method)
    (print-unreadable-object (o stream :type t)
      (format stream "~S ~S" (constit-cat o) (constit-feats o)))))
      

(defstruct var ;; make unreadable 2/14/95 bwm.
  name values non-empty)

(defmethod print-object ((o var) stream)
 (if *print-readably*
    (call-next-method)
   (print-unreadable-object (o stream :type t)
     (format stream "~S~@[:~S ~]" (var-name o) (var-values o)))))

;; 9/13/95 BWM
(defun parser-warn (format-string &rest args)
  (if (find-package :logging)
      (funcall (intern "DO-LOG" (find-package :logging))
                ";;Parser Warning: ~?~%" format-string args)
    (apply #'warn format-string args)))

;;  This constant indicates a successful unification

(defconstant *success* '((NIL NIL)))

(defvar *ignore-unknown-words*)

(setq *ignore-unknown-words* t)

;;(eval-when (load)
  (defvar *empty-constit*
    (make-constit :cat '- :feats '((parser::var -))))

;; Flag for new parser output format

(defvar *new-SA-format* nil)
