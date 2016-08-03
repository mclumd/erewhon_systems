;;; This file has the variables, parameters, and misc functions needed by the socket code.


(defvar *prodigy-base-directory*
  "w:/My Documents/prodigy/"
  "Base pathname for the prodigy 4.0 system.")

(defvar *prodigy-root-directory* 
  (concatenate 'string *prodigy-base-directory* 
	       "working/")
  "Pathname for the working system.")

(defvar *system-directory*
  (concatenate 'string *prodigy-root-directory*
	       "system/")
  "Directory holding all source file directories.")

(defvar *prod-ui-home* 
  (concatenate 'string 
	       *system-directory*
	       "ui/"))


(defvar *tcl-home* 
  (concatenate 
   'string
   *prodigy-base-directory*
   "tcl-tk/")
  )

(defvar *tcl-customizations* 
  (concatenate 'string 
	       *prod-ui-home*
	       "example-param-custom.tcl")
  "A string specifying a file with your personal tcl code")

;;; NOTE that this must remain a variable rather than a parameter so that users
;;; can change it. Otherwise the value remains nil when the systrem tries to
;;; load it. [cox 31oct96]
;;;
(defvar *post-tcl-customizations* nil
  "String specifies file with code loaded last that overloads existing code")


(defvar *load-ui-immediately* t
  "If t, then load binaries, else load source code.")


;;;
;;; For eof-p predicate below.
;;;
(defvar *end-of-file* (gensym)
  "Unique end of file character.")

;;;    #+(and ALLEGRO-V5.0.1) 
(defvar *ui-modules*
    #+(and ALLEGRO-V6.2) 
    '(("/lisp-source/"  "tcl" "prod-specific" "ask-rules" "shell" 
     "scrollbutton" "op-graph" "ui" 
     )
      )
    #-(and ALLEGRO-V6.2) 
    '(("/lisp-source/"  "tcl" "prod-specific" "ask-rules" "shell" 
     "scrollbutton" "op-graph" "ui" 
     )
    ("/sockets/"  "c-interface" "socket-interface"
     )
      )
    )


(defvar *ui-binary-pathname*
  (set-binary-path *prod-ui-home*)
  )


(defparameter *socket-home*
    "w:/My Documents/prodigy/working/Wrapper/java-lisp.sockets/")
    
(defparameter *java-socket-home*
    "w:/My Documents/prodigy/working/Wrapper/java-lisp.sockets/")
    
(defvar *socket-code-loaded-p* nil)

;;;
;;; Macro return-val is a utility used by Tcl to read LISP variables without 
;;; crashing if the variable has no value. If no binding, return-val returns 
;;; nil, otherwise, it returns the variable value. Because it is a macro, the 
;;; caller need not quote the variable identifier. See utils.tcl.
;;;
(defmacro return-val (var)
  (if (boundp var)
      var)
  )


;;; 
;;; Predicate eof-p tests whether the char x is the end of file character. It
;;; is used by the function recover-from-disk.
;;; 
(defun eof-p (x)
  (eq x *end-of-file*))




#+(and ALLEGRO-V6.2)
nil
(when (not *socket-code-loaded-p*)
  (setf *socket-code-loaded-p* t)
  (load (concatenate 'string *socket-home* "c-interface"))
  (load (concatenate 'string *socket-home* "socket-interface"))
  (load (concatenate 'string *java-socket-home* "socket"))
  )


